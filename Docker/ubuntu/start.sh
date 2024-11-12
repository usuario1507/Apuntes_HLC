#!/bin/bash
set -e

source ./usuarios/usuarios.sh

chmod +x /root/admin/usuarios/usuarios.sh

main(){
   newUser  
   # make_bienvenida

    tail -f /dev/null 
}

main
