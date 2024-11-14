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
    echo " ------------- USUARIO --------------------" >>  /root/logs/archivo.log
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