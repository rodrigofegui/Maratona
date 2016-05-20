#!/bin/bash
#
# @file pdf2zip.sh
# @author Guiherme N. Ramos (gnramos@unb.br)
# 
# Descrição
# ---------
# 
# A partir de um arquivo PDF que define uma prova e de uma sequência de problemas
# (que deve ser igual a apresentada no PDF), gera os arquivos ZIP com os problemas 
# para realização de um simulado com o servidor BOCA na disciplina Programação 
# Competitiva.
# 
# Uso
# ---
# 
# Este script assume que o arquivo PDF está definido na variável PDF_FILE, que 
# ele existe no diretório TMP_DIR (onde serão criados os arquivos ZIP), e que os
# problemas estão listados na variável PROBLEMAS. Além disso, assume-se que os
# estão devidamente organizados conforme a estrutura de diretórios do BOCA.
# 
# Observações
# -----------
# Para o juiz, assume-se cada problema está organizado com a seguinte estrutura 
# minimamente com de arquivos
# (dentro de um diretório que indica o principal conceito envolvido na resolução):
#	- conceito
#       `- problema
#	         |- input
#	         |    `- problema     (casos de teste)
#	         `- output
#	              `- problema     (resultados esperados para os casos de teste)
#
# Caso se deseje sobrescrever alguma configuração para um problema específico, 
# basta acrescentar o(s) diretório(s) e arquivo(s) relacionados ao diretório do
# problema. Ex:
#	- conceito
#       `- problema
#	         |- input
#	         |- limits
#	         |    `- java           (limites de tempo específicos para java)
#	         `- output

if [ -z "$PROBLEMAS" ] ; then
	echo "Problemas não definidos."
	exit 1
fi

TMP_PDF_FILE=$TMP_DIR/$PDF_FILE
if [ ! -e "$TMP_PDF_FILE" ] ; then
	echo "Arquivo \"$TMP_PDF_FILE\" não existe."
	exit 1
fi

echo "Gerando ZIP(s):"

BASEDIR=$(pwd)
LETTER=A
for problema in $PROBLEMAS; do
	TARGETDIR=$(find . -name $problema | head -n1)

	if [ ! -e $TARGETDIR/input/$problema ] || [ ! -e $TARGETDIR/output/$problema ]; then
		echo "    Problema \"$problema\" não contém entradas e/ou saídas. Ignorando..."
	else
		# Criar diretório com descrição
		DESC_DIR=$TARGETDIR/description
		PROB_INFO=$DESC_DIR/problem.info

		rm -rf $DESC_DIR
		mkdir $DESC_DIR
		FULLNAME=$(grep 'NomeProblema' $TARGETDIR/$problema.tex | cut -d'{' -f 2 | cut -d'}' -f 1)
		echo -e "basename=$problema\nfullname='$FULLNAME'\ndescfile=$PDF_FILE" > $PROB_INFO
		cp $TMP_PDF_FILE $DESC_DIR

		# Remover arquivo existente
		TARGETZIP="/tmp/$LETTER""_$problema.zip"
		echo "    $TARGETZIP"
		rm -f $TARGETZIP
		
		# Inclusão dos arquivos padrões
		cd BocaDefaults
		find . -print | zip $TARGETZIP -q -@
		cd ..

		# Incluir arquivos específicos do problema.
		cd "$TARGETDIR"
		TARGETDIR=$(find . -maxdepth 1 -type d -exec basename {} \;)
		for word in $TARGETDIR; do 
		    	if [ ! "$word" == "." ] ; then
		    		zip $TARGETZIP -q $word/*
		    	fi
		done		
		cd $BASEDIR

		# Remover diretório com descrição
		if [ -z $CREATEDDESC_DIR ] ; then
			rm -rf $DESC_DIR
		fi

		# Ajuste
		LETTER=$(echo "$LETTER" | tr "A-Z" "B-Z_")
	fi
done

echo "Não esqueça de conferir a ordem dos problemas com o PDF."