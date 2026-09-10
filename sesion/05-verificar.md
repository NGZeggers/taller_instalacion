# Paso 5 — Verifica y deja el proyecto reproducible

**Minuto 1:30 · 25 minutos**

Aquí es donde el taller se separa de una demostración. Vas a ejecutar el
criterio de aceptación que escribiste en el paso 3, con los comandos que
aprendiste en el paso 2.

## Uno · cuenta

Lo primero es siempre lo mismo: ¿entró y salió lo que debía?

```bash
ls datos | wc -l
ls salidas | wc -l
wc -l salidas/*.csv
```

Si el número no cuadra, el flujo perdió o duplicó algo. Averigua cuál antes
de seguir.

## Dos · busca lo que debería y lo que no debería estar

```bash
# ¿quedaron valores sin normalizar?
grep -c 'DESCONOCIDO\|REVISAR' salidas/*.csv

# ¿alguna categoría desapareció en el camino?
cut -d, -f2 salidas/*.csv | sort -u

# ¿el original sigue intacto?
ls -l datos | head
```

## Tres · compara contra la fuente, a mano

Toma dos o tres registros al azar y contrástalos con el original. No con la
vista: abre los dos y compara el dato exacto.

```bash
head -5 datos/tu_archivo_original
head -5 salidas/tu_resultado
```

> **Si no encontraste nada raro, comprueba una cosa más.** Casi siempre hay
> algo: una capitalización que no se normalizó, un espacio que sobrevivió,
> un registro que se marcó cuando debía descartarse, una referencia que
> apunta a una página que no existe. Encontrarlo es el resultado del taller,
> no un contratiempo.

## Cuatro · cierra el proyecto

Escribe en `NOTAS.md`, debajo de tu encargo:

1. **Qué comprobaste**, con el comando exacto que usaste.
2. **Qué salió mal**, y cómo lo detectaste.
3. **Qué no delegaste**, y por qué. Siempre hay algo.

## Cómo queda

```
mi-proyecto/
├── datos/          ← intacto, verificable
├── salidas/        ← el resultado, comprobado
├── NOTAS.md        ← propósito · encargo · verificación · límites
└── .mcp.json       ← reproducible en cualquier máquina
```

Eso es una automatización. Alguien más puede clonar esa carpeta, leer
`NOTAS.md` y repetir exactamente lo que hiciste. Y tú puedes volver en tres
meses y entender por qué tomaste cada decisión.
