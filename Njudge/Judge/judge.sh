#!/bin/bash

validate_folder() {
    cd "../Submissions" || exit 1
    file=$(ls | grep '\.c$')
    
    # Verificar se exatamente um arquivo .c foi encontrado
    if [ "$(echo $file | wc -w)" -eq 1 ]; then
        echo "Submission found: $file"
    else 
        echo "validate folder failed"
        exit 1
    fi
}

compile() {
    # Nome do executável gerado
    executable="compiled"
    gcc "$file" -o "$executable"
}

execution_time() {
    # Acessar a pasta do gerador
    cd "../problems/soma_de_cria/generator" || exit 1
    
    chmod +x gerador.sh
    ./gerador.sh
    
    cd "../sols/good"
    sol=$(ls | grep '\.c$')
    gcc "$sol" -o "sol"
    
    # Ditando o limite de tempo
    TIMEFORMAT='%R'
    tempo_total=$(time (
    for (( i=1; i<=10; i++ ))
    do
        ./sol < ../../tests/input/$i > ../../tests/output/$i
    done
    ) 2>&1)
    cp ../../tests/input/* ../../../../Inputs
    cp ../../tests/output/* ../../../../ExpectedOutput

    tempo_total=$(echo "$tempo_total" | tr ',' '.')
    constante=1.5
    
    # Calculando o time limit
    time_limit=$(echo "$constante * $tempo_total" | bc)
    
    echo "o resulta do time limit eh: $time_limit"
}

# 3. Limitar o tempo em que meu arquivo pode ser compilado

validate_compilation() {
    cd ../../../../Submissions
    # Utiliza o comando timeout para limitar o tempo de execução
    for (( i=1; i<=10; i++ ))
    do
        ./compiled < ../Inputs/$i  > ../Output/$i
        
        status=$?

    if [ $status -eq 124 ]; then
        echo "Time Limit Exceeded"
        exit 1
    elif [ $status -ne 0 ]; then
        echo "Runtime Error"
        exit 1
    else
        output=$(cat "../Output/$i")

        expected=$(cat "../ExpectedOutput/$i")
        if [ "$output" = "$expected" ]; then
            echo "Accepted"
        else
            echo "Wrong Answer"
        fi
    fi
    done
    rm compiled
}

validate_folder
compile
execution_time
validate_compilation
