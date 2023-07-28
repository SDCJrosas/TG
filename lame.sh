#!/bin/bash

# Verificar si LAME está instalado
if ! rpm -q lame >/dev/null 2>&1; then
    echo "LAME no está instalado, instalando..."
    # Instalar LAME con yum y aceptar automáticamente la confirmación de instalación
    yum install -y lame
else
    echo "LAME ya está instalado"
fi

# Verificar la versión de LAME instalada
#lame --version

