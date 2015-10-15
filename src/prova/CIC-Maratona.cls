%%
%% Arquivo CIC-Maratona.cls
%%
%% Copyright (C) 2014 by Guilherme N. Ramos (gnramos@unb.br)
%%
%%
%% Exemplo de uso:
%%
%%    \documentclass{CIC-Maratona}%
%%
%%    \titulo{Prova Exemplo}%
%%
%%    \begin{document}%
%%        \problema[1_gettingstarted]{fizzbuzz}%
%%        \problema[3_strings]{led}%
%%    \end{document}%

\NeedsTeXFormat{LaTeX2e}[1999/12/01]%

\ProvidesClass{CIC-Maratona}[2014/12/17 Classe para gerar simulados para Maratona de Programação do CIC.]%

\ProcessOptions\relax%
\LoadClass{UnBExam}%
\extraheadheight[0cm]{0mm}%

\RequirePackage{verbatim}% Inclusão de exemplos de IO para problemas.

\RequirePackage{totcount}% Contagem de problemas.
\newcounter{problem}%
\regtotcounter{problem}%

\newcommand{\titulo}[1]{\def\titulo@CICMaratona{#1}}% Título do documento.
\titulo{Prova}%

% Primeira página
\newcommand{\titlePage@CICMaratona}{%
    \thispagestyle{empty}%
    \begin{center}%
    \includegraphics[width=.6\textwidth]{CIC_header}%
    \end{center}%

    \vfill%

    \begin{center}\Huge\bf\titulo@CICMaratona\end{center}%

    \vfill%

    \begin{center}\bf{Informações Gerais}\end{center}%

    {\small%
    Este caderno contém \total{problem} problemas; as páginas estão numeradas de 1 a \numpages, não contando esta página de rosto. Verifique se o caderno está completo.%

    \paragraph{A) Sobre os nomes dos programas}\ \\%%
    1) Sua solução deve ser chamada \emph{codigo-de-problema}.\texttt{c}, \emph{codigo-de-problema}.\texttt{cpp} ou \emph{codigo-de-problema}.\texttt{java}, onde \emph{codigo-de-problema} é a letra maiúscula que identifica o problema. Lembre que em Java o nome da classe principal deve ser igual ao nome do arquivo.%

    \paragraph{B) Sobre a entrada}\ \\%
    1) A entrada de seu programa deve ser lida da entrada padrão.\\%
    2) Cada linha, incluindo a última, contém exatamente um caractere final-de-linha.\\%
    3) O final da entrada coincide com o final do arquivo.%

    \paragraph{C) Sobre a saída}\ \\%
    1) A saída de seu programa deve ser escrita na saída padrão.\\%
    2) Cada linha, incluindo a última, deve conter exatamente um caractere final-de-linha.%
    }%
}%

% Verificação de arquivos.
\newcommand{\@warnIfNotExists}[1]{%
    \IfFileExists{#1}%
        {}%
        {%
            \ClassWarning{CIC-Maratona}%
            {Arquivo '#1' nao encontrado.}%
            {O arquivo '#1' deveria estar junto ao demais arquivos do problema.}%
        }%
}%

% Verificação de arquivos.
\newcommand{\@stopIfNotExists}[1]{%
    \IfFileExists{#1}%
        {}%
        {%
            \ClassError{CIC-Maratona}%
            {Arquivo '#1' nao encontrado.}%
            {O arquivo '#1' deveria estar junto ao demais arquivos do problema.}%
        }%
}%

% Margens da tabela de exemplos.
\newlength{\inputWidth@CICMaratona}%
\newlength{\outputWidth@CICMaratona}%

% Largura da coluna de exemplos de entrada (na tabela de exemplos de IO de um
% problema). A largura da coluna com exemplos de saída é ajustada
% automaticamente em função da de entrada.
\newcommand{\setInputWidth}[1]{%
    \setlength{\inputWidth@CICMaratona}{#1}%
    \setlength{\outputWidth@CICMaratona}{\textwidth}%
    \addtolength{\outputWidth@CICMaratona}{-#1}%
}%
\setInputWidth{.5\textwidth}% Valor padrão.

% Define o título do problema
\newcommand{\NomeProblema}[1]{
    \begin{center}%
        \LARGE{\bf{#1}}%
    \end{center}
}%

% Define @atEndProblem, que é incluído ao final de cada problema. O conteúdo de
% @atEndProblem é liberado ao final de cada problema, de modo que cada "sufixo"
% só seja considerado uma vez.
\newcommand{\aoFinalDoProblema}[1]{\def\@atEndProblem{#1}}%
\aoFinalDoProblema{}%

% Insere um problema.
%   #1 - diretório dos arquivos
%   #2 - nome base dos arquivos
\newcommand{\problema}[2][]{%
    \ifx&#1&\@empty\def\@baseFileDir{\detokenize{#2}}%
    \else\def\@baseFileDir{\detokenize{#1/#2}}%
    \fi%

    \def\@fileName{\detokenize{#2}}%

    \graphicspath{{\@baseFileDir/}}%
    \def\@baseFile{\@baseFileDir/\@fileName}%
    \def\@inputExample{\@baseFile.in}%
    \def\@outputExample{\@baseFile.out}%

    \@stopIfNotExists{\@baseFile.tex}%
    \@stopIfNotExists{\@inputExample}%
    \@stopIfNotExists{\@outputExample}%

    \@warnIfNotExists{\@baseFileDir/input/\@fileName}%
    \@warnIfNotExists{\@baseFileDir/output/\@fileName}%

    \newpage\stepcounter{problem}%
    \begin{center}%
        \Large{\bf \sc Problema\ \Alph{problem}}%
    \end{center}%

    {% garantir o escopo local de inputWidth, caso seja alterada
        \input{\@baseFile}%

        \subsection*{Exemplo}%
        \vspace*{-.5\baselineskip}%
        \begin{tabular}[t]{|p{.95\inputWidth@CICMaratona}|p{.95\outputWidth@CICMaratona}|}%
            \hline%
            \textbf{Entrada} & \textbf{Saída} \\\hline%
            \vspace{-1.2\baselineskip}\verbatiminput{\@inputExample}%
            \vspace*{-2\baselineskip} &%
            \vspace{-1.2\baselineskip}\verbatiminput{\@outputExample}%
            \vspace*{-2\baselineskip} \\\hline%
        \end{tabular}%

        \@atEndProblem\aoFinalDoProblema{}%
    }%
}%

\AtBeginDocument{%
    \titlePage@CICMaratona%
    \pagestyle{plain}%
    \setcounter{page}{0}%
}%

\endinput
%%
%% End of file `CIC-Maratona.cls'.
