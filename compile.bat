@echo off
setlocal enabledelayedexpansion

REM Função para gerar arquivos .tex
:gerar_arquivo_tex
setlocal
set pasta=%1
set arquivo_saida=%2
set tipo=%3

cd "%pasta%" || exit /b

REM Verifica se há arquivos .tex na pasta
set arquivos_encontrados=0
for %%f in (??_*.tex) do (
    set arquivos_encontrados=1
    goto :arquivos_encontrados
)

:arquivos_encontrados
if %arquivos_encontrados%==1 (
    (
        echo %% Lista de %tipo% gerada automaticamente
        echo %% Atualize rodando 'compile.bat'
        echo.
        for %%f in (??_*.tex) do (
            REM Adiciona \newpage antes de \input se for apêndice ou anexo
            if "%tipo%"=="apêndices" (
                echo \newpage
            )
            if "%tipo%"=="anexos" (
                echo \newpage
            )
            echo \input{%pasta%/%%f}
        )
    ) > "%arquivo_saida%"
    echo Lista de %tipo% gerada em %arquivo_saida%
) else (
    echo Nenhum arquivo encontrado em %pasta%. Nada será gerado.
)

cd ..\..
endlocal
goto :eof

REM Processa os argumentos da linha de comando
set gerar_imagem=0
set gerar_tabela=0

:parse_args
if "%~1"=="" goto end_args
if "%~1"=="-i" set gerar_imagem=1
if "%~1"=="-t" set gerar_tabela=1
shift
goto parse_args

:end_args

REM Gera o arquivo imagem.txt
if %gerar_imagem%==1 (
    echo Gerando imagem.txt...
    (
        echo Lista de imagens gerada automaticamente
        echo Atualize rodando 'compile.bat'
    ) > imagem.txt
    echo Arquivo imagem.txt criado.
)

REM Gera o arquivo tabela.txt
if %gerar_tabela%==1 (
    echo Gerando tabela.txt...
    (
        echo Lista de tabelas gerada automaticamente
        echo Atualize rodando 'compile.bat'
    ) > tabela.txt
    echo Arquivo tabela.txt criado.
)

REM Gera o arquivo capitulos.tex
call :gerar_arquivo_tex "Texto\Capitulos" "..\..\capitulos.tex" "capítulos"

REM Gera o arquivo apendices.tex
call :gerar_arquivo_tex "Texto\Apendices" "..\..\apendices.tex" "apêndices"

REM Gera o arquivo anexos.tex
call :gerar_arquivo_tex "Texto\Anexos" "..\..\anexos.tex" "anexos"

REM Nome do seu arquivo principal LaTeX (sem a extensão .tex)
set MAIN_FILE=monografia

REM Executando o fluxo de compilação LaTeX com biber
pdflatex %MAIN_FILE%.tex
biber %MAIN_FILE%
makeglossaries %MAIN_FILE%
pdflatex %MAIN_FILE%.tex
pdflatex %MAIN_FILE%.tex

REM Deletando os arquivos auxiliares
del %MAIN_FILE%.aux %MAIN_FILE%.bbl %MAIN_FILE%.blg %MAIN_FILE%.glo %MAIN_FILE%.glg %MAIN_FILE%.gls %MAIN_FILE%.acn %MAIN_FILE%.acr %MAIN_FILE%.out %MAIN_FILE%.toc %MAIN_FILE%.lof %MAIN_FILE%.log %MAIN_FILE%.fls %MAIN_FILE%..bbl %MAIN_FILE%.idx %MAIN_FILE%.run.xml %MAIN_FILE%.lot %MAIN_FILE%.ist %MAIN_FILE%.bcf %MAIN_FILE%..blg %MAIN_FILE%.glsdefs %MAIN_FILE%.alg anexos.tex apendices.tex capitulos.tex *.txt

echo Compilação concluída e arquivos auxiliares removidos!
