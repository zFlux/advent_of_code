include("bits_parser.jl")
include("converter.jl")
using BitsParser, Converter

function evalGreaterThan(arg1,arg2)
    if arg1 > arg2
        1
    else
        0
    end
end

function evalLessThan(arg1,arg2)
    if arg1 < arg2
        1
    else
        0
    end
end

function evalEqualTo(arg1,arg2)
    if arg1 == arg2
        1
    else
        0
    end
end


evalFunctionMap = Dict(0 => +, 1 => *, 2 => min, 3 => max, 5 => evalGreaterThan, 6 => evalLessThan, 7 => evalEqualTo)

function evaluatePacket(packet)
    typeVal = packet["Type"]
    
    if typeVal == 4
        return packet["LiteralVal"]
    end

    args = []
    for subPacket in packet["Contains"]
        push!(args, evaluatePacket(subPacket))
    end

    evalFunc = evalFunctionMap[typeVal]
    result = reduce(evalFunctionMap[typeVal], args)
    result    
end


input = convertFileContentToBinary("input.txt")
result = parseBits(input)
resultEval = evaluatePacket(result)
printPackets(result, 1)
println(resultEval)