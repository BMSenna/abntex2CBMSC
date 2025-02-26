#!/bin/bash

# Função para gerar arquivos .tex
gerar_arquivo_tex() {
    local pasta="$1"
    local arquivo_saida="$2"
    local tipo="$3"

    cd "$pasta" || exit

    # Verifica se há arquivos .tex na pasta
    if ls ??_*.tex >/dev/null 2>&1; then
        (
            echo "%% Lista de $tipo gerada automaticamente"
            echo "%% Atualize rodando 'compile.sh'"
            echo
            for arquivo in ??_*.tex; do
                # Adiciona \newpage antes de \input se for apêndice ou anexo
                if [[ "$tipo" == "apêndices" || "$tipo" == "anexos" ]]; then
                    echo "\newpage"
                fi
                echo "\input{$pasta/$arquivo}"
            done
        ) > "$arquivo_saida"
        echo "Lista de $tipo gerada em $arquivo_saida"
    else
        echo "Nenhum arquivo encontrado em $pasta. Nada será gerado."
    fi

    cd ../..
}

# Processa os argumentos da linha de comando
while getopts "it" opt; do
    case $opt in
        i)
            # Gera o arquivo imagem.txt
            echo "Gerando imagem.txt..."
            echo "Lista de imagens gerada automaticamente" > imagem.txt
            echo "Atualize rodando 'compile.sh'" >> imagem.txt
            echo "Arquivo imagem.txt criado."
            ;;
        t)
            # Gera o arquivo tabela.txt
            echo "Gerando tabela.txt..."
            echo "Lista de tabelas gerada automaticamente" > tabela.txt
            echo "Atualize rodando 'compile.sh'" >> tabela.txt
            echo "Arquivo tabela.txt criado."
            ;;
        *)
            echo "Uso: $0 [-i] [-t]"
            echo "  -i  Gera o arquivo imagem.txt"
            echo "  -t  Gera o arquivo tabela.txt"
            exit 1
            ;;
    esac
done

# Gera o arquivo capitulos.tex
gerar_arquivo_tex "Texto/Capitulos" "../../capitulos.tex" "capítulos"

# Gera o arquivo apendices.tex
gerar_arquivo_tex "Texto/Apendices" "../../apendices.tex" "apêndices"

# Gera o arquivo anexos.tex
gerar_arquivo_tex "Texto/Anexos" "../../anexos.tex" "anexos"

# Nome do seu arquivo principal LaTeX (sem a extensão .tex)
MAIN_FILE="monografia"

# Executando o fluxo de compilação LaTeX com biber
pdflatex -interaction=nonstopmode $MAIN_FILE.tex
biber $MAIN_FILE
makeglossaries $MAIN_FILE
pdflatex -interaction=nonstopmode $MAIN_FILE.tex
pdflatex -interaction=nonstopmode $MAIN_FILE.tex

# Deletando os arquivos auxiliares
rm -f $MAIN_FILE.aux $MAIN_FILE.bbl $MAIN_FILE.blg $MAIN_FILE.glo $MAIN_FILE.glg $MAIN_FILE.gls $MAIN_FILE.acn $MAIN_FILE.acr $MAIN_FILE.out $MAIN_FILE.toc $MAIN_FILE.lof $MAIN_FILE.fls $MAIN_FILE..bbl $MAIN_FILE.idx $MAIN_FILE.run.xml $MAIN_FILE.lot $MAIN_FILE.ist $MAIN_FILE.bcf $MAIN_FILE..blg $MAIN_FILE.glsdefs $MAIN_FILE.alg anexos.tex apendices.tex capitulos.tex *.txt

echo "Compilação concluída e arquivos auxiliares removidos!"
