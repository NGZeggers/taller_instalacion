# Módulo 3 — Delegar tareas, no solo preguntar


> **Material de autoestudio.** Esto no se ve en la sesión de 2 horas.
> Las carpetas de entrega y la evaluación por evidencias corresponden a la
> versión larga del curso; ignóralas si estás repasando por tu cuenta.

**Duración:** 3 horas · **Evidencia:** especificación con casos de prueba

## La diferencia

Una pregunta busca información. Un encargo busca un resultado. Comparemos:

> Pregunta: ¿cómo limpio un CSV con fechas inconsistentes?

> Encargo: Limpia `datos/ventas_febrero_sucio.csv`. Normaliza las fechas a
> AAAA-MM-DD, quita el símbolo de moneda de la columna de precio, elimina la
> fila duplicada exacta y marca con `REVISAR` las filas con campos vacíos en
> lugar de borrarlas. Deja el resto igual. Escribe el resultado en
> `salidas/ventas_febrero_limpio.csv` sin modificar el original. Al terminar,
> reporta cuántas filas entraron, cuántas salieron y cuántas quedaron marcadas.

La segunda es más larga porque contiene decisiones que alguien tenía que
tomar. Si no las tomas tú, las toma el modelo, y no te vas a enterar de
cuáles tomó.

## Anatomía de un encargo

Cinco partes. Si falta alguna, el modelo la va a inventar.

| Parte | Pregunta que responde |
|---|---|
| **Objetivo** | ¿Qué debe existir al final que no existe ahora? |
| **Insumos** | ¿Qué archivos, datos o contexto tiene que usar? |
| **Restricciones** | ¿Qué no debe hacer? ¿Qué no debe tocar? |
| **Formato de salida** | ¿Dónde queda el resultado y con qué estructura? |
| **Criterio de aceptación** | ¿Cómo se comprueba que está bien? |

El criterio de aceptación es el que más se omite y el que más sirve. Si no
puedes escribirlo, todavía no entiendes bien la tarea.

## Gestión de contexto

El modelo solo sabe lo que le das. Dos errores opuestos:

- **Poco contexto:** le pides que respete "el formato de siempre" sin
  mostrarle un ejemplo.
- **Demasiado contexto:** le vacías cuarenta archivos y el detalle que
  importaba se pierde entre el ruido.

Regla práctica: da los archivos que un colega nuevo necesitaría para hacer
la tarea, ni uno más.

Para instrucciones que se repiten en todas las conversaciones de un
proyecto, usa un archivo persistente en la raíz. Ver
[`plantillas/CLAUDE.md.ejemplo`](plantillas/CLAUDE.md.ejemplo).

## Descomposición

Para tareas largas, pide primero el plan y revísalo antes de que ejecute.
Corregir un plan de seis líneas cuesta menos que deshacer cuarenta archivos
mal generados.

```
Antes de escribir nada, dime en qué pasos lo vas a hacer y qué archivos
vas a tocar. Espera mi confirmación.
```

## Antipatrones

| Antipatrón | Qué produce | Qué hacer |
|---|---|---|
| "Mejora esto" | Cambios arbitrarios que no puedes evaluar | Define qué significa mejor y en qué dimensión |
| Volcar todo el proyecto | Respuestas genéricas, el detalle se diluye | Da lo mínimo necesario |
| Aceptar sin leer | Errores que descubres tarde y caros | Define el criterio de aceptación antes |
| Prompt cada vez más largo | Instrucciones que se contradicen entre sí | Reescribe desde cero, no parches |
| Pedirle que verifique su trabajo | Se autoconfirma con seguridad | Verifica tú, con una herramienta distinta |

Ese último merece énfasis: preguntarle al modelo si su respuesta es correcta
no es verificación. Verificar es contrastar contra algo externo: la fuente
original, un comando de la terminal, una suma que debe cuadrar.

## Evaluación de prompts

Antes de escribir la instrucción, escribe los casos de prueba. Al menos
tres, y al menos uno que debería fallar:

1. **Caso normal:** la entrada típica.
2. **Caso límite:** entrada vacía, un solo registro, valores extremos.
3. **Caso que debe rechazarse:** algo que la instrucción prohíbe.

Plantilla en [`casos-de-prueba/plantilla.md`](casos-de-prueba/plantilla.md).

## Actividad en clase

**Reescritura por pares.** Cada quien trae tres peticiones vagas que haya
hecho realmente. En parejas, se convierten en especificaciones completas
usando [`plantillas/especificacion.md`](plantillas/especificacion.md).

**Duelo de prompts.** Dos equipos, la misma tarea, el mismo criterio de
aceptación acordado de antemano. Gana el que pase más casos de prueba, no el
que escriba más bonito.

## Entrega

En `tus-entregas/modulo-3-especificacion.md`: la especificación de la
tarea que elegiste en el módulo 1, con tres casos de prueba y el resultado
de cada uno.
