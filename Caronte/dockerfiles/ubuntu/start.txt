#!/bin/bash
set -e

echo "Configuracion de mi servidor" > /root/logs/archivo.log
echo "${USUARIO} es el usuario"  >> /root/logs/archivo.log

#Con función
check_usuario(){
    if grep -q "${USUARIO}" /etc/passwd 
    then
        echo "${USUARIO} se encuentra en el sistema"  >> /root/logs/archivo.log
        return 1 #si no se encuentra es FALLO
    else
        echo "${USUARIO} No se encuentra en el sistema"  >> /root/logs/archivo.log
        return 0 #si no se encuentra es EXITO
    fi
}
check_home(){
    if [ ! -d "/home/${USUARIO}" ]
    then
        echo "el directorio de ${USUARIO} No existe"  >> /root/logs/archivo.log
        return 0 #si no se encuentra es EXITO 
    else
        echo "el directorio de ${USUARIO} existe"  >> /root/logs/archivo.log
        return 1 #si no se encuentra es FALLO
    fi
}

newUser(){
    check_usuario 
    if [ "$?" -eq 0 ]
    then 
        check_home  
        if [ "$?" -eq 0 ]
        then
            useradd -m -d /home/"${USUARIO}" -s /bin/bash "${USUARIO}"
            echo "${USUARIO}:${PASSWORD}" | chpasswd
            echo "el usuario ${USUARIO} ha sido creado"  >> /root/logs/archivo.log
        else
            echo "el usuario ${USUARIO} NO PUEDE CREARSE, existe home"  >> /root/logs/archivo.log
        fi
    else
        echo "el usuario ${USUARIO} NO PUEDE CREARSE, existe en fichero"  >> /root/logs/archivo.log
    fi
}

make_bienvenida(){
    mv /root/bienvenida.j2 /home/${USUARIO}
    file="/home/${USUARIO}/bienvenida.j2"
    if [ -f "${file}" ]
    then
        #sed -i "s/#USUARIO#/${USUARIO}/g" "${file}"
        sed -i "s/#   Port 22/Port ${PORT_SSH}/g" "/etc/ssh/ssh_config"

        echo "fichero bienvenida modificado"  >> /root/logs/archivo.log
    else 
        echo "el archio ${file} no existe"  >> /root/logs/archivo.log
    fi
    mv ${file} "/home/${USUARIO}/bienvenida.txt"
}

main(){
    newUser  
    make_bienvenida

    tail -f /dev/null 
}

main


# ps aux | grep -q ${PROCESO} > /dev/null
# echo "---------" >> /root/logs/archivo.log
# pidof ${PROCESO}
# echo $? >> /root/logs/archivo.log

# if ps aux | grep -q "apache"; then
#     echo "'Apache' se encuentra en ejecucion"  >> /root/logs/archivo.log
# else
#     echo "'Apache' No se encuentra en ejecucion"  >> /root/logs/archivo.log
# fi

# ---- Con el resultado de un comando -----------
# pgrep "---> proceso = ${PROCESO}"  >> /root/logs/archivo.log

# if [ $? -gt 0 ]; then
#     echo "--> ${PROCESO} Se encuentra en ejecucion"  >> /root/logs/archivo.log
# else
#     echo "--> ${PROCESO} No se encuentra en ejecucion"  >> /root/logs/archivo.log
# fi

# tail -f /dev/null 