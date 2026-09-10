#!/usr/bin/env bash
# Diagnóstico del entorno del taller.
# Funciona igual en Linux y en WSL. No modifica nada: solo revisa y reporta.
#
#   bash setup/verificar.sh

set -uo pipefail

# Sin una configuración regional UTF-8, bash cuenta bytes en lugar de
# caracteres y las tildes descuadran las columnas. También es lo que hace que
# "María" se vea como "Mar\303\255a" en algunos entornos mínimos.
if ! printf '%s' "${LC_ALL:-${LANG:-}}" | grep -qi 'utf-\?8'; then
  for candidata in C.UTF-8 en_US.UTF-8 es_MX.UTF-8; do
    if locale -a 2>/dev/null | grep -qix "${candidata/UTF-8/utf8}\|$candidata"; then
      export LC_ALL="$candidata"; break
    fi
  done
fi

VERDE=$'\033[32m'; ROJO=$'\033[31m'; AMBAR=$'\033[33m'; GRIS=$'\033[90m'; FIN=$'\033[0m'
[ -t 1 ] || { VERDE=""; ROJO=""; AMBAR=""; GRIS=""; FIN=""; }

fallas=0
avisos=0

# printf %-26s alinea por bytes, no por caracteres: las tildes descuadran la
# columna. Esta función rellena contando caracteres.
rellena() { local t="$1" n=$(( 26 - ${#1} )); [ "$n" -lt 1 ] && n=1
            printf '%s%*s' "$t" "$n" ''; }

ok()    { printf '  %s✓%s %s %s\n' "$VERDE" "$FIN" "$(rellena "$1")" "${2:-}"; }
error() { printf '  %s✗%s %s %s\n' "$ROJO" "$FIN" "$(rellena "$1")" "${2:-}"; fallas=$((fallas+1)); }
aviso() { printf '  %s!%s %s %s\n' "$AMBAR" "$FIN" "$(rellena "$1")" "${2:-}"; avisos=$((avisos+1)); }
pista() { printf '      %s%s%s\n' "$GRIS" "$1" "$FIN"; }
titulo(){ printf '\n%s\n' "$1"; }

printf '\n Verificación del entorno — taller IA más allá del chat\n'

# ---------------------------------------------------------------- sistema
titulo "Sistema"

sistema="desconocido"
if grep -qi microsoft /proc/version 2>/dev/null; then
  sistema="wsl"
  ok "WSL detectado" "$(uname -r)"
elif [ "$(uname -s)" = "Linux" ]; then
  sistema="linux"
  distro=$(. /etc/os-release 2>/dev/null && echo "${PRETTY_NAME:-Linux}")
  ok "Linux" "$distro"
elif [ "$(uname -s)" = "Darwin" ]; then
  sistema="macos"
  aviso "macOS" "no es un sistema soportado oficialmente"
  pista "Los comandos del taller funcionan, pero el soporte se da para Windows y Linux."
else
  error "Sistema no reconocido" "$(uname -s)"
  pista "En Windows debes ejecutar esto dentro de WSL, no en PowerShell."
fi

# El repositorio en /mnt/c desde WSL es entre 5 y 20 veces más lento.
if [ "$sistema" = "wsl" ]; then
  case "$PWD" in
    /mnt/[a-z]/*)
      aviso "Ubicación del repositorio" "está en el disco de Windows"
      pista "Estás en: $PWD"
      pista "Muévelo al sistema de archivos de Linux para que no vaya lento:"
      pista "  cp -r \"$PWD\" ~/  &&  cd ~/$(basename "$PWD")"
      ;;
    *) ok "Ubicación del repositorio" "sistema de archivos de Linux" ;;
  esac
fi

# ------------------------------------------------------------- herramientas
titulo "Herramientas"

# bash 4 o superior: el taller usa arreglos asociativos y expansión de llaves
bash_mayor="${BASH_VERSINFO[0]:-0}"
if [ "$bash_mayor" -ge 4 ]; then
  ok "bash" "${BASH_VERSION%%(*}"
else
  error "bash" "versión ${BASH_VERSION:-desconocida}, se requiere 4 o mayor"
fi

if command -v git >/dev/null 2>&1; then
  ok "git" "$(git --version | awk '{print $3}')"
else
  error "git" "no instalado"
  pista "Ubuntu/Debian/WSL:  sudo apt install git"
  pista "Fedora:             sudo dnf install git"
fi

if command -v curl >/dev/null 2>&1; then
  ok "curl" "$(curl --version | head -1 | awk '{print $2}')"
else
  error "curl" "no instalado"
  pista "Ubuntu/Debian/WSL:  sudo apt install curl"
fi

# ----------------------------------------------------------------- node
titulo "Node.js"

if command -v node >/dev/null 2>&1; then
  ruta_node=$(command -v node)
  version_node=$(node --version)
  mayor_node=$(echo "$version_node" | sed 's/^v//' | cut -d. -f1)

  # Node instalado en Windows y visible desde WSL: causa errores irreproducibles
  case "$ruta_node" in
    /mnt/[a-z]/*)
      error "node" "estás usando el Node de Windows desde WSL"
      pista "Ruta detectada: $ruta_node"
      pista "Instala Node dentro de WSL con nvm. Ver setup/windows.md, sección 4."
      ;;
    *)
      if [ "${mayor_node:-0}" -ge 18 ]; then
        ok "node" "$version_node"
      else
        error "node" "$version_node, se requiere 18 o mayor"
        pista "Actualiza con:  nvm install --lts && nvm use --lts"
      fi
      ;;
  esac
else
  error "node" "no instalado"
  pista "Se necesita para los servidores MCP del módulo 4."
  pista "Instálalo con nvm. Ver setup/linux.md o setup/windows.md."
fi

if command -v npx >/dev/null 2>&1; then
  ok "npx" "disponible"
else
  error "npx" "no disponible"
  pista "Viene con Node. Si falta, reinstala Node."
fi

# ------------------------------------------------------------ asistente
titulo "Asistente de IA"

if command -v claude >/dev/null 2>&1; then
  ok "claude" "$(claude --version 2>/dev/null | head -1)"
  pista "Diagnóstico detallado:  claude doctor"
else
  aviso "claude" "no instalado"
  pista "Instálalo con:  curl -fsSL https://claude.ai/install.sh | bash"
  pista "Requiere cuenta de pago. El plan gratuito no incluye Claude Code."
  pista "Si usas otro asistente con CLI, coméntalo con los instructores."
fi

# ---------------------------------------------------------- repositorio
titulo "Repositorio"

if [ -d .git ]; then
  ok "repositorio git" "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
else
  error "repositorio git" "no estás dentro del repositorio clonado"
  pista "Ejecuta este script desde la raíz de taller_instalacion."
fi

# Si este archivo tiene CRLF, .gitattributes no se aplicó y los scripts fallarán
propio="${BASH_SOURCE[0]}"
if [ -f "$propio" ] && grep -qU $'\r' "$propio" 2>/dev/null; then
  error "fin de línea" "CRLF detectado en los scripts"
  pista "Corrígelo con:"
  pista "  git config core.autocrlf false"
  pista "  git rm --cached -r . && git reset --hard"
else
  ok "fin de línea" "LF"
fi

if [ -f datos/fda/Products.txt ] && [ -f datos/ventas_enero.csv ]; then
  ok "datos de práctica" "presentes"
else
  aviso "datos de práctica" "no encontrados"
  pista "Ejecútalo desde la raíz del repositorio."
fi

# ------------------------------------------------------------ resultado
printf '\n'
if [ "$fallas" -eq 0 ] && [ "$avisos" -eq 0 ]; then
  printf ' %sEntorno listo.%s Nos vemos en la sesión 1.\n\n' "$VERDE" "$FIN"
  exit 0
elif [ "$fallas" -eq 0 ]; then
  printf ' %s%d aviso(s)%s y ningún error. Puedes empezar el taller.\n\n' "$AMBAR" "$avisos" "$FIN"
  exit 0
else
  printf ' %s%d error(es)%s y %d aviso(s). Resuelve los errores antes de la sesión 1.\n' \
    "$ROJO" "$fallas" "$FIN" "$avisos"
  printf ' Si te atoras, abre un issue pegando esta salida completa.\n\n'
  exit 1
fi
