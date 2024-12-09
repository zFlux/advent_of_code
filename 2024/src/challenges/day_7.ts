import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import solvers from '../solvers/solvers';

export const challenge_7_example: Challenge = {
    description: "Example Day 7 Challenge: check if the result can be a result of a calculation with the given numbers",
    input_file_directory: 'day7',
    input_file_name: '7_example.input.txt',
    input_parser: Parsers.challenge_7,
    first_line_parsed: [190, [10, 19]],
    challenge_solver: solvers['challenge_7'],
    expected_output: 3749
};

export const challenge_7: Challenge = {
    description: "Example Day 7 Challenge: check if the result can be a result of a calculation with the given numbers",
    input_file_directory: 'day7',
    input_file_name: '7_input.txt',
    input_parser: Parsers.challenge_7,
    first_line_parsed: [54753537, [2, 35, 2, 5, 5, 9, 1, 17, 367, 73]],
    challenge_solver: solvers['challenge_7'],
    expected_output: 663613490587
};

export const challenge_7_2_example: Challenge = {
    description: "Example Day 7 Part 2 Challenge: same as before only adds a new concatenation rule ||",
    input_file_directory: 'day7',
    input_file_name: '7_example.input.txt',
    input_parser: Parsers.challenge_7,
    first_line_parsed: [190, [10, 19]],
    challenge_solver: solvers['challenge_7_2'],
    expected_output: 11387
};

export const challenge_7_2: Challenge = {
    description: "Example Day 7 Part 2 Challenge: check if the result can be a result of a calculation with the given numbers",
    input_file_directory: 'day7',
    input_file_name: '7_input.txt',
    input_parser: Parsers.challenge_7,
    first_line_parsed: [54753537, [2, 35, 2, 5, 5, 9, 1, 17, 367, 73]],
    challenge_solver: solvers['challenge_7_2'],
    expected_output: 110365987435001
};