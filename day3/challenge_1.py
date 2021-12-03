#!/usr/bin/python

file = open('input.txt')

result = [0,0,0,0,0,0,0,0,0,0,0,0]
for line in file:
    lineChars = []
    lineChars.extend(line.strip())
    
    i = 0
    for bit in lineChars:
        if bit == '1':
            result[i]+=1
        else:
            result[i]-=1
        i+=1

gammaString = ""
epsilonString = ""
for bit in result:
    if bit >= 0:
        gammaString+="1"
        epsilonString+="0"
    else:
        gammaString+="0"
        epsilonString+="1"

print(int(gammaString,2) * int(epsilonString,2))
