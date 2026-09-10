# Reto — Administración, negocios y contaduría

## Cierre mensual reproducible

### Situación

Cada mes recibes un archivo de ventas con columnas inconsistentes, fechas en
tres formatos y montos con y sin símbolo de moneda. Lo limpias a mano, lo
concilias contra el sistema y armas el reporte. Cada mes, lo mismo.

### Qué construir

1. Limpia y normaliza el archivo de ventas.
2. Concilia contra un segundo archivo y aísla las diferencias con su motivo.
3. Genera el reporte mensual con totales por sucursal, por producto y
   comentario de variaciones contra el mes anterior.
4. Deja el proceso como script para repetirlo el mes siguiente con un solo
   comando.

### Datos

Empieza con `datos/ventas_enero.csv` y
`ventas_febrero_sucio.csv`. Si usas datos de tu trabajo, anonimízalos:
cambia nombres, escala los montos por un factor constante.

### Verificación obligatoria

- La suma de la columna de cantidad debe cuadrar antes y después de limpiar.
  Si no cuadra, el flujo perdió o duplicó filas.
- El número de sucursales distintas debe ser el mismo.
- Comprueba manualmente tres filas al azar contra el original.
- Ejecuta el flujo dos veces sobre la misma entrada: debe dar el mismo
  resultado.

### Límite profesional

Toda cifra que salga del flujo se cuadra contra la fuente antes de
reportarse. La información financiera de un tercero no sale de tu máquina
sin autorización expresa.
