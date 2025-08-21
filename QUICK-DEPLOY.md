# 🚀 Deploy Rápido - DentalPro

## ⚡ Setup Inmediato (5 minutos)

### 1. Preparar Repositorio
```bash
# Verificar que todo está listo
./pre-deploy-check.sh

# Hacer commit final
git add .
git commit -m "🚀 Release v2.0.0 - Sistema DentalPro Completo"
git push origin main
```

### 2. Deploy en Easypanel
1. **Crear App**:
   - Type: `Source Code`
   - Repository: `https://github.com/tu-usuario/dental-system.git`
   - Branch: `main`

2. **Configurar Variables**:
   ```
   N8N_HOST=n8n.chilldigital.tech
   FRONTEND_DOMAIN=odonto.chilldigital.tech
   ENVIRONMENT=production
   ```

3. **Configurar Dominio**:
   ```
   Domain: odonto.chilldigital.tech
   SSL: Enabled
   ```

4. **Deploy**: Click "Deploy" ✨

### 3. Verificar Deploy
```bash
# Test básico
curl -I https://odonto.chilldigital.tech

# Test API
curl https://odonto.chilldigital.tech/api/estadisticas

# Test páginas
curl https://odonto.chilldigital.tech/pacientes.html
```

## 🎯 URLs Finales
- 🌐 **Frontend**: https://odonto.chilldigital.tech
- 📊 **API**: https://odonto.chilldigital.tech/api/
- 🔧 **N8N**: https://n8n.chilldigital.tech

## ✅ Checklist Post-Deploy
- [ ] Todas las páginas cargan
- [ ] API responde correctamente
- [ ] Formularios funcionan
- [ ] SSL activo
- [ ] Performance < 3s

## 🆘 Si algo falla
1. Revisar logs en Easypanel
2. Verificar variables de entorno
3. Comprobar conexión N8N
4. Consultar [docs/deployment.md](docs/deployment.md)

---
**¡Listo! Tu sistema dental está en producción** 🎉
