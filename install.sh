#!/usr/bin/env bash

##############################################################################
#
# OctoPrint PT-BR Installer
#
# Autor : Elton Nike Casa
# Projeto: https://github.com/eltonnikecasa/octoprint-ptbr
#
##############################################################################

set -euo pipefail

VERSION="2.0"

##############################################################################
# Cores
##############################################################################

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

##############################################################################
# Banner
##############################################################################

clear

echo -e "${CYAN}"
echo "==============================================================="
echo "             OctoPrint PT-BR Translation Installer"
echo "==============================================================="
echo "Versão : ${VERSION}"
echo "Autor  : Elton Nike Casa"
echo "==============================================================="
echo -e "${NC}"

##############################################################################
# Funções
##############################################################################

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

ok() {
    echo -e "${GREEN}[ OK ]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

erro() {
    echo -e "${RED}[ERRO]${NC} $1"
}

##############################################################################
# Root
##############################################################################

if [ "$EUID" -ne 0 ]; then

    erro "Execute o instalador utilizando sudo."

    echo

    echo "sudo ./install.sh"

    echo

    exit 1

fi

##############################################################################
# Diretório do script
##############################################################################

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

SOURCE_DIR="$SCRIPT_DIR/pt_BR/LC_MESSAGES"

##############################################################################
# gettext
##############################################################################

if ! command -v msgfmt >/dev/null 2>&1; then

    info "Instalando gettext..."

    apt-get update

    apt-get install -y gettext

fi

##############################################################################
# Descobrir serviço
##############################################################################

SERVICE=""

if command -v systemctl >/dev/null 2>&1; then

    SERVICE=$(systemctl list-unit-files \
        --type=service \
        | awk '/octoprint/ {print $1}' \
        | head -n1 \
        | sed 's/.service//')

fi

##############################################################################
# Descobrir usuário
##############################################################################

OCTO_USER=""

if [ -n "$SERVICE" ]; then

    OCTO_USER=$(systemctl show "$SERVICE" \
        -p User \
        --value)

fi

##############################################################################
# Descobrir HOME
##############################################################################

OCTO_HOME=""

if [ -n "$OCTO_USER" ]; then

    OCTO_HOME=$(getent passwd "$OCTO_USER" \
        | cut -d: -f6)

fi

##############################################################################
# Fallback
##############################################################################

if [ -z "$OCTO_HOME" ]; then

    warn "Serviço não localizado."

    info "Procurando instalação manualmente..."

    CONFIG=$(find /home /root /srv /opt \
        -name config.yaml \
        2>/dev/null \
        | grep '\.octoprint/config.yaml' \
        | head -n1)

    if [ -z "$CONFIG" ]; then

        erro "Não foi possível localizar o OctoPrint."

        exit 1

    fi

    OCTO_DIR=$(dirname "$CONFIG")

    OCTO_HOME=$(dirname "$OCTO_DIR")

    OCTO_USER=$(stat -c "%U" "$OCTO_DIR")

else

    OCTO_DIR="$OCTO_HOME/.octoprint"

fi

##############################################################################
# Diretórios
##############################################################################

TRANSLATION_DIR="$OCTO_DIR/translations/pt_BR/LC_MESSAGES"

BACKUP_DIR="$OCTO_DIR/translations/backup"

##############################################################################
# Informações
##############################################################################

echo

ok "OctoPrint localizado."

echo

echo "Usuário...........: $OCTO_USER"

echo "Home..............: $OCTO_HOME"

echo "Configuração......: $OCTO_DIR"

echo "Tradução..........: $TRANSLATION_DIR"

echo
##############################################################################
# Verificar arquivos
##############################################################################

if [ ! -f "$SOURCE_DIR/messages.po" ]; then

    erro "Arquivo messages.po não encontrado."

    echo

    echo "$SOURCE_DIR/messages.po"

    echo

    exit 1

fi

##############################################################################
# Versão do OctoPrint
##############################################################################

echo

if command -v octoprint >/dev/null 2>&1; then

    OCTO_VERSION=$(octoprint --version 2>/dev/null || true)

    if [ -n "$OCTO_VERSION" ]; then

        ok "Versão detectada: $OCTO_VERSION"

    fi

fi

##############################################################################
# Criar diretórios
##############################################################################

mkdir -p "$TRANSLATION_DIR"

mkdir -p "$BACKUP_DIR"

##############################################################################
# Backup automático
##############################################################################

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

if [ -f "$TRANSLATION_DIR/messages.po" ]; then

    info "Criando backup..."

    mkdir -p "$BACKUP_DIR/$TIMESTAMP"

    cp \
        "$TRANSLATION_DIR/messages.po" \
        "$BACKUP_DIR/$TIMESTAMP/"

    if [ -f "$TRANSLATION_DIR/messages.mo" ]; then

        cp \
            "$TRANSLATION_DIR/messages.mo" \
            "$BACKUP_DIR/$TIMESTAMP/"

    fi

    ok "Backup criado."

fi

##############################################################################
# Instalação
##############################################################################

info "Copiando tradução..."

cp \
"$SOURCE_DIR/messages.po" \
"$TRANSLATION_DIR/"

##############################################################################
# Compilação
##############################################################################

info "Compilando tradução..."

if ! msgfmt -c \
"$TRANSLATION_DIR/messages.po" \
-o "$TRANSLATION_DIR/messages.mo"
then

    erro "Erro durante a compilação."

    echo

    echo "Verifique o arquivo messages.po."

    echo

    exit 1

fi

ok "Compilação concluída."

##############################################################################
# Permissões
##############################################################################

info "Corrigindo permissões..."

chown \
"$OCTO_USER:$OCTO_USER" \
"$TRANSLATION_DIR/messages.po"

chown \
"$OCTO_USER:$OCTO_USER" \
"$TRANSLATION_DIR/messages.mo"

chmod 644 \
"$TRANSLATION_DIR/messages.po"

chmod 644 \
"$TRANSLATION_DIR/messages.mo"

ok "Permissões atualizadas."

echo
##############################################################################
# Reiniciar serviço
##############################################################################

if [ -n "$SERVICE" ]; then

    info "Reiniciando serviço..."

    systemctl restart "$SERVICE"

    sleep 2

    if systemctl is-active --quiet "$SERVICE"; then

        ok "Serviço iniciado com sucesso."

        SERVICE_STATUS="ATIVO"

    else

        erro "O serviço não iniciou corretamente."

        echo

        systemctl --no-pager --full status "$SERVICE"

        exit 1

    fi

else

    warn "Serviço do OctoPrint não encontrado."

    SERVICE_STATUS="NÃO LOCALIZADO"

fi

##############################################################################
# Resumo
##############################################################################

echo
echo -e "${CYAN}"
echo "==============================================================="
echo "                 INSTALAÇÃO CONCLUÍDA"
echo "==============================================================="
echo -e "${NC}"

printf "%-20s %s\n" "Versão:" "$VERSION"
printf "%-20s %s\n" "Usuário:" "$OCTO_USER"
printf "%-20s %s\n" "Grupo:" "$OCTO_GROUP"
printf "%-20s %s\n" "Serviço:" "${SERVICE:-Não encontrado}"
printf "%-20s %s\n" "Status:" "$SERVICE_STATUS"

echo

printf "%-20s %s\n" "Configuração:" "$OCTO_DIR"
printf "%-20s %s\n" "Tradução:" "$TRANSLATION_DIR"
printf "%-20s %s\n" "Backup:" "$BACKUP_DIR"

echo

echo "Ative a tradução em:"

echo
echo "Settings"
echo "  -> Appearance"
echo "      -> Language"
echo "          -> Portuguese (Brazil)"

echo

echo "Caso o idioma não apareça:"

echo " • Atualize a página (CTRL + F5)"
echo " • Limpe o cache do navegador"
echo " • Reinicie o OctoPrint"

echo

ok "Instalação concluída com sucesso."

exit 0
