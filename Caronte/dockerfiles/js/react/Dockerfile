# Usar la imagen base de Nginx
FROM nginx:latest

# Argumentos de construcción
ARG CONTEXT
ARG PROYECTO
ARG TZ

# Variables de entorno
ENV TZ=${TZ:-UTC}

# Actualizar paquetes e instalar herramientas necesarias
RUN apt-get update && apt-get install -y curl gnupg software-properties-common git

# Añadir el repositorio oficial de Node.js (versión 20)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

# Instalar Node.js y npm
RUN apt-get install -y nodejs

# Actualizar npm a la última versión
RUN npm install -g npm@latest

# Limpiar caché
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Crear directorios necesarios
USER root
RUN mkdir -p /root/admin/react/admin /root/logs && chmod -R 755 /root/logs

# Copiar archivos locales al contenedor
COPY ./admin /root/admin/react/admin
COPY ./package.json /root/admin/react/
COPY ./README.md /root/admin/react/

# Instalar dependencias
WORKDIR /root/admin/react
RUN npm install

# Dar permisos de ejecución al script
RUN chmod +x /root/admin/react/admin/start.sh

# Configurar el directorio de trabajo
WORKDIR /root/admin/react

# Exponer el puerto 80 (Nginx)
EXPOSE 80

# Entrypoint para iniciar la aplicación
ENTRYPOINT ["./admin/start.sh"]