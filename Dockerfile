# Dockerfile que organiza archivos para nginx
FROM nginx:alpine

# Crear usuario no-root
RUN adduser -D nginxuser

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

# Configurar permisos
RUN chown -R nginxuser:nginxuser /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Cambiar a usuario no-root
USER nginxuser

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]