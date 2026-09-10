# Ejercicio 3 — Datos sucios y delegación

El archivo `datos/ventas_febrero_sucio.csv` tiene problemas reales. Esta es
la primera vez que vas a delegarle trabajo al asistente, pero **primero
tienes que saber tú qué está mal**.

## Parte A: diagnóstico manual

Sin usar el asistente, encuentra y anota:

1. ¿Cuántos formatos de fecha distintos hay? Da un ejemplo de cada uno.
2. ¿Cuántas filas tienen el precio con símbolo de moneda?
3. Hay una fila duplicada. Encuéntrala con `sort` y `uniq -d`.
4. Hay una fila con un campo vacío. ¿Cuál es y qué campo le falta?
5. El nombre de una sucursal aparece escrito de tres formas distintas.
   ¿Cuál es y cuáles son las tres formas?
6. Un vendedor aparece con dos grafías distintas. ¿Quién?

Guarda tus hallazgos en `salidas/08-diagnostico.md`.

## Parte B: delegación

Ahora sí, abre el asistente en la raíz del repositorio:

```bash
claude
```

Pídele que limpie el archivo. Antes de escribir la instrucción, decide:

- **Formato de salida:** ¿qué columnas, en qué orden, con qué nombres?
- **Reglas de normalización:** ¿a qué formato van las fechas? ¿los precios
  llevan símbolo? ¿los nombres propios van con qué capitalización?
- **Qué hacer con la fila incompleta:** ¿se elimina, se marca, se imputa?
- **Criterio de aceptación:** ¿cómo vas a comprobar que quedó bien?

Escribe la instrucción completa **antes** de mandarla, y guárdala en
`salidas/09-instruccion.md`.

## Parte C: verificación

El asistente produjo `ventas_febrero_limpio.csv`. Ahora compruébalo desde
la terminal, no leyéndolo a ojo:

1. ¿Tiene el número de filas que esperabas? Recuerda que había un duplicado.
2. ¿Todas las fechas tienen el mismo formato? Verifícalo con `grep -c`.
3. ¿Los totales cuadran? Suma la columna de cantidad antes y después.
4. ¿Se perdió alguna sucursal en el camino? Compara las listas.

Anota qué comprobaste y qué encontraste en `salidas/10-verificacion.md`.

> Si el asistente hizo todo bien a la primera, tu verificación tiene que
> demostrarlo. "Se ve bien" no es una verificación.
