import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import * as Solvers from '../solvers/solvers';

export const challenge_4_example: Challenge = {
    description: "Example Day 4 Challenge: find the word xmas in any direction in a grid",
    input_file_name: '4_example.input.txt',
    input_file_directory: 'day4',
    input_parser: Parsers.challenge_4,
    first_line_parsed: ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
    challenge_solver: Solvers.challenge_4,
    expected_output: 18
};

export const challenge_4: Challenge = {
    description: "Day 4 Challenge: find how many times xmas appears in any direction on a grid",
    input_file_directory: 'day4',
    input_file_name: '4_input.txt',
    input_parser: Parsers.challenge_4,
    first_line_parsed: ["S","S","S","M","M","S","A","M","X","S","S","S","S","S","S","M","S","S","S","S","M","A","M","S","M","M","S","M","S","M","X","S","A","S","M","M","M","M","A","M","X","A","X","M","A","X","X","S","S","M","S","S","S","M","S","M","M","S","X","M","A","X","X","M","A","X","S","A","M","X","M","X","M","A","X","X","M","A","A","M","M","M","M","M","A","A","S","X","M","S","A","M","X","M","A","S","M","M","S","M","S","M","S","X","X","M","S","M","S","X","A","X","M","S","M","M","S","X","A","S","X","S","M","M","S","M","M","X","M","M","M","M","X","M","X","A","M","M","S","X"],
    challenge_solver: Solvers.challenge_4,
    expected_output: 2427
};

export const challenge_4_2_example: Challenge = {
    description: "Example Day 4 Part 2 Challenge: count the occurances of the word mas in an x anywhere in a grid",
    input_file_directory: 'day4',
    input_file_name: '4_example.input.txt',
    input_parser: Parsers.challenge_4,
    first_line_parsed: ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
    challenge_solver: Solvers.challenge_4_2,
    expected_output: 9
};

export const challenge_4_2: Challenge = {
    description: "Day 4 Part 2 Challenge: find how many times the word mas appears in an x on a grid",
    input_file_directory: 'day4',
    input_file_name: '4_input.txt',
    input_parser: Parsers.challenge_4,
    first_line_parsed: ["S","S","S","M","M","S","A","M","X","S","S","S","S","S","S","M","S","S","S","S","M","A","M","S","M","M","S","M","S","M","X","S","A","S","M","M","M","M","A","M","X","A","X","M","A","X","X","S","S","M","S","S","S","M","S","M","M","S","X","M","A","X","X","M","A","X","S","A","M","X","M","X","M","A","X","X","M","A","A","M","M","M","M","M","A","A","S","X","M","S","A","M","X","M","A","S","M","M","S","M","S","M","S","X","X","M","S","M","S","X","A","X","M","S","M","M","S","X","A","S","X","S","M","M","S","M","M","X","M","M","M","M","X","M","X","A","M","M","S","X"],
    challenge_solver: Solvers.challenge_4_2,
    expected_output: 1900
};