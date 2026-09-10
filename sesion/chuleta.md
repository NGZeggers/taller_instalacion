# Chuleta

Todo lo que se usa en las dos horas cabe en esta página. Tenla abierta.

## Moverse

```bash
pwd                 # dónde estoy
ls                  # qué hay aquí
ls datos            # qué hay en esa carpeta
cd datos            # entrar
cd ..               # salir
```

<kbd>Tab</kbd> autocompleta nombres. <kbd>↑</kbd> repite el comando anterior.
<kbd>Ctrl</kbd>+<kbd>C</kbd> cancela.

## Ver

```bash
cat datos/ventas_enero.csv        # todo
head -5 datos/ventas_enero.csv    # primeras 5 líneas
wc -l datos/ventas_enero.csv      # contar líneas
```

## Buscar y filtrar

```bash
grep Zapopan datos/ventas_enero.csv       # líneas que contienen Zapopan
grep -c Zapopan datos/ventas_enero.csv    # cuántas son
cut -d, -f2 datos/ventas_enero.csv        # solo la columna 2
sort                                       # ordenar
uniq -c                                    # agrupar y contar
```

## Encadenar y guardar

```bash
comando1 | comando2                # la salida de uno entra al otro
comando > archivo.txt              # guardar (sobrescribe)
comando >> archivo.txt             # agregar al final
```

Ejemplo completo:

```bash
cut -d, -f2 datos/ventas_enero.csv | tail -n +2 | sort | uniq -c | sort -rn
```

## Asistente

```bash
claude                             # abrir sesión en esta carpeta
/mcp                               # ver servidores conectados
/exit                              # salir
```

```bash
claude mcp add archivos -- npx -y @modelcontextprotocol/server-filesystem ./datos
claude mcp list
```

## Las cinco partes de un encargo

| | |
|---|---|
| **Objetivo** | qué debe existir al final |
| **Insumos** | qué archivos usar, ruta exacta |
| **Restricciones** | qué no tocar, qué no inventar |
| **Salida** | dónde queda y con qué estructura |
| **Aceptación** | cómo se comprueba que está bien |

## Verificar no es preguntarle al modelo

Verificar es contrastar contra algo externo:

```bash
wc -l datos/original.csv salidas/resultado.csv   # ¿cuadran las filas?
cut -d, -f2 salidas/resultado.csv | sort -u      # ¿se perdió alguna categoría?
diff <(sort a.txt) <(sort b.txt)                 # ¿qué cambió exactamente?
```

## Traducción Linux ↔ Windows

No la necesitas hoy: el taller usa bash en los dos sistemas. La ponemos
porque en tu trabajo te vas a topar con las dos formas.

| bash (lo que escribes hoy) | PowerShell |
|---|---|
| `pwd` | `Get-Location` |
| `ls` / `ls -la` | `Get-ChildItem` / `-Force` |
| `cd carpeta` | `Set-Location carpeta` |
| `cat archivo` | `Get-Content archivo` |
| `head -n 5 archivo` | `Get-Content archivo -TotalCount 5` |
| `tail -n 5 archivo` | `Get-Content archivo -Tail 5` |
| `wc -l archivo` | `Get-Content archivo \| Measure-Object -Line` |
| `grep texto archivo` | `Select-String texto archivo` |
| `cut -d, -f2 archivo` | `Import-Csv archivo \| Select-Object -Expand col` |
| `sort` / `sort -rn` | `Sort-Object` / `-Descending` |
| `uniq -c` | `Group-Object` |
| `mkdir -p a/b` | `New-Item -ItemType Directory -Force a\b` |
| `cp` / `mv` / `rm` | `Copy-Item` / `Move-Item` / `Remove-Item` |
| `export VAR=valor` | `$env:VAR = "valor"` |
| `/mnt/c/Users/ana` | `C:\Users\ana` |

En bash la tubería pasa **texto**; en PowerShell pasa **objetos** con
propiedades. Por eso PowerShell no necesita `cut`, pero también por eso bash
funciona igual con cualquier archivo, venga de donde venga.

## Si algo falla

| Mensaje | Qué pasa |
|---|---|
| `command not found` | El programa no está instalado o no está en el PATH |
| `No such file or directory` | Ruta mal escrita. Usa <kbd>Tab</kbd> |
| `Permission denied` | No tienes permiso ahí, o falta `bash` antes del script |
| `bad interpreter: ^M` | Fin de línea de Windows. Está resuelto en setup/ |
| Todo va lentísimo | Estás en `/mnt/c/` desde WSL. Copia a `~` |
