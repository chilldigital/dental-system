FROM nginx:alpine

# Archivos estáticos
WORKDIR /usr/share/nginx/html
COPY index.html .
COPY pacientes.html .
COPY nuevo-paciente.html .
COPY calendario.html .
COPY css ./css
COPY js ./js

# Configuración de Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY site.conf  /etc/nginx/conf.d/site.conf

EXPOSE 80
