#!/bin/bash

gcc -o isaac-ac ../sols/good/isaac-ac.c

for (( i=1; i<=10; i++ ))
do
    printf "Testando entrada $i\n"
    if [ $i -gt 0 ]; then
        # Gera dois numeros aleatorios A e B entre 1 e 100
        numeros=$(shuf -i 1-100 -n 2)
        printf "%s %s" "${numeros[0]}" "${numeros[1]}" > ../tests/input/$i
    fi
    ./isaac-ac < ../tests/input/$i > ../tests/output/$i
done

rm -Rf isaac-ac
