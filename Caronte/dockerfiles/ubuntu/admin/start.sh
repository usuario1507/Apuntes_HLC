#!/bin/bash
set -e

source ./usuarios/usuarios.sh
source ./ssh/ssh.sh

chmod +x /root/admin/usuarios/usuarios.sh
chmod +x /root/admin/ssh/ssh.sh

main(){
   newUser  
   config_ssh
   # make_bienvenida

    tail -f /dev/null 
}

main
