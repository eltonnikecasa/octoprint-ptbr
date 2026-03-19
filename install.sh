#!/bin/bash

set -e

echo "== OctoPrint pt_BR Installer =="

# =========================

# Funções

# =========================

check_command() {
command -v "$1" >/dev/null 2>&1
}

install_hint() {
echo "Para instalar, execute:"
echo "sudo apt install $1"
}

# =========================

# Checagem de dependências

# =========================

echo "Verificando dependências..."

if ! check_command git; then
echo "[ERRO] git não encontrado"
install_hint git
exit 1
fi

if ! check_command msgfmt; then
echo "[ERRO] msgfmt não encontrado (pacote gettext)"
install_hint gettext
exit 1
fi

if ! check_command cp; then
echo "[ERRO] comando cp não encontrado"
exit 1
fi

echo "Dependências OK"

# =========================

# Caminhos

# =========================

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.octoprint/translations/pt_BR/LC_MESSAGES"

echo "Repo: $REPO_DIR"
echo "Destino: $TARGET_DIR"

# =========================

# Validação de arquivos

# =========================

if [ ! -f "$REPO_DIR/pt_BR/LC_MESSAGES/messages.po" ]; then
echo "[ERRO] messages.po não encontrado"
exit 1
fi

# =========================

# Instalação

# =========================

echo "Criando diretório..."
mkdir -p "$TARGET_DIR"

echo "Copiando arquivos..."
cp "$REPO_DIR/pt_BR/LC_MESSAGES/"* "$TARGET_DIR/"

echo "Compilando tradução..."
cd "$TARGET_DIR"

if msgfmt -c messages.po -o messages.mo; then
echo "Compilação OK"
else
echo "[ERRO] Falha na compilação. Verifique o messages.po"
exit 1
fi

# =========================

# Limpeza de cache

# =========================

echo "Limpando cache do OctoPrint..."
rm -rf "$HOME/.octoprint/generated/"*

# =========================

# Reinício

# =========================

echo "Reiniciando OctoPrint..."

if check_command systemctl; then
sudo systemctl restart octoprint
else
echo "[AVISO] systemctl não encontrado"
echo "Reinicie o OctoPrint manualmente"
fi

# =========================

# Final

# =========================

echo ""
echo "Instalação concluída com sucesso!"
echo ""
echo "Passos finais:"
echo "1. Abra o navegador"
echo "2. Pressione CTRL + SHIFT + R"
echo "3. Vá em Settings → Appearance"
echo "4. Selecione: Portuguese (Brazil)"
echo ""
