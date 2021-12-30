function version(processData)
    newProcessData = processData
    input = processData["Input"]
    newProcessData["Version"] = parse(Int64, input[1:3], 2)
    newProcessData["Input"] = input[4:length(input)]
    newProcessData["Step"] = "Type"
    newProcessData
end

function bitType(processData)
    input = processData["Input"]
    bitTypeVal = parse(Int64, input[1:3], 2)
    remainder = input[4:length(input)]
    newProcessData = processData
    newProcessData["Type"] = bitTypeVal
    newProcessData["Input"] = remainder
    newProcessData["LiteralVal"] = ""

    if bitTypeVal == 4
        newProcessData["Step"] = "Literal"
    else
        newProcessData["Step"] = "Operation"
    end
  
    newProcessData
end

function literalValue(processData)
    newProcessData = processData
    input = processData["Input"]
    isLastDigit = input[1:1] == "0"
    literalVal = input[2:5]
    newProcessData["Input"] = input[6:length(input)]
    newProcessData["LiteralVal"] = string(processData["LiteralVal"], literalVal)

    if isLastDigit
        newProcessData["Step"] = "Done"
        newProcessData["LiteralVal"] = parse(Int64, newProcessData["LiteralVal"], 2)
    end

    newProcessData
end

function operation(processData)
    newProcessData = processData
    input = newProcessData["Input"]
    lengthTypeID = input[1:1]
    processSubPacketsByBitLength = input[1:1]  == "0"

    if processSubPacketsByBitLength
        numberOfBitsInSubpackets = parse(Int64, input[2:16], 2)
        subpacketInput = input[17:(16 + numberOfBitsInSubpackets)]
        newProcessData["Input"] = input[(16 + numberOfBitsInSubpackets) + 1: length(input)]

        while (length(subpacketInput) > 0)
            subpacketProcessedData = processBits(subpacketInput)
            push!(newProcessData["Contains"], subpacketProcessedData)
            subpacketInput = subpacketProcessedData["Input"]
        end

    else
        numberOfSubpackets = parse(Int64, input[2:12], 2)
        subpacketInput = input[13:length(input)]
        newProcessData["Input"] = input[13:length(input)]
        for i in 1:numberOfSubpackets
            subpacketProcessedData = processBits(subpacketInput)
            push!(newProcessData["Contains"], subpacketProcessedData)
            subpacketInput = subpacketProcessedData["Input"]
            newProcessData["Input"] = subpacketProcessedData["Input"]
        end
    end

    newProcessData["Step"] = "Done"
    newProcessData
end

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

function processBits(input)

    processData = Dict("Step" => "Version", "Input" => input, "Contains" => [])

    while processData["Step"] != "Done"
        processFunction = processingFunctions[processData["Step"]]
        processData = processFunction(processData)
    end

    processData
end

function sumVersions(input)
    versionSum = input["Version"]

    for subInput in input["Contains"]
        versionSum += sumVersions(subInput)
    end
    versionSum
end

processingFunctions = Dict("Version" => version,"Type" => bitType, "Literal" => literalValue, "Operation" => operation)
input = convertFileContentToBinary("/home/daniel/sandbox/advent_of_code/day16/input.txt")
result = processBits(input)
println(result)
println(sumVersions(result))

