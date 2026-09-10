# Instalación en Windows

Tiempo estimado: 25 minutos, la mayoría de espera. Hazlo con tiempo, no la
noche anterior.

Vas a instalar **WSL 2**, que corre Ubuntu dentro de tu Windows. No es una
máquina virtual pesada ni una partición: es una función del propio Windows.
Tus archivos de Windows siguen ahí y puedes seguir usando tu computadora
igual que siempre.

## Antes de empezar

Necesitas:

- Windows 10 versión 1809 o posterior, o Windows 11.
  Compruébalo con <kbd>Win</kbd> + <kbd>R</kbd>, escribe `winver` y presiona Enter.
- Permisos de administrador en el equipo.
- Virtualización habilitada en el BIOS. Casi siempre lo está de fábrica; el
  paso 1 te dirá si no.

> **Equipo institucional:** si el paso 1 falla por políticas de la
> organización, salta a [Ruta alterna sin WSL](#ruta-alterna-sin-wsl) y
> avísale a los instructores antes del taller.

---

## 1. Instalar WSL 2 con Ubuntu

Abre **PowerShell como administrador**: menú Inicio, escribe `PowerShell`,
clic derecho sobre el resultado, *Ejecutar como administrador*.

```powershell
wsl --install -d Ubuntu
```

Reinicia la computadora cuando lo pida.

Al volver a iniciar, se abre sola una ventana negra que dice
`Installing, this may take a few minutes...`. Espera. Después te pide:

- **Enter new UNIX username:** escribe un nombre en minúsculas y sin
  espacios. No tiene que coincidir con tu usuario de Windows.
- **New password:** la contraseña **no se ve mientras la escribes**, ni
  siquiera asteriscos. Es normal. Escríbela y presiona Enter.

Cuando veas un texto que termina en `$`, ya estás dentro de Ubuntu.

**Si `wsl --install` falla:**

| Mensaje | Qué significa | Solución |
|---|---|---|
| `El servicio de virtualización no está habilitado` | Falta activarlo en el BIOS | Reinicia, entra al BIOS (F2, F10 o Supr según la marca) y activa *Intel VT-x* o *AMD-V* |
| `No se reconoce wsl como un comando` | Windows desactualizado | Actualiza Windows y reintenta |
| `Error 0x80370102` | Hyper-V deshabilitado | En PowerShell admin: `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart` y reinicia |
| Bloqueado por política de la organización | Equipo administrado | Usa la [ruta alterna](#ruta-alterna-sin-wsl) |

## 2. Instalar la Terminal de Windows

Es opcional pero te va a ahorrar frustración: la ventana negra por defecto
no permite pegar con <kbd>Ctrl</kbd>+<kbd>V</kbd> ni redimensionar bien.

Instálala desde la Microsoft Store buscando *Windows Terminal*, o con:

```powershell
winget install Microsoft.WindowsTerminal
```

Ábrela y elige **Ubuntu** en la flecha junto a la pestaña.

## 3. Dónde vivirá el repositorio

Esto importa más de lo que parece. Desde Ubuntu puedes ver tu disco de
Windows en `/mnt/c/`, pero **trabajar ahí es entre 5 y 20 veces más lento**,
porque cada lectura cruza la frontera entre los dos sistemas.

Trabaja siempre dentro del sistema de archivos de Linux, es decir, en tu
carpeta personal `~`:

```bash
cd ~
git clone https://github.com/NGZeggers/taller_instalacion.git
cd taller_instalacion
```

Si necesitas abrir estos archivos con un programa de Windows, desde Ubuntu
escribe `explorer.exe .` y se abre el Explorador en la carpeta actual.

## 4. Instalar las dependencias

Desde la terminal de Ubuntu, en la raíz del repositorio:

```bash
bash setup/instalar.sh
```

El script instala git, curl, Node.js LTS mediante nvm, y Claude Code.
Te va a pedir tu contraseña de Ubuntu una vez, al principio.

> **No instales Node.js en Windows.** Si ya lo tienes ahí, déjalo, pero
> Ubuntu debe usar el suyo propio. Mezclar ambos produce errores que
> aparecen y desaparecen sin razón aparente. El script `verificar.sh`
> detecta esta situación y te avisa.

## 5. Verificar

Cierra la terminal, abre una nueva de Ubuntu y ejecuta:

```bash
cd ~/taller_instalacion
bash setup/verificar.sh
```

Todo en verde significa que terminaste. Guarda la salida por si necesitas
reportar algo.

## 6. Iniciar sesión en el asistente

```bash
claude
```

Se abre el navegador para autenticarte. Necesitas una cuenta de pago:
Pro, Max, Team, Enterprise o una cuenta de Console con créditos. El plan
gratuito de Claude.ai no da acceso al CLI.

---

## Ruta alterna sin WSL

Solo si WSL está bloqueado en tu equipo. Funciona para casi todo el taller,
con dos limitaciones que conviene que sepas: no hay aislamiento de comandos
y algunas utilerías de Linux no están disponibles.

1. Instala **Git for Windows**, que incluye Git Bash:
   ```powershell
   winget install Git.Git
   ```
2. Instala **Node.js LTS**:
   ```powershell
   winget install OpenJS.NodeJS.LTS
   ```
3. Instala **Claude Code** desde PowerShell:
   ```powershell
   irm https://claude.ai/install.ps1 | iex
   ```
4. Abre **Git Bash** (no PowerShell) y desde ahí clona el repositorio y
   ejecuta `bash setup/verificar.sh`.

Usa Git Bash para todos los ejercicios del taller. Los comandos son los
mismos que verás en pantalla.

---

## Problemas frecuentes

**`bash: setup/verificar.sh: /usr/bin/env^M: bad interpreter`**
El archivo llegó con fin de línea de Windows. Ejecuta:
```bash
git config core.autocrlf false
git rm --cached -r . && git reset --hard
```

**`command not found: claude` después de instalar**
Cierra la terminal y abre una nueva. Si persiste:
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc
```

**La contraseña de Ubuntu no se escribe**
Sí se está escribiendo. Los caracteres no se muestran a propósito.

**Olvidé la contraseña de Ubuntu**
Desde PowerShell: `wsl -u root passwd tu_usuario`

**Todo va muy lento**
Probablemente clonaste el repositorio en `/mnt/c/`. Muévelo:
```bash
cp -r /mnt/c/ruta/taller_instalacion ~/ && cd ~/taller_instalacion
```
