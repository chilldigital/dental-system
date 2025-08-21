# Dockerfile que organiza archivos para nginx
FROM nginx:alpine

# Crear usuario no-root
RUN adduser -D nginxuser

# Crear directorios temporales y asignar permisos
RUN mkdir -p /var/cache/nginx && \
    mkdir -p /var/cache/nginx/client_temp && \
    mkdir -p /var/cache/nginx/proxy_temp && \
    mkdir -p /var/cache/nginx/fastcgi_temp && \
    mkdir -p /var/cache/nginx/uwsgi_temp && \
    mkdir -p /var/cache/nginx/scgi_temp && \
    chown -R nginxuser:nginxuser /var/cache/nginx && \
    chmod -R 755 /var/cache/nginx

# Copiar archivos de configuración
COPY nginx.conf /etc/nginx/nginx.conf

# Copiar archivos de la aplicación
COPY public/ /usr/share/nginx/html/
COPY src/ /usr/share/nginx/html/src/

# Verificar estructura
RUN echo "=== VERIFICANDO ESTRUCTURA ===" && \
    ls -la /usr/share/nginx/html/ && \
    ls -la /usr/share/nginx/html/src/styles/ && \
    ls -la /usr/share/nginx/html/src/scripts/

# Configurar permisos de los archivos web
RUN chown -R nginxuser:nginxuser /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chown -R nginxuser:nginxuser /var/log/nginx && \
    chown -R nginxuser:nginxuser /etc/nginx/conf.d

# Cambiar a usuario no-root
USER nginxuser

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]