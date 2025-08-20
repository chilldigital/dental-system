FROM nginx:alpine

# Copiar archivos estáticos
COPY . /usr/share/nginx/html/

# Copiar configuración nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer puerto 80
EXPOSE 80

# Comando de inicio
CMD ["nginx", "-g", "daemon off;"]