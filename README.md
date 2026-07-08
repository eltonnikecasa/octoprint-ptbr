# OctoPrint pt_BR Translation (Brazilian Portuguese)

Tradução em Português do Brasil para o OctoPrint.

## Compatibilidade

- Testado em: **OctoPrint 1.11.7**
- Compatível com instalações utilizando **venv (Virtual Environment)**
- Compatível com instalações como **serviço systemd**
- Compatível com instalações utilizando o usuário **octoprint**

---

# Instalação

## 1. Baixar o repositório

```bash
git clone https://github.com/eltonnikecasa/octoprint-ptbr.git
cd octoprint-ptbr
```

---

## 2. Descobrir onde está o diretório do OctoPrint

### Instalação padrão (usuário atual)

Verifique se existe:

```bash
ls ~/.octoprint
```

Caso exista, utilize este diretório.

---

### Instalação como serviço (Recomendado)

Verifique:

```bash
sudo -u octoprint find /home/octoprint -name config.yaml
```

O retorno normalmente será:

```text
/home/octoprint/.octoprint/config.yaml
```

Neste caso o diretório correto será:

```text
/home/octoprint/.octoprint
```

---

## 3. Copiar os arquivos de tradução

### Instalação padrão

```bash
mkdir -p ~/.octoprint/translations/pt_BR/LC_MESSAGES

cp pt_BR/LC_MESSAGES/messages.po \
~/.octoprint/translations/pt_BR/LC_MESSAGES/
```

---

### Instalação como serviço (systemd)

```bash
sudo mkdir -p /home/octoprint/.octoprint/translations/pt_BR/LC_MESSAGES

sudo cp pt_BR/LC_MESSAGES/messages.po \
/home/octoprint/.octoprint/translations/pt_BR/LC_MESSAGES/

sudo chown -R octoprint:octoprint \
/home/octoprint/.octoprint/translations
```

---

## 4. Compilar a tradução

### Instalação padrão

```bash
cd ~/.octoprint/translations/pt_BR/LC_MESSAGES

msgfmt -c messages.po -o messages.mo
```

---

### Instalação como serviço

```bash
cd /home/octoprint/.octoprint/translations/pt_BR/LC_MESSAGES

msgfmt -c messages.po -o messages.mo

sudo chown octoprint:octoprint messages.mo
```

---

## 5. Reiniciar o OctoPrint

```bash
sudo systemctl restart octoprint
```

---

## 6. Ativar o idioma

Abra o navegador:

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

# Estrutura do Projeto

```
octoprint-ptbr/
└── pt_BR/
    └── LC_MESSAGES/
        ├── messages.po
        └── README.md
```

Após a compilação:

```
/home/octoprint/.octoprint/
└── translations/
    └── pt_BR/
        └── LC_MESSAGES/
            ├── messages.po
            └── messages.mo
```

---

# Desenvolvimento

Editar:

```bash
nano pt_BR/LC_MESSAGES/messages.po
```

Compilar:

```bash
msgfmt -c pt_BR/LC_MESSAGES/messages.po \
-o pt_BR/LC_MESSAGES/messages.mo
```

---

# Validação

Sempre valide antes de instalar:

```bash
msgfmt -c pt_BR/LC_MESSAGES/messages.po
```

Se não houver saída, o arquivo está correto.

---

# Problemas conhecidos

## O idioma não aparece

Verifique se a tradução foi instalada no diretório correto.

Instalação padrão:

```text
~/.octoprint/translations/
```

Instalação como serviço:

```text
/home/octoprint/.octoprint/translations/
```

---

## Safe Mode

Se o OctoPrint iniciar em Safe Mode:

Verifique a tradução:

```bash
msgfmt -c messages.po
```

Caso exista erro, remova temporariamente:

Instalação padrão:

```bash
rm ~/.octoprint/translations/pt_BR/LC_MESSAGES/messages.mo
```

Instalação como serviço:

```bash
sudo rm /home/octoprint/.octoprint/translations/pt_BR/LC_MESSAGES/messages.mo
```

Reinicie:

```bash
sudo systemctl restart octoprint
```

---

## Verificar onde o OctoPrint está instalado

```bash
systemctl status octoprint
```

Você verá algo semelhante a:

```
ExecStart=/home/octoprint/venv/bin/octoprint serve
```

Para localizar o diretório de configuração:

```bash
sudo -u octoprint find /home/octoprint -name config.yaml
```

---

# Licença

Mesmo licenciamento do projeto OctoPrint.

---

# Autor

**Elton Nike Casa**
