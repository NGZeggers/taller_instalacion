# Más allá del chat: el CLI en tu día a día

**Parte 2 del taller.** Aquí no vamos a instalar nada nuevo: vamos a ver qué se puede hacer
con lo que ya instalaste, y por qué es un mundo distinto al chat de una página web.

---

## Parte 0 — La diferencia que lo explica todo

Cuando usas Claude o ChatGPT en el navegador, tú eres el intermediario. Tú copias el archivo,
tú pegas el error, tú bajas el resultado, tú lo pruebas, tú regresas a contarle qué pasó.

En la Terminal, el asistente hace todo eso solo. Ve tus archivos, ejecuta comandos, lee lo que
salió, y corrige. Tú describes el objetivo; él da las vueltas.

| | Chat en el navegador | CLI en tu Terminal |
|---|---|---|
| Ver tus archivos | Solo lo que subes, uno por uno | Carpetas completas, miles de archivos |
| Ejecutar comandos | No puede | Sí, y lee el resultado |
| Corregir sus errores | Tú le dices qué falló | Lo ve solo y vuelve a intentar |
| Datos grandes | Se topa con el límite | Escribe un script y lo procesa |
| Tu hardware | Invisible | Wifi, USB, cámara, disco, batería |
| Resultado | Texto que copias | Archivos reales en tu carpeta |

### La parte honesta: el límite no desaparece, cambia de estrategia

Vas a oír que "el CLI no tiene límite de contexto". **No es cierto**, y conviene que lo entiendas
bien para no frustrarte.

El límite existe igual. Lo que cambia es **cómo se usa**:

- El **chat ingiere**: para saber qué hay en un archivo, tiene que meterlo entero en la conversación.
  Diez archivos grandes y ya no cabe nada más.
- El **CLI busca**: usa herramientas para *filtrar antes de leer*. Busca la palabra en 4.000 archivos,
  encuentra que aparece en 6, y lee solo esos 6. O escribe un programa que procese los 4.000 y lee
  únicamente el resumen de 20 líneas.

Es la diferencia entre leerte la biblioteca completa y saber usar el catálogo. Por eso puede
trabajar con volúmenes que al chat lo ahogan: **casi nunca lee todo, y no lo necesita.**

---

## Parte 1 — Tu computadora deja de ser una caja negra

Esta es la parte que más sorprende a quien viene de usar solo el chat.

**No tienes que aprenderte ningún comando.** Describes el síntoma en español y el asistente
sabe qué revisar, lo ejecuta, y te traduce el resultado.

### Cómo se pide

Abre la Terminal y escribe `claude`. Luego, literalmente:

```
Mi wifi va lentísimo desde hace dos días. Averigua qué está pasando
y explícamelo sin tecnicismos.
```

```
Conecté un pendrive y no aparece en el Finder. ¿Puedes ver si la
computadora lo está detectando?
```

```
El micrófono no funciona en las videollamadas pero sí en las notas
de voz. Diagnostica el problema.
```

```
Se me llenó el disco y no sé con qué. Encuentra las 20 carpetas que
más espacio ocupan en mi usuario y dime qué puedo borrar sin riesgo.
```

```
La batería me dura la mitad que antes. Revisa el estado real de la
batería y qué programas están consumiendo más.
```

```
Mi Mac va lenta desde que la encendí. ¿Qué está corriendo en segundo
plano que no debería?
```

### Qué ejecuta por debajo

No necesitas memorizar esto. Está aquí para que veas que no es magia: son comandos que macOS
ya trae, y que el asistente sabe interpretar.

| Quieres saber | Comando real |
|---|---|
| Estado y velocidad del wifi | `system_profiler SPAirPortDataType` |
| Velocidad real de tu internet | `networkQuality` |
| Si hay pérdida de paquetes | `ping -c 20 1.1.1.1` |
| Qué dispositivos USB detecta | `system_profiler SPUSBHostDataType` |
| Discos y pendrives conectados | `diskutil list` |
| Micrófonos y salidas de audio | `system_profiler SPAudioDataType` |
| Cámaras disponibles | `system_profiler SPCameraDataType` |
| Bluetooth y sus dispositivos | `system_profiler SPBluetoothDataType` |
| Espacio libre en disco | `df -h` |
| Qué carpeta ocupa más | `du -sh * \| sort -hr \| head -20` |
| Salud y carga de la batería | `pmset -g batt` |
| Qué consume CPU ahora mismo | `top -o cpu` |
| Qué programa está usando la red | `sudo lsof -i -P \| grep LISTEN` |
| Pantallas y tarjeta gráfica | `system_profiler SPDisplaysDataType` |
| Memoria RAM instalada | `system_profiler SPMemoryDataType` |

> 💡 **El truco que vale el taller entero:** cuando algo de tu computadora falle, en vez de buscar
> en Google y pegar comandos que no entiendes, describe el síntoma en la Terminal. El asistente
> ejecuta el diagnóstico, lee la salida cruda, y te dice qué significa.

### Reglas de seguridad — léelas antes de la primera vez

El asistente puede ejecutar comandos reales en tu computadora. Eso es justo lo que lo hace útil,
y también lo que exige criterio.

1. **Te va a pedir permiso antes de cada acción.** Léelo. No aceptes en automático.
2. **Desconfía de `sudo`.** Significa "hazlo como administrador". Para *diagnosticar* casi nunca
   hace falta. Si aparece un `sudo` en algo que solo debía leer información, pregunta por qué.
3. **Ojo con `rm`.** Borra sin papelera: no hay "deshacer". Si ves un `rm -rf`, detente y pide
   que te explique exactamente qué va a borrar antes de aceptar.
4. **Empieza en una carpeta de pruebas**, no en tu carpeta de documentos importantes.
5. **Si el proyecto te importa, usa Git.** Con `git init` y commits frecuentes, cualquier cambio
   se puede revertir. Pídele que lo configure por ti.

---

## Parte 2 — Datos masivos: lo que el chat simplemente no puede

Aquí es donde, como ingeniero, la diferencia deja de ser comodidad y pasa a ser capacidad.

### El escenario

Tienes una carpeta con **400 archivos CSV** de mediciones. O 2 GB de logs. O 80 hojas de Excel
que te mandaron distintas áreas durante el año.

**En el chat web:** subes tres o cuatro archivos y ya no caben más. Y aunque cupieran, el modelo
no *calcula* de verdad: estima leyendo, y con miles de filas se equivoca.

**En el CLI:** el asistente nunca intenta leerlos todos. Hace algo mucho más parecido a lo que
harías tú:

```
1. Mira UN archivo para entender la estructura     →  head -5 datos_001.csv
2. Cuenta el volumen real                          →  wc -l *.csv
3. Escribe un programa que procese los 400
4. Lo ejecuta
5. Lee solo el resultado: 20 líneas de resumen
6. Si algo no cuadra, corrige el programa y repite
```

De 2 GB de datos, a la conversación solo entran unas líneas. El trabajo pesado lo hace el
programa, no el modelo. **Por eso los números salen bien: los calcula una máquina, no una
estimación de lenguaje.**

### Cómo se pide

```
En ~/Datos/mediciones hay unos 400 CSV. Explora primero la estructura
de uno, luego escribe un script que los una todos, y dime:
cuántas filas hay en total, qué rango de fechas cubren, cuántos
valores faltantes hay por columna y qué archivos tienen formato
distinto al resto.
```

```
Esta carpeta tiene 2 GB de logs. Encuentra todos los errores, agrúpalos
por tipo, y dime cuáles son los 10 más frecuentes y a qué horas se
concentran.
```

```
Tengo 80 archivos de Excel de distintas áreas, cada uno con columnas
diferentes. Haz un inventario: qué columnas tiene cada uno, cuáles se
repiten, y propón un esquema común para unificarlos.
```

```
Busca en todo este proyecto dónde se menciona el cliente "ACME",
en cualquier tipo de archivo, y dame el contexto de cada aparición.
```

### Con qué formatos funciona

CSV, Excel (`.xlsx`), JSON, XML, logs de texto, PDFs, bases de datos SQLite, Parquet, archivos
comprimidos. Si hace falta una librería (`pandas`, `openpyxl`), el asistente la instala él mismo.

> ⚠️ **Un dato sensible sigue siendo un dato sensible.** Lo que el asistente lee viaja a los
> servidores de Anthropic. Si trabajas con información confidencial de tu empresa o datos
> personales de terceros, ve a la **Parte 4**: ahí es donde los modelos locales dejan de ser
> curiosidad y pasan a ser la respuesta correcta.

---

## Parte 3 — De los datos a una página web que puedes volver a usar

Un resumen en la Terminal se pierde cuando cierras la ventana. Una página web se queda.

Este es el paso que convierte un análisis de una sola vez en una herramienta:

```
Con los resultados del análisis anterior, créame una página web en un
solo archivo HTML con:
- un resumen arriba con los números principales
- una gráfica de la evolución mensual
- una tabla que pueda filtrar y ordenar
- que funcione sin internet, abriendo el archivo directamente
```

Y después:

```
Ahora haz que pueda arrastrar un CSV nuevo a la página y que se
recalcule todo automáticamente.
```

Ese segundo paso es el importante. Deja de ser un reporte y se convierte en **una herramienta
que vas a usar el mes que viene sin volver a pedir nada.**

### Ideas que funcionan bien

- Un panel del avance de tus proyectos, que lee de una carpeta local
- Una calculadora con las fórmulas específicas de tu especialidad
- Un visor de planos, mediciones o series de tiempo
- Un formulario que genera reportes con el formato que te exigen
- Un comparador de cotizaciones de proveedores

### Compartirlo

Pídele que publique la página como **Artifact** y te da un enlace privado que puedes compartir
con tu equipo. Sin servidor, sin hosting, sin configurar nada. Justo así se hizo la guía de
instalación de la Parte 1.

---

## Parte 4 — LLMs locales: Ollama y Hugging Face

Un modelo local corre **dentro de tu computadora**. Sin internet, sin cuenta, sin que ningún
dato salga de tu máquina.

### Cuándo tiene sentido de verdad

| Motivo | Por qué importa |
|---|---|
| **Privacidad** | Datos de clientes, información médica, contratos, cosas bajo NDA |
| **Costo cero por uso** | Procesar 50.000 registros no te cuesta nada extra |
| **Sin internet** | Obra, planta, avión, sitios remotos |
| **Volumen** | Clasificar miles de documentos donde no importa la brillantez, sino terminar |

### Instalar y usar Ollama

```bash
brew install ollama
```

Arranca el servidor (déjalo corriendo en su propia ventana de Terminal):

```bash
ollama serve
```

En otra ventana, descarga un modelo y pruébalo:

```bash
ollama pull llama3.2
ollama run llama3.2
```

Para salir del chat del modelo: `/bye`.

### Qué modelo elegir según tu RAM

Para saber cuánta tienes: menú  → *Acerca de esta Mac*.

| RAM | Modelos recomendados | Tamaño aprox. |
|---|---|---|
| 8 GB | `llama3.2:3b`, `phi4-mini` | 2–3 GB |
| 16 GB | `qwen2.5:7b`, `llama3.1:8b`, `mistral` | 4–5 GB |
| 32 GB o más | `qwen2.5:14b`, `gemma2:27b` | 9–17 GB |

Regla práctica: el modelo debe ocupar **menos de la mitad** de tu RAM. Si se pasa, tu Mac va a
usar disco como memoria y todo se vuelve insoportablemente lento.

Comandos útiles:

```bash
ollama list          # qué modelos tienes descargados
ollama rm <modelo>   # borrar uno que ya no uses
ollama ps            # qué está cargado en memoria ahora
```

### Hugging Face: el repositorio de todo lo demás

Ollama es cómodo pero tiene un catálogo limitado. Hugging Face tiene **cientos de miles** de
modelos, incluidos los especializados: traducción, transcripción de audio, visión, modelos
entrenados para un dominio concreto.

```bash
pip3 install --user huggingface_hub
```

```bash
hf auth login                              # solo para modelos privados o restringidos
hf download <organizacion>/<modelo>        # descargar
hf cache scan                              # ver qué tienes y cuánto ocupa
hf cache delete                            # liberar espacio
```

> Los modelos se guardan en `~/.cache/huggingface` y **ocupan mucho**. Revisa `hf cache scan`
> cada cierto tiempo o te vas a quedar sin disco sin darte cuenta.

### La parte honesta: qué NO esperes de un modelo local

Esto es importante decirlo, porque la decepción viene de expectativas mal puestas.

Un modelo de 7B en tu laptop **no es comparable** a Claude o GPT en calidad de razonamiento.
Va a ser más lento, se va a equivocar más, y con tareas complejas se pierde.

**Úsalo para:** clasificar, extraer campos de documentos, resumir textos cortos, traducir,
transcribir, filtrar grandes volúmenes, cualquier cosa repetitiva y acotada.

**No lo uses para:** razonamiento complejo, escribir código no trivial, análisis que requiera
criterio, nada donde un error salga caro.

### La combinación que sí es potente

No es "local *o* nube". Es **local *y* nube**, cada uno en lo suyo:

```
Tengo 3.000 informes en PDF con datos confidenciales de clientes.
Escribe un script que use el modelo local de Ollama para extraer de
cada uno el nombre del proyecto, la fecha y el monto, y que guarde
todo en un CSV. Los datos no deben salir de mi computadora.
```

Claude Code —que es bueno razonando— **escribe el programa**. El modelo local —que es privado y
gratis— **procesa los datos sensibles**. Lo confidencial nunca sale de tu máquina, y aun así
tuviste ayuda de primer nivel para construir la solución.

---

## Parte 5 — Proyectos personales

Un puñado de cosas reales que se pueden pedir tal cual, sin saber programar:

**Automatizar lo tedioso**
```
Todos los lunes recibo un Excel con el mismo formato. Escribe un script
que lo procese, genere el reporte en PDF y lo guarde con la fecha en el
nombre.
```

**Ordenar el caos**
```
Mi carpeta de Descargas tiene 2.000 archivos. Organízalos en subcarpetas
por tipo y por año, pero enséñame primero qué vas a hacer, sin ejecutarlo.
```

**Multimedia** (necesitas `brew install ffmpeg`)
```
Convierte todos los videos de esta carpeta a MP4 comprimido, y extrae
el audio de cada uno como MP3 aparte.
```

**Aprender**
```
Explícame qué hace este script línea por línea, como si nunca hubiera
programado.
```

**Publicar**
```
Convierte mi CV en una página web personal y publícala.
```

---

## Parte 6 — Cómo trabajar bien con el asistente

Lo que separa a quien le saca provecho de quien se frustra:

1. **Di el objetivo, no los pasos.** "Quiero saber por qué mi wifi va lento" funciona mejor que
   "ejecuta system_profiler". Él sabe los pasos; tú sabes lo que quieres.

2. **Pide el plan antes de la ejecución** cuando algo sea delicado: *"enséñame qué vas a hacer,
   sin ejecutarlo todavía"*.

3. **Da contexto que él no puede ver.** "Este CSV lo exporta un sensor cada 10 minutos y las
   filas con valor -999 son fallos de lectura" le ahorra tres intentos.

4. **Corrígelo sin rodeos.** "No, la columna de fecha está en formato europeo" y sigue adelante.
   Es una conversación, no un formulario.

5. **Usa `/clear` entre tareas distintas.** Arrastrar una conversación larga de otro tema lo
   confunde y gasta contexto.

6. **Empieza cada proyecto con `/init`.** Analiza la carpeta y crea un archivo de contexto para
   que no tengas que reexplicar de qué va todo cada vez.

---

## En una frase

> El chat te da **respuestas**. El CLI te da **resultados**: archivos creados, datos procesados,
> problemas diagnosticados y herramientas que se quedan funcionando en tu computadora.

Uno te ayuda a pensar. El otro trabaja contigo.
