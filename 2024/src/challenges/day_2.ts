import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import * as Solvers from '../solvers/solvers';

export const challenge_2_example: Challenge = {
    description: "Example Day 2 Challenge: Check that the lists validate as 'safe'",
    input_file_name: '2_example.input.txt',
    input_file_directory: 'day2',
    input_parser: Parsers.challenge_2,
    first_line_parsed: [7, 6, 4, 2, 1],
    challenge_solver: Solvers.challenge_2,
    expected_output: 2
};

export const challenge_2: Challenge = {
    description: "Day 2 Challenge: Check that the lists validate as 'safe'",
    input_file_directory: 'day2',
    input_file_name: '2_input.txt',
    input_parser: Parsers.challenge_2,
    first_line_parsed: [16, 18, 20, 22, 23, 22],
    challenge_solver: Solvers.challenge_2,
    expected_output: 606
};

export const challenge_2_2_example: Challenge = {
    description: "Example Day 2 Part 2 Challenge: Check that the lists validate as 'safe' with a bit more effort",
    input_file_directory: 'day2',
    input_file_name: '2_example.input.txt',
    input_parser: Parsers.challenge_2,
    first_line_parsed: [7, 6, 4, 2, 1],
    challenge_solver: Solvers.challenge_2_2,
    expected_output: 4
};

export const challenge_2_2: Challenge = {
    description: "Day 2 Part 2 Challenge: Check that the lists validate as 'safe' with a bit more effort",
    input_file_directory: 'day2',
    input_file_name: '2_input.txt',
    input_parser: Parsers.challenge_2,
    first_line_parsed: [16, 18, 20, 22, 23, 22],
    challenge_solver: Solvers.challenge_2_2,
    expected_output: 644
};