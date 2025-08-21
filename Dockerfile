# Dockerfile SIMPLE para DentalPro con Caddy
FROM caddy:2-alpine

# Copiar archivos del proyecto
COPY public/ /usr/share/caddy/
COPY src/ /usr/share/caddy/src/

# Crear Caddyfile básico
RUN echo ":80" > /etc/caddy/Caddyfile && \
    echo "root * /usr/share/caddy" >> /etc/caddy/Caddyfile && \
    echo "file_server" >> /etc/caddy/Caddyfile && \
    echo "try_files {path} /index.html" >> /etc/caddy/Caddyfile && \
    echo "" >> /etc/caddy/Caddyfile && \
    echo "reverse_proxy /api/* https://n8n.chilldigital.tech {" >> /etc/caddy/Caddyfile && \
    echo "    uri strip_prefix /api" >> /etc/caddy/Caddyfile && \
    echo "    uri add_prefix /webhook" >> /etc/caddy/Caddyfile && \
    echo "}" >> /etc/caddy/Caddyfile

# Verificar Caddyfile creado
RUN cat /etc/caddy/Caddyfile

# Exponer puerto 80
EXPOSE 80

# Comando de inicio
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
