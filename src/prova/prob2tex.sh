#!/bin/bash
#
# @file prob2tex.sh
# @author Guiherme N. Ramos (gnramos@unb.br)
#
# Descrição
# ---------
#
# A partir de uma sequência de nomes de problemas, gera um arquivo TeX de prova.
#
# Uso
# ---
#
# Este script recebe uma lista de argumentos indicando o(s) nome(s) do(s)
# problema(s) e gera um arquivo TeX listando os  problemas *na mesma ordem* de
# entrada. A lista de problemas fica armazenada na variável PROBLEMAS, e o nome
# do arquivo TeX na variável TEX_FILE.
#
# O arquivo TeX gerado é nomeado como AAAA-MM-DD_prova.tex (AAAA indicando o
# ano, MM o mês, e DD o dia em que foi gerado). Caso seja fornecido um argumento
# opcional com o nome desejado, este será utilizado. Em ambos os casos, o arquivo
# será sobrescrito se existir.

PROBLEMAS=""
TEX_FILE=""

if [[ -z "$@" ]] ; then
	echo "É preciso definir os problemas de entrada."
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
	elif [[ $arg == *.* ]] ; then
		echo "Ignorando argumento \"$arg\"."
	elif [[ ! "$PROBLEMAS" =~ "$arg" ]]; then
		PATH_TO=$(find . -name $arg | sort | head -n1 | cut -d'/' -f 2)
		if [ -z "$PATH_TO" ]; then
			echo "Problema \"$arg\" não encontrado. Ignorando..."
		else
			PROBLEMAS="$PROBLEMAS $arg"
		fi
	fi
done

# Remover espaços extras
PROBLEMAS=$(echo "$PROBLEMAS" | sed -e 's/^ *//' -e 's/ *$//')

if [ -z "$TEX_FILE" ] ; then
	TEX_FILE="$(date +%Y-%m-%d_prova.tex)"
fi

if [ -e "$TEX_FILE" ] ; then
	echo "Sobrescrevendo $TEX_FILE."
else
	echo "Gerando $TEX_FILE."
fi

ANO=$(date +%Y)
MES=$(date +%m)
DIA=$(date +%d)
echo -e "%% $TEX_FILE (gerado automaticamente)\n%%\n" > $TEX_FILE
echo -e "\documentclass{CIC-Maratona}%\n" >> $TEX_FILE
echo -e "\periodo{$MES/$ANO}%\n" >> $TEX_FILE
echo "\begin{document}%" >> $TEX_FILE
for problema in $PROBLEMAS; do
	PATH_TO=$(dirname `find . -name $problema | sort | head -n1`)
	PATH_TO=${PATH_TO#./}
	echo "    \problema[$PATH_TO]{$problema}%" >> $TEX_FILE
done
echo "\end{document}%" >> $TEX_FILE