# Ejercicio 4 — Control de versiones

## Preparación

Si todavía no lo hiciste, haz un fork de este repositorio en GitHub y
clónalo. Después crea tu carpeta de equipo:

```bash
mkdir -p tus-entregas
```

Reemplaza `TU-EQUIPO` por el nombre real, en minúsculas y sin espacios.

## Ejercicios

1. Copia `despues/inventario-de-tareas/inventario-de-tareas.md` a tu carpeta de
   carpeta como `modulo-1-inventario.md`.
2. Revisa el estado del repositorio. ¿Qué archivos aparecen como nuevos y
   cuáles como modificados?
3. Haz tu primer commit, solo con ese archivo, con un mensaje descriptivo.
4. Edita el archivo: agrega tu nombre y carrera. Revisa el cambio línea por
   línea antes de guardarlo.
5. Haz un segundo commit.
6. Ahora borra el archivo por accidente:
   ```bash
   rm tus-entregas/modulo-1-inventario.md
   ```
   Recupéralo. El comando que necesitas está en la guía del módulo.
7. Agrega tus archivos de comandos de los ejercicios 1 a 3 y haz un tercer
   commit.
8. Muestra el historial en una línea por commit.

## Comprobación

Al terminar deberías tener al menos tres commits con mensajes que expliquen
qué cambió. Revísalo con `git log --oneline`.

## Trampa

Ejecuta esto y observa el resultado:

```bash
echo "ANTHROPIC_API_KEY=sk-ant-esto-es-falso" > .env
git status
```

`.env` no aparece. Está en `.gitignore` desde el primer commit del
repositorio, precisamente para que nadie suba una credencial por descuido.

Bórralo cuando termines de verlo: `rm .env`
