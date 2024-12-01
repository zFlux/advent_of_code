import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import * as Solvers from '../solvers/solvers';  

export const challenge_1: Challenge = {
    description: "Day 1 Challenge: Sum of the absolute difference of two sorted lists of numbers",
    input_file_name: '1_input.txt',
    input_parser: Parsers.challenge_1,
    first_line_parsed: [98415, 86712],
    challenge_solver: Solvers.challenge_1,
    expected_output: 2192892
};

export const challenge_1_2: Challenge = {
    description: "Day 1 Part 2 Challenge: multiply each number in left list by number of occurences in right list and sum",
    input_file_name: '1_input.txt',
    input_parser: Parsers.challenge_1,
    first_line_parsed: [98415, 86712],
    challenge_solver: Solvers.challenge_1_2,
    expected_output: 22962826
};
