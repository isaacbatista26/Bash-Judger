#!/bin/bash

# Pasta contendo os arquivos de submissão
folder_submissions="../Submissions"

cd "$folder_submissions" || exit 1

# Obter o nome do único arquivo na pasta de submissões
file=$(ls | grep '\.c$')

# Verificar se exatamente um arquivo .c foi encontrado
if [ "$(echo $file | wc -w)" -eq 1 ]; then
    echo "Arquivo de submissão encontrado: $file"

    # Nome do executável gerado
    executable="compiled"
    # como fazer o ./executable?, arranjar uma forma de rodar o ./
    # Compilar o programa
    gcc "$file" -o "$executable"
         #CMAKE utlizar flags de compilacao
         #Compilar 2 arquivos
        #loop for para verificar cada caso teste de entrada

    # Verificar se a compilação foi bem-sucedida
    if [ $? -ne 0 ]; then
        echo "Compilation Error."
        exit 1 # Saia do script com código de erro
    else
        echo "Compilação bem-sucedida. Executando o programa..."
        # Executar o programa
        output_program=$(./"$executable")

        folder_output="../ExpectedOutput"

        output_expected=$(cat "$folder_output/output.txt")

        # Comparar a saída com um valor esperado
        if [ "$output_program" = "$output_expected" ]; then
            echo "Accepted"
            echo "$output_program"
        else
            echo "Wrong Answer"
        fi
    fi
else
    echo "Nenhum arquivo .c encontrado ou mais de um arquivo encontrado na mesma pasta"
fi
    
