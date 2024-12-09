import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import solvers from '../solvers/solvers';

export const challenge_5_example: Challenge = {
    description: "Example Day 5 Challenge: use rules to determine the correctness of a set of instructions and sum the middle numbers of the correct ones",
    input_file_name: '5_example.input.txt',
    input_file_directory: 'day5',
    input_parser: Parsers.challenge_5,
    first_line_parsed: [47, 53],
    challenge_solver: solvers['challenge_5'],
    expected_output: 143
};

export const challenge_5: Challenge = {
    description: "Day 5 Challenge: parse a list of rules and page orders and return the number of pages that are valid",
    input_file_directory: 'day5',
    input_file_name: '5_input.txt',
    input_parser: Parsers.challenge_5,
    first_line_parsed: [65,47],
    challenge_solver: solvers['challenge_5'],
    expected_output: 5108
};

export const challenge_5_2_example: Challenge = {
    description: "Example Day 5 Part 2 Challenge: use rules to determine the incorrectness of a set of instructions and sum the middle numbers of the incorrect ones",
    input_file_directory: 'day5',
    input_file_name: '5_example.input.txt',
    input_parser: Parsers.challenge_5,
    first_line_parsed: [47, 53],
    challenge_solver: solvers['challenge_5_2'],
    expected_output: 123
};

export const challenge_5_2: Challenge = {
    description: "Example Day 5 Part 2 Challenge: use rules to determine the incorrectness of a set of instructions and sum the middle numbers of the incorrect ones",
    input_file_directory: 'day5',
    input_file_name: '5_input.txt',
    input_parser: Parsers.challenge_5,
    first_line_parsed: [65,47],
    challenge_solver: solvers['challenge_5_2'],
    expected_output: 7380
};