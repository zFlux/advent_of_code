include("bits_parser.jl")
using BitsParser

function hexDigitToFourBinaryDigits(hexValue)
    lpad(bin(parse(Int16, hexValue, 16)), 4, "0")
end

function convertFileContentToBinary(fileName)
    file = open(fileName,"r")
    input = ""
    while !eof(file)
        hexChar = read(file, Char)
        binaryString = hexDigitToFourBinaryDigits(hexChar)
        input = string(input, binaryString)    
    end
    close(file)
    input
end

input = convertFileContentToBinary("input_test8.txt")
result = processBits(input)
printPackets(result, 1)

