# Módulo 2 — Fundamentos de terminal


> **Material de autoestudio.** Esto no se ve en la sesión de 2 horas.
> Las carpetas de entrega y la evaluación por evidencias corresponden a la
> versión larga del curso; ignóralas si estás repasando por tu cuenta.

**Duración:** 4 horas · **Evidencia:** ejercicios resueltos y tres commits

No necesitas experiencia previa. Sí necesitas haber corrido
`bash setup/verificar.sh` sin errores antes de llegar.

## Por qué importa

Todo lo que viene después ocurre aquí. Un asistente conectado a tu terminal
puede leer tus archivos, transformarlos y guardar el resultado. Para
supervisarlo necesitas entender qué está haciendo, y eso significa saber
leer un comando.

---

## 1. Qué es una terminal

Una terminal es una ventana donde escribes órdenes en texto en lugar de dar
clics. El programa que interpreta esas órdenes se llama **shell**. El shell
del taller es **bash**.

Cada línea sigue la misma forma:

```
comando  opciones  argumentos
```

Por ejemplo, `ls -l datos` es el comando `ls` con la opción `-l` aplicada al
argumento `datos`.

Tres teclas que te van a servir desde el primer minuto:

| Tecla | Qué hace |
|---|---|
| <kbd>Tab</kbd> | Autocompleta nombres de archivo. Úsala siempre; evita errores de dedo |
| <kbd>↑</kbd> | Recupera el comando anterior |
| <kbd>Ctrl</kbd>+<kbd>C</kbd> | Cancela lo que se esté ejecutando |

## 2. Moverse por el sistema de archivos

```bash
pwd                    # dónde estoy
ls                     # qué hay aquí
ls -la                 # incluyendo archivos ocultos, con detalles
cd datos               # entrar a una carpeta
cd ..                  # subir un nivel
cd ~                   # ir a mi carpeta personal
cd -                   # volver a donde estaba
```

Una **ruta absoluta** empieza en la raíz: `/home/ana/taller_instalacion`.
Una **ruta relativa** parte de donde estás: `datos/ventas_enero.csv`.

En este repositorio siempre usamos rutas relativas. Es lo que permite que el
mismo comando funcione en tu máquina y en la del instructor.

## 3. Crear, copiar, mover, borrar

```bash
mkdir practica              # crear carpeta
mkdir -p practica/salidas   # crear carpeta y las que falten en el camino
touch practica/notas.txt    # crear archivo vacío
cp origen.txt destino.txt   # copiar
mv viejo.txt nuevo.txt      # mover o renombrar
rm archivo.txt              # borrar
rm -r carpeta               # borrar carpeta y su contenido
```

> **Sobre `rm`.** No hay papelera. Lo que borras se fue. Antes de escribir
> `rm -r`, ejecuta el mismo patrón con `ls` para ver qué vas a eliminar.
> Nunca escribas `rm -rf /` ni pegues un `rm` que encontraste en internet
> sin leerlo completo.

## 4. Leer archivos

```bash
cat datos/ventas_enero.csv        # todo el contenido
head -5 datos/ventas_enero.csv    # primeras 5 líneas
tail -5 datos/ventas_enero.csv    # últimas 5 líneas
less datos/ventas_enero.csv       # navegable; se sale con q
wc -l datos/ventas_enero.csv      # contar líneas
```

## 5. Buscar

```bash
grep Zapopan datos/ventas_enero.csv        # líneas que contienen Zapopan
grep -i zapopan datos/ventas_enero.csv     # sin distinguir mayúsculas
grep -c Zapopan datos/ventas_enero.csv     # contar coincidencias
grep -r "virtualización" datos/            # buscar dentro de una carpeta
```

## 6. Tuberías y redirección

Aquí es donde la terminal deja de ser un explorador de archivos incómodo y
empieza a ser una herramienta.

La **tubería** `|` toma la salida de un comando y se la entrega al
siguiente:

```bash
# ¿Cuántas ventas hubo en Zapopan?
grep Zapopan datos/ventas_enero.csv | wc -l

# ¿Qué vendedores aparecen, sin repetir?
cut -d, -f6 datos/ventas_enero.csv | tail -n +2 | sort | uniq

# ¿Quién aparece más veces?
cut -d, -f6 datos/ventas_enero.csv | tail -n +2 | sort | uniq -c | sort -rn
```

La **redirección** `>` guarda la salida en un archivo, y `>>` la agrega al
final sin borrar lo anterior:

```bash
grep Zapopan datos/ventas_enero.csv > salidas/zapopan.csv
echo "revisado el $(date +%F)" >> salidas/bitacora.txt
```

> `>` sobrescribe sin preguntar. Si el archivo existía, su contenido
> anterior desaparece.

## 7. Variables de entorno y PATH

```bash
echo $HOME       # tu carpeta personal
echo $PATH       # dónde busca el shell los programas
export API_KEY="valor"   # definir una variable en esta sesión
```

Cuando la terminal dice `command not found`, casi siempre significa que el
programa existe pero no está en una carpeta listada en `PATH`.

**Las claves API nunca van escritas en un comando ni en un archivo del
repositorio.** Van en variables de entorno o en un archivo `.env`, que este
repositorio ya ignora.

## 8. Git mínimo viable

Git guarda versiones de tu trabajo. Con seis comandos alcanza para el
taller:

```bash
git status                  # qué cambió
git diff                    # ver los cambios línea por línea
git add archivo.md          # marcar para guardar
git commit -m "mensaje"     # guardar una versión
git log --oneline           # historial
git restore archivo.md      # deshacer cambios no guardados
```

Un buen mensaje de commit dice qué cambió y por qué, en una línea:
`agrega inventario de tareas del equipo 3`, no `cambios`.

Recuperar un archivo borrado que ya estaba en un commit:

```bash
git restore archivo.md
```

## 9. El error multiplataforma número uno

Windows termina las líneas con dos caracteres invisibles (CRLF); Linux con
uno solo (LF). Un script escrito en Windows y ejecutado en Linux falla con:

```
bash: ./script.sh: /usr/bin/env^M: bad interpreter: No such file or directory
```

El `^M` es el carácter sobrante. Este repositorio lo previene con el archivo
`.gitattributes`, que fuerza LF en todo. No lo modifiques.

Si aun así te aparece, revisa que no tengas `core.autocrlf` activado:

```bash
git config core.autocrlf false
git rm --cached -r . && git reset --hard
```

---

## Ejercicios

Están en [`ejercicios/`](ejercicios/). Resuélvelos en orden. Cuando
termines, comprueba tus respuestas con:

```bash
bash modulo-2-terminal/ejercicios/comprobar.sh
```

El script te dice cuáles pasaron y cuáles no, sin darte la respuesta.

## Entrega

En tu fork, dentro de `tus-entregas/`:

1. `modulo-2-comandos.md` con los comandos que usaste para cada ejercicio.
2. La salida completa de `comprobar.sh`.
3. Al menos tres commits con mensajes descriptivos.
