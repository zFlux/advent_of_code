include("bits_parser.jl")
include("converter.jl")
using BitsParser, Converter

input = convertFileContentToBinary("input.txt")
result = parseBits(input)
println(sumVersions(result))