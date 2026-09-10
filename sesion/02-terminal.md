# Paso 2 — Mira tus datos desde la terminal

**Minuto 0:10 · 25 minutos**

Aquí la diferencia deja de ser comodidad y pasa a ser capacidad. Vas a
trabajar sobre un conjunto real: **931 mil filas en 12 archivos, 40 MB**. En el
chat web no cabría ni la décima parte.

## El límite no desaparece: cambia de estrategia

Vas a oír que «el CLI no tiene límite de contexto». **No es cierto.** El límite
existe igual; lo que cambia es cómo se usa:

- **El chat ingiere.** Para saber qué hay en un archivo tiene que meterlo
  entero en la conversación. Diez archivos grandes y ya no cabe nada más.
- **El CLI busca.** Filtra antes de leer. Busca una palabra en 4.000 archivos,
  encuentra que aparece en 6, y lee solo esos 6. O escribe un programa que
  procese los 4.000 y lee únicamente el resumen de 20 líneas.

Es la diferencia entre leerte la biblioteca completa y saber usar el catálogo.
Por eso puede con volúmenes que al chat lo ahogan: **casi nunca lee todo, y no
lo necesita.**

```bash
du -sh datos/fda
wc -l datos/fda/*.txt | tail -1
```

```
40M	datos/fda
931538 total
```

Son los registros públicos de medicamentos aprobados por la FDA. Nadie va a
leer eso, ni tú ni el modelo. Se consulta.

Once comandos alcanzan, y son los mismos que vas a usar en el paso 5 para
verificar lo que el asistente hizo.

Ten abierta la [chuleta](chuleta.md) en otra pestaña.

## Calentamiento

Escríbelos tú, no los copies con el ratón. La memoria está en los dedos.

```bash
pwd
ls
ls datos
head -3 datos/ventas_enero.csv
wc -l datos/ventas_enero.csv
```

## La línea que construimos juntos

Se arma un pedazo a la vez. Ejecuta cada versión y observa qué cambia.

```bash
cut -d, -f2 datos/ventas_enero.csv
cut -d, -f2 datos/ventas_enero.csv | tail -n +2
cut -d, -f2 datos/ventas_enero.csv | tail -n +2 | sort
cut -d, -f2 datos/ventas_enero.csv | tail -n +2 | sort | uniq -c
cut -d, -f2 datos/ventas_enero.csv | tail -n +2 | sort | uniq -c | sort -rn
```

Cada `|` toma lo que salió del comando anterior y se lo pasa al siguiente.
Eso es todo lo que hay que entender.

## Tres preguntas, diez minutos

Responde con un solo comando cada una. Anota el que usaste.

**1.** ¿Cuántas ventas se registraron en enero, sin contar el encabezado?

**2.** ¿Cuántas de esas ventas fueron en la sucursal Zapopan?

**3.** ¿Qué vendedor aparece más veces en enero?

<details>
<summary>Pistas, si te atoras más de tres minutos</summary>

1. `wc -l` cuenta líneas. El encabezado es una de ellas.
2. `grep` filtra líneas, y tiene una opción para contarlas en lugar de mostrarlas.
3. Es la misma línea que construimos juntos, cambiando el número de columna.
   Los vendedores están en la columna 6.

</details>

## El error que vas a encontrar con datos de verdad

Pide la **última** columna de otro archivo:

```bash
cut -f4 datos/fda/Applications.txt | tail -n +2 | sort | uniq -c | sort -rn | head -3 | cat -A
```

```
    902 WATSON LABS^M$
    559 HIKMA^M$
    474 CHARTWELL RX^M$
```

Ese `^M` es un carácter invisible. **Estos datos vienen de Windows**, que
termina cada línea con dos caracteres donde Linux usa uno. El sobrante se pega
al último campo de cada fila y contamina cualquier comparación.

```bash
cut -f4 datos/fda/Applications.txt | tail -n +2 | tr -d '\r' | sort | uniq -c | sort -rn | head -3
```

Este es el error número uno al mover datos entre Windows y Linux, y es
invisible hasta que te muerde: los totales no cuadran, un filtro no encuentra
nada, dos valores idénticos aparecen como distintos. `cat -A` te lo enseña y
`tr -d '\r'` lo arregla.

## Comprobación

```bash
bash sesion/comprobar.sh
```

## Ahora sobre tus datos

Cámbiate a tu proyecto y responde tres preguntas sobre **tu** material.
Anota las respuestas en `NOTAS.md`.

```bash
cd ~/mi-proyecto
ls datos | wc -l
ls -lh datos | head
```

1. ¿Cuántos archivos tienes, y de qué tipos?
2. ¿Qué tan parecidos son entre sí? Abre dos con `head -20` y compara.
3. ¿Qué quieres extraer, ordenar o transformar exactamente de ahí?

## Cómo queda

```
mi-proyecto/
├── datos/          ← tus archivos, ya copiados
├── salidas/
└── NOTAS.md        ← tu propósito + lo que encontraste al mirar
```

## Una advertencia

`rm` borra sin papelera y sin preguntar. Antes de borrar con un patrón,
ejecuta el mismo patrón con `ls` para ver qué se va a ir.

Nunca pegues un comando que encontraste en internet sin leerlo completo.
