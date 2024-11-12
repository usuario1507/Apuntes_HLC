# Partimios de una imagen de ubuntu de la su última version :version
FROM ubuntu:24.04

#Se define una argumento en construccion de la imagen 
ARG NAME
#Se define una variable en ejecucuión del contenedor 
# ENV USUARIO=${NAME}

ENV USUARIO="pepe"
ENV PASSWORD="abc"

RUN apt-get update && apt-get install -yq --no-install-recommends && rm -rf /var/lib/apt/lists/* \
     curl \ 
     dosunix \
     nano \
     net-tools \ 
     iputils-ping

RUN mkdir /root/logs
RUN touch /root/logs/archivo.log

RUN mkdir /root/admin
COPY ./admin /root/admin
COPY start.sh /root/admin

# COPY ./datos/bienvenida.j2 /root
RUN chmod +x /root/admin/start.sh
WORKDIR /root/admin

ENTRYPOINT ["/root/admin/start.sh"]