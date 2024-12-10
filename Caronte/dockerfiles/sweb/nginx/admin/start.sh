#!/bin/bash
set -e

config_nginx(){
   #nginx -g 'daemon off;'
   nginx &
}

#....

load_entrypoint_base(){
   #ejecutar entrypoint ubbase
   /root/admin/start.sh
  
}

main(){
 
  config_nginx
  load_entrypoint_base
    
}

main
