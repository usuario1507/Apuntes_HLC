#!/bin/bash
set -e

config_git(){
   # Descarga el proyecto via Git en /home/${USUARIO}/app
   mkdir -p /home/${USUARIO}/app
   cd /home/${USUARIO}/app
   echo "Clonando repositorio desde ${GITHUB}..."
   git clone ${GITHUB}
   if [ $? -ne 0 ]; then
      echo "Error al clonar el repositorio. Abortando." >> /root/logs/react.log
      exit 1
   fi
   echo "Proyecto ${PROYECTO} clonado..." >> /root/logs/react.log
}

config_react(){
   cd /home/${USUARIO}/app/${PROYECTO}
   if [ ! -d ".git" ]; then
      echo "El directorio del proyecto no existe. Abortando." >> /root/logs/react.log
      exit 1
   fi
   echo "Dentro de ${PROYECTO}..." >> /root/logs/react.log

   # Verifica si React ya está inicializado
   if [ ! -d "node_modules" ]; then
      echo "Instalando dependencias..."
      npm install 
      if [ $? -ne 0 ]; then
         echo "Error al instalar dependencias. Abortando." >> /root/logs/react.log
         exit 1
      fi
      echo "Dependencias instaladas..." >> /root/logs/react.log
   fi

   if [ ! -d "build" ]; then
      echo "Construyendo la aplicación React para producción..." >> /root/logs/react.log
      npm run build 
      if [ $? -ne 0 ]; then
         echo "Error al construir la aplicación. Abortando." >> /root/logs/react.log
         exit 1
      fi
      cp -r ./build/* /var/www/html
      chown -R www-data /var/www/html
      chmod -R 755 /var/www/html
      echo "Build movido a /var/www/html... Sirviendo nginx" >> /root/logs/react.log
   fi
}

main(){
   touch /root/logs/react.log
   config_git
   config_react

   tail -f /dev/null
}

main