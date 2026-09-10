#!/usr/bin/env bash
# Comprueba las salidas de los ejercicios del módulo 2.
# No te da la respuesta: te dice si la tuya coincide con la esperada.
#
#   bash modulo-2-terminal/ejercicios/comprobar.sh
#
# Ejecútalo desde la raíz del repositorio.

set -uo pipefail

VERDE=$'\033[32m'; ROJO=$'\033[31m'; GRIS=$'\033[90m'; FIN=$'\033[0m'
[ -t 1 ] || { VERDE=""; ROJO=""; GRIS=""; FIN=""; }

DATOS="datos"
SALIDAS="salidas"

aciertos=0
total=0

if [ ! -d "$DATOS" ]; then
  printf '%sEjecuta este script desde la raíz del repositorio.%s\n' "$ROJO" "$FIN" >&2
  exit 1
fi

# revisar <número> <descripción> <archivo> <valor esperado>
# Compara ignorando espacios sobrantes y líneas vacías.
revisar() {
  local num="$1" desc="$2" archivo="$3" esperado="$4"
  total=$((total+1))

  if [ ! -f "$SALIDAS/$archivo" ]; then
    printf '  %s✗%s %-2s %-42s %sfalta %s%s\n' \
      "$ROJO" "$FIN" "$num" "$desc" "$GRIS" "$SALIDAS/$archivo" "$FIN"
    return
  fi

  local obtenido
  obtenido=$(tr -d '\r' < "$SALIDAS/$archivo" | sed '/^[[:space:]]*$/d' \
             | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr -s ' ')
  local limpio
  limpio=$(printf '%s' "$esperado" | sed '/^[[:space:]]*$/d' \
           | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr -s ' ')

  if [ "$obtenido" = "$limpio" ]; then
    printf '  %s✓%s %-2s %s\n' "$VERDE" "$FIN" "$num" "$desc"
    aciertos=$((aciertos+1))
  else
    printf '  %s✗%s %-2s %-42s %sno coincide%s\n' \
      "$ROJO" "$FIN" "$num" "$desc" "$GRIS" "$FIN"
  fi
}

# existe <número> <descripción> <archivo>
# Para respuestas escritas, donde no hay una única salida correcta.
existe() {
  local num="$1" desc="$2" archivo="$3"
  total=$((total+1))
  if [ -s "$SALIDAS/$archivo" ]; then
    printf '  %s✓%s %-2s %s\n' "$VERDE" "$FIN" "$num" "$desc"
    aciertos=$((aciertos+1))
  else
    printf '  %s✗%s %-2s %-42s %sfalta o está vacío%s\n' \
      "$ROJO" "$FIN" "$num" "$desc" "$GRIS" "$FIN"
  fi
}

printf '\n Comprobación — módulo 2\n\n Ejercicio 2: tuberías y filtros\n'

revisar 1 "total de ventas de enero" "01-total-ventas.txt" \
  "$(tail -n +2 "$DATOS/ventas_enero.csv" | wc -l | tr -d ' ')"

revisar 2 "sucursales sin repetir" "02-sucursales.txt" \
  "$(cut -d, -f2 "$DATOS/ventas_enero.csv" | tail -n +2 | sort -u)"

revisar 3 "ventas por vendedor" "03-ventas-por-vendedor.txt" \
  "$(cut -d, -f6 "$DATOS/ventas_enero.csv" | tail -n +2 | sort | uniq -c | sort -rn)"

revisar 4 "filas de Zapopan con encabezado" "04-zapopan.csv" \
  "$(head -1 "$DATOS/ventas_enero.csv"; grep '^[^,]*,Zapopan,' "$DATOS/ventas_enero.csv")"

revisar 5 "pendientes de Campos" "05-pendientes-campos.txt" \
  "$(grep -h 'Responsable: Campos' "$DATOS"/notas/*.txt)"

revisar 6 "alumnos no activos" "06-no-activos.txt" \
  "$(tail -n +2 "$DATOS/inscripciones.csv" | grep -v ',activo$')"

revisar 7 "alumnos por carrera" "07-por-carrera.txt" \
  "$(cut -d, -f3 "$DATOS/inscripciones.csv" | tail -n +2 | sort | uniq -c | sort -rn)"

printf '\n Ejercicio 3: datos sucios\n'
existe 8  "diagnóstico manual"        "08-diagnostico.md"
existe 9  "instrucción de limpieza"   "09-instruccion.md"
existe 10 "bitácora de verificación"  "10-verificacion.md"

printf '\n Ejercicio 4: control de versiones\n'
total=$((total+1))
commits=$(git rev-list --count HEAD 2>/dev/null || echo 0)
if [ "$commits" -ge 3 ]; then
  printf '  %s✓%s 11 al menos tres commits (%s)\n' "$VERDE" "$FIN" "$commits"
  aciertos=$((aciertos+1))
else
  printf '  %s✗%s 11 %-42s %ssolo %s%s\n' "$ROJO" "$FIN" "al menos tres commits" "$GRIS" "$commits" "$FIN"
fi

printf '\n %d de %d\n' "$aciertos" "$total"
if [ "$aciertos" -eq "$total" ]; then
  printf ' %sTodo correcto.%s Guarda esta salida para tu entrega.\n\n' "$VERDE" "$FIN"
else
  printf ' %sLos que no coinciden%s suelen fallar por el encabezado del CSV,\n' "$GRIS" "$FIN"
  printf ' por el orden de la salida o por no haber ordenado antes de agrupar.\n\n'
fi
