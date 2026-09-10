# Guion de la sesión

Para Alberto y David. 120 minutos exactos, sin margen.

## Principio de diseño

El taller no enseña cuatro temas: **construye un proyecto**. Cada paso deja
una pieza en la carpeta de cada participante, y al final la ejecutan.

```
mi-proyecto/
├── datos/          paso 1
├── salidas/        paso 4
├── NOTAS.md        pasos 1, 3 y 5
└── .mcp.json       paso 4
```

Ese árbol se proyecta al inicio y se vuelve a mostrar al cerrar cada paso,
con lo nuevo resaltado. Es el hilo visual de toda la sesión: la gente ve que
va acumulando algo, no que va viendo temas.

Si el tiempo aprieta, se recorta el paso 1 a cinco minutos. **La
verificación del paso 5 no se recorta nunca.**

## Antes de la sesión

- Verificación de instalación cerrada **48 horas antes**. Quien no pasó el
  script no puede seguir el ritmo; se le ofrece la siguiente fecha.
- Recordarles por mensaje que **traigan material propio**. Sin material, el
  taller se convierte en una demostración.
- Proyector con fuente grande. La terminal al frente debe leerse desde atrás.
- Alberto conduce; David circula resolviendo atascos individuales.
- Una laptop de respaldo ya configurada, para emparejar a quien llegue con el
  equipo roto.

---

## 0:00 — 0:20 · La caja negra, y elige tu propósito

**Abrir ejecutando, no explicando.** Al frente, en la terminal:

> Se me está llenando el disco y no sé con qué. Encuentra las 20 carpetas que
> más espacio ocupan y dime cuáles puedo borrar sin riesgo.

Que vean al asistente elegir el comando, ejecutarlo y traducir la salida. Es
el momento de mayor impacto de toda la sesión y no cuesta preparación.

Enseguida, las tres reglas: lee el permiso, desconfía de `sudo`, ojo con `rm`.

Advertir el límite de WSL sin rodeos: ve archivos, no ve hardware. Los de
Windows hacen la prueba sobre `/mnt/c`.

Después proyectar el árbol del proyecto: «esto es lo que van a tener al
salir». Sin diapositivas de contexto ni historia de los modelos.

Presentar los seis propósitos de [`01-proposito.md`](01-proposito.md) en
treinta segundos cada uno y pedir que elijan **en voz alta, por mesa**. Sirve
para dos cosas: los compromete, y ustedes detectan de inmediato a quien no
trajo material.

Todos ejecutan el `mkdir` y crean la estructura. Que escriban su propósito en
`NOTAS.md` antes de avanzar.

**No hacer:** preguntar de qué carrera es cada quien. El propósito importa,
la disciplina no.

## 0:20 — 0:45 · Terminal sobre datos reales

Todos escriben. Nadie mira.

Abrir con `du -sh datos/fda` y `wc -l`: 931 mil filas, 40 MB. Preguntar al
grupo cuántas de esas líneas creen que va a leer el modelo. La respuesta
—casi ninguna— es el concepto del bloque: **el chat ingiere, el CLI busca.**

Once comandos, en este orden: `pwd`, `ls`, `cd`, `head`, `wc -l`, `grep`,
`cut`, `sort`, `uniq`, la tubería `|` y la redirección `>`.

Construir en pantalla la consulta de formas farmacéuticas, un comando a la
vez. Resumir 50 mil filas en menos de un segundo.

**No saltarse el bloque del `^M`.** Es el mejor momento del taller para la
diferencia Windows/Linux, porque no es teoría: son datos reales que traen
CRLF y descuadran el conteo. `cat -A` lo revela, `tr -d '\r'` lo arregla.

Después, que apliquen lo mismo a **su** carpeta: cuántos archivos hay, qué
tan parecidos son, qué quieren sacar de ahí.

**La traducción a PowerShell se menciona una vez, sin detenerse.** Está en la
chuleta para quien la quiera. Decirlo así: «lo que escriben hoy existe con
otro nombre en Windows nativo; la idea es la misma, y la tabla está en la
chuleta».

## 0:45 — 1:10 · El encargo

Ejercicio de contraste, cinco minutos: proyectar las dos instrucciones y que
el grupo diga qué decisiones tomó el modelo por su cuenta en la primera.

Presentar las cinco partes. Es el único marco conceptual de la sesión.

Cada quien escribe el suyo, ocho minutos, sobre su propio propósito. Leer dos
o tres en voz alta y señalar qué falta. **Casi siempre falta el criterio de
aceptación**, y ahí conviene insistir: es lo que van a ejecutar en el paso 5.

## 1:10 — 1:40 · Conectar y ejecutar

Tres minutos de explicación con un dibujo en el pizarrón: modelo aislado,
protocolo, servidor. Tres primitivas mencionadas, no desarrolladas.

Todos conectan su propia carpeta, con alcance a `datos/` y `salidas/`.
Señalar que esas rutas son el límite y pedirles que intenten sacar al
asistente de ahí. Que vean el rechazo.

Mandan su encargo. Mientras trabaja, explicar los dos riesgos: privilegio
mínimo, e instrucciones escondidas en el contenido que el modelo lee.

## 1:40 — 1:55 · Verificar

Este es el bloque que justifica el taller. Nadie acepta su resultado sin
correr al menos dos comprobaciones desde la terminal.

Preguntar en voz alta a quién le falló algo. **Si nadie levanta la mano,
decirlo directo: entonces nadie verificó.** Repartir treinta segundos más y
volver a preguntar.

Cierre del proyecto: qué comprobaste, qué salió mal, qué no delegaste.

## 1:55 — 2:00 · Cierre

Tres cosas, sin adornos:

1. La carpeta que tienen es suya y funciona. La chuleta se queda con ellos.
2. `despues/` tiene la ruta para hacerla más sólida: git, casos de prueba,
   servidores propios, y convertirla en algo que corre solo.
3. La responsabilidad no se delega. Cerrar con esta frase, no con una
   invitación a usar más la herramienta.

Dos punteros de `despues/` que conviene tener a mano, porque son las
preguntas que siempre salen:

- **«¿y si mis datos son confidenciales?»** → modelos locales, bloque 5.
- **«¿esto sirve para Blender o para CAD?»** → sí, bloque 6. Blender y FreeCAD
  se conectan por MCP igual que la carpeta de hoy, y el CAD por código es
  donde mejor funciona. Con un grupo de ingeniería, esta pregunta sale seguro.

---

## Plan B

| Si pasa | Qué hacer |
|---|---|
| La red se cae | El paso 2 funciona sin internet. Adelantarlo y correr los pasos 4 y 5 en la máquina del instructor, proyectada |
| Alguien no instaló nada | Emparejarlo de inmediato. No detener al grupo |
| Alguien no trajo material | Que use `datos/fda` y elija el propósito 3 |
| El paso 2 se alarga | Recortar el cierre a 2 minutos y quitar el ejercicio de contraste del paso 3 |
| Todos terminan antes | Que rompan su propio flujo: entrada vacía, un solo archivo, un campo con coma dentro de comillas |
| Nadie encuentra errores del modelo | Repartir un caso preparado con un error real. Que lo encuentren ellos |
