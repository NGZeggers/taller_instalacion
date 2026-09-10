# Paso 1 — Tu computadora deja de ser una caja negra

**Minuto 0:00 · 20 minutos**

## Primero, pruébalo

No tienes que aprenderte ningún comando. Describes el síntoma en español, el
asistente decide qué revisar, lo ejecuta y te traduce el resultado.

Abre la terminal, escribe `claude` y pídele esto tal cual:

> Se me está llenando el disco y no sé con qué. Encuentra las 20 carpetas que
> más espacio ocupan en mi usuario, dime cuánto ocupa cada una, y señala
> cuáles se pueden borrar sin riesgo y cuáles no.

Otras que funcionan igual de bien:

> Esta carpeta de Descargas tiene cientos de archivos. Dime cuántos hay por
> tipo, cuáles están duplicados y cuál es el más viejo.

> Encuentra todos los archivos de más de 100 MB en mi carpeta personal y dime
> de qué son.

### Qué pasa por debajo

No es magia. Son comandos que tu sistema ya trae:

| Lo que quieres saber | Lo que ejecuta |
|---|---|
| Espacio libre en disco | `df -h` |
| Qué carpeta ocupa más | `du -sh * \| sort -hr \| head -20` |
| Archivos grandes | `find ~ -size +100M` |
| Cuántos archivos por tipo | `ls \| sed 's/.*\.//' \| sort \| uniq -c` |

**El truco que vale el taller entero:** cuando algo falle, en vez de buscar en
Google y pegar comandos que no entiendes, describe el síntoma.

> **Si estás en Windows con WSL, hay un límite honesto.** WSL ve tus archivos
> pero no tu hardware: no puede diagnosticar wifi, batería ni micrófono,
> porque pertenecen a Windows. Todo lo de archivos y disco sí funciona,
> incluido `/mnt/c`.

### Tres reglas antes de la primera vez

1. **Te pide permiso antes de cada acción. Léelo.** Es el único momento en que
   puedes detener algo.
2. **Desconfía de `sudo`.** Para diagnosticar casi nunca hace falta. Si
   aparece en algo que solo debía leer información, pregunta por qué.
3. **Ojo con `rm`.** Borra sin papelera. Si ves un `rm -rf`, pide que te
   explique exactamente qué va a borrar antes de aceptar.

---

## Ahora elige tu propósito

Todo lo que sigue trabaja sobre lo que decidas aquí. No hay un propósito
correcto: hay uno que a ti te ahorra tiempo.

## Seis propósitos frecuentes

Elige uno. Si tu caso no está, el más parecido funciona: la mecánica es
idéntica.

| # | Propósito | Qué traes |
|---|---|---|
| 1 | **Ordenar un montón de archivos.** Renombrar con una convención y armar un índice | Una carpeta desordenada, copiada |
| 2 | **Sacar datos de documentos a una tabla.** Información atrapada en PDF, actas o reportes | 3 a 5 documentos parecidos |
| 3 | **Procesar un volumen que no cabe en el chat.** Cientos de CSV, gigabytes de logs, decenas de hojas con formatos distintos | Tus archivos, anonimizados |
| 4 | **Resumir o comparar textos largos.** Extraer lo importante con su referencia exacta | 2 o 3 textos largos |
| 5 | **Entender un proyecto que no escribiste.** Mapear qué hace cada archivo | Un repositorio pequeño |
| 6 | **Repetir un reporte que haces siempre.** Dejarlo como un flujo de un comando | Los insumos y un reporte anterior |

Si trabajas con modelos 3D o CAD, el propósito 3 o el 5 aplican igual: revisar
un lote de STL, extraer medidas de un conjunto de piezas, entender un
proyecto paramétrico ajeno. La conexión con Blender y FreeCAD está en
`despues/diseno-3d/`.

> **Sin datos de terceros.** Nada de expedientes, historiales, nóminas o
> material bajo confidencialidad. Si tu caso real solo funciona con datos
> sensibles, arma una copia con tres registros falsos de la misma estructura.
> Esa restricción no es del taller: es de tu profesión.

## Crea la estructura

```bash
cd ~
mkdir -p mi-proyecto/datos mi-proyecto/salidas
cd mi-proyecto
touch NOTAS.md
```

Copia tus archivos a `datos/`. Si están en Windows y trabajas desde WSL:

```bash
cp -r /mnt/c/Users/TU_USUARIO/Documentos/tu-carpeta/* datos/
```

## Cómo queda

```
mi-proyecto/
├── datos/          ← aquí van tus archivos, y no se tocan
├── salidas/        ← vacía por ahora
└── NOTAS.md        ← vacío por ahora
```

**Por qué dos carpetas y no una.** `datos/` es de solo lectura por
convención: es tu material original y no se modifica nunca. `salidas/` es
desechable: si algo sale mal, la borras y vuelves a generar. Esa separación
es lo que te permite equivocarte sin miedo.

## Antes de pasar al siguiente

Escribe tu propósito en `NOTAS.md`, en una frase. Lo vas a necesitar en el
paso 3.
