import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import * as Solvers from '../solvers/solvers';


export const challenge_1_example: Challenge = {
    description: "Example Day 1 Challenge: Sum of the absolute difference of two sorted lists of numbers",
    input_file_name: '1_example.input.txt',
    input_file_directory: 'day1',
    input_parser: Parsers.challenge_1,
    first_line_parsed: [3, 4],
    challenge_solver: Solvers.challenge_1,
    expected_output: 11
};

export const challenge_1: Challenge = {
    description: "Day 1 Challenge: Sum of the absolute difference of two sorted lists of numbers",
    input_file_name: '1_input.txt',
    input_file_directory: 'day1',
    input_parser: Parsers.challenge_1,
    first_line_parsed: [98415, 86712],
    challenge_solver: Solvers.challenge_1,
    expected_output: 2192892
};

export const challenge_1_2_example: Challenge = {
    description: "Example Day 1 Part 2: multiply each number in left list by number of occurences in right list and sum (example)",
    input_file_name: '1_example.input.txt',
    input_file_directory: 'day1',
    input_parser: Parsers.challenge_1,
    first_line_parsed: [3, 4],
    challenge_solver: Solvers.challenge_1_2,
    expected_output: 31
};

export const challenge_1_2: Challenge = {
    description: "Day 1 Part 2 Challenge: multiply each number in left list by number of occurences in right list and sum",
    input_file_name: '1_input.txt',
    input_file_directory: 'day1',
    input_parser: Parsers.challenge_1,
    first_line_parsed: [98415, 86712],
    challenge_solver: Solvers.challenge_1_2,
    expected_output: 22962826
};