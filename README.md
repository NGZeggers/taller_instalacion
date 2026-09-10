# Taller: IA más allá del chat

**Construye tu primera automatización real, en dos horas.**

**Imparten:** Alberto Campos de la Torre y David Medina Castellanos
**Sistemas:** macOS, Windows 10/11 y Linux

---

## Qué vas a construir

No vienes a ver una demostración. Vienes a construir tu propio proyecto:

```
mi-proyecto/
├── datos/          tus archivos de entrada, intactos
├── salidas/        lo que generó el asistente
├── NOTAS.md        tu encargo y cómo lo verificaste
└── .mcp.json       qué puede tocar el asistente, y qué no
```

Cada paso agrega una pieza. Al final lo ejecutas y lo compruebas.

**Cada quien viene por algo distinto, y está bien.** Uno quiere ordenar tres
años de archivos, otro sacar datos de cincuenta PDF, otro entender un
repositorio que heredó. En el paso 1 eliges tu propósito, y los cuatro pasos
siguientes lo construyen.

---

## Requisitos: antes del taller, no el mismo día

Son 2 horas. Si los primeros veinte minutos se van en instalar, el grupo se
parte en dos ritmos y ya no se recupera. **La instalación es requisito de
entrada.**

| Tu sistema | Guía |
|---|---|
| macOS 13+ | [`setup/instalacion-macos.md`](setup/instalacion-macos.md) |
| Windows 10 (build 1809+) u 11 | [`setup/windows.md`](setup/windows.md) |
| Linux | [`setup/linux.md`](setup/linux.md) |

La instalación toma de 30 a 45 minutos de descargas. **Hazla con tiempo.**

```bash
git clone https://github.com/NGZeggers/taller_instalacion.git
cd taller_instalacion
bash setup/instalar.sh
bash setup/verificar.sh
```

Todo en verde es el boleto de entrada. Hay asesoría los tres días previos:
abre un issue pegando la salida completa.

También necesitas:

- **Cuenta de pago**: Claude Pro/Max para Claude Code, o ChatGPT Plus/Pro para
  Codex. Sirve cualquiera de las dos; el taller usa los mismos conceptos. Los
  planes gratuitos no dan acceso a la línea de comandos.
- **Material propio** con el que quieras trabajar: documentos, un CSV, una
  carpeta desordenada, un proyecto de código. **Sin datos de terceros** sin
  anonimizar.

---

## Los cinco pasos

| Minuto | Paso | Qué deja en tu proyecto |
|---|---|---|
| 0:00 | [La caja negra + tu propósito](sesion/01-proposito.md) | La estructura de carpetas |
| 0:20 | [La terminal sobre 931 mil filas](sesion/02-terminal.md) | Lo que encontraste al mirar tus datos |
| 0:45 | [El encargo](sesion/03-encargo.md) | La instrucción en cinco partes |
| 1:10 | [Conectar y ejecutar](sesion/04-conectar.md) | El resultado y el alcance de permisos |
| 1:40 | [Verificar](sesion/05-verificar.md) | La comprobación y los límites |

Ten abierta la [**chuleta**](sesion/chuleta.md) toda la sesión. Cabe en una
página e incluye la traducción entre comandos de Linux y Windows.

El [**manual completo**](docs/index.html) con todos los comandos y ejemplos
está publicado en `docs/`.

---

## Por qué bash en los dos sistemas

Este taller usa **un solo intérprete de comandos: bash**. En Linux es el que
ya tienes. En Windows se obtiene instalando WSL 2 con Ubuntu, que corre una
distribución real de Linux dentro de tu Windows.

La razón es práctica: si la mitad del grupo usara PowerShell, cada comando
tendría dos versiones y la pantalla del instructor no coincidiría con la de
nadie. Con un solo shell, lo que se ve al frente es lo que pasa en tu
máquina.

Aun así, la equivalencia con PowerShell está documentada en la chuleta y en
el manual, porque en tu trabajo te vas a topar con las dos.

Si no puedes instalar WSL —virtualización deshabilitada por tu institución,
por ejemplo— hay una ruta alterna con Git Bash en
[`setup/windows.md`](setup/windows.md). Avísale a los instructores al
inscribirte, no el día del taller.

---

## Pasos a futuro

La carpeta [`despues/`](despues/) tiene la ruta para hacer tu proyecto más
sólido, ordenada por dependencia: elegir mejor qué automatizar, git completo,
encargos que se prueban solos, servidores MCP propios, y convertir la carpeta
en un flujo que corre con un comando.

---

## Estructura

```
setup/       Instalación y diagnóstico. Se usa ANTES del taller
sesion/      Los cinco pasos, la chuleta y el guion del instructor
datos/       Archivos de práctica
datos/fda/   Registros públicos de la FDA: 931 mil filas, 40 MB
despues/     Material para seguir por tu cuenta
docs/        Manual público, paso por paso
```

## Reglas

- **Nunca subas credenciales.** Las claves van en variables de entorno o en
  un `.env`, que ya está ignorado.
- **Nunca uses datos de terceros.** Nada de expedientes, historiales,
  nóminas o entrevistas sin anonimizar. Los datos de este repo son
  sintéticos a propósito.
- **`datos/` no se modifica.** Es tu material original. Todo resultado va a
  `salidas/`.
- **Fin de línea LF** en todo el repositorio, salvo `datos/fda/`, que conserva
  su CRLF original a propósito: es el ejemplo real del paso 2 sobre datos que
  vienen de Windows. El `.gitattributes` ya lo contempla.
