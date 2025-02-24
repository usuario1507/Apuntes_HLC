FROM ubuntu:latest

RUN apt-get update

ENV TZ=Europe/Madrid

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install -y nginx

# Create the directory before writing the file
RUN mkdir -p /var/www/html/
RUN echo 'Ejemplo de POD CON KUBERNETES y YAML' > /var/www/html/index.html

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]

EXPOSE 80