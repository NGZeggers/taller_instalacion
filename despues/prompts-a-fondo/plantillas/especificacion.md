# Especificación de tarea

Copia esta plantilla y llénala antes de escribirle nada al asistente.
Si no puedes llenar una sección, ese es el trabajo que falta hacer.

---

## Objetivo

Qué debe existir al final que no existe ahora. Una o dos frases, en
resultado, no en actividad.

> Ejemplo: un archivo CSV con las ventas de febrero normalizadas, listo para
> importarse al sistema contable.

## Insumos

Archivos, datos y contexto que el asistente necesita. Rutas exactas.

- `ruta/al/archivo.csv` — qué contiene y qué formato tiene
- `ruta/al/ejemplo-de-salida.csv` — cómo debe verse el resultado

## Restricciones

Qué no debe hacer. Lo que no está prohibido, se lo va a permitir.

- No modificar los archivos originales.
- No inventar valores para campos faltantes.
- No cambiar el orden de las columnas.
- No tocar nada fuera de `salidas/`.

## Formato de salida

Dónde queda el resultado, con qué nombre y con qué estructura.

- Ruta: `salidas/nombre.csv`
- Columnas, en este orden: ...
- Codificación: UTF-8, fin de línea LF
- Además, un reporte en pantalla con: filas de entrada, filas de salida,
  filas descartadas y el motivo de cada descarte.

## Criterio de aceptación

Cómo se comprueba que quedó bien. Tiene que ser verificable por alguien más,
con un comando o una revisión concreta.

1. El total de filas de salida es igual al de entrada menos los duplicados.
2. Todas las fechas cumplen el patrón AAAA-MM-DD:
   `grep -cv '^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\},' salidas/nombre.csv` devuelve 1
   (solo el encabezado).
3. La suma de la columna cantidad coincide con la del original.
4. Ninguna sucursal del original desapareció.

## Qué NO se delega

La parte que sigue siendo tuya, y por qué.

> Ejemplo: la decisión de qué hacer con las filas incompletas. El asistente
> las marca; yo decido si se imputan o se descartan.

## Verificación realizada

Se llena después de ejecutar.

| Criterio | Resultado | Comando o evidencia |
|---|---|---|
| 1 |  |  |
| 2 |  |  |
| 3 |  |  |
| 4 |  |  |
