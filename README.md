# 🦷 DentalPro - Sistema Odontológico

> Sistema integral de gestión para consultorios odontológicos con frontend moderno y backend automatizado.

[![Licencia](https://img.shields.io/badge/licencia-MIT-blue.svg)](LICENSE)
[![Estado](https://img.shields.io/badge/estado-Producción-green.svg)](https://odonto.chilldigital.tech)
[![Versión](https://img.shields.io/badge/versión-2.0.0-brightgreen.svg)](#)

![DentalPro Screenshot](docs/images/hero-screenshot.png)

## ✨ Características Principales

- 🏥 **Gestión de Pacientes**: Registro completo con historia clínica
- 📅 **Sistema de Turnos**: Calendario integrado para citas
- 📊 **Dashboard Analytics**: Estadísticas en tiempo real
- 🔒 **Seguridad Avanzada**: Headers de seguridad y validación robusta
- ♿ **Accesibilidad Completa**: Compatible con lectores de pantalla
- 📱 **Responsive Design**: Funciona en móviles y tablets
- ⚡ **Alto Rendimiento**: Optimizado para velocidad de carga
- 🔄 **Automatización N8N**: Backend sin servidor con workflows

## 🚀 Demo en Vivo

**🌐 URL Principal**: [https://odonto.chilldigital.tech](https://odonto.chilldigital.tech)

**Funcionalidades disponibles:**
- ✅ Dashboard con estadísticas
- ✅ Gestión completa de pacientes
- ✅ Formularios con validación en tiempo real
- ✅ Búsqueda y filtros avanzados
- ✅ Calendario de turnos
- ✅ Sistema de notificaciones

## 🛠️ Tecnologías Utilizadas

### Frontend
- **HTML5** - Estructura semántica y accesible
- **CSS3** - Estilos modernos con variables CSS
- **JavaScript ES6+** - Lógica del cliente modular
- **Bootstrap 5.3.2** - Framework CSS responsive
- **Bootstrap Icons** - Iconografía consistente

### Backend & APIs
- **N8N** - Automatización y workflows
- **Airtable** - Base de datos en la nube
- **Google Calendar API** - Gestión de eventos
- **Webhooks** - Comunicación en tiempo real

### Infraestructura
- **Docker** - Contenedorización
- **Nginx** - Servidor web con configuración de seguridad
- **Easypanel** - Plataforma de deployment
- **GitHub** - Control de versiones

## 📁 Estructura del Proyecto

```
dental-system/
├── 📁 public/                  # Páginas HTML públicas
│   ├── index.html             # Dashboard principal
│   ├── pacientes.html         # Gestión de pacientes
│   ├── nuevo-paciente.html    # Formulario de registro
│   ├── calendario.html        # Sistema de turnos
│   ├── 404.html              # Página de error 404
│   └── 50x.html              # Página de error servidor
├── 📁 src/                    # Código fuente
│   ├── 📁 styles/            # Estilos CSS
│   │   └── style.css         # Archivo principal de estilos
│   ├── 📁 scripts/           # JavaScript modular
│   │   ├── app.js           # API client y funciones principales
│   │   ├── dashboard.js     # Lógica del dashboard
│   │   ├── pacientes.js     # Gestión de pacientes
│   │   ├── nuevo-paciente.js # Formulario de pacientes
│   │   ├── calendario.js    # Sistema de calendario
│   │   └── utils.js         # Utilidades generales
│   └── 📁 api/              # Comunicación con APIs
│       └── dental-api.js    # Cliente API para N8N
├── 📁 docker/               # Configuración Docker
│   ├── Dockerfile           # Imagen del contenedor
│   └── nginx.conf          # Configuración Nginx segura
├── 📁 docs/                 # Documentación
│   ├── setup.md            # Guía de instalación
│   ├── api.md              # Documentación de API
│   └── deployment.md       # Guía de deployment
├── .gitignore              # Archivos excluidos de Git
├── SECURITY.md             # Políticas de seguridad
├── README.md               # Este archivo
└── LICENSE                 # Licencia del proyecto
```

## 🚀 Instalación y Setup

### Prerrequisitos

- **Docker & Docker Compose** - Para contenedorización
- **Git** - Para clonar el repositorio
- **Cuenta N8N** - Para el backend automatizado
- **Cuenta Airtable** - Para la base de datos

### Instalación Local

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/dental-system.git
   cd dental-system
   ```

2. **Configurar variables de entorno**
   ```bash
   cp .env.example .env
   # Editar .env con tus configuraciones
   ```

3. **Construir y ejecutar con Docker**
   ```bash
   docker build -t dental-pro .
   docker run -p 80:80 dental-pro
   ```

4. **Acceder a la aplicación**
   ```
   http://localhost
   ```

### Configuración de N8N

1. **Importar workflows** desde `docs/n8n-workflows/`
2. **Configurar credenciales** de Airtable y Google Calendar
3. **Activar webhooks** en la configuración de N8N
4. **Probar endpoints** con las URLs de webhook

> 📖 **Guía completa**: Ver [docs/setup.md](docs/setup.md) para instrucciones detalladas.

## 🔧 Configuración

### Variables de Entorno

```bash
# N8N Configuration
N8N_HOST=tu-instancia-n8n.com
N8N_WEBHOOK_PATH=/webhook

# Airtable Configuration  
AIRTABLE_API_KEY=tu_api_key
AIRTABLE_BASE_ID=tu_base_id

# Google Calendar Configuration
GOOGLE_CALENDAR_API_KEY=tu_api_key
GOOGLE_CALENDAR_ID=tu_calendar_id

# Frontend Configuration
FRONTEND_DOMAIN=tu-dominio.com
ENVIRONMENT=production
```

### Endpoints de API

| Endpoint | Método | Descripción |
|----------|--------|-------------|
| `/api/estadisticas` | GET | Estadísticas del dashboard |
| `/api/pacientes` | GET | Lista de pacientes |
| `/api/pacientes` | POST | Crear nuevo paciente |
| `/api/pacientes/{id}` | GET | Obtener paciente específico |
| `/api/calendario` | GET | Eventos del calendario |

> 📖 **Documentación completa**: Ver [docs/api.md](docs/api.md)

## 🔒 Seguridad

DentalPro implementa múltiples capas de seguridad:

- **🛡️ Headers de Seguridad**: CSP, X-Frame-Options, HSTS
- **🚦 Rate Limiting**: Protección contra DDoS y abuso
- **✅ Validación Robusta**: Frontend y backend
- **🔐 CORS Restrictivo**: Solo dominios autorizados
- **🚫 Archivos Protegidos**: Bloqueo de archivos sensibles

> 📖 **Detalles completos**: Ver [SECURITY.md](SECURITY.md)

## 🎯 Uso del Sistema

### Dashboard Principal
- **Estadísticas en tiempo real** de pacientes y turnos
- **Acciones rápidas** para las tareas más comunes
- **Lista de pacientes recientes** con acceso directo

### Gestión de Pacientes
- **Registro completo** con historia clínica
- **Búsqueda avanzada** por nombre y obra social
- **Validación en tiempo real** de formularios
- **Estados visuales** para mejor UX

### Sistema de Turnos
- **Calendario integrado** con Google Calendar
- **Filtros por fecha y estado** de turnos
- **Notificaciones automáticas** via N8N

## 🧪 Testing

### Tests Automáticos
```bash
# Validar HTML
npm run test:html

# Verificar CSS
npm run test:css

# Lint JavaScript
npm run test:js
```

### Tests Manuales
- ✅ Navegación por teclado (accesibilidad)
- ✅ Responsive en diferentes dispositivos
- ✅ Formularios con datos válidos/inválidos
- ✅ Performance con Lighthouse

## 🚀 Deployment

### Easypanel (Recomendado)

1. **Crear nueva aplicación** tipo "Source Code"
2. **Conectar repositorio** GitHub
3. **Configurar branch** `main`
4. **Deploy automático** en cada push

### Docker Manual

```bash
# Build
docker build -t dental-pro .

# Run
docker run -d -p 80:80 \
  --name dental-pro \
  dental-pro
```

> 📖 **Guía completa**: Ver [docs/deployment.md](docs/deployment.md)

## 🤝 Contribuir

### Proceso de Contribución

1. **Fork** el repositorio
2. **Crear branch** para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. **Commit** tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. **Push** al branch (`git push origin feature/nueva-funcionalidad`)
5. **Crear Pull Request**

### Estándares de Código

- **HTML**: Semántico y accesible (WCAG 2.1)
- **CSS**: Variables CSS y metodología BEM
- **JavaScript**: ES6+, funciones puras, JSDoc
- **Commits**: Conventional commits

### Issues y Bugs

Usa las plantillas de GitHub para reportar:
- 🐛 **Bug reports** con pasos para reproducir
- ✨ **Feature requests** con casos de uso
- 📖 **Mejoras de documentación**

## 📈 Roadmap

### Version 2.1 (Próximo)
- [ ] **Dashboard mejorado** con más métricas
- [ ] **Reportes PDF** de historias clínicas
- [ ] **Sistema de recordatorios** automáticos
- [ ] **Multi-usuario** con roles y permisos

### Version 2.2 (Futuro)
- [ ] **App móvil** React Native
- [ ] **Integración WhatsApp** para notificaciones
- [ ] **Backup automático** de datos
- [ ] **Analytics avanzado** con gráficos

### Version 3.0 (Visión)
- [ ] **Multi-consultorio** (SaaS)
- [ ] **Facturación integrada**
- [ ] **Telemedicina** básica
- [ ] **IA para diagnósticos** asistidos

## 📊 Performance

### Métricas Lighthouse (Promedio)
- **Performance**: 95/100 ⚡
- **Accessibility**: 100/100 ♿
- **Best Practices**: 100/100 ✅
- **SEO**: 95/100 📈

### Tiempos de Carga
- **First Contentful Paint**: < 1.2s
- **Largest Contentful Paint**: < 2.0s
- **Cumulative Layout Shift**: < 0.1

## 📞 Soporte

### Canales de Soporte

- 📧 **Email**: soporte@chilldigital.tech
- 💬 **GitHub Issues**: Para bugs y features
- 📱 **WhatsApp**: +54 9 XXX XXX-XXXX (urgencias)

### Horarios de Atención
- **Lunes a Viernes**: 9:00 - 18:00 (GMT-3)
- **Respuesta promedio**: < 4 horas
- **Urgencias**: 24/7 via WhatsApp

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

```
MIT License

Copyright (c) 2024 Chill Digital

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software...
```

## 🙏 Agradecimientos

- **Bootstrap Team** - Por el excelente framework CSS
- **N8N Community** - Por la plataforma de automatización
- **Airtable** - Por la base de datos en la nube
- **GitHub** - Por el hosting del código
- **Easypanel** - Por la plataforma de deployment

---

<div align="center">

**Desarrollado con ❤️ por [Chill Digital](https://chilldigital.tech)**

[🌐 Website](https://chilldigital.tech) • [📧 Email](mailto:hola@chilldigital.tech) • [💼 LinkedIn](https://linkedin.com/company/chill-digital)

</div>
