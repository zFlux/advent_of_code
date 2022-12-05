#!/bin/bash

cargoPiles=()

# for loop to read only the first three lines
for i in {1..3}
do
    IFS="";read -r line
     if [[ ${line:1:1} != " " ]]; then
        cargoPiles[1]+=${line:1:1}
    fi
    if [[ ${line:5:1} != " " ]]; then
        cargoPiles[2]+=${line:5:1}
    fi
    if [[ ${line:9:1} != " " ]]; then
        cargoPiles[3]+=${line:9:1}
    fi
done < input_sample.txt

while read -r line; do
    if [[ ${line:0:4} == "move" ]]; then
        move=$(echo $line | awk '{print $2}')
        from=$(echo $line | awk '{print $4}')
        to=$(echo $line | awk '{print $6}')
        for (( j=1; j<=$move; j++ ))
        do
            cargoPiles[$to]=${cargoPiles[$from]:0:1}${cargoPiles[$to]}
            cargoPiles[$from]=${cargoPiles[$from]:1}
            echo "Result: ${cargoPiles[@]} Seq: $j"
        done
    fi
done < input_sample.txt

# print the first character from each string in cargoPiles followed by a newline
for (( i=1; i<=${#cargoPiles[@]}; i++ ))
do
    echo -n ${cargoPiles[$i]:0:1}
done
echo
