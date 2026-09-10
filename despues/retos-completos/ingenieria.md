# Reto — Ingeniería y ciencias computacionales

## Flujo de trabajo sobre un repositorio real

### Situación

Tienes un repositorio propio con deuda técnica, sin pruebas suficientes y
con tareas manuales repetidas.

### Qué construir

Elige uno:

1. **Refactor guiado por pruebas.** Escribe pruebas para un módulo, luego
   delega el refactor con la condición de que las pruebas sigan pasando.
2. **Servidor MCP propio.** Construye un servidor que exponga una
   herramienta interna de tu equipo: consultar un catálogo, lanzar un
   proceso, leer una métrica.
3. **Procesamiento de datos experimentales.** Automatiza la limpieza y el
   análisis descriptivo de datos de laboratorio o de sensores.
4. **Revisión previa al commit.** Configura una comprobación que corra
   pruebas y linter antes de permitir un commit.

### Datos

Un repositorio propio o un proyecto de código abierto pequeño.

### Verificación obligatoria

- Las pruebas pasan antes y después. Si no había pruebas, escribirlas es
  parte del reto.
- Revisa el diff completo línea por línea. Un refactor que "se ve bien" en
  resumen puede haber cambiado el comportamiento.
- Para el servidor MCP: intenta usarlo fuera de su alcance previsto y
  documenta qué pasó.

### Límite profesional

Ningún código llega a la rama principal sin revisión humana y pruebas en
verde. Las credenciales viven en variables de entorno, nunca en el prompt
ni en el repositorio. Un servidor MCP que expone una herramienta interna es
una superficie de ataque nueva: documenta su alcance.
