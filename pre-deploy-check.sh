#!/bin/bash
# 🚀 Script de Pre-Deploy - DentalPro v2.0.0
# Verifica que todo está listo para producción

echo "🔍 VERIFICACIÓN PRE-DEPLOY - DentalPro v2.0.0"
echo "=============================================="
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

# Check Docker files
check_file "docker/Dockerfile" "Dockerfile optimizado"
check_file "docker/nginx.conf" "Nginx configurado"

# Check documentation
check_file "docs/setup.md" "Guía de instalación"
check_file "docs/api.md" "Documentación de API"
check_file "docs/deployment.md" "Guía de deployment"

# Check public files
check_file "public/index.html" "Página principal"
check_file "public/pacientes.html" "Página de pacientes"
check_file "public/nuevo-paciente.html" "Formulario de pacientes"
check_file "public/calendario.html" "Sistema de calendario"
check_file "public/404.html" "Página de error 404"
check_file "public/50x.html" "Página de error 5xx"

# Check source files
check_file "src/styles/style.css" "CSS principal"
check_file "src/scripts/app.js" "JavaScript principal"
check_file "src/scripts/dashboard.js" "JS del dashboard"
check_file "src/scripts/pacientes.js" "JS de pacientes"
check_file "src/scripts/nuevo-paciente.js" "JS de formulario"
check_file "src/scripts/calendario.js" "JS de calendario"
check_file "src/scripts/utils.js" "Utilidades JS"

# Check directories
check_dir "src" "Directorio source"
check_dir "public" "Directorio público"
check_dir "docs" "Directorio documentación"
check_dir "docker" "Directorio Docker"

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
    echo "🔨 Construyendo imagen Docker de prueba..."
    if docker build -t dental-pro-test . > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Docker build exitoso${NC}"
        ((PASSED++))
        
        # Clean up test image
        docker rmi dental-pro-test > /dev/null 2>&1
    else
        echo -e "${RED}❌ Docker build falló${NC}"
        ((FAILED++))
    fi
else
    echo -e "${YELLOW}⚠️  Docker no disponible - skipping build test${NC}"
fi

echo ""
echo -e "${BLUE}📊 RESUMEN DE VERIFICACIÓN${NC}"
echo "=========================="
echo ""
echo -e "✅ Checks pasados: ${GREEN}$PASSED${NC}"
echo -e "❌ Checks fallidos: ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡PERFECTO! Todo está listo para el deploy${NC}"
    echo -e "${GREEN}🚀 Tu proyecto está preparado para producción${NC}"
    echo ""
    echo -e "${BLUE}Próximos pasos:${NC}"
    echo "1. git add ."
    echo "2. git commit -m \"🚀 Release v2.0.0 - Sistema DentalPro Completo\""
    echo "3. git push origin main"
    echo "4. Deploy en Easypanel"
    echo ""
    exit 0
else
    echo -e "${RED}⚠️  HAY PROBLEMAS QUE RESOLVER${NC}"
    echo -e "${YELLOW}Por favor corrige los errores antes del deploy${NC}"
    echo ""
    exit 1
fi
