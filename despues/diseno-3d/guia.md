# Conectar el asistente con tu software de 3D

> **Material de autoestudio.** Continúa el paso 4 de la sesión: es el mismo
> MCP, apuntando a otra herramienta. Y el paso 5 se vuelve más interesante,
> porque verificar geometría se hace midiendo, no mirando.

**Toma:** 3 a 4 horas · **Depende de:** los pasos 4 y 5 de la sesión

---

## Dos caminos, y no son equivalentes

### Camino A — conectar la aplicación por MCP

Blender y FreeCAD exponen su API de Python, y hay servidores MCP que la
traducen a herramientas que el asistente puede llamar. El asistente crea
objetos, aplica materiales, corre análisis, renderiza y exporta.

La arquitectura es siempre la misma:

```
tu terminal  ──stdio──▶  servidor MCP  ──TCP local──▶  add-on dentro de la app
```

El add-on corre **dentro** de Blender o FreeCAD, escuchando en un puerto
local. Eso significa que la aplicación tiene que estar abierta y con el
add-on activo: no es headless.

### Camino B — CAD por código

OpenSCAD, CadQuery y build123d describen geometría con texto. El asistente
no manipula una interfaz: **escribe un archivo que es la pieza.**

Esto encaja mucho mejor con todo lo del taller:

- Se versiona con git. Un cambio de diseño es un diff que puedes leer.
- Se regenera desde cero, siempre igual. No hay estado escondido.
- El asistente es bueno en esto, porque es código, que es lo que mejor hace.
- Revisar el resultado no requiere abrir nada: lees veinte líneas.

**Si estás empezando, empieza por el camino B.** El A es más vistoso en una
demostración; el B es el que vas a seguir usando en tres meses.

---

## Camino B en la práctica

### Instalar

```bash
# macOS
brew install openscad
pip install cadquery build123d trimesh

# Linux / WSL
sudo apt install openscad
pip install cadquery build123d trimesh
```

En WSL, OpenSCAD sin interfaz gráfica funciona bien para generar archivos;
para ver el modelo, abre el `.stl` resultante desde Windows.

### Un encargo de ejemplo

Las cinco partes del paso 3, aplicadas a una pieza:

```
OBJETIVO:
Una brida de montaje paramétrica en OpenSCAD, lista para imprimir.

INSUMOS:
Las medidas están en medidas.md. Diámetro exterior 80 mm, cuatro barrenos
M4 en círculo de 60 mm, espesor 6 mm, chaflán de 1 mm en los bordes
exteriores. La impresora tiene tolerancia de 0.2 mm en agujeros.

RESTRICCIONES:
Todas las medidas como variables al principio del archivo, con nombre y
unidad en un comentario. Nada de números mágicos en el cuerpo. No uses
módulos externos ni bibliotecas.

SALIDA:
brida.scad, y el STL generado en salidas/brida.stl.
Al terminar, reporta el volumen y la caja envolvente.

CRITERIO DE ACEPTACIÓN:
- La caja envolvente mide 80 x 80 x 6 mm, con 0.1 mm de tolerancia.
- Los cuatro barrenos miden 4.2 mm de diámetro, no 4.0.
- La malla es cerrada (watertight) y sin caras invertidas.
- Cambiar la variable del diámetro a 100 regenera la pieza sin errores.
```

### Generar sin abrir nada

```bash
openscad -o salidas/brida.stl brida.scad
```

Con CadQuery, desde Python:

```bash
python -c "
import cadquery as cq
pieza = cq.importers.importStep('pieza.step')
cq.exporters.export(pieza, 'salidas/pieza.stl')
"
```

---

## Verificar geometría: medir, no mirar

Esta es la parte que conecta con el paso 5 del taller, y es donde la mayoría
de la gente falla: mira el render, le parece bien, y manda a imprimir una
pieza que no cierra.

```bash
pip install trimesh
```

```python
import trimesh
m = trimesh.load('salidas/brida.stl')

print('caja envolvente:', m.bounding_box.extents)   # ¿mide lo que pediste?
print('volumen mm³:', m.volume)
print('cerrada:', m.is_watertight)                   # imprescindible para imprimir
print('normales bien:', m.is_winding_consistent)
print('componentes sueltos:', len(m.split(only_watertight=False)))
```

Cuatro comprobaciones que atrapan casi todo:

| Qué revisas | Por qué importa |
|---|---|
| **Caja envolvente** | Si no mide lo que pediste, el modelo entendió otra cosa |
| **`is_watertight`** | Una malla abierta no se puede imprimir ni analizar |
| **Componentes sueltos** | Más de uno suele significar geometría que quedó flotando |
| **Volumen** | Contra un cálculo a mano: detecta agujeros que no se restaron |

Para tolerancias y espesores, mide en el archivo fuente, no en la malla: en
CAD por código las medidas están escritas y se pueden leer con `grep`.

---

## Camino A: conectar Blender o FreeCAD

### Blender

Blender mantiene un servidor MCP en su laboratorio, con documentación
oficial en <https://www.blender.org/lab/mcp-server/> y código en
<https://projects.blender.org/lab/blender_mcp>. Da acceso en lenguaje
natural a la API de Python, a la documentación y al manual.

También hay servidores de la comunidad, algunos con integraciones para
bibliotecas de recursos. Revisa quién los mantiene antes de instalarlos: un
servidor MCP ejecuta código en tu máquina.

El flujo típico: instalas el add-on en Blender, lo activas, y registras el
servidor MCP en tu proyecto. Después:

> Crea una escena con la brida que está en salidas/brida.stl, ponle un
> material metálico, tres luces de tres puntos y renderiza una vista
> isométrica a 1920x1080 en salidas/render.png.

Para lotes sin interfaz, Blender corre headless y no necesita MCP:

```bash
blender --background --python renderizar.py -- salidas/brida.stl
```

Esa es la forma correcta de renderizar cuarenta piezas: un script, no
cuarenta conversaciones.

### FreeCAD

Hay varios servidores MCP para FreeCAD, con distinto alcance: creación de
sólidos, operaciones booleanas, análisis FEM con CalculiX, generación de
planos, ejecución de Python arbitrario. Casi todos funcionan igual: instalas
un add-on, arrancas un servidor RPC desde la consola de Python de FreeCAD, y
el servidor MCP se conecta a él.

FreeCAD también corre sin interfaz:

```bash
FreeCADCmd script.py
```

---

## La parte honesta

Los modelos son buenos escribiendo el **código** que genera geometría, y
malos razonando sobre la geometría misma.

**Funciona bien hoy:**

- Piezas paramétricas sencillas: bridas, soportes, cajas, adaptadores.
- Variaciones de algo que ya existe: cambiar medidas, agregar barrenos.
- Procesamiento por lotes: convertir formatos, revisar mallas, renderizar.
- Traducir de un lenguaje CAD a otro.
- Explicarte un archivo de otra persona.

**Todavía no:**

- Geometría orgánica o compleja. Se pierde.
- Ensambles con muchas restricciones entre piezas.
- Cualquier cosa donde el criterio de diseño sea el trabajo, no la ejecución.

La división es la misma de todo el taller: **tú pones la intención de diseño
y el criterio profesional; el asistente pone la mecánica.** Si una pieza va a
soportar carga, va a una máquina o se va a fabricar, la revisión es tuya y
no se delega.

---

## Riesgos específicos

- Un servidor MCP de una aplicación de 3D suele poder **ejecutar Python
  arbitrario** dentro de ella. Eso es mucho más alcance que leer una carpeta.
  Aplica el mismo criterio del paso 4: privilegio mínimo, y lee lo que va a
  ejecutar antes de aprobar.
- Los archivos CAD de tu trabajo suelen ser **propiedad del cliente o de la
  empresa**. Antes de conectarlos a un asistente en la nube, revisa si puedes.
  Si no, el bloque de modelos locales es el camino.
- No mandes a fabricar nada que no hayas medido tú.
