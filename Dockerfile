# Dockerfile SIMPLE para DentalPro con Caddy
FROM caddy:2-alpine

# Copiar archivos del proyecto
COPY public/ /usr/share/caddy/
COPY src/ /usr/share/caddy/src/

# Copiar Caddyfile externo (más limpio)
COPY Caddyfile /etc/caddy/Caddyfile

# Verificar contenido del Caddyfile
RUN cat /etc/caddy/Caddyfile

# Exponer puerto 80
EXPOSE 80

# Comando de inicio
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
