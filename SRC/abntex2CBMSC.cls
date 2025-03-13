%% ==================================================================
%% Classe abntex2CBMSC - Adaptada a partir da abntex2.cls
%% ==================================================================
%%
%% Este arquivo é uma modificação da classe abntex2.cls, originalmente
%% desenvolvida pelo projeto abnTeX2 (https://github.com/abntex/abntex2).
%% 
%% Adaptado por: Jonatas Senna <jonatas.senna.bmsc@gmail.com>
%% Instituição: CBMSC
%% Data: 06/02/2025
%%
%% Licença: LaTeX Project Public License (LPPL) v1.3c ou posterior
%% Consulte: https://www.latex-project.org/lppl.txt
%%
%% Esta classe segue as diretrizes da LPPL. As modificações foram feitas
%% para atender às necessidades do CBMSC, incluindo [breve descrição das mudanças].
%%
%% NOTA: Esta classe não é oficialmente mantida pelo projeto abnTeX2.
%%
%% ==================================================================
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Declaracao da classe abntex2 como uma extensao da classe memoir
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{abntex2CBMSC}[2025/01/28]
\RequirePackage{ifthen}
%
% Captura as options article e twocolumn
%
\providecommand{\ABNTEXisarticle}{false}
\DeclareOption{article}{
	\renewcommand{\ABNTEXisarticle}{true}
	\PassOptionsToClass{article}{memoir}%}
}
\providecommand{\ABNTEXistwocolumn}{false}
\DeclareOption{twocolumn}{
	\renewcommand{\ABNTEXistwocolumn}{true}
	\PassOptionsToClass{twocolumn}{memoir}%}
}
%	
% Opcoes chapter=TITLE, section=TITLE, subsection=TITLE e
% subsubsection=TITLE: titulos em letras maiusculas
% 
\newboolean{ABNTEXupperchapter}     %true=titles of chapter/appendix in uppercase
\newboolean{ABNTEXuppersection}     %true=titles of sections in uppercase
\newboolean{ABNTEXuppersubsection}  %true=titles of subsections in uppercase
\newboolean{ABNTEXuppersubsubsection}  %true=titles of subsubsections in uppercase
\newboolean{ABNTEXuppersubsubsubsection}  %true=titles of subsubsubsections in uppercase
\setboolean{ABNTEXupperchapter}{false}
\setboolean{ABNTEXuppersection}{false}
\setboolean{ABNTEXuppersubsection}{false}
\setboolean{ABNTEXuppersubsubsection}{false}
\setboolean{ABNTEXuppersubsubsubsection}{false}
\DeclareOption{chapter=TITLE}{\setboolean{ABNTEXupperchapter}{true}}
\DeclareOption{section=TITLE}{\setboolean{ABNTEXuppersection}{true}}
\DeclareOption{subsection=TITLE}{\setboolean{ABNTEXuppersubsection}{true}}
\DeclareOption{subsubsection=TITLE}{\setboolean{ABNTEXuppersubsubsection}{true}}
\DeclareOption{subsubsubsection=TITLE}{\setboolean{ABNTEXuppersubsubsubsection}{true}}
%
% Opções de diagramação de sumários
% sumario=tradicional    : Sumário tradicional do LaTeX/Memoir
% sumario=abnt-6027-2012 : Sumário conforme recomendação da ABNT NBR 6027:2012
\newboolean{ABNTEXsumario-tradicional}     %true=titles of chapter/appendix in uppercase
\newboolean{ABNTEXsumario-abnt-6027-2012} 
\setboolean{ABNTEXsumario-tradicional}{false}
\setboolean{ABNTEXsumario-abnt-6027-2012}{true}
\DeclareOption{sumario=tradicional}{%
  \setboolean{ABNTEXsumario-tradicional}{true}%
  \setboolean{ABNTEXsumario-abnt-6027-2012}{false}}
\DeclareOption{sumario=abnt-6027-2012}{%
  \setboolean{ABNTEXsumario-abnt-6027-2012}{true}
  \setboolean{ABNTEXsumario-tradicional}{false}}

  
%
% Repassa demais opcoes a memoir	
%
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}%
}
\ProcessOptions\relax
\LoadClass{memoir}

% sumario=abnt-6027-2012 : Sumário conforme recomendação da ABNT NBR 6027:2012, que
%    soh pode ser usado com memoir v3.6k ou superior
%    \settocpreprocessor \changes{v3.6k}{2012/09/18}{Added}
\ifdefined\settocpreprocessor
\else
  \setboolean{ABNTEXsumario-tradicional}{true}
  \setboolean{ABNTEXsumario-abnt-6027-2012}{false}
\fi

% ---
% Comandos para controlar as opcoes de titulos com letras maiusculas 
% ---

% pacote que prove \MakeTextUppercase
\RequirePackage{textcase}

\newcommand{\ABNTEXchapterupperifneeded}[1]{\ifthenelse{\boolean{ABNTEXupperchapter}}{\MakeTextUppercase{#1}}{#1}}
\newcommand{\ABNTEXsectionupperifneeded}{\ifthenelse{\boolean{ABNTEXuppersection}}{\MakeTextUppercase}{}}
\newcommand{\ABNTEXsubsectionupperifneeded}{\ifthenelse{\boolean{ABNTEXuppersubsection}}{\MakeTextUppercase}{}}
\newcommand{\ABNTEXsubsubsectionupperifneeded}{\ifthenelse{\boolean{ABNTEXuppersubsubsection}}{\MakeTextUppercase}{}}
\newcommand{\ABNTEXsubsubsubsectionupperifneeded}{\ifthenelse{\boolean{ABNTEXuppersubsubsubsection}}{\MakeTextUppercase}{}}
% ---

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Pacotes adicionais e customizacoes gerais do memoir
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ---
% Do pacote de if/them/else
\newcommand{\abntex@ifnotempty}[2]{\ifthenelse{\not\equal{#1}{}}{#2}{}}
% ---

% ---
% Controla as referencias internas do PDF
\RequirePackage{hyperref}
\pdfstringdefDisableCommands{\def\\{, }\def\and{; }}
% ---

% ---
% Controla os bookmarks do PDF
\RequirePackage{bookmark}   			
% ---

% ---
% Hifenizacao e caracteres especiais portugues-brasil por padrao
% ---
\RequirePackage[brazil]{babel}
%
% Nomes constantes do abnTeX2 em portugues (definicoes padroes)
\newcommand{\folhaderostoname}{Folha de rosto}
\newcommand{\epigraphname}{Ep\'igrafe}
\newcommand{\dedicatorianame}{Dedicat\'oria}
\newcommand{\errataname}{Errata}
\newcommand{\agradecimentosname}{Agradecimentos}
\newcommand{\anexoname}{ANEXO}
\newcommand{\anexosname}{Anexos}
\newcommand{\apendicename}{AP\^ENDICE}
\newcommand{\apendicesname}{Ap\^endices}
\newcommand{\orientadorname}{Orientador(a):}
\newcommand{\coorientadorname}{Coorientador(a):}
\newcommand{\folhadeaprovacaoname}{Folha de aprova\c{c}\~ao}
\newcommand{\resumoname}{\textbf{RESUMO}} 
\newcommand{\listadesiglasname}{Lista de abreviaturas e siglas}
\newcommand{\listadesimbolosname}{Lista de s\'imbolos}
\newcommand{\fontename}{Fonte}
\newcommand{\notaname}{Nota}
%
\addto\captionsbrazil{% portugues-brasil
  %% ajusta nomes padroes do babel
  \renewcommand{\bibname}{Refer\^encias}
  \renewcommand{\indexname}{\'Indice}
  \renewcommand{\listfigurename}{\bfseries\MakeUppercase{Lista de ilustra\c{c}\~{o}es}}
  \renewcommand{\listtablename}{\bfseries\MakeUppercase{Lista de tabelas}}
  %% ajusta nomes usados com a macro \autoref
  \renewcommand{\pageautorefname}{p\'agina}
  \renewcommand{\sectionautorefname}{se{\c c}\~ao}
  \renewcommand{\subsectionautorefname}{subse{\c c}\~ao}
  \renewcommand{\subsubsectionautorefname}{subse{\c c}\~ao}
  \renewcommand{\paragraphautorefname}{subse{\c c}\~ao}
}
\addto\captionsenglish{% ingles
  %% adjusts names from abnTeX2
  \renewcommand{\folhaderostoname}{Title page}
  \renewcommand{\epigraphname}{Epigraph}
  \renewcommand{\dedicatorianame}{Dedication}
  \renewcommand{\errataname}{Errata sheet}
  \renewcommand{\agradecimentosname}{Acknowledgements}
  \renewcommand{\anexoname}{ANNEX}
  \renewcommand{\anexosname}{Annex}
  \renewcommand{\apendicename}{APPENDIX}
  \renewcommand{\apendicesname}{Appendix}
  \renewcommand{\orientadorname}{Supervisor:}
  \renewcommand{\coorientadorname}{Co-supervisor:}
  \renewcommand{\folhadeaprovacaoname}{Approval}
  \renewcommand{\resumoname}{\textbf{ABSTRACT}} 
  \renewcommand{\listadesiglasname}{List of abbreviations and acronyms}
  \renewcommand{\listadesimbolosname}{List of symbols}
  \renewcommand{\fontename}{Source}
  \renewcommand{\notaname}{Note}
   %% adjusts names used by \autoref
  \renewcommand{\pageautorefname}{page}
  \renewcommand{\sectionautorefname}{section}
  \renewcommand{\subsectionautorefname}{subsection}
  \renewcommand{\subsubsectionautorefname}{subsubsection}
  \renewcommand{\paragraphautorefname}{subsubsubsection}
}
% ---

% ---
% Customiza listas
\RequirePackage{enumitem}
% ---

% ---
% Pacote que permite realizar operacoes matematicas no codigo TeX
\RequirePackage{calc}
% ---

% ---
% Margens - NBR 14724/2011 - 5.1 Formato
% ---
\setlrmarginsandblock{3cm}{2cm}{*}
\setulmarginsandblock{3cm}{2cm}{*}
\checkandfixthelayout
% ---

% ---
% Espacamento entre linhas - NBR 14724/2011 - 5.2 Espacamento
% ---
\OnehalfSpacing
% ---

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Comandos publicos
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ---
% ``Tamanho menor e uniforme'' ditada pela NBR 14724/2011 - 5.1
% ---
\newcommand{\ABNTEXfontereduzida}{\footnotesize}
% ---


% ---
% Fontes padroes de part, chapter, section, subsection e subsubsection
\newcommand{\ABNTEXchapterfont}{\rmfamily}
\newcommand{\ABNTEXchapterfontsize}{\normalsize}

\newcommand{\ABNTEXpartfont}{\ABNTEXchapterfont}
\newcommand{\ABNTEXpartfontsize}{\normalsize}

\newcommand{\ABNTEXsectionfont}{\ABNTEXchapterfont}
\newcommand{\ABNTEXsectionfontsize}{\normalsize}

\newcommand{\ABNTEXsubsectionfont}{\bfseries}
\newcommand{\ABNTEXsubsectionfontsize}{\normalsize}

\newcommand{\ABNTEXsubsubsectionfont}{\ABNTEXsubsectionfont}
\newcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}

\newcommand{\ABNTEXsubsubsubsectionfont}{\ABNTEXsubsectionfont}
\newcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize}
% ---

\providecommand{\cursodefinido}{}
\newcommand{\curso}[1]{\renewcommand{\cursodefinido}{#1}}
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Comandos e variaveis privados
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ---
% Comando para registro do bookmark interno
% ---
\newcounter{abntex@bookmarkcounter}
\setcounter{abntex@bookmarkcounter}{0}
\newcommand{\PRIVATEbookmarkthis}[1]{%
  \addtocounter{abntex@bookmarkcounter}{1}%
  \phantomsection\pdfbookmark[0]{#1}{chapterb\arabic{abntex@bookmarkcounter}}
}
% ---

% ---
% Comando que cria capitulos nao numerados ja com bookmark anotado
% ---
\newcommand{\pretextualchapter}[1]{%
  \addtocounter{abntex@bookmarkcounter}{1}%
  \PRIVATEbookmarkthis{#1}%
  \chapter*[#1]{#1}%
  }
\provideboolean{abntex@apendiceousecao}
\setboolean{abntex@apendiceousecao}{false}
% ---

% ---
% cleardoublepage se este documento nao for article
% ---
\newcommand{\PRIVATEclearpageifneeded}{%
  \ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
    %
  }{ % else
    \cleardoublepage%
  }
}  

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Configuracoes de layout
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ---
% Notas de rodape - footnotes - NBR 14724/2011 - 5.2.1 
\setlength{\footmarkwidth}{1.2em} % largura do footnotemark
\setlength{\footmarksep}{0em}
\footmarkstyle{\footnotesize{\textsuperscript{#1}}\hfill}

% tamanho da fonte do footnote
\renewcommand{\foottextfont}{\ABNTEXfontereduzida}
% ---

% ---
% Numeracao continua das figuras
\ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
  \counterwithout{section}{chapter}
  \counterwithout{figure}{section}
  \counterwithout{table}{section}
}{%else
  \counterwithout{figure}{chapter}
  \counterwithout{table}{chapter}
}
% ---

% ---
% Estilos de caption
% ---
\hangcaption
\newcommand{\ABNTEXcaptiondelim}{~\textendash~}
\newcommand{\ABNTEXcaptionfontedelim}{:~}
%\captionnamefont{\ABNTEXfontereduzida}
%\captiontitlefont{\ABNTEXfontereduzida}

% Para uso com pacotes subfig e caption dentro do memoir se estes forem carregados ou não.
% É necessário para que os comandos \IBGEtab e \fonte funcionem 
% independente do carregamento de pacotes externos ao memoir que tratam captions.
\newcommand{\IBGEtabfontsize}{\ABNTEXfontereduzida}
\AtBeginDocument{%
  % comandos auxiliares para manipular os captions dentro do comando \IBGEtab.
  \newcommand{\configurecaptions}{\captionstyle[\raggedright]{}}
  \newcommand{\configureseparator}{\captiondelim{\ABNTEXcaptiondelim}}
  % Define o comando \IBGEtab{}{}{} com caption e legenda da largura do conteúdo tabular, tabular*, etc
  % Parece funcionar com qualque pacote
  \newsavebox{\myptabbox}
  \newlength{\myptabboxwidth}
  \newcommand{\IBGEtab}[3]{%
    \savebox{\myptabbox}{{\IBGEtabfontsize #2}}%
    \settowidth{\myptabboxwidth}{\usebox{\myptabbox}}%
    \centering%
    \parbox{\myptabboxwidth}{%
    \configurecaptions
    #1%
    \par%
    {\IBGEtabfontsize%
    #2%
    }%
    \par%
    #3}%
  }
  \let\ibgetab\IBGEtab  
}

% Define o comando \fonte que respeita as configurações de caption do memoir ou do caption
\newcommand{\fonte}[2][\fontename]{%
  \M@gettitle{#2}%
  \memlegendinfo{#2}%
  \par
  \begingroup
     \@parboxrestore
     \if@minipage
       \@setminipage
     \fi
     \ABNTEXfontereduzida
     %\configureseparator
     \captiondelim{\ABNTEXcaptionfontedelim}
     \@makecaption{\ABNTEXfontereduzida #1}{\ignorespaces\ABNTEXfontereduzida #2}\par
  \endgroup}

% Define o comando \notas que respeita as configurações de caption do memoir ou do caption
\newcommand{\nota}[2][\notaname]{\fonte[#1]{#2}}


% Altera os comandos \configurecaptions e \configureseparator para trabalhar com 
% o pacote caption e amigos.
\AtEndPackage{caption}{
  \AtBeginDocument{%
    \DeclareCaptionLabelSeparator{barr}{\ABNTEXcaptiondelim}
    \DeclareCaptionFont{ABNTEXfontereduzida}{\ABNTEXfontereduzida}
      \captionsetup{format=hang,
                    labelseparator=barr,
                    %labelfont=ABNTEXfontereduzida,
                    %font=ABNTEXfontereduzida
                    }
      \renewcommand{\configurecaptions}{%
                  \captionsetup{justification=justified,%
                                singlelinecheck=false}}
      \renewcommand{\configureseparator}{\captionsetup{labelsep=colon}}
  }
}

\AtBeginDocument{
 \captiondelim{\ABNTEXcaptiondelim}
}
% ---

% -----
% Configuracoes do TOC
% -----
% nivel de profundidade (implementa o quinto nivel - subsubsubsection)
\setsecnumdepth{paragraph}
\settocdepth{paragraph}
\setcounter{tocdepth}{5}
\setcounter{secnumdepth}{5}
\maxsecnumdepth{paragraph}

% redefine os comandos *paragraph* para *subsubsubsection* ****
\newcommand{\subsubsubsection}{\paragraph}
\newcommand{\cftbeforesubsubsubsectionskip}{\cftbeforeparagraphskip}
\newcommand{\cftsubsubsubsectionfont}{\cftparagraphfont}
\newcommand{\setsubsubsubsecheadstyle}{\setparaheadstyle}

\setafterparaskip{1.0\onelineskip plus 0.5\onelineskip minus 0.2\onelineskip}
\setparaheadstyle{\normalfont\sffamily\raggedright}%

% lista de ilustracoes
\renewcommand{\cftfigurename}{\figurename\space} 
\renewcommand*{\cftfigureaftersnum}{\hfill\textendash\hfill}
 
% lista de tabelas  
\renewcommand{\cfttablename}{\tablename\space}
\renewcommand*{\cfttableaftersnum}{\hfill\textendash\hfill}	
 
% fonte das partes e do capitulo do TOC
\renewcommand{\tocheadstart}{\ABNTEXchapterfont}

% leaders para os capitulos
\renewcommand*{\cftchapterdotsep}{\cftdotsep}

% suprime espaço entre os itens de listings de diferentes capítulos 
\setlength{\cftbeforechapterskip}{0pt plus 0pt}
\renewcommand*{\insertchapterspace}{}

% macros para configurar o Sumário conforme 6027-2012 ou tradicional cft
\cftinsertcode{A}{}

\newlength{\cftlastnumwidth}
\setlength{\cftlastnumwidth}{\cftsubsubsectionnumwidth}
\addtolength{\cftlastnumwidth}{1em}

\newcommand{\tocprintchapter}{}
\newcommand{\tocinnonumchapter}{}
\newcommand{\tocprintchapternonum}{}
\newcommand{\tocpartapendices}{}
\newcommand{\tocpartanexos}{}

% insere o hifen no anexo/apendice do toc
\cftinsertcode{A}{\renewcommand{\cftchapteraftersnum}{\hfill\textendash\hfill}}

% No caso de Sumario (TOC) tradicional
\ifthenelse{\boolean{ABNTEXsumario-tradicional}}{}{} % essa linha não faz nada,
                                                     % mas se houver necessidade de alterar o comportamento
                                                     % do sumário tradicional altere aqui.

% No caso de Sumario (TOC) especifico da ABNT-6027-2012

\makeatletter
\ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{
  \settocpreprocessor{chapter}{%
  \let\tempf@rtoc\f@rtoc%
  \def\f@rtoc{%
  \texorpdfstring{\MakeTextUppercase{\tempf@rtoc}}{\tempf@rtoc}}%
  }
  \settocpreprocessor{part}{%
  \let\tempf@rtoc\f@rtoc%
  \def\f@rtoc{%
  \texorpdfstring{\MakeTextUppercase{\tempf@rtoc}}{\tempf@rtoc}}%
  }
}{}
\makeatother
%


% \newcommand{\listofacronyms}{%
% 	\@inputTeXFile{siglas}%
% 	\printglossary[type=\acronymtype]%
% }%

% \newcommand{\sigla}[2]{\newacronym{#1}{#1}{#2}}%

% \newlength{\cftpartnumwidth}
% \newlength{\cftchapternumwidth}
\newlength{\cftsecnumwidth}
\newlength{\cftsubsecnumwidth}
\newlength{\cftsubsubsecnumwidth}

\usepackage{calc} % Para cálculos de comprimento

% Ajusta as larguras dinamicamente
% \setlength{\cftpartnumwidth}{\widthof{99} + 1em}
\setlength{\cftchapternumwidth}{\widthof{99}}
\setlength{\cftsecnumwidth}{\widthof{9.9} + 0.5em}
\setlength{\cftsubsecnumwidth}{\widthof{9.9.9} + 0.5em}
\setlength{\cftsubsubsecnumwidth}{\widthof{9.9.9.9} + 0.5em}



\ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{%
  
  % Configuração de indentação para cada nível do sumário
  \cftsetindents{part}{0em}{\cftpartnumwidth}           % Partes
  \cftsetindents{chapter}{0em}{0pt}        % Capítulos
  \cftsetindents{section}{1em}{\cftsecnumwidth}        % Seções
  \cftsetindents{subsection}{2em}{\cftsubsecnumwidth}     % Subseções
  \cftsetindents{subsubsection}{3em}{\cftsubsubsecnumwidth}  % Subsubseções
  \cftsetindents{paragraph}{4em}{2em}     % Parágrafos
  \cftsetindents{subparagraph}{5em}{2em}  % Subparágrafos

  % Ajusta entradas específicas no sumário
  \renewcommand{\tocprintchapter}{%
    \addtocontents{toc}{\cftsetindents{chapter}{0em}{3em}}}

  \renewcommand{\tocinnonumchapter}{%
    \addtocontents{toc}{\cftsetindents{chapter}{3em}{3em}}%
    \cftinserthook{toc}{A}}

  \renewcommand{\tocprintchapternonum}{%
    \addtocontents{toc}{\cftsetindents{chapter}{0em}{3em}}}

  \renewcommand{\tocpartapendices}{%
    \addtocontents{toc}{\cftsetindents{part}{0em}{3em}}
    \cftinserthook{toc}{A}}

  \renewcommand{\tocpartanexos}{%
    \addtocontents{toc}{\cftsetindents{part}{0em}{3em}}
    \cftinserthook{toc}{A}}

  % Ajusta espaçamento entre capítulos, seções, etc.
  \setlength{\cftbeforechapterskip}{1em}

  % Configuração de fontes das entradas no sumário
  \renewcommand{\cftpartfont}{\large}
  \renewcommand{\cftchapterfont}{\normalsize}
  \renewcommand{\cftchapterpagefont}{\normalsize\cftchapterfont}

  \renewcommand{\cftsectionfont}{\normalsize}
  \renewcommand{\cftsectionpagefont}{\cftsectionfont}

  \renewcommand{\cftsubsectionfont}{\normalsize}
  \renewcommand{\cftsubsectionpagefont}{\cftsubsectionfont}

  \renewcommand{\cftsubsubsectionfont}{\normalsize}
  \renewcommand{\cftsubsubsectionpagefont}{\cftsubsubsectionfont}

  \renewcommand{\cftparagraphfont}{\footnotesize}
  \renewcommand{\cftparagraphpagefont}{\cftparagraphfont}

  % Ajusta entrada Referências no sumário
  \renewcommand{\bibsection}{%
    \chapter*{\bibname}
    \bibmark
    \ifnobibintoc\else
    \phantomsection
    \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{\bibname}}{\bibname}}
    \fi
    \prebibhook
  }

}{}


\makeatletter
\renewcommand{\l@chapter}{%
    \@dottedtocline{0}{0em}{1em}} % Ajuste os valores para recuo e largura
\makeatother


% Comando que simula a finalizacao de uma parte no bookmark e
% adiciona espaco de \part no sumario
\newcommand{\phantompart}{%
  \bookmarksetup{startatroot}%
  \phantomsection%
  \ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{%
    \addtocontents{toc}{\vspace{\cftbeforechapterskip}}}{%
    \addtocontents{toc}{\vspace{\cftbeforepartskip}}}%
}
% -----

% ---
% Configuracao dos titulos dos capitulos
% Novo estido do memoir 
% ABNT NBR 14724-2011 - 5.2.2-5.2.4; ABNT NBR 6024-2003 - 3.1-3.8
\provideboolean{abntex@innonumchapter}
\setboolean{abntex@innonumchapter}{true}
\makechapterstyle{abnt}{%
  \renewcommand{\chapterheadstart}{} 

  \ifx \chapternamenumlength \undefined
    \newlength{\chapternamenumlength}
  \fi

  % tamanhos de fontes de chapter e part	
   \ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
     \setlength\beforechapskip{\baselineskip}
     \renewcommand{\chaptitlefont}{\ABNTEXsectionfont\ABNTEXsectionfontsize}
   }{%else
     \setlength{\beforechapskip}{0pt}
     \renewcommand{\chaptitlefont}{\ABNTEXchapterfont\ABNTEXchapterfontsize}
   }
  
  \renewcommand{\chapnumfont}{\chaptitlefont}
  \renewcommand{\parttitlefont}{\ABNTEXpartfont\ABNTEXpartfontsize}
  \renewcommand{\partnumfont}{\ABNTEXpartfont\ABNTEXpartfontsize}
  \renewcommand{\partnamefont}{\ABNTEXpartfont\ABNTEXpartfontsize}
  
  % tamanhos de fontes de section, subsection, subsubsection e subsubsubsection
  \setsecheadstyle{\ABNTEXsectionfont\ABNTEXsectionfontsize\ABNTEXsectionupperifneeded}
  \setsubsecheadstyle{\ABNTEXsubsectionfont\ABNTEXsubsectionfontsize\ABNTEXsubsectionupperifneeded}
  \setsubsubsecheadstyle{\ABNTEXsubsubsectionfont\ABNTEXsubsubsectionfontsize\ABNTEXsubsubsectionupperifneeded}
  \setsubsubsubsecheadstyle{\ABNTEXsubsubsubsectionfont\ABNTEXsubsubsubsectionfontsize\ABNTEXsubsubsubsectionupperifneeded}
  
  % impressao do numero do capitulo
  \renewcommand{\chapternamenum}{}
  
  % impressao do nome do capitulo
  \renewcommand{\printchaptername}{%
   \chaptitlefont
   \ifthenelse{\boolean{abntex@apendiceousecao}}{\appendixname}{}%
  }
    
  % impressao do titulo do capitulo
  \def\printchaptertitle##1{%
    \chaptitlefont%
    \ifthenelse{\boolean{abntex@innonumchapter}}{\centering\ABNTEXchapterupperifneeded{##1}}{%
    \ifthenelse{\boolean{abntex@apendiceousecao}}{%
        \centering%
        \settowidth{\chapternamenumlength}{\printchaptername\printchapternum\afterchapternum}%
        \ABNTEXchapterupperifneeded{##1}%
      }{%
        \settowidth{\chapternamenumlength}{\printchaptername\printchapternum\afterchapternum}%
        \parbox[t]{\columnwidth-\chapternamenumlength}{\ABNTEXchapterupperifneeded{##1}}}%
     }    
  }
       
  % impressao do numero do capitulo     	
  \renewcommand{\printchapternum}{%
     \tocprintchapter
     \setboolean{abntex@innonumchapter}{false}
     \chapnumfont%
     \space\thechapter\space%
     \ifthenelse{\boolean{abntex@apendiceousecao}}{%
       \tocinnonumchapter
       \ABNTEXcaptiondelim%
     }{} % else
  }
  \renewcommand{\afterchapternum}{}
  
  % impressao do capitulo nao numerado
  \renewcommand\printchapternonum{%
     \tocprintchapternonum
     \setboolean{abntex@innonumchapter}{true}%
    }
}
\chapterstyle{abnt}
% ---

% -----
% Declaracoes de cabecalhos 
% -----
% Cabecalho padrao
\makepagestyle{abntheadings}
\makeevenhead{abntheadings}{\ABNTEXfontereduzida\thepage}{}{\ABNTEXfontereduzida\textit\leftmark}
\makeoddhead{abntheadings}{\ABNTEXfontereduzida\textit\rightmark}{}{\ABNTEXfontereduzida\thepage}
\makeheadrule{abntheadings}{\textwidth}{\normalrulethickness}

% Cabecalho do inicio do capitulo
\makepagestyle{abntchapfirst}
\makeoddhead{abntchapfirst}{}{}{\ABNTEXfontereduzida\thepage}
% ---

% ---
% Configura layout para elementos pre-textuais
\newcommand{\pretextual}{%
  \aliaspagestyle{chapter}{empty}% customizing chapter pagestyle
  \pagestyle{empty}
  \aliaspagestyle{cleared}{empty}
  \aliaspagestyle{part}{empty}
}
\renewcommand{\frontmatter}{\pretextual} 

% por default, inicializa o documento com elementos \pretextuais
\AtBeginDocument{\pretextual}
% ---

% ---
% Configura layout para elementos textuais
\newcommand{\textual}{%
  \ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
    \pagestyle{plain}%
  }{%else  
    \pagestyle{abntheadings}%
    \aliaspagestyle{chapter}{abntchapfirst}% customizing chapter pagestyle
  }  
  \nouppercaseheads%
  \bookmarksetup{startatroot}% 
}
\renewcommand{\mainmatter}{\textual}
% ---

% ---
% Configura layout para elementos pos-textuais
\newcommand{\postextual}{\phantompart}
\renewcommand{\backmatter}{\postextual}
% -----

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Comandos de dados para CAPA e FOLHA DE ROSTO 
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% Comandos de dados - titulo do documento
\newcommand{\titulo}[1]{\title{#1}}
\newcommand{\imprimirtitulo}{\thetitle}

% Comandos de dados - titulo do documento
\newcommand{\tituloestrangeiro}[1]{\providecommand{\theforeigntitle}{#1}}
\newcommand{\imprimirtituloestrangeiro}{\theforeigntitle}


% Comandos de dados - autor (use \and para multiplos autores)
\newcommand{\autor}[1]{\author{#1}}
\newcommand{\imprimirautor}{\theauthor}

% Comandos de dados - data
\let\olddate\date
\renewcommand{\date}[1]{\AtBeginDocument{\olddate{#1}}}
\newcommand{\ano}[1]{\date{#1}}
\providecommand{\imprimirMes}{}
\newcommand{\mes}[1]{\renewcommand{\imprimirMes}{#1}}
\providecommand{\imprimirDia}{}
\newcommand{\dia}[1]{\renewcommand{\imprimirDia}{#1}}
\newcommand{\imprimirdata}{\thedate}

% Comandos de dados - instituicao
\providecommand{\imprimirinstituicao}{}
\newcommand{\instituicao}[1]{\renewcommand{\imprimirinstituicao}{#1}}

% Comandos de dados - local
\providecommand{\imprimirlocal}{}
\newcommand{\local}[1]{\renewcommand{\imprimirlocal}{#1}}

% Comandos de dados - preambulo
\providecommand{\imprimirpreambulo}{Projeto de Pesquisa apresentado para
elaboração do Trabalho de Conclusão de
Curso em cumprimento parcial às exigências
do \cursoCompleto, do Corpo
de Bombeiros Militar de Santa Catarina.}


% Comandos de dados - orientador
\providecommand{\imprimirorientadorRotulo}{}
\providecommand{\imprimirorientador}{}
\providecommand{\imprimirorientadorInstituicao}{}
\newcommand{\orientador}[3][\orientadorname]%
  {\renewcommand{\imprimirorientadorRotulo}{#1}%
   \renewcommand{\imprimirorientador}{#2}
   \renewcommand{\imprimirorientadorInstituicao}{#3}
   }

% Comandos de dados - coorientador
\providecommand{\imprimircoorientadorRotulo}{}
\providecommand{\imprimircoorientador}{}
\providecommand{\imprimircoorientadorInstituicao}{}
\newcommand{\coorientador}[3][\coorientadorname]%
  {\renewcommand{\imprimircoorientadorRotulo}{#1}%
   \renewcommand{\imprimircoorientador}{#2}
   \renewcommand{\imprimircoorientadorInstituicao}{#3}
   }

% Comandos de dados - tipo de trabalho
\providecommand{\imprimirtipotrabalho}{}
\newcommand{\tipotrabalho}[1]{\renewcommand{\imprimirtipotrabalho}{#1}}

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Comandos e ambientes de editoracao PRE-TEXTUAIS
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ---
% Ambiente para definicao da Capa
\newenvironment{capa}{\begin{titlingpage}}{\end{titlingpage}}
% ---

% ---
% Titulos em lingua estrangeira para artigos: ABNT NBR 6022:2018
\ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
\renewcommand{\maketitlehookb}{\LARGE\center\textit{\theforeigntitle}}
}{}
% ---

% ---
% Ficha catalografica (Dados internacionais de
% catalogação-na-publicacao)
\newenvironment{fichacatalografica}{%
    \thispagestyle{empty}
    \begin{SingleSpacing}
      \ABNTEXfontereduzida
}{%   
    \end{SingleSpacing}%
}%
% ---

% ---
% Errata
\newenvironment{errata}[1][\errataname]{%
   \pretextualchapter{#1}
  }{\PRIVATEclearpageifneeded}
% ---

% ---
% Folha de aprovacao - NBR 14724/2011 - 4.2.1.3
\newenvironment{folhadeaprovacao}[1][\folhadeaprovacaoname]{%
   \clearpage%
   \PRIVATEbookmarkthis{#1}%
   \begin{Spacing}{1.0}
}{\end{Spacing}\PRIVATEclearpageifneeded}   
% ---

% ---
% Dedicatoria
\newenvironment{dedicatoria}[1][]{%
   \ifthenelse{\equal{#1}{}}{%
    \PRIVATEbookmarkthis{\dedicatorianame}
    }{\pretextualchapter{#1}}
  }{\PRIVATEclearpageifneeded}
% ---

% ---
% Agradecimentos
\newenvironment{agradecimentos}[1][\agradecimentosname]{%
   \pretextualchapter{Agradecimentos}
  }{\PRIVATEclearpageifneeded}
% ---

% ---
% Epigrafe
\newenvironment{epigrafe}[1][]{%
   \ifthenelse{\equal{#1}{}}{%
    \PRIVATEbookmarkthis{\epigraphname}
    }{\pretextualchapter{#1}}
  }{\PRIVATEclearpageifneeded}
% ---

% ---
% Resumo e abstracts em diferentes idiomas - NBR 14724/2011

% altera as margens padrões do memoir para abstract caso nao seja article
\ifthenelse{\equal{\ABNTEXisarticle}{true}}{%
    % em artigos, margens e fontes são as mesmas de memoir
  }{ % else
  	% Ajusta as margens para serem a mesma do documento
    \setlength\absleftindent{0cm}
    \setlength\absrightindent{0cm}
    % Garante que a fonte do texto do abstract será a mesma do documento, pois
    % na classe memoir está \small
    \renewcommand{\abstracttextfont}{\normalfont\normalsize}
  }
  
% A norma não diz nada sobre identação e separação entre parágrafos no abstract,
% porém o uso mostra que muitos abstracts são montados sem identação.
\AtBeginDocument{%
   \setlength{\absparindent}{0pt}
}

\newenvironment{resumo}[1][\resumoname]{%
   \PRIVATEbookmarkthis{#1}
   \renewcommand{\abstractnamefont}{\chaptitlefont}
   \renewcommand{\abstractname}{\ABNTEXchapterupperifneeded{#1}}
   \begin{abstract}
  }{\end{abstract}\PRIVATEclearpageifneeded}
  
\newenvironment{resumoumacoluna}[1][\resumoname]{%
   \PRIVATEbookmarkthis{#1}
   \renewcommand{\abstractnamefont}{\chaptitlefont}
   \renewcommand{\abstractname}{\ABNTEXchapterupperifneeded{#1}}
   \begin{onecolabstract}
}{\end{onecolabstract}\PRIVATEclearpageifneeded}
% ---

% ---
% Lista de abreviaturas e siglas
\newenvironment{siglas}{%
  \pretextualchapter{\listadesiglasname}
  \begin{symbols}
}{%
  \end{symbols}
  \cleardoublepage
}
% ---

% ---
% Lista de simbolos
\newenvironment{simbolos}{%
  \pretextualchapter{\listadesimbolosname}
  \begin{symbols}
}{%
  \end{symbols}
  \cleardoublepage
}
% ---



% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Comandos e ambientes de editoracao APENDICES e ANEXOS
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ---
% Definicoes compartilhadas entre Apendices e Anexos
% ---
\makeatletter
\newcommand\@switch[1]{ \@writefile{toc}{\renewcommand*{\cftappendixname}{#1 \space}} }
\newcommand{\switchchapname}[1]{ \protected@write \@auxout {}{\string\@switch{#1} }}
\makeatother

\newcommand{\PRIVATEapendiceconfig}[2]{%
 \setboolean{abntex@apendiceousecao}{true}%
 \renewcommand{\appendixname}{#1}
 \ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{
   \renewcommand{\appendixtocname}{\uppercase{#2}}
  }{%
  \renewcommand{\appendixtocname}{#2}} 
 \renewcommand{\appendixpagename}{#2}
 \switchchapname{#1}% Corrected from \switchapname -> \switchchapname
 \renewcommand*{\cftappendixname}{#1 \space}
}
% ---

% ---
% Apendices - comando 
\newcommand{\apendices}{%
 \PRIVATEapendiceconfig{\apendicename}{\apendicesname}
 \appendix
}
% Apendices - ambiente
\newenvironment{apendicesenv}{%
 \PRIVATEapendiceconfig{\apendicename}{\apendicesname}
 \begin{appendix}
}{
 \end{appendix}
 \setboolean{abntex@apendiceousecao}{false}
 \bookmarksetup{startatroot}
}
% ---

% ---
% Anexos - comando
\newcommand{\anexos}{%
 \cftinserthook{toc}{AAA}
 
 \PRIVATEapendiceconfig{\anexoname}{\anexosname}
 \appendix
 \renewcommand\theHchapter{anexochapback.\arabic{chapter}}
}
% Anexos - ambiente
\newenvironment{anexosenv}{%
 \cftinserthook{toc}{AAA}
 
 \PRIVATEapendiceconfig{\anexoname}{\anexosname}
 \begin{appendix}
 \renewcommand\theHchapter{anexochapback.\arabic{chapter}}
}{
 \end{appendix}
 \setboolean{abntex@apendiceousecao}{false}
 \bookmarksetup{startatroot}
}
% ---

% ---
% Imprime uma pagina de divisao no estilo parte
\newcommand{\partpage}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{part}{\appendixtocname}%
  \appendixpage*
}

% atalhos para \partpage ou \appendixpage* 
\makeatletter
\newcommand{\partapendices}{%
\tocpartapendices%
\@ifstar{\appendixpage*}{\partpage}}

\newcommand{\partanexos}{%
\tocpartanexos%
\@ifstar{\appendixpage*}{\partpage}}
\makeatother
% ---


% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Comandos e ambientes de editoracao CITACAO, ALINEA, INCISO, ASSINATURA
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ---
% Citacao direta com mais de 3 linhas - ABNT NBR 10520/2002 - 5.3
\newlength{\ABNTEXcitacaorecuo}% recuo de 4 cm da margem esquerda
\ifthenelse{\equal{\ABNTEXistwocolumn}{true}}{%
  \setlength{\ABNTEXcitacaorecuo}{1.8cm}
}{% else
  \setlength{\ABNTEXcitacaorecuo}{4cm}
}
\newenvironment*{citacao}[1][default]{%
   \list{}%
   \ABNTEXfontereduzida%
   \addtolength{\leftskip}{\ABNTEXcitacaorecuo}%
   \item[]%
   \begin{SingleSpace}%
   \ifthenelse{\not\equal{#1}{default}}{\itshape\selectlanguage{#1}}{}%
 }{%
   \end{SingleSpace}%
   \endlist}%
% ---

% ---
% Ambiente para alineas e e subalineas (incisos)
% ABNT NBR 6024/2012 - 4.2 e 4.3
\newlist{alineas}{enumerate}{2}
\setlist[alineas,1]{label={\alph*)},topsep=0pt,itemsep=0pt,leftmargin=\parindent+\labelwidth-\labelsep}%
\setlist[alineas,2]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}
\newlist{subalineas}{enumerate}{1}
\setlist[subalineas,1]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}%
\newlist{incisos}{enumerate}{1}
\setlist[incisos,1]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}%
% ---
  
% ---
% Comando \assinatura for signature
   % width of the line and text under the line
\newlength{\ABNTEXsignwidth}
\setlength{\ABNTEXsignwidth}{8cm}
   % thickness of the line
\newlength{\ABNTEXsignthickness}
\setlength{\ABNTEXsignthickness}{1pt}
   % ammount of space left between previous text and th signature line
\newlength{\ABNTEXsignskip}
\setlength{\ABNTEXsignskip}{0.3cm}
   % \assinatura{name} -> types a line with name under the line, centralized
   % \assinatura*{name} -> Creates the box with the line and name under
   %     it, but the box has no position assigned. However the line and the
   %     name are centralized with respect to each other.
\makeatletter
\newcommand{\assinatura}{\@ifstar{\ABNTEXsign}{\ABNTEXcsign}}
\makeatother
   % assinatura com estrela
\newcommand{\ABNTEXsign}[1]{%
  \parbox[t]{\ABNTEXsignwidth}{\SingleSpacing\vspace*
  {\ABNTEXsignskip}\centering%
  \rule{\ABNTEXsignwidth}{\ABNTEXsignthickness}\\%
  \nopagebreak #1}%
}
   % assinatura sem estrela
\newcommand{\ABNTEXcsign}[1]%
  {\begingroup\par\centering\ABNTEXsign{#1}\par\endgroup}  
% ---

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% IMPRESSOES PADROES DE CAPA E FOLHA DE ROSTO
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
\makeatletter
\renewcommand{\chapter}{%
    \@startsection{chapter}{0}{\z@} % Início da seção de capítulo
        {-3.5ex \@plus -1ex \@minus -.2ex}% Espaçamento antes
        {2.3ex \@plus.2ex}% Espaçamento depois
        {\normalfont\normalsize\bfseries}% Estilo do título do capítulo
}
\makeatother


% ---
% Impressão da Capa
\newcommand{\imprimircapa}{%
  \begin{capa}%
    \center
    \ABNTEXchapterfont\normalsize\textbf{CORPO DE BOMBEIROS MILITAR DE SANTA CATARINA}\\
    \ABNTEXchapterfont\normalsize\textbf{CENTRO DE ENSINO BOMBEIRO MILITAR}\\
    \ABNTEXchapterfont\normalsize\textbf{ACADEMIA BOMBEIRO MILITAR}
    \vfill
    \ABNTEXchapterfont\normalsize\bfseries\MakeUppercase\imprimirautor

    \vfill
    \begin{center}
    \ABNTEXchapterfont\bfseries\normalsize\MakeUppercase\imprimirtitulo
    \end{center}
    \vfill
    
    \normalsize\bfseries\MakeUppercase\imprimirlocal

    \normalsize\bfseries\imprimirdata
    
    \vspace*{1cm}
  \end{capa}
}
% ---


% ---
% Folha de rosto
%   usar \imprimirfolhaderosto* casodeseje imprimir algo no verso da
%   página no caso de estar no modo twoside. Util para imprimir a Ficha
%   Bibliografica. Porem, se estiver no modo oneside, a versao sem estrela
%   é identica.
\newenvironment{folhaderosto}[1][\folhaderostoname]{\clearpage\PRIVATEbookmarkthis{#1}}{\newpage}
\newenvironment{folhaderosto*}[1][\folhaderostoname]{\clearpage\PRIVATEbookmarkthis{#1}}{\newpage}%

% ---
% Conteudo padrao da Folha de Rosto
\makeatletter
\newcommand{\folhaderostocontent}{
  \begin{center}

    %\vspace*{1cm}
    {\ABNTEXchapterfont\normalsize\bfseries\imprimirautor}
	
    \vspace*{\fill}\vspace*{\fill}
    \begin{center}
      \ABNTEXchapterfont\bfseries\normalsize\imprimirtitulo
    \end{center}
    \vspace*{\fill}
	
    \abntex@ifnotempty{\imprimirpreambulo}{%
      \hspace{.45\textwidth}
      \begin{minipage}{.5\textwidth}
      	\SingleSpacing
         \imprimirpreambulo
         \newline\newline \textbf{Linha de Pesquisa: } \imprimirLinhaDePesquisa
         \newline\newline \textbf{Orientador(a):}
         \hyphenpenalty=10000
\exhyphenpenalty=10000
\tolerance=500
         \imprimirorientador ~~--~~\imprimirorientadorRotulo.
\ifdefvoid{\imprimircoorientador}{%	
}{%
  % Imprime o coorientador se a variável não estiver vazia
  \newline \textbf{Co-orientador(a):}
  \imprimircoorientador ~~--~~\imprimircoorientadorRotulo.	
}

         
       \end{minipage}%
       \vspace*{\fill}

       \fussy
    }%

 
    \vspace*{\fill}

    {\normalsize\bfseries\imprimirlocal}
    \par
    {\normalsize\bfseries \imprimirMes ~~\imprimirdata}
    \vspace*{1cm}

  \end{center}
}
\makeatother


\newcommand{\imprimirfolhaderostostar}[1]{%
  \begin{folhaderosto*}{#1}
     \folhaderostocontent
  \end{folhaderosto*}}

\newcommand{\imprimirfolhaderostonostar}[1]{%
  \begin{folhaderosto}{#1}
     \folhaderostocontent
  \end{folhaderosto}}

\makeatletter
\newcommand{\imprimirfolhaderosto}[1][\folhaderostoname]{%
   \@ifstar
     \imprimirfolhaderostostar  
     \imprimirfolhaderostonostar
}
\makeatother
% ---


%função para simplificar a inserção de imagens
\newcommand{\figura}[6][H]{ 
    \begin{figure}[#1]
        \ifthenelse{\equal{#6}{L}} % Verifica se o parâmetro é "L"
            {\hspace*{-1.5cm}} % Alinha à esquerda
            {\centering} % Centraliza por padrão
        \includegraphics[#2]{#3}
        \caption{#4}
        \label{#5}
    \end{figure}
}

\newcommand{\tab}{
  \par\indent
}

\usepackage{xparse, pgffor,expl3} % Pacotes necessários

% Comando para lista itemize com separador personalizado
\ExplSyntaxOn
\NewDocumentCommand{\lista}{ m }{
    \begin{itemize}
        \seq_set_split:Nnn \l_tmpa_seq { | } { #1 }  % Divide a string pelo separador "|"
        \seq_map_inline:Nn \l_tmpa_seq { \item ##1 } % Processa cada item sem alterar vírgulas
    \end{itemize}
}
\ExplSyntaxOff

% Comando para lista enumerate com separador personalizado
\ExplSyntaxOn
\NewDocumentCommand{\listaNumerada}{ m }{
    \begin{enumerate}
        \seq_set_split:Nnn \l_tmpa_seq { | } { #1 }  % Divide a string pelo separador "|"
        \seq_map_inline:Nn \l_tmpa_seq { \item ##1 } % Processa cada item sem alterar vírgulas
    \end{enumerate}
}
\ExplSyntaxOff


\RequirePackage[acronym,nonumberlist]{glossaries}


\renewcommand*{\acronymname}{Lista de Abreviaturas e Siglas}

\usepackage{etoolbox} % Pacote para verificação de argumentos opcionais

\newcommand{\sigla}[2]{\newacronym{#1}{#1}{#2}}
\newcommand{\listadeacronimos}{
    % \cleardoublepage  % Garante que a lista comece em uma nova página
    \renewcommand{\glossarysection}[2][]{%
        \chapter*{\centering\textbf{LISTA DE ABREVIATURAS}}  % Centraliza e coloca o título em negrito
        %\addcontentsline{toc}{chapter}{LISTA DE ABREVIATURAS}  % Adiciona ao sumário
    }
    \printglossary[type=\acronymtype]  % Gera a lista
    \clearpage  % Garante que o próximo conteúdo comece na página seguinte
}

\newcommand{\linhaDePesquisa}[1]{
    \def\imprimirLinhaDePesquisa{#1}
}

\RequirePackage{xkeyval}



% Criar um comando que exibe o nome completo do curso
\newcommand{\cursoCompleto}{%
  \ifdefstring{\cursodefinido}{CCEM}{%
    Curso de Comando e Estado Maior%
  }{%
    \ifdefstring{\cursodefinido}{CAEE}{%
      Curso de Altos Estudos Estratégicos%
    }{%
      Curso de Formação de Oficiais% % CFO (padrão)
    }%
  }%
}

\usepackage{xstring}
% Define um comando para inverter o nome do autor (SOBRENOME, Nome)
\newcommand{\inverterAutor}[1]{%
    \StrCount{#1}{ }[\numespacos]%
    \IfEq{\numespacos}{0}{%
        #1% Se não houver espaços, retorna o nome original
    }{%
        \StrBehind[\numespacos]{#1}{ }[\ultimonome]%
        \StrBefore[\numespacos]{#1}{ }[\restante]%
        \ultimonome, \restante%
    }%
}

\newcommand{\posto}[1]{%
  \ifthenelse{\equal{#1}{2TEN}}{2º Tenente}{}%
  \ifthenelse{\equal{#1}{1TEN}}{1º Tenente}{}%
  \ifthenelse{\equal{#1}{CAP}}{Capitão}{}%
  \ifthenelse{\equal{#1}{MAJ}}{Major}{}%
  \ifthenelse{\equal{#1}{TC}}{Tenente Coronel}{}%
  \ifthenelse{\equal{#1}{CEL}}{Coronel}{}%
}

\newcommand{\corporacao}[1]{%
  \ifthenelse{\equal{#1}{PM}}{PM}{}%
  \ifthenelse{\equal{#1}{BM}}{BM}{}%
}

\newcommand{\imprimirFolhadeAprovacao}{
\begin{center}
    {\ABNTEXchapterfont\bfseries\normalsize\MakeUppercase{\imprimirautor}}
    %\vspace*{\fill}
    \vspace*{\fill}
    \begin{center}
    \ABNTEXchapterfont\bfseries\normalsize\MakeUppercase\imprimirtitulo
    \end{center}
    \vspace*{\fill}
    %\hspace{.45\textwidth}
    \begin{flushleft}
        Monografia apresentada como pré-requisito para conclusão do \cursoCompleto~do 
        \imprimirinstituicao.
\end{flushleft}
    
    %\vspace*{\fill}
   \end{center}
    \textbf{Banca Examinadora:}\\  
   %Trabalho aprovado. \imprimirlocal, 24 de novembro de 2012:
    \textbf{Orientador(a):}
   \assinatura{\imprimirorientador \\ \imprimirorientadorRotulo \\ \imprimirorientadorInstituicao}
\ifdefvoid{\imprimircoorientador}{%
  % Não faz nada se o coorientador estiver vazio ou não estiver definido
}{%
  % Imprime o coorientador se a variável não estiver vazia
  \begin{flushleft}
  \textbf{Co-orientador(a):}
  \end{flushleft}
  \assinatura{%
    \imprimircoorientador \\
    \imprimircoorientadorRotulo \\
    \imprimircoorientadorInstituicao
  }
}
   
\begin{flushleft}
   \textbf{Membros:}
\end{flushleft}
   \ExplSyntaxOn
   \processarAssinaturas
    \ExplSyntaxOff
      
   \begin{center}
    \vspace*{\fill}
    {\normalsize\imprimirlocal}, \imprimirDia~de \imprimirMes~de 
    {\normalsize\imprimirdata}
    \vspace*{0.3cm}
  \end{center}

\newpage
}

\newcommand{\imprimirFichaCatalografica}{
\sffamily
	\vspace*{\fill}					% Posição vertical
	\begin{center}					% Minipage Centralizado
	\fbox{\begin{minipage}[c][8cm]{13.5cm}		% Largura
	\small
    \begin{adjustwidth}{0.5cm}{}
	\textbf{\inverterAutor{\theauthor}}
	%Sobrenome, Nome do autor
	
	   \hspace{0.5cm}\imprimirtitulo  / \imprimirautor. --
	\imprimirlocal: CEBM, \imprimirdata.
	
	\hspace{0.5cm} \thelastpage p.\\
	
    
	Monografia (\cursoCompleto)~ -- ~\imprimirinstituicao, Centro de Ensino Bombeiro Militar, \cursoCompleto,
	\imprimirdata.
    
    
    
    \hspace{1cm} Orientador(a): \imprimirorientadorRotulo~\imprimirorientador
    \ifdefvoid{\imprimircoorientador}{%
   %Não faz nada se o coorientador estiver vazio ou não estiver definido
}{%
  % Imprime o coorientador se a variável não estiver vazia
  
  \hspace{1cm} Co-orientador(a): 
  \imprimircoorientadorRotulo~\imprimircoorientador
}
\\
\hyphenpenalty=10000
\exhyphenpenalty=10000
\tolerance=500
	\hspace{0.5cm}
		\gerarListaPalavrasChave ~
		I. \inverterAutor{\imprimirorientador}.
         \ifdefvoid{\imprimircoorientador}{%
  II. Título 		
}{%
  % Imprime o coorientador se a variável não estiver vazia
  II. \inverterAutor{\imprimircoorientador}.
  III. Título 		
}

    \fussy
        \end{adjustwidth}
	\end{minipage}}
	\end{center}
\newpage
}


\ExplSyntaxOn

% Variável para armazenar a lista de membros (título, nome e organização)
\seq_new:N \g_membros_lista_seq

% Função para adicionar membros à lista (título, nome e organização)
\NewDocumentCommand{\adicionarMembro}{mmm}{
  \seq_gput_right:Nn \g_membros_lista_seq {#1||#2||#3} % Armazena título, nome e organização separados por ||
}

% Função para processar a lista de membros e chamar \assinatura
\NewDocumentCommand{\processarAssinaturas}{}{
  \seq_map_inline:Nn \g_membros_lista_seq {
    \seq_set_split:Nnn \l_tmpa_seq {||} {##1} % Divide o par título||nome||organização
    \assinatura{
      \seq_item:Nn \l_tmpa_seq {2} \\ % Nome (segundo item)
      \seq_item:Nn \l_tmpa_seq {1} \\ % Título (primeiro item)
      \seq_item:Nn \l_tmpa_seq {3}    % Organização (terceiro item)
    }
  }
}


% Variável para armazenar a lista de palavras-chave
\seq_new:N \g_palavras_chave_seq

% Função para adicionar palavras-chave à lista
\NewDocumentCommand{\adicionarPalavraChave}{m}{
  \seq_gput_right:Nn \g_palavras_chave_seq {#1} % Armazena a palavra-chave
}

% Função para gerar a lista numerada de palavras-chave
\NewDocumentCommand{\gerarListaPalavrasChave}{}{
  \int_zero:N \l_tmpa_int % Inicializa o contador
  \seq_map_inline:Nn \g_palavras_chave_seq {
    \int_incr:N \l_tmpa_int % Incrementa o contador
    \int_compare:nNnT { \l_tmpa_int } > { 1 } { ~ } % Adiciona vírgula após o primeiro item
    \int_to_arabic:n { \l_tmpa_int }.~##1 % Número da palavra-chave seguido do texto
  }
}

\NewDocumentCommand{\imprimirPalavrasChave}{}{
  \seq_use:Nn \g_palavras_chave_seq { .~ } % Separa as palavras-chave por ". "
}

% Variável para armazenar a lista de keywords
\seq_new:N \g_keywords_seq

% Função para adicionar keywords à lista
\NewDocumentCommand{\adicionarKeyword}{m}{
  \seq_gput_right:Nn \g_keywords_seq {#1} % Armazena a keyword
}

% Função para gerar a lista numerada de keywords
\NewDocumentCommand{\gerarListaKeywords}{}{
  \int_zero:N \l_tmpa_int % Inicializa o contador
  \seq_map_inline:Nn \g_keywords_seq {
    \int_incr:N \l_tmpa_int % Incrementa o contador
    \int_compare:nNnT { \l_tmpa_int } > { 1 } { ~ } % Adiciona vírgula após o primeiro item
    \int_to_arabic:n { \l_tmpa_int }.~##1 % Número da keyword seguido do texto
  }
}

% Função para imprimir keywords separadas por ". "
\NewDocumentCommand{\imprimirKeywords}{}{
  \seq_use:Nn \g_keywords_seq { .~ } % Separa as keywords por ". "
}

\ExplSyntaxOff

\newcommand{\imprimirDedicatoria}{
% ---
% Dedicatória
% ---
\IfFileExists{Texto/Dedicatoria.tex}{%
    \begin{dedicatoria}
        \vspace*{\fill}
        \centering
        \hspace{\fill}\begin{minipage}{.5\textwidth}
            \noindent
            \input{Texto/Dedicatoria}
        \end{minipage}
       % \vspace*{\fill}
    \end{dedicatoria}
}{}
}

\newcommand{\imprimirEpigrafe}{

\IfFileExists{Texto/Epigrafe.tex}{
\newpage
 \begin{epigrafe}
     \vspace*{\fill}
 	\hspace{\fill}\begin{minipage}{.5\textwidth}
 		\input{Texto/Epigrafe}
	\end{minipage}
 \end{epigrafe}
}{}
}


\newcommand{\imprimirResumo}{

\IfFileExists{Texto/Resumo.tex}{

 \newpage
 \begin{center}
     \textbf{RESUMO}
 \end{center}
     
  \input{Texto/Resumo}

  \textbf{Palavras-chave}: \imprimirPalavrasChave.

  }{}
}

\newcommand{\imprimirAbstract}{

\IfFileExists{Texto/Abstract.tex}{

 \newpage
 \begin{center}
     \textbf{ABSTRACT}
 \end{center}
  \begin{otherlanguage*}{english}
    \input{Texto/Abstract}

    \vspace{\onelineskip}
 
    \noindent 
    \textbf{Keywords}: \imprimirKeywords.
  \end{otherlanguage*}


  }{}
}

\newcommand{\imprimirAgradecimentos}{

\IfFileExists{Texto/Agradecimentos.tex}{

\begin{center}
     \textbf{\MakeUppercase{agradecimentos}}
 \end{center}
  \input{Texto/Agradecimentos}

    }{}
}

\newcommand{\imprimirapendices}{
\IfFileExists{apendices.tex}{%
  \begin{apendicesenv}

% Imprime uma página indicando o início dos apêndices
\partapendices
\input{apendices.tex}
\end{apendicesenv}

}{%
    % Se o arquivo não existir
}

}


\newcommand{\imprimiranexos}{
\IfFileExists{anexos.tex}{%
  \begin{anexosenv}

% Imprime uma página indicando o início dos apêndices
\partanexos
\input{anexos.tex}
\end{anexosenv}

}{%
    % Se o arquivo não existir
}

}
