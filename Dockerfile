# Dockerfile optimizado para DentalPro con Caddy
FROM caddy:2-alpine

# Copiar archivos del proyecto manteniendo estructura
COPY public/ /usr/share/caddy/
COPY src/ /usr/share/caddy/src/

# Configuración Caddy súper simple para tu estructura
RUN echo ':80 { \
    # Servir desde la raíz \
    root * /usr/share/caddy \
    file_server \
    \
    # Proxy para tu N8N \
    reverse_proxy /api/* https://n8n.chilldigital.tech { \
        uri strip_prefix /api \
        uri add_prefix /webhook \
    } \
    \
    # SPA fallback para React-style routing \
    try_files {path} /index.html \
    \
    # Headers básicos de seguridad \
    header { \
        X-Frame-Options "SAMEORIGIN" \
        X-Content-Type-Options "nosniff" \
        X-XSS-Protection "1; mode=block" \
    } \
    \
    # Logs para debugging en Easypanel \
    log { \
        output stdout \
        level INFO \
    } \
}' > /etc/caddy/Caddyfile

# Health check para Easypanel
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Exponer puerto 80
EXPOSE 80

# Caddy se ejecuta automáticamente
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
