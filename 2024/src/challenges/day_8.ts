import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import solvers from '../solvers/solvers';

export const challenge_8_example: Challenge = {
    description: "Example Day 8 Challenge: find all the 'antinode' positions for a map of antennas",
    input_file_directory: 'day8',
    input_file_name: '8_example.input.txt',
    input_parser: Parsers.challenge_8,
    first_line_parsed: "............".split(''),
    challenge_solver: solvers['challenge_8'],
    expected_output: 14
};

export const challenge_8: Challenge = {
    description: "Day 8 Challenge: find all the 'antinode' positions for a map of antennas",
    input_file_directory: 'day8',
    input_file_name: '8_input.txt',
    input_parser: Parsers.challenge_8,
    first_line_parsed: ".......................V.........e...O............".split(''),
    challenge_solver: solvers['challenge_8'],
    expected_output: 341
};

export const challenge_8_2_example: Challenge = {
    description: "Example Day 8 Part 2 Challenge: find all the 'antinode' positions for a map of antennas more challenging",
    input_file_directory: 'day8',
    input_file_name: '8_example.input.txt',
    input_parser: Parsers.challenge_8,
    first_line_parsed: "............".split(''),
    challenge_solver: solvers['challenge_8_2'],
    expected_output: 34
};

export const challenge_8_2: Challenge = {
    description: "Day 8 Part 2 Challenge: find all the 'antinode' positions for a map of antennas more challenging",
    input_file_directory: 'day8',
    input_file_name: '8_input.txt',
    input_parser: Parsers.challenge_8,
    first_line_parsed: ".......................V.........e...O............".split(''),
    challenge_solver: solvers['challenge_8_2'],
    expected_output: 1134
};