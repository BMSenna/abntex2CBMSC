@echo off
setlocal enabledelayedexpansion

:: Função para gerar arquivos .tex
:gerar_arquivo_tex
set "pasta=%~1"
set "arquivo_saida=%~2"
set "tipo=%~3"

cd "%pasta%" || exit /b

:: Verifica se há arquivos .tex na pasta
for %%F in (??_*.tex) do (
    if exist "%%F" (
        (echo %% Lista de %tipo% gerada automaticamente
         echo %% Atualize rodando 'compile.bat'
         echo.
         for %%A in (??_*.tex) do (
             if "%tipo%" == "apêndices" (echo \newpage)
             if "%tipo%" == "anexos" (echo \newpage)
             echo \input{%pasta%/%%A}
         )) > "%arquivo_saida%"
        echo Lista de %tipo% gerada em %arquivo_saida%
    ) else (
        echo Nenhum arquivo encontrado em %pasta%. Nada será gerado.
    )
)
cd ..\..
exit /b

:: Processa os argumentos da linha de comando
set imagem=0
set tabela=0

:process_args
if "%1"=="-i" set imagem=1
if "%1"=="-t" set tabela=1
shift
if not "%1"=="" goto process_args

if %imagem%==1 (
    echo Gerando imagem.txt...
    echo Lista de imagens gerada automaticamente > imagem.txt
    echo Atualize rodando 'compile.bat' >> imagem.txt
    echo Arquivo imagem.txt criado.
)

if %tabela%==1 (
    echo Gerando tabela.txt...
    echo Lista de tabelas gerada automaticamente > tabela.txt
    echo Atualize rodando 'compile.bat' >> tabela.txt
    echo Arquivo tabela.txt criado.
)

:: Gera os arquivos .tex
call :gerar_arquivo_tex "Texto\Capitulos" "..\..\capitulos.tex" "capítulos"
call :gerar_arquivo_tex "Texto\Apendices" "..\..\apendices.tex" "apêndices"
call :gerar_arquivo_tex "Texto\Anexos" "..\..\anexos.tex" "anexos"

:: Nome do arquivo principal LaTeX
set "MAIN_FILE=monografia"

:: Executando a compilação LaTeX com biber
pdflatex %MAIN_FILE%.tex
biber %MAIN_FILE%
makeglossaries %MAIN_FILE%
pdflatex %MAIN_FILE%.tex
pdflatex %MAIN_FILE%.tex

:: Deletando arquivos auxiliares
del /F /Q %MAIN_FILE%.aux %MAIN_FILE%.bbl %MAIN_FILE%.blg %MAIN_FILE%.glo %MAIN_FILE%.glg %MAIN_FILE%.gls %MAIN_FILE%.acn %MAIN_FILE%.acr %MAIN_FILE%.out %MAIN_FILE%.toc %MAIN_FILE%.lof %MAIN_FILE%.fls %MAIN_FILE%..bbl %MAIN_FILE%.idx %MAIN_FILE%.run.xml %MAIN_FILE%.lot %MAIN_FILE%.ist %MAIN_FILE%.bcf %MAIN_FILE%..blg %MAIN_FILE%.glsdefs %MAIN_FILE%.alg anexos.tex apendices.tex capitulos.tex *.txt

echo Compilação concluída e arquivos auxiliares removidos!
