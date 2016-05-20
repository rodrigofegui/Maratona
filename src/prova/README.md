Provas
======

As provas são feitos com o software [BOCA](http://www.ime.usp.br/~cassio/boca/), portanto os problemas devem ser estruturados de acordo com ele em 9 diretórios. Os valores padrões para as configurações do BOCA estão no diretório [BocaDefaults](BocaDefaults), mas cada problema tem pelo menos 4 arquivos específicos que o definem (não inclusos na estrutura de diretórios padrão).

Problemas
---------

Para usar o juíz automático, cada problema deve definir os seguintes arquivos:

    problema
       |- description
       |     |- problem.info
       |     `- prova.pdf
       |- input
       |     `- problema
       `- output
             `- problema

Conforme a [documentação](http://www.ime.usp.br/~cassio/boca/boca/doc/ADMIN.txt), o arquivo ```problem.info``` descreve os nomes relacionados ao problema, e indica o arquivo que contém a descrição mais detalhada deste (no exemplo, ```prova.pdf```, mas poderia ser outro tipo de arquivo ou mesmo nenhum). O arquivo ```input/problema``` deve conter as entradas a serem utilizadas para testar as soluções enviadas. O arquivo ```output/problema``` deve conter as saídas associadas às entradas (*na mesma ordem*), os arquivos necessariamente devem ter o mesmo nome. **Cuidado com a versão do BOCA sendo utilizada, a versão considerada aqui assume apenas um arquivo de entrada e um de saída, versões mais recentes utilizam diversos arquivos.**

Supondo que se queria avaliar a implementação de um _conceito_ específico com um _problema_, a forma mais simples de se incluir um problema é copiar os arquivos padrões e definir os diretórios/arquivos específicos. Por exemplo, considerando o problema [easyled](3_strings/easyled) (baseado em [LED](https://www.urionlinejudge.com.br/judge/pt/problems/view/1168)), que lida com strings, bastaria definir:

    easyled
     |- description
     |     |- problem.info
     |     `- prova.pdf
     |- input
     |     `- easyled
     `- output
           `- easyled

Além destes, pode ser interessante analisar os arquivos do diretório ```compile``` para, por exemplo, verificar o comando utilizado para compilar a solução (e acrescentar/remover _flags_ de compilação), e os arquivos do diretório ```limits```, que definem as restrições de tempo/espaço associadas ao problema.

Uma vez que todos os 9 diretórios estão completos, basta utilizar uma ferramenta qualquer para gerar um arquivo ZIP deles e submetê-lo ao BOCA via interface web.

PDF de Prova
------------

A classe [CIC-Maratona](CIC-Maratona.cls) facilita a criação de provas, bastando apenas que os problemas sigam a simples estrutura descrita. Ela utiliza a classe [UnBExam](https://github.com/gnramos/UnBExam) como base. Assume-se que cada problema está organizado com a seguinte estrutura de arquivos (dentro de um diretório [opcional] que indica o conceito mais importante para resolução):

    - conceito
        `- problema
	         |- problema.tex
	         |- problema.in
	         `- problema.out

O arquivo ```problema.tex``` contém a descrição do problema e as definições de entrada/saída, ```problema.in``` contém os exemplos de entrada e ```problema.out``` as saídas associadas ao arquivo anterior (veja [easyled](3_strings/easyled) como exemplo).

Todo arquivo ```problema.tex``` deve ter a seguinte estrutura:

```TeX
\NomeProblema{Nome}% Define o título do problema.
Texto introdutório contextualizando/explicando o problema.%

\subsection*{Entrada}%
Texto descrevendo o formato e o significado dos dados de entrada.%

\subsection*{Saída}%
Texto descrevendo a saída de dados.%

% Neste ponto, *automaticamente* serão inclusos os exemplos de IO.

% Caso necessário, pode-se usar:
\aoFinalDoProblema{%
    % Conteúdo a ser inserido *após* os exemplos de IO.
}%
```

Exemplo de uso da classe CIC-Maratona:

```TeX
\documentclass{CIC-Maratona}%

\begin{document}%
    \problema[1_gettingstarted]{fizzbuzz}%
    \problema[3_strings]{easyled}%
\end{document}%
```

Scripts
-------

Para facilitar a configuração do BOCA, alguns __scripts__ são utilizados (feitos para ambiente GNU/Linux).

### ```prob2zip.sh```

O mais útil deles, a partir de uma sequência de nomes de problemas (com arquivos devidamente estruturados), gera os arquivos ZIP relacionados (um por problema), para utilização no BOCA.

Exemplo de uso:

```bash
./prob2zip.sh fizzbuzz easyled
```

### ```tex2zip.sh```

A partir de um arquivo TeX que define uma sequência de problemas (usando a classe [CIC-Maratona](CIC-Maratona.cls)), gera o PDF da prova e os arquivos ZIP com os problemas em questão, na mesma ordem do arquivo TeX.

Exemplo de uso:

```bash
./tex2zip.sh 2015-10-04_prova.tex
```
