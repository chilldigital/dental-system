# Dockerfile que organiza archivos para nginx
FROM nginx:alpine

# Copiar archivos HTML a la raíz de nginx
COPY public/ /usr/share/nginx/html/

# Copiar archivos src/ TAMBIÉN a la raíz para que nginx los encuentre
COPY src/ /usr/share/nginx/html/src/

# Verificar que los archivos están en el lugar correcto
RUN echo "=== VERIFICANDO ESTRUCTURA ===" && \
    echo "Archivos HTML:" && \
    ls -la /usr/share/nginx/html/ && \
    echo "Archivos CSS:" && \
    ls -la /usr/share/nginx/html/src/styles/ && \
    echo "Archivos JS:" && \
    ls -la /usr/share/nginx/html/src/scripts/

# Usar configuración simple de nginx
RUN echo 'server { \
    listen 80; \
    server_name odonto.chilldigital.tech localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    \
    location /api/ { \
        proxy_pass https://n8n.chilldigital.tech/webhook/; \
        proxy_set_header Host n8n.chilldigital.tech; \
        proxy_set_header X-Real-IP $remote_addr; \
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; \
        proxy_set_header X-Forwarded-Proto $scheme; \
    } \
    \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    \
    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ { \
        expires 1y; \
    } \
    \
    error_page 404 /404.html; \
    error_page 500 502 503 504 /50x.html; \
}' > /etc/nginx/conf.d/default.conf

# Exponer puerto 80
EXPOSE 80

# Comando de inicio
CMD ["nginx", "-g", "daemon off;"]