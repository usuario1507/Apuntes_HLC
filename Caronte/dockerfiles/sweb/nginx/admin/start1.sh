#!/bin/bash
set -e


main(){
   #ejecutar entrypoint ubbase
   bash /root/admin/start.sh

   # nginx -g 'daemon off;'
   nginx
   tail -f /dev/null 
}

main
