#!/bin/bash
#
# @file tex2zip.sh
# @author Guiherme N. Ramos (gnramos@unb.br)
# 
# Descrição
# ---------
# 
# A partir de um arquivo TeX que define uma sequência de problemas, gera o PDF 
# da prova e os arquivos ZIP com os problemas em questão, na mesma ordem do arquivo
# TeX, para realização de um simulado com o servidor BOCA na disciplina Programação 
# Competitiva.
# 
# Uso
# ---
# 
# Este script recebe um arquivo TeX como argumento, indicando o(s) nome(s) do(s) 
# problema(s) (conforme definido na estrutura de diretórios). Um arquivo PDF com
# o mesmo nome é gerado deste e incluído no ZIP do problema. Para cada problema, 
# um arquivo problema.ZIP será gerado no diretório /tmp, já na estrutura padrão 
# para uso no BOCA. 
#
# Por exemplo:
# 
#     ./tex2zip.sh 2014_Maratona.tex

source tex2prob.sh
source tex2pdf.sh
source pdf2zip.sh

exit 0