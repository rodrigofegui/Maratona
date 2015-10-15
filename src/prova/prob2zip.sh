#!/bin/bash
#
# @file prob2zip.sh
# @author Guiherme N. Ramos (gnramos@unb.br)
# 
# Descrição
# ---------
# 
# A partir de uma sequência de problemas, gera o arquivo TeX para uma prova, o 
# qual serve de base para produzir um PDF da prova e os arquivos ZIP com os 
# problemas em questão, na mesma ordem fornecida, para realização de um simulado 
# com o servidor BOCA na disciplina Programação Competitiva.
# 
# Uso
# ---
# 
# Este script recebe uma lista de argumentos indicando o(s) nome(s) do(s) 
# problema(s) e gera um arquivo TeX, listando os  problemas *na mesma ordem* de 
# entrada. Um arquivo PDF com o mesmo nome do TeX é gerado deste e incluído no 
# ZIP do problema. Para cada problema, um arquivo problema.ZIP será gerado no 
# diretório temporário (/tmp), já na estrutura padrão para uso no BOCA.
#
# Por exemplo, o comando a seguir gera os arquivos /tmp/ludo.zip e /tmp/led.zip,
# ambos referentes a prova definida no arquivo AAAA-MM-DD_simulado.tex.
# 
#     ./prob2zip.sh ludo led
# 
# Pode-se passar um argumento adicional (opcional) indicando qual o nome do arquivo 
# TeX a ser criado. A ordem de apresentação do argumentos não é relevante.
# 
# Por exemplo, o comando a seguir gera o arquivo /tmp/ludo.zip e /tmp/led.zip,
# ambos referentes a uma mesma prova definida no arquivo simulado.tex.
# 
#     ./prob2zip.sh ludo simulado.tex led

source prob2tex.sh
source tex2pdf.sh
source pdf2zip.sh

exit 0