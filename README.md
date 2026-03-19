# OctoPrint pt_BR Translation (Brazilian Portuguese)

Tradução em Português do Brasil para o OctoPrint.

## Compatibilidade

* Testado em: **OctoPrint 1.11.7**
* Pode funcionar em versões próximas, mas não é garantido

---

## Instalação (Recomendado)

### 1. Baixar o repositório

```bash
git clone https://github.com/eltonnikecasa/octoprint-ptbr.git
```

---

### 2. Copiar arquivos de tradução

```bash
mkdir -p ~/.octoprint/translations/pt_BR/LC_MESSAGES
cp -r octoprint-ptbr/pt_BR/LC_MESSAGES/* ~/.octoprint/translations/pt_BR/LC_MESSAGES/
```

---

### 3. Compilar tradução

```bash
cd ~/.octoprint/translations/pt_BR/LC_MESSAGES
msgfmt -c messages.po -o messages.mo
```

---

### 4. Reiniciar o OctoPrint

```bash
sudo systemctl restart octoprint
```

---

### 5. Ativar idioma

No navegador:

Settings → Appearance → Language → **Portuguese (Brazil)**

---

## Estrutura do Projeto

```
pt_BR/
└── LC_MESSAGES/
    ├── messages.po   # Arquivo fonte (editável)
    └── messages.mo   # Arquivo compilado
```

---

## Desenvolvimento

### Editar tradução

```bash
nano pt_BR/LC_MESSAGES/messages.po
```

---

### Validar e compilar

```bash
msgfmt -c pt_BR/LC_MESSAGES/messages.po -o pt_BR/LC_MESSAGES/messages.mo
```

---

### Importante

* Sempre validar antes de usar (`msgfmt -c`)
* Erros no `.po` podem causar **Safe Mode**

---

## Problemas conhecidos

### Safe Mode ativado

Se o OctoPrint iniciar em Safe Mode:

1. Verifique erros no `.po`:

   ```bash
   msgfmt -c messages.po
   ```

2. Remova temporariamente a tradução:

   ```bash
   rm ~/.octoprint/translations/pt_BR/LC_MESSAGES/messages.mo
   ```

3. Reinicie o OctoPrint

---

## Licença

Mesmo licenciamento do projeto OctoPrint.

---

## Autor

Elton Nike Casa
