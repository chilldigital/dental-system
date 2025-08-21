# Configuración de Seguridad - DentalPro

Este documento explica las medidas de seguridad implementadas en el proyecto DentalPro.

## 🔒 Headers de Seguridad Implementados

### Content Security Policy (CSP)
```
default-src 'self'; 
script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; 
style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; 
img-src 'self' data: https:; 
font-src 'self' https://cdn.jsdelivr.net; 
connect-src 'self' https://n8n.chilldigital.tech; 
object-src 'none'; 
base-uri 'self'; 
form-action 'self';
```

**¿Qué hace?**
- Previene ataques XSS (Cross-Site Scripting)
- Controla qué recursos puede cargar la página
- Solo permite scripts y estilos de fuentes confiables

### X-Frame-Options
```
X-Frame-Options: SAMEORIGIN
```
**¿Qué hace?**
- Previene clickjacking
- Evita que la página se incruste en iframes maliciosos

### X-Content-Type-Options
```
X-Content-Type-Options: nosniff
```
**¿Qué hace?**
- Previene MIME-type sniffing
- Evita que el navegador "adivine" tipos de archivo

### X-XSS-Protection
```
X-XSS-Protection: 1; mode=block
```
**¿Qué hace?**
- Activa el filtro XSS del navegador
- Bloquea páginas cuando detecta ataques XSS

### Referrer-Policy
```
Referrer-Policy: strict-origin-when-cross-origin
```
**¿Qué hace?**
- Controla qué información se envía en el header Referer
- Protege la privacidad del usuario

## 🚦 Rate Limiting

### Configuración General
- **Límite general**: 30 requests por segundo por IP
- **Burst**: Permite hasta 20 requests en ráfagas

### Configuración API
- **Límite API**: 10 requests por segundo por IP
- **Burst**: Permite hasta 5 requests en ráfagas

**¿Por qué es importante?**
- Previene ataques DDoS
- Evita abuso de la API
- Protege los recursos del servidor

## 🔐 CORS (Cross-Origin Resource Sharing)

### Configuración Restrictiva
```
Access-Control-Allow-Origin: https://odonto.chilldigital.tech
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-CSRF-Token
Access-Control-Allow-Credentials: true
```

**¿Qué hace?**
- Solo permite requests desde el dominio oficial
- Controla qué métodos HTTP están permitidos
- Especifica qué headers pueden enviarse

## 🛡️ Validación de Datos

### Frontend (JavaScript)
- **Sanitización**: Limpia espacios y caracteres innecesarios
- **Validación en tiempo real**: Feedback inmediato al usuario
- **Regex patterns**: Para email, DNI, teléfono
- **Longitud mínima/máxima**: Para todos los campos de texto

### Campos Validados
1. **Nombre**: Mínimo 2 caracteres
2. **Email**: Formato email válido (opcional)
3. **DNI**: 7-8 dígitos sin puntos (opcional)
4. **Teléfono**: Formato flexible argentino (opcional)
5. **Historia Clínica**: Mínimo 10 caracteres

## 🚫 Archivos Bloqueados

### Extensiones Peligrosas
- `.env`, `.conf`, `.config`, `.ini`
- `.log`, `.bak`, `.backup`, `.old`
- `.tmp`, `.temp`

### Directorios Ocultos
- `.git`, `.svn`, `.hg`, `.bzr`
- Cualquier directorio que empiece con punto

**¿Por qué?**
- Evita exposición de información sensible
- Previene acceso a archivos de configuración
- Protege el código fuente

## 📝 Logging y Monitoreo

### Logs Disponibles
- `access.log`: Todas las requests HTTP
- `error.log`: Errores del servidor
- Rate limiting logs automáticos

### Información Registrada
- IP del cliente
- Timestamp
- URL solicitada
- User-Agent
- Código de respuesta

## 🔄 Actualizaciones de Seguridad

### Checklist Regular
- [ ] Actualizar dependencias de Bootstrap
- [ ] Revisar policies de CSP
- [ ] Monitorear logs de rate limiting
- [ ] Verificar certificados SSL
- [ ] Audit de seguridad trimestral

### Dependencias Externas
- **Bootstrap 5.3.2**: Framework CSS/JS
- **Bootstrap Icons**: Iconografía
- **CDN**: jsdelivr.net (confiable)

## 🆘 Respuesta a Incidentes

### En caso de ataque detectado:
1. **Revisar logs** en `/var/log/nginx/`
2. **Identificar IP atacante**
3. **Agregar regla de bloqueo temporal**
4. **Notificar al equipo de desarrollo**
5. **Documentar el incidente**

### Contactos de Emergencia
- **Desarrollador Principal**: [Tu email]
- **Hosting Provider**: Easypanel support
- **N8N Service**: n8n.chilldigital.tech admin

## 🔧 Configuración de Desarrollo

### Variables de Entorno Requeridas
```bash
# N8N Configuration
N8N_HOST=n8n.chilldigital.tech
N8N_WEBHOOK_PATH=/webhook

# Frontend Configuration
FRONTEND_DOMAIN=odonto.chilldigital.tech
ENVIRONMENT=production
```

### Comandos Útiles
```bash
# Reiniciar nginx
sudo systemctl reload nginx

# Ver logs en tiempo real
tail -f /var/log/nginx/error.log

# Verificar configuración
nginx -t

# Ver rate limiting stats
nginx -T | grep limit_req
```

## ✅ Verificación de Seguridad

### Tests Automáticos
- [ ] CSP headers presentes
- [ ] CORS configurado correctamente
- [ ] Rate limiting funcional
- [ ] Validación de formularios activa
- [ ] Archivos sensibles bloqueados

### Tests Manuales
- [ ] Intentar XSS en formularios
- [ ] Verificar clickjacking protection
- [ ] Test de rate limiting con herramientas
- [ ] Verificar HTTPS redirect
- [ ] Audit con herramientas online

---

**Última actualización**: $(date)
**Versión**: 1.0
**Responsable**: Equipo de Desarrollo DentalPro
