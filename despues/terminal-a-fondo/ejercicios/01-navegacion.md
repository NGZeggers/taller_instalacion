# Ejercicio 1 — Navegación y archivos

Trabaja desde la raíz del repositorio. Anota el comando que usaste para cada
punto; los vas a entregar.

1. Muestra la ruta absoluta de la carpeta donde estás parado.
2. Lista todo lo que hay en `datos/`, incluyendo archivos
   ocultos y con detalles de tamaño y fecha.
3. Cuenta cuántos archivos `.txt` hay dentro de `datos/notas/`.
4. Crea la carpeta `salidas/` en la raíz del repositorio. Ya está en el
   `.gitignore`, así que no se subirá.
5. Copia `datos/ventas_enero.csv` a `salidas/respaldo_enero.csv`.
6. Muestra las primeras 3 líneas y las últimas 3 líneas de
   `datos/inscripciones.csv`.
7. Renombra `salidas/respaldo_enero.csv` a `salidas/enero_original.csv`.

**Pista para el punto 3:** combina `ls` con una tubería.

**Trampa deliberada:** algunos nombres de vendedor llevan acentos y eñes.
Si tu terminal los muestra como `Mar\303\255a`, tu configuración regional no
está en UTF-8. Revísalo con `locale`.
