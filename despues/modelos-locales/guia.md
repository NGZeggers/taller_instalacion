> **Material de autoestudio.** Continúa el paso 4 de la sesión. Es la respuesta
> a la pregunta que siempre sale: qué hacer cuando los datos no pueden salir de
> tu máquina.

# Modelos locales: Ollama y Hugging Face

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

