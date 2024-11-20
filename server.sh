#!/bin/bash
PORT="2022"

echo "Servidor de Dragon Magia Abuelita Miedo 2022"

echo "0. escuchamos"
DATA=`nc -l $PORT`
HEADER=`echo "$DATA" | cut -d " " -f1`
IP=`echo "$DATA" | cut -d " " -f2`

if [ "$HEADER" != "DMAM" ]
then
	echo "ERROR 1: Cabecera incorrecta"
	echo "KO_HEADER" | nc $IP $PORT
	exit 1
fi

echo "2. CHECK OK - Enviando OK_HEADER"
echo "OK_HEADER" | nc $IP $PORT

echo "La IP del cliente es: $IP"
echo "5.COMPROBANDO PREFIJO"

DATA=`nc -l $PORT`

PREFIX=`echo "$DATA" | cut -d ' ' -f1`

echo $DATA

if [ "$PREFIX" != "FILE_NAME" ]
then
	echo "ERROR 2: Prefijo incorrecto"
	echo "KO_FILE_NAME" | nc $IP $PORT
	exit 2
fi

echo "6. ENVIANDO OK_FILE_NAME"

echo "OK_FILE_NAME" | nc $IP $PORT

echo "9. RECIBIENDO UN ARCHIVO"
DATA=`nc -l $PORT`
WHAT=`cat ./server/dragon.txt`
echo $WHAT
COMPROBACION=`echo $WHAT | md5sum`
echo $COMPROBACION

echo "10. COMPROBANDO DRAGON"
if [ "$DATA" != "$COMPROBACION" ]
then
	echo "ERROR 3: Dragon incorrecto"
	echo "KO_DRAGON" | nc $IP $PORT
	exit 3
fi

echo "11. ENVIANDO DRAGON"
echo "OK_DRAGON" | nc $IP $PORT

echo "12. FIN DRAGON"
DATA=`nc -l $PORT`
