import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import solvers from '../solvers/solvers';

export const challenge_10_example: Challenge = {
    description: "Example Day 10 Challenge: best trail",
    input_file_directory: 'day10',
    input_file_name: '10_example.input.txt',
    input_parser: Parsers.challenge_10,
    first_line_parsed: "89010123".split(''),
    challenge_solver: solvers['challenge_10'],
    expected_output: 36
};

export const challenge_10: Challenge = {
    description: "Example Day 10 Challenge: best trail",
    input_file_directory: 'day10',
    input_file_name: '10_input.txt',
    input_parser: Parsers.challenge_10,
    first_line_parsed: "78434565658934341239890154327898789410169567876".split(''),
    challenge_solver: solvers['challenge_10'],
    expected_output: 512
};

export const challenge_10_2_example: Challenge = {
    description: "Example Day 10 Part 2 Challenge: best trail rating",
    input_file_directory: 'day10',
    input_file_name: '10_example.input.txt',
    input_parser: Parsers.challenge_10_2,
    first_line_parsed: "89010123".split('').map((num: string) => parseInt(num)),
    challenge_solver: solvers['challenge_10_2'],
    expected_output: 81
};

export const challenge_10_2: Challenge = {
    description: "Example Day 10 Challenge: best trail rating",
    input_file_directory: 'day10',
    input_file_name: '10_input.txt',
    input_parser: Parsers.challenge_10_2,
    first_line_parsed: "78434565658934341239890154327898789410169567876".split('').map((num: string) => parseInt(num)),
    challenge_solver: solvers['challenge_10_2'],
    expected_output: 1045
};
