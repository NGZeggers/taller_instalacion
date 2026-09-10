# Ejercicio 2 — Tuberías, filtros y redirección

Todos los datos están en `datos/`. Guarda cada resultado
en `salidas/` con el nombre indicado.

1. ¿Cuántas ventas se registraron en enero? Cuenta las filas de datos, sin
   contar el encabezado. → `salidas/01-total-ventas.txt`
2. Lista las sucursales que aparecen en enero, sin repetir y ordenadas
   alfabéticamente. → `salidas/02-sucursales.txt`
3. ¿Cuántas ventas hizo cada vendedor en enero? Ordena de mayor a menor.
   → `salidas/03-ventas-por-vendedor.txt`
4. Extrae todas las filas de enero de la sucursal Zapopan, conservando el
   encabezado. → `salidas/04-zapopan.csv`
5. En `datos/notas/`, encuentra todas las líneas que mencionan un pendiente
   con responsable Campos. → `salidas/05-pendientes-campos.txt`
6. Lista los alumnos de `inscripciones.csv` cuyo estatus no sea `activo`.
   → `salidas/06-no-activos.txt`
7. Cuenta cuántos alumnos hay por carrera, ordenados de mayor a menor.
   → `salidas/07-por-carrera.txt`

**Comandos que vas a necesitar:** `cut`, `sort`, `uniq`, `grep`, `wc`,
`head`, `tail`.

**Sobre el punto 4:** conservar el encabezado necesita dos comandos y un
`>>`. Piensa qué escribe cada uno.

**Sobre el punto 7:** `uniq -c` solo agrupa líneas idénticas y consecutivas.
Tienes que ordenar antes.
