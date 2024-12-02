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