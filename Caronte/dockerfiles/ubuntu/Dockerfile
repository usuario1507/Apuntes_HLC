# Partimios de una imagen de ubuntu de la su última version :version
FROM ubuntu:24.04

#Se define una argumento en construccion de la imagen 

ENV USUARIO="pepe"
ENV PASSWORD="abc"
# ENV CONTEXTO=${CONTEXTO}

ARG CONTEXT
ARG D_FILES=${CONTEXT}/dockerfiles

RUN apt-get update && apt-get install -yq --no-install-recommends && rm -rf /var/lib/apt/lists/* \
     curl \ 
     dosunix \
     nano \
     net-tools \ 
     iputils-ping

RUN mkdir /root/logs
RUN touch /root/logs/build.log

RUN echo "contexto: ${D_FILES}" 


RUN mkdir /root/admin
COPY ./dockerfiles/ubuntu/admin /root/admin


# COPY ./datos/bienvenida.j2 /root
RUN chmod +x /root/admin/start.sh
WORKDIR /root/admin

ENTRYPOINT ["/root/admin/start.sh"]