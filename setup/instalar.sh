#!/usr/bin/env bash
# Instala las dependencias del taller en Linux o en WSL.
# Idempotente: puedes correrlo varias veces sin romper nada.
#
#   bash setup/instalar.sh
#
# Qué instala:
#   git, curl, build-essential  (gestor de paquetes del sistema, pide sudo)
#   nvm + Node.js LTS           (en tu carpeta personal, sin sudo)
#   Claude Code                 (instalador oficial, sin sudo)

set -euo pipefail

VERDE=$'\033[32m'; ROJO=$'\033[31m'; AZUL=$'\033[36m'; FIN=$'\033[0m'
[ -t 1 ] || { VERDE=""; ROJO=""; AZUL=""; FIN=""; }

paso()  { printf '\n%s==>%s %s\n' "$AZUL" "$FIN" "$1"; }
listo() { printf '%s  ✓%s %s\n' "$VERDE" "$FIN" "$1"; }
morir() { printf '%s  ✗%s %s\n' "$ROJO" "$FIN" "$1" >&2; exit 1; }

# ------------------------------------------------------- comprobaciones
if [ "$(uname -s)" != "Linux" ]; then
  morir "Este script es para Linux y WSL. En Windows, ábrelo dentro de WSL."
fi

if [ "$(id -u)" -eq 0 ]; then
  morir "No lo ejecutes como root ni con sudo. El script pide sudo solo donde hace falta."
fi

# ------------------------------------------------- paquetes del sistema
paso "Paquetes del sistema"

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update -qq
  sudo apt-get install -y -qq git curl ca-certificates build-essential
  listo "git, curl y herramientas de compilación (apt)"
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y -q git curl ca-certificates make gcc gcc-c++
  listo "git, curl y herramientas de compilación (dnf)"
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm git curl base-devel
  listo "git, curl y herramientas de compilación (pacman)"
else
  morir "No reconozco tu gestor de paquetes. Instala git, curl y un compilador a mano."
fi

# --------------------------------------------------------- nvm y node
paso "Node.js"

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  listo "nvm instalado en $NVM_DIR"
else
  listo "nvm ya estaba instalado"
fi

# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"

if nvm ls --no-colors 2>/dev/null | grep -q 'lts/\*'; then
  listo "Node LTS ya estaba instalado"
else
  nvm install --lts
fi
nvm use --lts >/dev/null
nvm alias default 'lts/*' >/dev/null
listo "Node $(node --version) activo por defecto"

# ------------------------------------------------------ claude code
paso "Claude Code"

if command -v claude >/dev/null 2>&1; then
  listo "Ya estaba instalado: $(claude --version 2>/dev/null | head -1)"
else
  # Instalador nativo oficial. Documentación: https://code.claude.com/docs/es/setup
  curl -fsSL https://claude.ai/install.sh | bash
  listo "Claude Code instalado en ~/.local/bin/claude"
fi

# El instalador nativo deja el binario en ~/.local/bin, que no siempre está en PATH
case ":$PATH:" in
  *":$HOME/.local/bin:"*) : ;;
  *)
    perfil="$HOME/.bashrc"
    [ -n "${ZSH_VERSION:-}" ] && perfil="$HOME/.zshrc"
    printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$perfil"
    listo "Agregado ~/.local/bin al PATH en $perfil"
    ;;
esac

# --------------------------------------------------------------- cierre
paso "Instalación terminada"

cat <<'FIN_MENSAJE'

  Cierra esta terminal y abre una nueva para que los cambios de PATH
  surtan efecto. Después, desde la raíz del repositorio, ejecuta:

      bash setup/verificar.sh

  Cuando todo salga en verde, inicia sesión en el asistente con:

      claude

  Se abrirá el navegador para autenticarte. Necesitas una cuenta de pago;
  el plan gratuito de Claude.ai no incluye acceso al CLI.

FIN_MENSAJE
