#!/bin/bash
set -e

source /root/admin/usuarios/usuarios.sh
source /root/admin/ssh/ssh.sh

chmod +x /root/admin/usuarios/usuarios.sh
chmod +x /root/admin/ssh/ssh.sh

main(){
   newUser  
#    if [ "$?" -eq 0 ]
#    then 
   newSSH
   # make_bienvenida

   # tail -f /dev/null &
}

main
