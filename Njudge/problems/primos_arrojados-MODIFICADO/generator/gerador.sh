#!/bin/bash

gcc -o ribas-ac ../sols/ribas-ac.c

for (( i=1; i<=10; i++ ))
do
    printf "Testando entrada $i\n"
    if [ $i -gt 1 ]
    then
	quantidade=$(shuf -i 1-100 -n 1)
	printf "$quantidade\n$(shuf -i 1-10000000 -n $quantidade)\n" > ../tests/in$i
    fi
    ./ribas-ac < ../tests/in$i > ../tests/out$i
done

rm -Rf ribas-ac
