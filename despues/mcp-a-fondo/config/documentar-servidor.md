# Documentación del servidor MCP

Una ficha por cada servidor que conectes.

## Identificación

**Nombre en la configuración:**
**Qué herramienta o servicio expone:**
**Transporte:** local (proceso en mi máquina) / remoto (HTTP)

## Alcance

**A qué tiene acceso, exactamente:**
Sé literal. "Mis archivos" no sirve; "la carpeta `./datos` y sus
subcarpetas, con permiso de lectura y escritura" sí.

**Qué NO alcanza:**

**Cómo se impone ese límite:**
El argumento, la variable o la configuración concreta que lo restringe.

## Verificación del límite

Intenta que el asistente lea o escriba algo fuera del alcance configurado.

**Qué le pediste:**
**Qué pasó:**
**El límite se respetó:** sí / no

## Análisis de riesgo

**Qué pasaría si el servidor tuviera un alcance mayor:**

**Puede este servidor leer contenido que no controlo yo** (correos, páginas
web, archivos de terceros)**:** sí / no

Si la respuesta es sí, ese contenido puede contener instrucciones dirigidas
al modelo. Describe cómo lo mitigas:

**Qué acciones exigen mi aprobación explícita:**

**Qué pasa si apruebo sin leer:**

## Justificación

**Por qué un servidor MCP y no un script de una sola vez:**

**Con qué frecuencia se usará esta conexión:**

## Datos sensibles

**Este servidor toca datos personales, de pacientes, financieros o bajo
secreto profesional:** sí / no

Si es sí, describe la anonimización o el consentimiento previo. Si no puedes
describirlo, no conectes ese servidor en el taller.
