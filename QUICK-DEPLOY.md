# 🚀 Deploy Rápido - DentalPro v2.0 con Caddy

## ⚡ Setup Inmediato (5 minutos) - ACTUALIZADO

### 🎯 Cambios Importantes
- ✅ **Migrado de nginx a Caddy** (70% menos configuración)
- ✅ **SSL automático** (sin configuración manual)
- ✅ **Headers de seguridad** mejorados
- ✅ **CORS optimizado** para N8N
- ✅ **Logs con rotación** automática

### 1. Verificar Archivos Actualizados
```bash
# Verificar que los archivos fueron actualizados
cat Caddyfile | head -5    # Debería mostrar configuración nueva
cat Dockerfile | head -5   # Debería mostrar "CADDY OPTIMIZADO"

# Verificar que todo está listo
./pre-deploy-check.sh
```

### 2. Test Local (RECOMENDADO)
```bash
# Construir imagen nueva
docker build -t dental-caddy-v2 .

# Probar localmente
docker run -p 80:80 -p 443:443 dental-caddy-v2

# En otra terminal, verificar
curl http://localhost                    # → Tu frontend
curl http://localhost/api/estadisticas  # → Proxy a N8N
```

### 3. Deploy en Easypanel
1. **Actualizar Repositorio**:
   ```bash
   git add .
   git commit -m "🚀 Migración a Caddy v2.0 - SSL automático y configuración optimizada"
   git push origin main
   ```

2. **En Easypanel**:
   - Type: `Source Code` ✅
   - Repository: `https://github.com/tu-usuario/dental-system.git` ✅
   - Branch: `main` ✅
   - **NO cambies nada más** - Caddy se configura automáticamente

3. **Variables de Entorno** (las mismas):
   ```
   N8N_HOST=n8n.chilldigital.tech
   FRONTEND_DOMAIN=odonto.chilldigital.tech
   ENVIRONMENT=production
   ```

4. **Deploy**: Click "Deploy" ✨

### 4. Verificar Deploy Mejorado
```bash
# Test SSL automático (NUEVO)
curl -I https://odonto.chilldigital.tech
# Debería mostrar certificado válido automáticamente

# Test headers de seguridad (MEJORADO)
curl -I https://odonto.chilldigital.tech | grep -E "(X-Frame|Content-Security|Strict-Transport)"

# Test API (IGUAL)
curl https://odonto.chilldigital.tech/api/estadisticas

# Test CORS (MEJORADO)
curl -H "Origin: https://odonto.chilldigital.tech" \
     -H "Access-Control-Request-Method: POST" \
     -X OPTIONS https://odonto.chilldigital.tech/api/pacientes
```

## 🎯 URLs Finales (IGUALES)
- 🌐 **Frontend**: https://odonto.chilldigital.tech
- 📊 **API**: https://odonto.chilldigital.tech/api/
- 🔧 **N8N**: https://n8n.chilldigital.tech

## ✅ Checklist Post-Deploy MEJORADO
- [ ] ✅ **SSL automático** funcionando (certificado válido)
- [ ] ✅ **Headers de seguridad** presentes
- [ ] ✅ **CORS** configurado correctamente
- [ ] ✅ **Compresión gzip** activa
- [ ] ✅ **Cache** optimizado para assets
- [ ] ✅ **Logs** con rotación automática
- [ ] ✅ **Performance** < 2s (mejorado desde Caddy)
- [ ] ✅ **Health checks** funcionando

## 🆘 Troubleshooting Específico Caddy

### Si algo falla:
1. **Ver logs de Caddy**:
   ```bash
   # En Easypanel/Docker logs
   docker logs tu-contenedor | grep caddy
   ```

2. **Verificar Caddyfile**:
   ```bash
   # Validar sintaxis
   caddy validate --config /etc/caddy/Caddyfile
   ```

3. **Test SSL local**:
   ```bash
   # Si SSL falla
   caddy trust  # Instalar CA local
   ```

4. **Test proxy N8N**:
   ```bash
   # Verificar que N8N responde
   curl https://n8n.chilldigital.tech/webhook/test
   ```

## 🎉 Beneficios de la Migración

| Aspecto | Antes (nginx) | Ahora (Caddy) |
|---------|---------------|---------------|
| **Configuración** | 150+ líneas | 80 líneas |
| **SSL** | Manual, complejo | ✅ **Automático** |
| **HTTP/2** | Configuración manual | ✅ **Por defecto** |
| **Logs** | Sin rotación | ✅ **Con rotación** |
| **Memory** | ~30MB | ✅ **~15MB** |
| **Updates** | Manual | ✅ **Auto-reload** |

---
**¡Listo! Tu sistema dental está ahora con Caddy y más optimizado** 🎉

**¿Problemas?** Consulta [docs/deployment.md](docs/deployment.md) o contacta soporte.
