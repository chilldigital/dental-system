# =======================================================================
# DOCKERFILE OPTIMIZADO - DENTALPRO CON CADDY
# Reemplaza la configuración nginx por Caddy más simple y potente
# =======================================================================

# Usar imagen base de Caddy (Alpine para menor tamaño)
FROM caddy:2-alpine

# Crear usuario y directorios necesarios
RUN addgroup -g 1001 -S dental && \
    adduser -S dental -u 1001 -G dental && \
    mkdir -p /usr/share/caddy /var/log/caddy && \
    chown -R dental:dental /usr/share/caddy /var/log/caddy

# Copiar el Caddyfile (configuración principal)
COPY Caddyfile /etc/caddy/Caddyfile

# Copiar archivos estáticos del proyecto
COPY public/ /usr/share/caddy/
COPY src/ /usr/share/caddy/src/

# Establecer permisos correctos
RUN chown -R dental:dental /usr/share/caddy

# Instalar herramientas para health check
RUN apk add --no-cache curl

# Cambiar a usuario no-root por seguridad
USER dental

# Exponer puertos HTTP y HTTPS
EXPOSE 80 443

# Health check optimizado
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Variables de entorno
ENV CADDY_CONFIG=/etc/caddy/Caddyfile
ENV CADDY_DATA_DIR=/data
ENV CADDY_CONFIG_DIR=/config

# Comando de inicio optimizado
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

# =======================================================================
# METADATA Y LABELS
# =======================================================================
LABEL maintainer="Chill Digital <soporte@chilldigital.tech>"
LABEL description="DentalPro - Sistema Odontológico con Caddy"
LABEL version="2.0.0"
LABEL project="dental-system"