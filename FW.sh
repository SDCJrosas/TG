#!/bin/sh

#APITG
#   SDC_SERVERS_1
#TOKEN="5948500645:AAGmWF-2V1v5OVXQdnyN82FPR3DOaiMxPGk"
#ID="-855041401"
#URL="https://api.telegram.org/bot$TOKEN/sendMessage"
#   SDC_SERVERS
TOKEN="5948500645:AAGmWF-2V1v5OVXQdnyN82FPR3DOaiMxPGk"
ID="-883116561"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"


#Envia alerta si a leyenda y la consulta son iguales
ipt="iptables: Firewall is not running."
ipt2=$(/sbin/service iptables status)
server=$(hostname -I | awk ' {print $1}')

if [[ $ipt2 = $ipt ]]; then


/sbin/service iptables restart
	



curl -s -X POST $URL -d chat_id=$ID -d text="Servicio Iptables estaba desactivado.
Se reinicio el servicio: $(hostname)
Ip addr:  $server
Fecha:  $(date)"	

fi
