# Instalación en Linux

Tiempo estimado: 10 minutos. Ya tienes lo más difícil resuelto: una terminal
de verdad.

## Distribuciones probadas

| Distribución | Estado |
|---|---|
| Ubuntu 20.04 o posterior | Probado |
| Debian 10 o posterior | Probado |
| Fedora 38 o posterior | Probado |
| Arch, Manjaro | Funciona, soporte limitado |
| Otras | Deberían funcionar; avisa si algo falla |

## 1. Clonar el repositorio

```bash
cd ~
git clone https://github.com/NGZeggers/taller_instalacion.git
cd taller_instalacion
```

Si `git` no está instalado todavía, el script del paso 2 lo instala; clona
después de correrlo, o instala git primero con el gestor de tu distribución.

## 2. Instalar dependencias

```bash
bash setup/instalar.sh
```

Instala, en este orden:

- **git, curl y herramientas de compilación**, con `apt`, `dnf` o `pacman`
  según tu distribución. Este paso pide tu contraseña.
- **nvm y Node.js LTS**, dentro de tu carpeta personal. Se usa nvm en lugar
  del paquete del sistema porque las versiones de los repositorios suelen
  ser demasiado viejas para las herramientas del taller.
- **Claude Code**, con el instalador oficial. Queda en `~/.local/bin/claude`.

Ningún paso instala nada fuera de tu usuario salvo los paquetes del sistema
de la primera línea.

## 3. Verificar

Cierra la terminal, abre una nueva y ejecuta:

```bash
cd ~/taller_instalacion
bash setup/verificar.sh
```

## 4. Iniciar sesión en el asistente

```bash
claude
```

Se abre el navegador para autenticarte. Necesitas una cuenta de pago:
Pro, Max, Team, Enterprise o una cuenta de Console con créditos. El plan
gratuito de Claude.ai no da acceso al CLI.

---

## Instalación manual

Si prefieres no correr el script, esto es lo que hace:

```bash
# Debian, Ubuntu y derivadas
sudo apt update
sudo apt install -y git curl ca-certificates build-essential

# Fedora y RHEL
sudo dnf install -y git curl ca-certificates make gcc gcc-c++

# Arch y derivadas
sudo pacman -S --needed git curl base-devel
```

```bash
# nvm y Node LTS
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc
nvm install --lts
nvm alias default 'lts/*'
```

```bash
# Claude Code
curl -fsSL https://claude.ai/install.sh | bash
```

En Debian, Fedora, RHEL y Alpine también existen repositorios firmados de
apt, dnf y apk para Claude Code, si prefieres que lo gestione tu sistema.
La documentación oficial los describe en
<https://code.claude.com/docs/es/setup>.

---

## Problemas frecuentes

**`command not found: claude`**
El instalador nativo deja el binario en `~/.local/bin`, que no siempre está
en el PATH. Agrégalo:
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc
```

**`command not found: nvm` al abrir una terminal nueva**
El instalador de nvm escribe en `~/.bashrc`. Si usas zsh o fish, agrega el
bloque de carga a `~/.zshrc` o al archivo de configuración correspondiente.

**El navegador no abre al ejecutar `claude`**
Copia manualmente la URL que imprime la terminal. En entornos sin interfaz
gráfica, ábrela en otro equipo y pega el código de vuelta.

**SELinux o AppArmor bloquean el binario**
Reporta el mensaje completo en un issue. Suele resolverse instalando desde
el repositorio de tu distribución en lugar del instalador nativo.
