# Para seguir por tu cuenta

Este material no cabe en dos horas. No es relleno: es lo que hace la
diferencia entre haber visto una demostración y poder trabajar así.

Está ordenado por dependencia. Si vas a hacer solo uno, haz el primero.

## 1. Elige mejor qué automatizar

`inventario-de-tareas/`

Antes de automatizar algo hay que saber qué vale la pena automatizar. Una
plantilla para mirar tu propia semana y elegir un caso con criterio, en lugar
de automatizar lo primero que se te ocurra.

**Toma:** 30 minutos. **Depende de:** nada.

## 2. Terminal a fondo

`terminal-a-fondo/`

Lo que se recortó del bloque 1: git completo, permisos, variables de entorno,
instalación de paquetes, y el problema de fin de línea entre Windows y Linux.
Incluye ejercicios con comprobador automático.

**Toma:** 3 a 4 horas. **Depende de:** haber sobrevivido al bloque 1.

## 3. De los datos a una herramienta que se queda

`de-datos-a-herramienta/`

Un resumen en la terminal se pierde al cerrar la ventana. Convierte tu salida
en una página web de un solo archivo, con gráficas y tabla filtrable, a la que
puedas arrastrar el archivo del mes siguiente y que se recalcule sola.

**Toma:** 2 a 3 horas. **Depende de:** el paso 5 de la sesión.

## 4. Prompts a fondo

`prompts-a-fondo/`

La plantilla completa de especificación, cómo escribir casos de prueba antes
de la instrucción, y un ejemplo de archivo de instrucciones persistentes para
un proyecto.

**Toma:** 2 horas. **Depende de:** el bloque 2 de la sesión.

## 5. Modelos locales: Ollama y Hugging Face

`modelos-locales/`

Un modelo que corre dentro de tu computadora, sin internet y sin que ningún
dato salga. Es la respuesta correcta para información confidencial y para
procesar volúmenes donde el costo por uso importa.

La combinación potente no es local *o* nube: el asistente de nube escribe el
programa, el modelo local procesa los datos sensibles.

**Toma:** 3 horas. **Depende de:** el paso 4 de la sesión.

## 6. Conecta el asistente con tu software de 3D

`diseno-3d/`

Blender y FreeCAD exponen su API por MCP: el asistente crea geometría, corre
análisis, renderiza y exporta desde la terminal. Pero lo que mejor funciona
hoy es el **CAD por código** (OpenSCAD, CadQuery, build123d), porque el modelo
escribe un archivo de texto que *es* la pieza: se versiona con git y se revisa
en un diff.

Incluye lo importante: cómo verificar geometría midiendo en lugar de mirar
—caja envolvente, volumen, si la malla cierra— y qué funciona hoy y qué no.

**Toma:** 3 a 4 horas. **Depende de:** los pasos 4 y 5 de la sesión.

## 7. MCP a fondo

`mcp-a-fondo/`

Arquitectura del protocolo, las tres primitivas, plantilla de configuración
comentada y una ficha para documentar el riesgo de cada servidor que
conectes.

**Toma:** 2 a 3 horas. **Depende de:** el bloque 3 de la sesión.

## 8. De proyecto a flujo que corre solo

`proyecto-final/` y `retos-completos/`

Convertir tu carpeta en algo que se ejecuta con un comando, se repite cada
mes y avisa cuando algo no cuadra. Es el salto de «me funcionó una vez» a
«lo uso». Incluye casos desarrollados para seis áreas de trabajo distintas.

**Toma:** 6 horas o más. **Depende de:** todo lo anterior.

---

## La versión completa

Estos ocho bloques más la sesión de dos horas dan material para un curso de
30 horas. Si tu coordinación lo quiere en ese formato, habla con los
instructores.
