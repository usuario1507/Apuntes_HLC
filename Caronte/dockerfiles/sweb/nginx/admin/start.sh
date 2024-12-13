#!/bin/bash
set -e

config_nginx(){
   # Inicia Nginx en segundo plano
   #Para lanzar Nginx en segundo plano y mantener el contenedor activo, n
   #ecesitas un proceso en primer plano que evite que Docker finalice el contenedor. 
   #Nginx, por defecto, se ejecuta como un demonio (en segundo plano), 
   #pero Docker requiere un proceso principal activo en el contenedor.
   nginx &
   # Mantener el contenedor activo ejecutando Nginx en primer plano
   # exec nginx -g "daemon off;"
   # Mantén el contenedor vivo
   #tail -f /dev/null
}

#....

load_entrypoint_base(){
   #ejecutar entrypoint ubbase
   /root/admin/start.sh
  
}

main(){
   load_entrypoint_base
   config_nginx
 

#   tail -f /dev/null 
    
}

main
