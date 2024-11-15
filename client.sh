#!/bin/bash
PORT="2022"

echo "Cliente de Dragon Magia Abuelita Miedo 2022"

echo "1. ENVIO DE CABECERA"


echo "DMAM" | nc 127.0.0.1 $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: el header se envio incorrectamente"
	exit 1
fi

echo "4. Enviando el FILE_NAME"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc localhost $PORT

echo "7. RECIBIENDO OK_FILE_NAME"
DATA=`nc -l $PORT`

echo "8. ENVIANDO UN ARCHIVO"
MD5=`cat ./client/dragon.txt`
echo $MD5
ENVIANDO=`echo $MD5 | md5sum`
echo $ENVIANDO
echo $ENVIANDO| nc localhost $PORT

echo "9.RECIBIENDO OK_DRAGON"
DATA=`nc -l $PORT`
if [ "$DATA" != "OK_DRAGON" ]
then
	echo "ERROR 4: No dragon"
	echo "KO_DRAGON"
	exit 4
fi
