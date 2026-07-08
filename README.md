# 🇧🇷 OctoPrint PT-BR

[![OctoPrint](https://img.shields.io/badge/OctoPrint-1.11.7+-blue.svg)](https://octoprint.org/)
[![Platform](https://img.shields.io/badge/Platform-Debian-red.svg)]()
[![Language](https://img.shields.io/badge/Language-Português%20(Brasil)-green.svg)]()
[![License](https://img.shields.io/badge/License-AGPL%20v3-orange.svg)]()

Tradução em Português do Brasil para o **OctoPrint**.

---

## Compatibilidade

- ✔ OctoPrint **1.11.7** ou superior
- ✔ Instalações utilizando **Virtual Environment (venv)**
- ✔ Instalações como **serviço systemd**
- ✔ Debian e derivados

---

# Instalação

Clone o repositório:

```bash
git clone https://github.com/eltonnikecasa/octoprint-ptbr.git
cd octoprint-ptbr
```

Execute o instalador:

```bash
sudo ./install.sh
```

---

## O instalador faz tudo automaticamente

- Detecta a instalação do OctoPrint
- Detecta o usuário do serviço
- Localiza automaticamente o diretório `.octoprint`
- Instala o pacote **gettext** (caso necessário)
- Cria backup da tradução anterior
- Copia os arquivos de tradução
- Compila o arquivo `messages.po`
- Gera automaticamente o `messages.mo`
- Corrige permissões
- Reinicia o serviço do OctoPrint

Não é necessário configurar caminhos manualmente.

---

# Ativando o idioma

Após a instalação:

```
Settings
    → Appearance
        → Language
            → Portuguese (Brazil)
```

Depois atualize a página utilizando:

```
CTRL + F5
```

---

# Atualização

Para atualizar a tradução:

```bash
cd octoprint-ptbr
git pull
sudo ./install.sh
```

O instalador substituirá automaticamente a tradução existente e manterá um backup da versão anterior.

---

# Desenvolvimento

Editar a tradução:

```bash
nano pt_BR/LC_MESSAGES/messages.po
```

Validar:

```bash
msgfmt -c pt_BR/LC_MESSAGES/messages.po
```

Compilar manualmente:

```bash
msgfmt \
pt_BR/LC_MESSAGES/messages.po \
-o pt_BR/LC_MESSAGES/messages.mo
```

---

# Estrutura do Projeto

```
octoprint-ptbr/

├── install.sh
├── README.md
│
└── pt_BR
    └── LC_MESSAGES
        ├── messages.po
        └── messages.mo
```

---

# Backup

Sempre que uma tradução existente for atualizada, o instalador cria automaticamente um backup da versão anterior.

---

# Solução de Problemas

Caso o idioma não apareça:

- Atualize a página (`CTRL + F5`)
- Limpe o cache do navegador
- Reinicie o OctoPrint

Verifique o status do serviço:

```bash
systemctl status octoprint
```

Validar a tradução:

```bash
msgfmt -c pt_BR/LC_MESSAGES/messages.po
```

---

# Requisitos

- Debian ou distribuição baseada em Debian
- OctoPrint instalado
- Permissão de administrador (`sudo`)

Todos os demais requisitos são tratados automaticamente pelo instalador.

---

# Licença

Este projeto utiliza o mesmo licenciamento do **OctoPrint**.

---

# Autor

**Elton Nike Casa**

GitHub:

https://github.com/eltonnikecasa

---

⭐ Caso esta tradução tenha sido útil, considere dar uma **estrela** no repositório.
