# OctoPrint pt_BR Translation (Brazilian Portuguese)

Tradução em Português do Brasil para o OctoPrint.

---

## Compatibilidade

- Testado em **OctoPrint 1.11.7**
- Compatível com instalações em **Virtual Environment (venv)**
- Compatível com instalações como **serviço systemd**
- Compatível com Debian e derivados

---

# Instalação

Clone o repositório:

```bash
git clone https://github.com/eltonnikecasa/octoprint-ptbr.git
cd octoprint-ptbr
```

Dê permissão ao instalador:

```bash
chmod +x install.sh
```

Execute:

```bash
sudo ./install.sh
```

O instalador irá automaticamente:

- Localizar a instalação do OctoPrint
- Detectar o diretório `.octoprint`
- Criar a estrutura de traduções
- Copiar os arquivos
- Compilar `messages.po`
- Gerar `messages.mo`
- Corrigir as permissões
- Reiniciar o serviço do OctoPrint
- Exibir uma mensagem de sucesso

---

# Ativando o idioma

No OctoPrint:

```
Settings
    ↓
Appearance
    ↓
Language
    ↓
Portuguese (Brazil)
```

---

# Atualizando a tradução

```bash
git pull
sudo ./install.sh
```

---

# Desenvolvimento

Editar:

```bash
nano pt_BR/LC_MESSAGES/messages.po
```

Compilar manualmente:

```bash
msgfmt -c pt_BR/LC_MESSAGES/messages.po \
-o pt_BR/LC_MESSAGES/messages.mo
```

---

# Estrutura do projeto

```
octoprint-ptbr/

├── install.sh
├── README.md
└── pt_BR
    └── LC_MESSAGES
        └── messages.po
```

---

# Problemas

Caso ocorra algum erro durante a instalação:

```bash
sudo ./install.sh
```

O instalador informará em qual etapa ocorreu o problema.

---

# Licença

Mesmo licenciamento do projeto OctoPrint.

---

# Autor

**Elton Nike Casa**
