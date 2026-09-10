# Módulo 5 — Dinámica aplicada a tu carrera


> **Material de autoestudio.** Esto no se ve en la sesión de 2 horas.
> Las carpetas de entrega y la evaluación por evidencias corresponden a la
> versión larga del curso; ignóralas si estás repasando por tu cuenta.

**Duración:** 3 horas · **Evidencia:** automatización funcional y defensa

## Formato

| Tiempo | Actividad |
|---|---|
| 15 min | Formación de equipos por carrera y elección del reto |
| 90 min | Construcción, con asesoría de los instructores |
| 15 min | Descanso y preparación de la defensa |
| 50 min | Defensas de 5 minutos por equipo |
| 10 min | Coevaluación y cierre |

Equipos de 3 o 4 personas, agrupados por afinidad disciplinar. Si tu carrera
no está en [`../retos-completos/`](../retos-completos/), elige el reto más cercano y adáptalo; avísale
a los instructores al inicio.

## Qué se construye

Una **automatización mínima viable**: algo que funcione de principio a fin
sobre un caso real, aunque sea pequeño. Un flujo completo que ahorra veinte
minutos vale más que un prototipo ambicioso que no corre.

## La defensa

Cinco minutos, cuatro cosas:

1. **El problema.** Qué tarea, cuánto tiempo tomaba, con qué frecuencia.
2. **El flujo.** Qué hace, ejecutado en vivo desde la terminal. Diapositivas
   con capturas no cuentan.
3. **El error.** Al menos un caso donde el modelo se equivocó, cómo lo
   detectaron y qué cambiaron. Un equipo que no encontró ningún error no
   verificó lo suficiente.
4. **El límite.** Qué parte del trabajo no delegaron y por qué.

## Rúbrica

| Criterio | Peso | Qué se busca |
|---|---|---|
| Funciona | 30 % | El flujo se ejecuta completo en vivo, sin intervención manual no declarada |
| Verificación | 30 % | Existen comprobaciones concretas y se ejecutaron; el error encontrado es real |
| Especificación | 20 % | La instrucción es reproducible por otra persona sin explicación adicional |
| Criterio profesional | 20 % | Los límites disciplinares están identificados y respetados |

Un flujo que corre pero cuya verificación es "lo revisamos y se ve bien"
pierde los 30 puntos de verificación.

## Reglas de datos

Todos los retos se resuelven con datos **sintéticos, públicos o
anonimizados**. Nada de expedientes, historiales clínicos, nóminas,
entrevistas sin consentimiento o material bajo secreto profesional.

Si tu caso real solo funciona con datos sensibles, construye una versión con
datos falsos que tengan la misma estructura. Esa restricción es parte del
ejercicio profesional, no un obstáculo del taller.

## Entrega

En `tus-entregas/`:

- `README.md` con el problema, el flujo y cómo ejecutarlo.
- Los archivos del flujo: scripts, especificaciones, configuración MCP.
- `bitacora-verificacion.md` con las comprobaciones y el error encontrado.
- Datos de ejemplo, sintéticos.
