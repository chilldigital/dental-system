# 🚀 Guía de Instalación - DentalPro

Esta guía te llevará paso a paso para instalar y configurar DentalPro en tu entorno.

## 📋 Prerrequisitos

### Software Necesario
- ✅ **Docker** v20.10+ y Docker Compose
- ✅ **Git** v2.30+
- ✅ **Navegador moderno** (Chrome 90+, Firefox 88+, Safari 14+)
- ✅ **Editor de código** (VS Code recomendado)

### Servicios Externos
- ✅ **Cuenta N8N** (n8n.cloud o instancia propia)
- ✅ **Cuenta Airtable** (plan gratuito suficiente)
- ✅ **Google Cloud Console** (para Calendar API)
- ✅ **Dominio propio** (opcional para producción)

## 🛠️ Instalación Local

### 1. Clonar el Repositorio

```bash
# Clonar desde GitHub
git clone https://github.com/tu-usuario/dental-system.git

# Navegar al directorio
cd dental-system

# Verificar estructura
ls -la
```

### 2. Configurar Variables de Entorno

```bash
# Crear archivo de variables
cp .env.example .env

# Editar con tu editor favorito
nano .env
```

**Contenido del archivo .env:**
```bash
# N8N Configuration
N8N_HOST=tu-instancia.n8n.cloud
N8N_WEBHOOK_PATH=/webhook
N8N_API_KEY=tu_api_key_n8n

# Airtable Configuration
AIRTABLE_API_KEY=patXXXXXXXXXXXXXX.XXXXXXXXXXXXXXXXX
AIRTABLE_BASE_ID=appXXXXXXXXXXXXXX

# Google Calendar Configuration
GOOGLE_CALENDAR_API_KEY=AIzaXXXXXXXXXXXXXXXXXXXXXXXX
GOOGLE_CALENDAR_ID=tu-calendario@gmail.com

# Frontend Configuration
FRONTEND_DOMAIN=localhost
ENVIRONMENT=development
DEBUG=true
```

### 3. Configuración con Docker

```bash
# Construir la imagen
docker build -t dental-pro .

# Verificar que se creó correctamente
docker images | grep dental-pro

# Ejecutar el contenedor
docker run -d \
  --name dental-pro-dev \
  -p 8080:80 \
  --env-file .env \
  dental-pro

# Verificar que está corriendo
docker ps
```

### 4. Acceso Local

Abre tu navegador y ve a:
- **URL**: http://localhost:8080
- **Dashboard**: Debería cargar la página principal
- **Test**: Intenta navegar entre las páginas

## ⚙️ Configuración de N8N

### 1. Crear Workflows

1. **Acceder a tu instancia N8N**
2. **Importar workflows** desde `docs/n8n-workflows/`
3. **Configurar credenciales** necesarias

### 2. Credenciales Requeridas

#### Airtable
- **Credential Type**: Airtable API
- **API Key**: Tu token personal de Airtable
- **Base ID**: ID de tu base de datos

#### Google Calendar
- **Credential Type**: Google Calendar API
- **Service Account**: JSON key del service account
- **Calendar ID**: ID del calendario específico

### 3. Activar Webhooks

```bash
# URLs de webhook necesarias
https://tu-instancia.n8n.cloud/webhook/estadisticas
https://tu-instancia.n8n.cloud/webhook/pacientes  
https://tu-instancia.n8n.cloud/webhook/calendario
```

### 4. Probar Conexiones

```bash
# Test webhook estadísticas
curl -X GET https://tu-instancia.n8n.cloud/webhook/estadisticas

# Test crear paciente
curl -X POST https://tu-instancia.n8n.cloud/webhook/pacientes \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Test","obra_social":"OSDE","historia_clinica":"Prueba"}'
```

## 🗄️ Configuración de Airtable

### 1. Crear Base de Datos

1. **Acceder a Airtable**
2. **Crear nueva base** llamada "DentalPro"
3. **Crear tabla "Pacientes"** con estos campos:

| Campo | Tipo | Descripción |
|-------|------|-------------|
| Nombre | Single line text | Nombre completo |
| DNI | Single line text | Documento |
| Teléfono | Phone number | Teléfono de contacto |
| Email | Email | Email del paciente |
| Obra Social | Single select | OSDE, Swiss Medical, etc. |
| Número Afiliado | Single line text | Número de afiliado |
| Fecha Nacimiento | Date | Fecha de nacimiento |
| Historia Clínica | Long text | Historia clínica completa |
| Alergias | Long text | Alergias conocidas |
| Antecedentes | Multiple select | Diabetes, Hipertensión, etc. |
| Fecha Registro | Date | Fecha de registro automática |

### 2. Configurar Permisos

- **API Access**: Habilitar acceso via API
- **Webhook URLs**: Configurar para notificaciones
- **Backup**: Configurar backup automático

### 3. Obtener Credenciales

```bash
# API Key (Personal Access Token)
1. Ve a https://airtable.com/create/tokens
2. Crea nuevo token con permisos de lectura/escritura
3. Copia el token: pat1234567890abcdef...

# Base ID
1. Ve a https://airtable.com/api
2. Selecciona tu base "DentalPro"
3. Copia el Base ID: app1234567890abcdef
```

## 📅 Configuración de Google Calendar

### 1. Crear Proyecto en Google Cloud

```bash
# Paso a paso:
1. Ve a https://console.cloud.google.com
2. Crea nuevo proyecto "DentalPro"
3. Habilita Google Calendar API
4. Crea credenciales tipo "Service Account"
5. Descarga el archivo JSON
```

### 2. Configurar Service Account

```json
{
  "type": "service_account",
  "project_id": "dentalpro-123456",
  "private_key_id": "abc123...",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...",
  "client_email": "dentalpro@dentalpro-123456.iam.gserviceaccount.com",
  "client_id": "123456789012345678901",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token"
}
```

### 3. Compartir Calendario

1. **Abrir Google Calendar**
2. **Seleccionar calendario** para turnos
3. **Configuración y compartir**
4. **Agregar Service Account** como editor
5. **Copiar Calendar ID** (example@gmail.com)

## 🧪 Verificación de Instalación

### 1. Tests Básicos

```bash
# Verificar que Docker está corriendo
docker ps | grep dental-pro

# Verificar logs
docker logs dental-pro-dev

# Test de conectividad
curl -I http://localhost:8080
```

### 2. Tests de Funcionalidad

| Funcionalidad | URL | Test |
|---------------|-----|------|
| Dashboard | `/` | ¿Cargan las estadísticas? |
| Pacientes | `/pacientes.html` | ¿Aparece la tabla? |
| Nuevo Paciente | `/nuevo-paciente.html` | ¿Funciona la validación? |
| Calendario | `/calendario.html` | ¿Cargan los eventos? |

### 3. Tests de API

```bash
# Test estadísticas
curl "http://localhost:8080/api/estadisticas"

# Test crear paciente
curl -X POST "http://localhost:8080/api/pacientes" \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan Pérez",
    "obra_social": "OSDE", 
    "historia_clinica": "Paciente de prueba para verificar funcionamiento"
  }'
```

## 🚨 Solución de Problemas

### Problemas Comunes

#### Error: "Cannot connect to N8N"
```bash
# Verificar URL de N8N
echo $N8N_HOST

# Test manual
curl https://$N8N_HOST/webhook/test

# Verificar credenciales en N8N
```

#### Error: "Airtable API authentication failed"
```bash
# Verificar API Key
echo $AIRTABLE_API_KEY | cut -c1-10

# Test manual
curl "https://api.airtable.com/v0/$AIRTABLE_BASE_ID/Pacientes" \
  -H "Authorization: Bearer $AIRTABLE_API_KEY"
```

#### Error: "Google Calendar access denied"
```bash
# Verificar Service Account
# 1. ¿Está habilitada la API?
# 2. ¿Está compartido el calendario?
# 3. ¿Son correctas las credenciales?
```

#### Error: "Docker container won't start"
```bash
# Ver logs detallados
docker logs dental-pro-dev -f

# Verificar configuración nginx
docker exec dental-pro-dev nginx -t

# Reiniciar contenedor
docker restart dental-pro-dev
```

### Logs y Debugging

```bash
# Logs de aplicación
docker logs dental-pro-dev

# Logs de nginx
docker exec dental-pro-dev cat /var/log/nginx/error.log

# Logs en tiempo real
docker exec dental-pro-dev tail -f /var/log/nginx/access.log
```

## ✅ Checklist de Verificación

### Pre-Deploy
- [ ] Docker container corre sin errores
- [ ] Todas las páginas cargan correctamente
- [ ] N8N webhooks responden
- [ ] Airtable se conecta correctamente
- [ ] Google Calendar funciona
- [ ] Formularios validan correctamente
- [ ] CSS y JS cargan sin errores

### Post-Deploy
- [ ] HTTPS funciona (en producción)
- [ ] Headers de seguridad activos
- [ ] Rate limiting funcional
- [ ] Páginas de error personalizadas
- [ ] Performance aceptable (< 3s carga)
- [ ] Mobile responsive
- [ ] Accesibilidad completa

## 📞 Soporte

Si tienes problemas durante la instalación:

1. **Revisa esta guía** paso a paso
2. **Consulta SECURITY.md** para configuración de seguridad
3. **Revisa los logs** de Docker y nginx
4. **Crea un issue** en GitHub con detalles
5. **Contacta soporte** si es urgente

---

**¡Listo!** Tu instalación de DentalPro debería estar funcionando correctamente.
