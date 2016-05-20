#!/bin/bash
#
# @file tex2pdf.sh
# @author Guiherme N. Ramos (gnramos@unb.br)
# 
# Descrição
# ---------
# 
# A partir de um arquivo TeX, gera o PDF da prova com o mesmo nome no diretório 
# definido por TMP_DIR.
# 
# Uso
# ---
# 
# Este script assume que o arquivo TeX está definido na variável TEX_FILE, e 
# define as variáveis TMP_DIR (diretório onde será criado o PDF) e PDF_FILE 
# (define o nome do arquivo PDF).

if [ ! -e "$TEX_FILE" ] ; then
	echo "Arquivo \"$TEX_FILE\" não existe."
	exit 1
fi

if [ -z "$TMP_DIR" ] ; then
	TMP_DIR=/tmp
fi

PDF_FILE="${TEX_FILE%.*}.pdf"
echo "Gerando $PDF_FILE em $TMP_DIR."

pdflatex -output-directory=$TMP_DIR -interaction=batchmode $TEX_FILE 1>/dev/null
if [ "$?" -ne 0 ]; then 
	# repete para mostrar o erro
	pdflatex -output-directory=$TMP_DIR -interaction=nonstopmode $TEX_FILE
	exit 1;
fi

# Indexação correta
pdflatex -output-directory=$TMP_DIR -interaction=batchmode $TEX_FILE 1>/dev/null