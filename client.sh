#!/bin/bash

if [ "$1" == "" ]
then
	echo "Debes indicar la direccion del servidor."
	echo "Ejemplo:"
	echo -e "\t$0 127.0.0.1"
	exit 1
fi

IP_Server=$1

IP=`ip a | grep "scope global" | xargs | cut -d " " -f 2 | cut -d "/" -f 1`
PORT="2022"

echo "Cliente de Dragon Magia Abuelita Miedo 2022"

echo "1. ENVIO DE CABECERA"


echo "DMAM $IP" | nc $IP $PORT
DATA=`nc -l $PORT`

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: el header se envio incorrectamente"
	exit 1
fi

echo "4. Enviando el FILE_NAME"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc $IP $PORT

echo "7. RECIBIENDO OK_FILE_NAME"
DATA=`nc -l $PORT`

echo "8. ENVIANDO UN ARCHIVO"
MD5=`cat ./client/dragon.txt`
echo $MD5
ENVIANDO=`echo $MD5 | md5sum`
echo $ENVIANDO
echo $ENVIANDO| nc $IP $PORT

echo "9.RECIBIENDO OK_DRAGON"
DATA=`nc -l $PORT`
if [ "$DATA" != "OK_DRAGON" ]
then
	echo "ERROR 4: No dragon"
	echo "KO_DRAGON"
	exit 4
fi
