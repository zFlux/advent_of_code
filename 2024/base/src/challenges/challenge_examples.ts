import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import * as Solvers from '../solvers/solvers';

export const challenge_example: Challenge = {
    input_file_name: '0_example.input.txt',
    description: "Example: Sum of two numbers",
    input_parser: Parsers.example,
    first_line_parsed: [1, 2],
    challenge_solver: Solvers.example,
    expected_output: 3
};

export const challenge_1_example: Challenge = {
    input_file_name: '1_example.input.txt',
    description: "Example Day 1 Challenge: Sum of the absolute difference of two sorted lists of numbers",
    input_parser: Parsers.challenge_1,
    first_line_parsed: [3, 4],
    challenge_solver: Solvers.challenge_1,
    expected_output: 11
};

export const challenge_1_2_example: Challenge = {
    input_file_name: '1_example.input.txt',
    description: "Example Day 1 Part 2: multiply each number in left list by number of occurences in right list and sum (example)",
    input_parser: Parsers.challenge_1,
    first_line_parsed: [3, 4],
    challenge_solver: Solvers.challenge_1_2,
    expected_output: 31
};

export const challenge_2_example: Challenge = {
    input_file_name: '2_example.input.txt',
    description: "Example Day 2 Challenge: Check that the lists validate as 'safe'",
    input_parser: Parsers.challenge_2,
    first_line_parsed: [7, 6, 4, 2, 1],
    challenge_solver: Solvers.challenge_2,
    expected_output: 2
};

export const challenge_2_2_example: Challenge = {
    input_file_name: '2_example.input.txt',
    description: "Example Day 2 Part 2 Challenge: Check that the lists validate as 'safe' with a bit more effort",
    input_parser: Parsers.challenge_2,
    first_line_parsed: [7, 6, 4, 2, 1],
    challenge_solver: Solvers.challenge_2_2,
    expected_output: 4
};

export const challenge_3_example: Challenge = {
    input_file_name: '3_example.input.txt',
    description: "Example Day 3 Challenge: parse a string with instructions in it and execute the instructions",
    input_parser: Parsers.challenge_3,
    first_line_parsed: ["mul(2,4)", "mul(5,5)", "mul(11,8)", "mul(8,5)"],
    challenge_solver: Solvers.challenge_3,
    expected_output: 161
};

export const challenge_3_2_example: Challenge = {
    input_file_name: '3_2_example.input.txt',
    description: "Example Day 3 Part 2 Challenge: parse a string with instructions in it and execute the instructions with 'do()'",
    input_parser: Parsers.challenge_3_2,
    first_line_parsed: ["mul(2,4)", "don't()", "mul(5,5)", "mul(11,8)", "do()", "mul(8,5)"],
    challenge_solver: Solvers.challenge_3_2,
    expected_output: 48
};

export const challenge_4_example: Challenge = {
    input_file_name: '4_example.input.txt',
    description: "Example Day 4 Challenge: find the word xmas in any direction in a grid",
    input_parser: Parsers.challenge_4,
    first_line_parsed: ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
    challenge_solver: Solvers.challenge_4,
    expected_output: 18
};

export const challenge_4_2_example: Challenge = {
    input_file_name: '4_example.input.txt',
    description: "Example Day 4 Part 2 Challenge: count the occurances of the word mas in an x anywhere in a grid",
    input_parser: Parsers.challenge_4,
    first_line_parsed: ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
    challenge_solver: Solvers.challenge_4_2,
    expected_output: 9
};

export const challenge_5_example: Challenge = {
    input_file_name: '5_example.input.txt',
    description: "Example Day 5 Challenge: use rules to determine the correctness of a set of instructions and sum the middle numbers of the correct ones",
    input_parser: Parsers.challenge_5,
    first_line_parsed: [47, 53],
    challenge_solver: Solvers.challenge_5,
    expected_output: 143
};

export const challenge_5_2_example: Challenge = {
    input_file_name: '5_example.input.txt',
    description: "Example Day 5 Part 2 Challenge: use rules to determine the incorrectness of a set of instructions and sum the middle numbers of the incorrect ones",
    input_parser: Parsers.challenge_5,
    first_line_parsed: [47, 53],
    challenge_solver: Solvers.challenge_5_2,
    expected_output: 123
};

export const challenge_6_example: Challenge = {
    input_file_name: '6_example.input.txt',
    description: "Example Day 6 Challenge: find the number of unique characters in a string",
    input_parser: Parsers.challenge_6,
    first_line_parsed: [".",".",".",".","#",".",".",".",".",".",],
    challenge_solver: Solvers.challenge_6,
    expected_output: 41
};

export const challenge_6_2_example: Challenge = {
    input_file_name: '6_example.input.txt',
    description: "Example Day 6 Part 2 Challenge: find the number of obstructions that would cause a cycle to occur",
    input_parser: Parsers.challenge_6,
    first_line_parsed: [".",".",".",".","#",".",".",".",".",".",],
    challenge_solver: Solvers.challenge_6_2,
    expected_output: 6
};