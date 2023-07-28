#!/bin/sh

# Busca si hay algún proceso con el nombre de este script en ejecución
LOCKFILE=/var/lock/VSD.lock

if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
  echo "El script ya se está ejecutando, saliendo"
  exit
fi

trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}


#APITG
#   SDC_SERVERS_1
#TOKEN="5948500645:AAGmWF-2V1v5OVXQdnyN82FPR3DOaiMxPGk"
#ID="-855041401"
#URL="https://api.telegram.org/bot$TOKEN/sendMessage"
#   SDC_SERVERS
TOKEN="5948500645:AAGmWF-2V1v5OVXQdnyN82FPR3DOaiMxPGk"
ID="-883116561"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"



# set alert level 90% is default
ALERT=90

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;

do
  #echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  server=$(echo $output |hostname -I | awk ' {print $1}')
  
  if [ $usep -ge $ALERT ]; then
  	
    
    ################# MP3 #############################	
    if command -v lame >/dev/null 2>&1; then

	############### Telegram ########################

	curl -s -X POST $URL -d chat_id=$ID -d      text="Quedandose sin espacion en el servidor : $(hostname)
Espacion en el disco : \"$partition ($usep%)\"
Ip addr:  $server
Fecha:  $(date)"
       
sh /root/TG/convert_MP3.sh
sleep 5
sh /root/TG/symlink.sh

        mp3=$(df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " "  }')
      

	curl -s -X POST $URL -d chat_id=$ID -d  text="Se convirtieron archivos a MP3 en $(hostname)
Espacion en el disco : \"  $mp3  \"
Fecha:  $(date)"

    else
    sh /root/TG/lame.sh

	curl -s -X POST $URL -d chat_id=$ID -d  text="Quedandose sin espacion en el servidor : $(hostname)

LAME no está instalado en el servidor. La conversión de MP3 no se puede realizar.

Ip addr:  $server
Fecha:  $(date)"

       # echo "LAME no está instalado en el servidor. La conversión de MP3 no se puede realizar."
    fi
  	
  fi

done

