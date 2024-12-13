#!/bin/bash
set -e

config_git(){
   # descarga el proyecto via Git en /home/${USUARIO}/app
   mkdir /home/${USUARIO}/app
   cd /home/${USUARIO}/app
   git clone ${GITHUB}
   echo "Proyecto ${PROYECTO} clonado..." >> /root/logs/archivo.log

}
config_react(){
   cd /home/${USUARIO}/app/${PROYECTO}
   echo "Dentro de ${PROYECTO}..." >> /root/logs/archivo.log
   # Verifica si React con TypeScript ya está inicializado
   if [ ! -d "node_modules" ]; then
      # Ejecutar npm install
      npm install 
      if [ $? -ne 0 ]; then
         echo "Error al instalar dependencias. Abortando." >> /root/logs/archivo.log
         exit 1
      fi
      echo "dependencias instaladas..." >> /root/logs/archivo.log
      # Ejecutar npm start
      npm start
      if [ $? -ne 0 ]; then
         echo "Error al iniciar la aplicación. Abortando."
         exit 1
      fi
      echo "Iniciando la aplicación en 3000.." >> /root/logs/archivo.log
   fi
  
   if [ ! -d "build" ] || [ -z "$(ls -A build)" ]; then
      echo "Construyendo la aplicación React para producción..." >> /root/logs/archivo.log
      # Ejecutar npm run build
      npm run build
      if [ $? -ne 0 ]; then
            echo "Error al construir la aplicación.">> /root/logs/archivo.log
            exit 1
      fi
      # Mover al html
      mv build/*.* /var/www/html
      chown -R www-data /var/www/html
      chmod -R 755  /var/www/html
      echo "Build movido a /var/www/html... Sirviendo nginx" >> /root/logs/archivo.log
      echo "Todo completado exitosamente.">> /root/logs/archivo.log
   fi
}

load_entrypoint_nginx(){
   #ejecutar entrypoint ngin. Invoca a EP de base, configura nginx y lanza nginx &
   /root/admin/nginx/admin/start.sh
}

main(){
   load_entrypoint_nginx 
   config_git
   config_react

   tail -f /dev/null
}

main
