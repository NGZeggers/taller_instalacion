# Reto — Medicina y ciencias de la salud

## Gestión de literatura y extracción de datos

### Situación

Estás haciendo una revisión de literatura. Tienes cuarenta artículos en PDF
con nombres de archivo inservibles y necesitas una tabla de evidencia.

### Qué construir

1. Normaliza los nombres de archivo al formato `autor-año-titulo-corto.pdf`.
2. Extrae de cada estudio: población, intervención, comparador, desenlace,
   tamaño de muestra y diseño.
3. Detecta duplicados y artículos que no cumplen los criterios de inclusión
   que tú definas.
4. Produce una tabla de evidencia en CSV lista para revisión manual.

### Datos

Artículos de acceso abierto (PubMed Central, SciELO). **Prohibido cualquier
dato de pacientes identificables.**

### Verificación obligatoria

- Toma tres artículos y compara los datos extraídos contra el texto original.
  Los tamaños de muestra son especialmente propensos a errores de extracción.
- Comprueba que los artículos excluidos lo fueron por el criterio correcto.
- Verifica que ninguna referencia bibliográfica esté inventada. Las citas
  fabricadas son el modo de fallo más conocido de estas herramientas.

### Límite profesional

Ningún resumen sustituye la lectura del artículo original. Ninguna salida de
este flujo fundamenta una decisión clínica. La tabla de evidencia es un
punto de partida para revisar, no un resultado.
