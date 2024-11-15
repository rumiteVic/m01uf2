#!/bin/bash
PORT="2022"

echo "Servidor de Dragon Magia Abuelita Miedo 2022"

echo "0. escuchamos"
DATA=`nc -l $PORT`

if [ "$DATA" != "DMAM" ]
then
	echo "ERROR 1: Cabecera incorrecta"
	echo "KO_HEADER" | nc localhost $PORT
	exit 1
fi

echo "2. CHECK OK - Enviando OK_HEADER"
echo "OK_HEADER" | nc localhost $PORT

echo "5.COMPROBANDO PREFIJO"

DATA=`nc -l $PORT`

PREFIX=`echo "$DATA" | cut -d ' ' -f1`

echo $DATA

if [ "$PREFIX" != "FILE_NAME" ]
then
	echo "ERROR 2: Prefijo incorrecto"
	echo "KO_FILE_NAME" | nc localhost 2022
	exit 2
fi

echo "OK_FILE_NAME" | nc localhost  2022
