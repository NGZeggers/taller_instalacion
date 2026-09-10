# Paso 3 — Escribe el encargo

**Minuto 0:35 · 25 minutos**

## Dos instrucciones para la misma tarea

**A**

> Límpiame este CSV.

**B**

> Limpia `datos/ventas_febrero_sucio.csv`. Normaliza las fechas al formato
> AAAA-MM-DD, quita el símbolo de moneda de la columna de precio, elimina la
> fila duplicada exacta y marca con `REVISAR` las filas con campos vacíos en
> lugar de borrarlas. No modifiques el original. Escribe el resultado en
> `salidas/ventas_febrero_limpio.csv`. Al terminar, reporta cuántas filas
> entraron, cuántas salieron y cuántas quedaron marcadas.

La instrucción A no es más corta: es igual de larga, solo que las decisiones
las va a tomar el modelo y tú no te vas a enterar de cuáles tomó.

## Las cinco partes

| Parte | Qué responde |
|---|---|
| **Objetivo** | Qué debe existir al final que no existe ahora |
| **Insumos** | Qué archivos usar, con ruta exacta |
| **Restricciones** | Qué no debe hacer, qué no debe tocar |
| **Salida** | Dónde queda el resultado y con qué estructura |
| **Aceptación** | Cómo se comprueba que está bien |

La que más se omite es la última, y es la que más sirve. Si no puedes
escribirla, todavía no entiendes bien la tarea.

## Arma el tuyo

Si practicas con los datos de ejemplo, míralos antes de escribir nada:

```bash
head -6 datos/ventas_febrero_sucio.csv
```

Vas a ver, al menos: tres formatos de fecha distintos, precios con y sin
símbolo de moneda, una fila repetida, una fila con un campo vacío, una
sucursal escrita de tres maneras y un vendedor con dos grafías.

Escribe tu encargo completo. **Todavía no lo ejecutes.**

```
Objetivo:

Insumos:

Restricciones:

Salida:

Criterio de aceptación:
```

Decisiones que tienes que tomar tú, no el modelo:

- La fila con el campo vacío: ¿se borra, se marca o se rellena?
- Los nombres con distinta capitalización: ¿cuál es la forma correcta?
- El original: ¿se modifica o se deja intacto?

## Un antipatrón que vale la pena nombrar

Pedirle al modelo que revise su propio trabajo no es verificación. Va a
confirmar su respuesta con seguridad. Verificar es contrastar contra algo
externo: la fuente, un comando, una suma que debe cuadrar.


## Cómo queda

Pega tu encargo en `NOTAS.md`, debajo de tu propósito.

```
mi-proyecto/
├── datos/
├── salidas/
└── NOTAS.md        ← ahora contiene el encargo completo, en cinco partes
```

El criterio de aceptación que acabas de escribir **es lo que vas a ejecutar
en el paso 5**. Si quedó vago, ahí te vas a dar cuenta.
