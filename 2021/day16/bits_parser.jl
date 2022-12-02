module BitsParser

    export parseBits, sumVersions, printPackets

    function processVersion(processData)
        newProcessData = processData
        input = processData["Input"]
        newProcessData["Version"] = parse(Int64, input[1:3], 2)
        newProcessData["Input"] = input[4:length(input)]
        newProcessData["Step"] = "Type"
        newProcessData
    end

    function processBitType(processData)
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

    function processLiteralValue(processData)
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

    function processOperation(processData)
        newProcessData = processData
        input = newProcessData["Input"]
        lengthTypeID = input[1:1]
        processSubPacketsByBitLength = input[1:1]  == "0"

        if processSubPacketsByBitLength
            numberOfBitsInSubpackets = parse(Int64, input[2:16], 2)
            subpacketInput = input[17:(16 + numberOfBitsInSubpackets)]
            newProcessData["Input"] = input[(16 + numberOfBitsInSubpackets) + 1: length(input)]

            while (length(subpacketInput) > 0)
                subpacketProcessedData = parseBits(subpacketInput)
                push!(newProcessData["Contains"], subpacketProcessedData)
                subpacketInput = subpacketProcessedData["Input"]
            end

        else
            numberOfSubpackets = parse(Int64, input[2:12], 2)
            subpacketInput = input[13:length(input)]
            newProcessData["Input"] = input[13:length(input)]
            for i in 1:numberOfSubpackets
                subpacketProcessedData = parseBits(subpacketInput)
                push!(newProcessData["Contains"], subpacketProcessedData)
                subpacketInput = subpacketProcessedData["Input"]
                newProcessData["Input"] = subpacketProcessedData["Input"]
            end
        end

        newProcessData["Step"] = "Done"
        newProcessData
    end

    processingFunctionMap = Dict("Version" => processVersion,"Type" => processBitType, "Literal" => processLiteralValue, "Operation" => processOperation)

    function parseBits(input)

        processData = Dict("Step" => "Version", "Input" => input, "Contains" => [])

        while processData["Step"] != "Done"
            processingFunction = processingFunctionMap[processData["Step"]]
            processData = processingFunction(processData)
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

    function printPackets(input, tabs)
        spaces = " "^tabs
        newTabs = tabs + 1
        val = spaces * "Version: " * string(input["Version"]) * " Type: " * string(input["Type"]) * " Literal Val: " * string(input["LiteralVal"])
        println(val)
        if length(input["Contains"]) > 0
            for subInput in input["Contains"]
                printPackets(subInput, newTabs)
            end
        end
    end

end