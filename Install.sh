#!/bin/bash

# Agregar tareas al crontab
function add_cron_task() {
    # Validar que no se haya agregado antes
    local existing_task=$(crontab -l | grep -Fx "$1")
    if [ -z "$existing_task" ]; then
        (crontab -l 2>/dev/null; echo "$1") | crontab -
    else
        echo "La tarea ya está agregada al crontab"
    fi
}

# Dar permiso de ejecución a un archivo
function give_execute_permission() {
    if [ -e "$1" ]; then
        chmod +x "$1"
        echo "Se dio permiso de ejecución al archivo $1"
    else
        echo "El archivo $1 no existe"
    fi
}

# Ejecutar un script si existe
function run_script() {
    if [ -e "$1" ]; then
        sh "$1"
    else
        echo "El archivo $1 no existe"
    fi
}


#Utilidades
# Crea el archivo freeram en /usr/local/bin/
echo '#!/bin/sh' > /usr/local/bin/freeram
echo '# Freeram es un script para limpiar la cache de la memoria RAM' >> /usr/local/bin/freeram
echo 'sync ; echo 3 > /proc/sys/vm/drop_caches ; echo "RAM Liberada"' >> /usr/local/bin/freeram


# Crea el archivo ipadd en /usr/local/bin/
echo '#!/bin/sh' > /usr/local/bin/ipadd
echo 'if [[ $# -eq 1 ]]; then' >> /usr/local/bin/ipadd
echo '  ipadd=$1' >> /usr/local/bin/ipadd
echo '  iptables -I INPUT 5 -s $ipadd/255.255.255.255 -j ACCEPT -m comment --comment "remoto"' >> /usr/local/bin/ipadd
echo '  service iptables save' >> /usr/local/bin/ipadd
echo '  echo "IP $ipadd agregada a la lista de IPs aceptadas en iptables."' >> /usr/local/bin/ipadd
echo 'else' >> /usr/local/bin/ipadd
echo '  echo "Uso: ./ipadd.sh <IP>"' >> /usr/local/bin/ipadd
echo 'fi' >> /usr/local/bin/ipadd

# Tareas a agregar al crontab
task1="*/10 6-22 * * 1-6 /root/TG/VSD.sh"
task2="* * * * 0-7 /root/TG/FW.sh"

# Dar permiso de ejecución a los archivos
give_execute_permission /root/TG/VSD.sh
give_execute_permission /root/TG/FW.sh
give_execute_permission /root/TG/convert_MP3.sh
give_execute_permission /root/TG/symlink.sh
give_execute_permission /root/TG/lame.sh
give_execute_permission /usr/local/bin/freeram
give_execute_permission /usr/local/bin/ipadd

# Agregar tareas al crontab
add_cron_task "$task1"
add_cron_task "$task2"



# Le da permisos de ejecución al archivo freeram
#chmod +x /usr/local/bin/freeram
#echo 'Archivo freeram creado en /usr/local/bin/ y configurado para tener permisos de ejecución.'



# Ejecutar un script
run_script /root/TG/lame.sh
