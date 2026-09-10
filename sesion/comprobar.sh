#!/usr/bin/env bash
# Comprueba las tres respuestas del bloque 1.
#
#   bash sesion/comprobar.sh
#
# Ejecútalo desde la raíz del repositorio. Te pide cada respuesta y te dice
# si coincide. No te da el resultado: te dice si el tuyo es el correcto.

set -uo pipefail

if ! printf '%s' "${LC_ALL:-${LANG:-}}" | grep -qi 'utf-\?8'; then
  for c in C.UTF-8 en_US.UTF-8 es_MX.UTF-8; do
    locale -a 2>/dev/null | grep -qi "^${c%.*}\.utf-\?8$" && { export LC_ALL="$c"; break; }
  done
fi

VERDE=$'\033[32m'; ROJO=$'\033[31m'; GRIS=$'\033[90m'; FIN=$'\033[0m'
[ -t 1 ] || { VERDE=""; ROJO=""; GRIS=""; FIN=""; }

CSV="datos/ventas_enero.csv"
[ -f "$CSV" ] || { printf '%sEjecútalo desde la raíz del repositorio.%s\n' "$ROJO" "$FIN" >&2; exit 1; }

# Respuestas calculadas en vivo desde los datos, no escritas a mano
r1=$(tail -n +2 "$CSV" | wc -l | tr -d ' ')
r2=$(grep -c ',Zapopan,' "$CSV")
r3=$(cut -d, -f6 "$CSV" | tail -n +2 | sort | uniq -c | sort -rn | head -1 | sed 's/^ *[0-9]* *//')

aciertos=0

normaliza() {
  printf '%s' "$1" | sed 's/^ *//;s/ *$//' | tr '[:upper:]' '[:lower:]' \
    | sed 'y/áéíóúüñ/aeiouun/'
}

preguntar() {
  local num="$1" texto="$2" correcta="$3" pista="$4" respuesta
  printf '\n %s\n' "$texto"
  printf ' Tu respuesta: '
  read -r respuesta

  # Compara sin distinguir mayúsculas, acentos ni espacios sobrantes:
  # nadie debe fallar por no escribir la tilde de Núñez.
  local a b
  a=$(normaliza "$respuesta")
  b=$(normaliza "$correcta")

  if [ "$a" = "$b" ]; then
    printf ' %s✓ correcto%s\n' "$VERDE" "$FIN"
    aciertos=$((aciertos+1))
  else
    printf ' %s✗ no es esa%s\n' "$ROJO" "$FIN"
    printf ' %s%s%s\n' "$GRIS" "$pista" "$FIN"
  fi
}

printf '\n Bloque 1 — comprobación\n'

preguntar 1 "1. ¿Cuántas ventas se registraron en enero, sin el encabezado?" \
  "$r1" "Pista: wc -l cuenta líneas, y el encabezado es una de ellas."

preguntar 2 "2. ¿Cuántas de esas ventas fueron en Zapopan?" \
  "$r2" "Pista: grep tiene una opción para contar en lugar de mostrar."

preguntar 3 "3. ¿Qué vendedor aparece más veces? (nombre completo)" \
  "$r3" "Pista: la misma línea que armamos juntos, con la columna 6."

printf '\n %d de 3\n\n' "$aciertos"
if [ "$aciertos" -eq 3 ]; then
  printf ' %sListo.%s Pasa al bloque 2.\n\n' "$VERDE" "$FIN"
else
  printf ' Revisa la chuleta y vuelve a intentar. Si te atoras, levanta la mano.\n\n'
fi
