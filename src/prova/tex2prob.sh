#!/bin/bash
#
# @file tex2prob.sh
# @author Guiherme N. Ramos (gnramos@unb.br)
# 
# Descrição
# ---------
# 
# A partir de um arquivo TeX, define uma sequência de problemas.
# 
# Uso
# ---
# 
# Este script recebe um arquivo TeX como argumento (definindo assim a variável
# TEX_FILE), o processa para identificar o(s) nome(s) do(s) problema(s), que são 
# armazenados na variável PROBLEMAS.

TEX_FILE=""
PROBLEMAS=""

if [[ -z "$@" ]] ; then
	echo "É preciso definir a entrada."
	exit 1
fi

for arg in "$@"; do
	if [[ $arg == *.tex ]] ; then
		if [ ! -z "$TEX_FILE" ] ; then
			echo "Só pode haver um arquivo TeX."
			exit 1
		elif [ ! -e $arg ]; then
			echo "Arquivo \"$arg\" não existe."
			exit 1
		fi
		TEX_FILE=$arg
	fi
done

if [ -z "$TEX_FILE" ] ; then
	echo "É preciso definir um arquivo TeX."
	exit 1
fi

GREP_PROBLEMAS=$(grep '^[[:space:]]*[^\%][[:space:]]*\\problema' $TEX_FILE)
for problema in $GREP_PROBLEMAS; do
	AUX=$(grep -oP '{\K.*?(?=})' <<< "$problema")
	PROBLEMAS="$PROBLEMAS $AUX"
done

# Remover espaços extras
PROBLEMAS=$(echo "$PROBLEMAS" | sed -e 's/^ *//' -e 's/ *$//')

if [ -z "$PROBLEMAS" ] ; then
	echo "Não foi possível identificar os problemas em \"$TEX_FILE\"."
	exit 1
fi