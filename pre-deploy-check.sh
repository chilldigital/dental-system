#!/bin/bash
# 🚀 Script de Pre-Deploy - DentalPro v2.0.0 CON CADDY
# Verifica que todo está listo para producción con Caddy

echo "🔍 VERIFICACIÓN PRE-DEPLOY - DentalPro v2.0.0 + CADDY"
echo "======================================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0

# Function to check if file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✅ $2${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ $2 - Archivo faltante: $1${NC}"
        ((FAILED++))
    fi
}

# Function to check if directory exists
check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✅ $2${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ $2 - Directorio faltante: $1${NC}"
        ((FAILED++))
    fi
}

echo -e "${BLUE}📁 VERIFICANDO ESTRUCTURA DE ARCHIVOS...${NC}"
echo ""

# Check critical files
check_file "README.md" "README principal"
check_file "LICENSE" "Licencia MIT"
check_file ".gitignore" "GitIgnore configurado"
check_file "CHANGELOG.md" "Changelog estructurado"
check_file "SECURITY.md" "Políticas de seguridad"

# Check Caddy files (NUEVO)
check_file "Dockerfile" "Dockerfile con Caddy"
check_file "Caddyfile" "Caddyfile configurado"

# Check documentation
check_file "docs/setup.md" "Guía de instalación" 2>/dev/null || echo -e "${YELLOW}⚠️  docs/setup.md no encontrado${NC}"
check_file "docs/api.md" "Documentación de API" 2>/dev/null || echo -e "${YELLOW}⚠️  docs/api.md no encontrado${NC}"
check_file "docs/deployment.md" "Guía de deployment" 2>/dev/null || echo -e "${YELLOW}⚠️  docs/deployment.md no encontrado${NC}"

# Check public files
check_file "public/index.html" "Página principal"
check_file "public/pacientes.html" "Página de pacientes"
check_file "public/nuevo-paciente.html" "Formulario de pacientes"
check_file "public/calendario.html" "Sistema de calendario"

# Check source files
check_file "src/styles/style.css" "CSS principal"
check_file "src/scripts/app.js" "JavaScript principal"

# Check directories
check_dir "src" "Directorio source"
check_dir "public" "Directorio público"

echo ""
echo -e "${BLUE}🔧 VERIFICANDO CONFIGURACIÓN CADDY...${NC}"
echo ""

# Verificar que Caddyfile tiene el dominio correcto
if grep -q "odonto.chilldigital.tech" Caddyfile; then
    echo -e "${GREEN}✅ Dominio correcto en Caddyfile${NC}"
    ((PASSED++))
else
    echo -e "${RED}❌ Dominio no configurado en Caddyfile${NC}"
    ((FAILED++))
fi

# Verificar que tiene configuración N8N
if grep -q "n8n.chilldigital.tech" Caddyfile; then
    echo -e "${GREEN}✅ Proxy N8N configurado${NC}"
    ((PASSED++))
else
    echo -e "${RED}❌ Proxy N8N no configurado${NC}"
    ((FAILED++))
fi

# Verificar headers de seguridad
if grep -q "Content-Security-Policy" Caddyfile; then
    echo -e "${GREEN}✅ Headers de seguridad configurados${NC}"
    ((PASSED++))
else
    echo -e "${RED}❌ Headers de seguridad faltantes${NC}"
    ((FAILED++))
fi

# Verificar CORS
if grep -q "Access-Control-Allow-Origin" Caddyfile; then
    echo -e "${GREEN}✅ CORS configurado${NC}"
    ((PASSED++))
else
    echo -e "${RED}❌ CORS no configurado${NC}"
    ((FAILED++))
fi

echo ""
echo -e "${BLUE}🔒 VERIFICANDO SEGURIDAD...${NC}"
echo ""

# Check for sensitive files that shouldn't be in repo
if [ -f ".env" ]; then
    echo -e "${YELLOW}⚠️  Archivo .env detectado - verificar que está en .gitignore${NC}"
fi

if [ -f "config.json" ]; then
    echo -e "${RED}❌ Archivo config.json detectado - NO debe estar en el repo${NC}"
    ((FAILED++))
else
    echo -e "${GREEN}✅ No hay archivos de configuración sensibles${NC}"
    ((PASSED++))
fi

# Check gitignore content
if grep -q ".env" .gitignore; then
    echo -e "${GREEN}✅ .env está en .gitignore${NC}"
    ((PASSED++))
else
    echo -e "${RED}❌ .env NO está en .gitignore${NC}"
    ((FAILED++))
fi

echo ""
echo -e "${BLUE}🐳 VERIFICANDO DOCKER...${NC}"
echo ""

# Test Docker build (if Docker is available)
if command -v docker &> /dev/null; then
    echo "🔨 Construyendo imagen Docker de prueba con Caddy..."
    if docker build -t dental-caddy-test . > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Docker build con Caddy exitoso${NC}"
        ((PASSED++))
        
        # Clean up test image
        docker rmi dental-caddy-test > /dev/null 2>&1
    else
        echo -e "${RED}❌ Docker build falló${NC}"
        ((FAILED++))
    fi
else
    echo -e "${YELLOW}⚠️  Docker no disponible - skipping build test${NC}"
fi

# Verificar que NO hay archivos nginx
if [ -f "nginx.conf" ]; then
    echo -e "${YELLOW}⚠️  nginx.conf detectado - debería estar como backup${NC}"
fi

if [ -f "nginx.conf.backup" ]; then
    echo -e "${GREEN}✅ nginx.conf.backup preservado${NC}"
    ((PASSED++))
fi

echo ""
echo -e "${BLUE}📊 RESUMEN DE VERIFICACIÓN${NC}"
echo "=========================="
echo ""
echo -e "✅ Checks pasados: ${GREEN}$PASSED${NC}"
echo -e "❌ Checks fallidos: ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡PERFECTO! Todo está listo para el deploy con CADDY${NC}"
    echo -e "${GREEN}🚀 Tu proyecto migrado a Caddy está preparado para producción${NC}"
    echo ""
    echo -e "${BLUE}Próximos pasos:${NC}"
    echo "1. git add ."
    echo "2. git commit -m \"🚀 Migración completa a Caddy v2.0 - SSL automático\""
    echo "3. git push origin main"
    echo "4. Deploy en Easypanel (automático)"
    echo ""
    echo -e "${BLUE}Beneficios de Caddy:${NC}"
    echo "✅ SSL automático (sin Let's Encrypt manual)"
    echo "✅ 70% menos configuración que nginx"
    echo "✅ HTTP/2 por defecto"
    echo "✅ Logs con rotación automática"
    echo "✅ Menor uso de memoria"
    echo ""
    exit 0
else
    echo -e "${RED}⚠️  HAY PROBLEMAS QUE RESOLVER${NC}"
    echo -e "${YELLOW}Por favor corrige los errores antes del deploy${NC}"
    echo ""
    exit 1
fi