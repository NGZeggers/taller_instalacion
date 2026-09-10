# Taller: Instalación de Claude Code y Codex desde cero

Guía paso a paso para instalar los dos asistentes de programación en tu computadora.
**No necesitas saber programar.** Solo copiar, pegar y presionar Enter.

> **Tiempo estimado:** 30–45 minutos
> **Sistema:** macOS (para Windows, ver el [Anexo A](#anexo-a-windows))

---

## Índice

0. [Antes de empezar](#0-antes-de-empezar)
1. [Abrir la Terminal](#1-abrir-la-terminal)
2. [Instalar las Herramientas de Línea de Comandos de Xcode](#2-instalar-las-herramientas-de-línea-de-comandos-de-xcode)
3. [Instalar Homebrew](#3-instalar-homebrew)
4. [Instalar Node.js](#4-instalar-nodejs)
5. [Instalar Claude Code](#5-instalar-claude-code)
6. [Instalar Codex](#6-instalar-codex)
7. [Primer proyecto de prueba](#7-primer-proyecto-de-prueba)
8. [Problemas comunes](#8-problemas-comunes)

---

## 0. Antes de empezar

### Qué vas a instalar y para qué sirve cada cosa

| Herramienta | Qué es | Por qué la necesitas |
|---|---|---|
| **Terminal** | Una ventana donde le escribes órdenes a la computadora con texto | Es donde viven Claude Code y Codex |
| **Xcode Command Line Tools** | Herramientas básicas de desarrollo de Apple | Homebrew las necesita para funcionar |
| **Homebrew** | Un "instalador de programas" para la Terminal | Instala todo lo demás con un comando |
| **Node.js** | El motor que ejecuta ambos asistentes | Claude Code y Codex están escritos sobre él |
| **Claude Code** | El asistente de Anthropic | Escribe y modifica código por ti |
| **Codex** | El asistente de OpenAI | Alternativa/complemento a Claude Code |

### Requisitos previos

- [ ] Una Mac con macOS 13 (Ventura) o superior
- [ ] Conexión a internet estable
- [ ] Al menos **5 GB de espacio libre** en disco
- [ ] La contraseña de tu usuario de la Mac (te la va a pedir un par de veces)
- [ ] Una cuenta en **[claude.ai](https://claude.ai)** (para Claude Code)
- [ ] Una cuenta en **[chatgpt.com](https://chatgpt.com)** o una API key de OpenAI (para Codex)

> 💡 **Crea las cuentas ANTES del taller.** Si llegas sin cuenta, vas a perder 10 minutos verificando tu correo mientras el resto avanza.

---

## 1. Abrir la Terminal

La Terminal es una ventana negra (o blanca) donde escribes comandos. Es tu herramienta principal de aquí en adelante.

**Cómo abrirla:**

1. Presiona `⌘ Command` + `Espacio` (se abre Spotlight)
2. Escribe: `Terminal`
3. Presiona `Enter`

Verás algo así:

```
davidmedina@MacBook-Pro ~ %
```

Ese símbolo `%` (o `$`) se llama **prompt**. Significa "estoy listo, escribe algo".

### Reglas básicas de la Terminal

- **Escribe el comando y presiona `Enter`** para ejecutarlo.
- **Copiar y pegar funciona normal:** `⌘C` y `⌘V`.
- **Cuando te pida contraseña, NO vas a ver nada al escribir.** Ni asteriscos, ni puntos. Es normal, es seguridad. Escribe tu contraseña "a ciegas" y presiona `Enter`.
- **Para cancelar algo que se quedó atorado:** `Control` + `C`.
- **Para limpiar la pantalla:** escribe `clear` y `Enter`.

### ✅ Punto de control

Copia y pega esto, y presiona `Enter`:

```bash
echo "Hola, mi terminal funciona"
```

Si respondió `Hola, mi terminal funciona`, ya estás listo para continuar.

---

## 2. Instalar las Herramientas de Línea de Comandos de Xcode

Homebrew necesita unas herramientas básicas de Apple. Se instalan con un solo comando.

```bash
xcode-select --install
```

**Qué va a pasar:**
- Se abre una ventana emergente preguntando si quieres instalarlas → clic en **"Instalar"**
- Aceptas los términos → clic en **"Aceptar"**
- Se descarga (puede tardar 5–15 minutos según tu internet)

> ℹ️ Si te aparece el mensaje `command line tools are already installed`, perfecto: **ya las tienes**, sigue al paso 3.

### ✅ Punto de control

```bash
xcode-select -p
```

Debe responder algo como `/Library/Developer/CommandLineTools`. Si responde eso, listo.

---

## 3. Instalar Homebrew

Homebrew es como la App Store, pero para la Terminal. Con un comando instala lo que necesites.

### 3.1 Ejecutar el instalador

Copia y pega **todo** esto en una sola línea:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Qué va a pasar:**
1. Te muestra una lista de lo que va a instalar → presiona `Enter` (RETURN) para continuar
2. Te pide tu **contraseña de la Mac** → escríbela (recuerda: no se ve nada) y `Enter`
3. Espera 3–10 minutos

### 3.2 Agregar Homebrew a tu PATH ⚠️ PASO CRÍTICO

Al terminar, Homebrew te muestra un mensaje que dice **"Next steps"** con dos líneas para copiar. **No las ignores.** Si las saltas, la Terminal no encontrará Homebrew.

Ejecuta estos dos comandos (funcionan para Mac con chip Apple Silicon: M1, M2, M3, M4):

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
```

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

<details>
<summary>¿Tienes una Mac Intel (más antigua, sin chip M)?</summary>

Usa estas rutas en su lugar:

```bash
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

Para saber qué chip tienes: menú  → "Acerca de esta Mac".
</details>

### ✅ Punto de control

```bash
brew --version
```

Debe responder algo como `Homebrew 4.x.x`.

> ❌ Si dice `command not found: brew`, **cierra la Terminal por completo** (`⌘Q`), vuelve a abrirla y prueba de nuevo. Si sigue fallando, ve a [Problemas comunes](#8-problemas-comunes).

---

## 4. Instalar Node.js

Node.js es el motor que ejecuta Claude Code y Codex.

```bash
brew install node
```

Tarda unos 2–5 minutos.

### ✅ Punto de control

Ejecuta los dos comandos:

```bash
node --version
```

```bash
npm --version
```

- `node --version` debe responder `v22.x.x` o superior (cualquier número **20 o mayor** sirve)
- `npm --version` debe responder `10.x.x` o similar

Si ambos responden con números, ya tienes todo el entorno base listo. 🎉

---

## 5. Instalar Claude Code

### 5.1 Instalación

```bash
npm install -g @anthropic-ai/claude-code
```

La bandera `-g` significa "global": lo instala para que puedas usarlo desde cualquier carpeta.

> ⚠️ **Si te aparece un error que dice `EACCES` o `permission denied`:** NO uses `sudo`. Ve a [Problemas comunes → Error de permisos](#error-eacces--permission-denied-al-instalar-con-npm).

<details>
<summary>Alternativa: instalador nativo (si npm te da problemas)</summary>

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Después cierra y vuelve a abrir la Terminal.
</details>

### 5.2 Verificar

```bash
claude --version
```

Debe responder con un número de versión.

### 5.3 Iniciar sesión

Crea una carpeta para el taller y entra en ella:

```bash
mkdir -p ~/Desktop/taller && cd ~/Desktop/taller
```

Ahora arranca Claude Code:

```bash
claude
```

**La primera vez:**
1. Te pregunta qué tema de colores quieres → elige con las flechas ↑↓ y `Enter`
2. Te pide iniciar sesión → elige **"Log in with Claude account"** (usa tu suscripción Pro/Max) o **"Anthropic Console"** (si tienes API key con créditos)
3. Se abre tu navegador → inicia sesión y autoriza
4. Vuelve a la Terminal: ya estás dentro

Verás un cuadro de texto esperando tu mensaje. **Escribe en español normal**, no comandos:

```
Hola, dime en una línea qué puedes hacer por mí
```

### 5.4 Comandos útiles dentro de Claude Code

| Comando | Qué hace |
|---|---|
| `/help` | Lista todos los comandos disponibles |
| `/login` | Volver a iniciar sesión o cambiar de cuenta |
| `/status` | Ver tu cuenta, modelo y configuración actual |
| `/clear` | Borrar la conversación y empezar de cero |
| `/config` | Cambiar tema, modelo y preferencias |
| `/init` | Analiza el proyecto y crea un archivo de contexto |
| `Control` + `C` (dos veces) | Salir de Claude Code |

### ✅ Punto de control

Claude respondió a tu mensaje en español. ✅

---

## 6. Instalar Codex

Codex es el asistente de línea de comandos de OpenAI. Se instala igual de fácil.

### 6.1 Instalación

**Opción A — con Homebrew (recomendada):**

```bash
brew install codex
```

**Opción B — con npm:**

```bash
npm install -g @openai/codex
```

> Usa **una sola** de las dos opciones, no ambas.

### 6.2 Verificar

```bash
codex --version
```

### 6.3 Iniciar sesión

Desde la carpeta del taller:

```bash
cd ~/Desktop/taller && codex
```

**La primera vez:**
1. Te ofrece **"Sign in with ChatGPT"** → elígelo si tienes ChatGPT Plus, Pro, Business o Enterprise
2. Se abre el navegador → autoriza el acceso
3. Vuelve a la Terminal

<details>
<summary>Si prefieres usar una API key de OpenAI</summary>

Elige la opción de API key durante el login, o configúrala antes:

```bash
export OPENAI_API_KEY="tu-api-key-aquí"
```

Para que se guarde permanentemente:

```bash
echo 'export OPENAI_API_KEY="tu-api-key-aquí"' >> ~/.zshrc
source ~/.zshrc
```

⚠️ Una API key es como una contraseña: **no la compartas ni la subas a internet.**
</details>

### 6.4 Comandos útiles dentro de Codex

| Comando | Qué hace |
|---|---|
| `/help` | Lista de comandos |
| `/model` | Cambiar el modelo que usa |
| `/new` | Nueva conversación |
| `/approvals` | Cambiar cuánto le permites hacer sin preguntarte |
| `Control` + `C` | Salir |

### ✅ Punto de control

```
Escribe: "Hola, ¿estás funcionando?"
```

Si responde, ya tienes ambos asistentes listos. 🎉

---

## 7. Primer proyecto de prueba

Vamos a comprobar que todo funciona de verdad haciendo algo real.

### 7.1 Crear una carpeta de proyecto

```bash
mkdir -p ~/Desktop/taller/mi-primer-proyecto && cd ~/Desktop/taller/mi-primer-proyecto
```

### 7.2 Pedirle algo a Claude Code

```bash
claude
```

Y escribe:

```
Crea una página web simple en un archivo index.html que muestre
"Hola Taller" con un fondo azul y letras blancas centradas
```

Claude te va a pedir permiso para crear el archivo → responde **"Yes"** con las flechas y `Enter`.

### 7.3 Ver el resultado

Sal de Claude (`Control` + `C` dos veces) y ejecuta:

```bash
open index.html
```

Se abre tu navegador con la página. **Acabas de crear tu primer proyecto sin escribir una línea de código.**

### 7.4 Ideas para seguir practicando

- `Agrega un botón que cambie el color de fondo al hacer clic`
- `Explícame línea por línea qué hace este archivo`
- `Crea un archivo README.md que documente este proyecto`

---

## 8. Problemas comunes

### `command not found: brew`

Homebrew está instalado pero la Terminal no sabe dónde encontrarlo. Ejecuta:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
```

Luego cierra la Terminal (`⌘Q`) y ábrela de nuevo.

---

### `command not found: claude` o `command not found: codex`

Instalado pero fuera del PATH. Primero recarga la configuración:

```bash
source ~/.zshrc 2>/dev/null; source ~/.zprofile 2>/dev/null; hash -r
```

Si no funciona, revisa dónde quedó instalado:

```bash
npm list -g --depth=0
```

Y agrega la carpeta de npm a tu PATH:

```bash
echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

---

### Error `EACCES` / `permission denied` al instalar con npm

**Nunca uses `sudo npm install`.** Rompe permisos y causa problemas después. La solución correcta es darle a npm su propia carpeta:

```bash
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Ahora vuelve a instalar:

```bash
npm install -g @anthropic-ai/claude-code
```

---

### El navegador no abre al iniciar sesión

Copia manualmente la URL larga que aparece en la Terminal y pégala en tu navegador. Al terminar, copia el código que te da y pégalo de vuelta en la Terminal.

---

### La instalación se queda "colgada" sin avanzar

Espera al menos 5 minutos: algunas descargas son grandes y no muestran progreso. Si de verdad no avanza, `Control` + `C` y vuelve a ejecutar el comando.

---

### "No tengo suscripción, ¿puedo usarlo igual?"

- **Claude Code:** requiere una suscripción Claude (Pro o Max) o créditos de API en [console.anthropic.com](https://console.anthropic.com).
- **Codex:** requiere ChatGPT Plus/Pro/Business o una API key con créditos.

Verifica esto **antes** del taller para no quedarte atorado.

---

### Cómo actualizar más adelante

```bash
npm update -g @anthropic-ai/claude-code
brew upgrade codex
```

---

## Anexo A: Windows

Homebrew no existe en Windows. La ruta recomendada es **WSL** (Windows Subsystem for Linux), que te da un Linux dentro de Windows.

### A.1 Instalar WSL

Abre **PowerShell como Administrador** (clic derecho en el menú Inicio → "Terminal (Administrador)") y ejecuta:

```powershell
wsl --install
```

Reinicia la computadora. Al volver, se abre Ubuntu y te pide crear un usuario y contraseña.

### A.2 Dentro de Ubuntu

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential
```

### A.3 Instalar Node.js

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
```

### A.4 Instalar los asistentes

```bash
npm install -g @anthropic-ai/claude-code
npm install -g @openai/codex
```

A partir de aquí, todo lo demás de esta guía (login, uso, comandos) funciona igual.

---

## Anexo B: Chuleta de comandos de Terminal

| Comando | Qué hace |
|---|---|
| `pwd` | Muestra en qué carpeta estás |
| `ls` | Lista los archivos de la carpeta actual |
| `cd nombre-carpeta` | Entra a una carpeta |
| `cd ..` | Sube un nivel |
| `cd ~` | Va a tu carpeta de usuario |
| `mkdir nombre` | Crea una carpeta |
| `open .` | Abre la carpeta actual en el Finder |
| `clear` | Limpia la pantalla |
| `Control` + `C` | Cancela lo que se esté ejecutando |
| `↑` (flecha arriba) | Repite el comando anterior |
| `Tab` | Autocompleta nombres de archivos y carpetas |

---

## Checklist final del taller

- [ ] Terminal abierta y funcionando
- [ ] `xcode-select -p` responde con una ruta
- [ ] `brew --version` responde
- [ ] `node --version` responde v20 o superior
- [ ] `npm --version` responde
- [ ] `claude --version` responde
- [ ] Sesión iniciada en Claude Code
- [ ] `codex --version` responde
- [ ] Sesión iniciada en Codex
- [ ] Primer `index.html` creado y visto en el navegador

**Si marcaste todo: ya estás listo. 🚀**
