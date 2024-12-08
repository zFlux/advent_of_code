import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import * as Solvers from '../solvers/solvers';

export const challenge_6_example: Challenge = {
    description: "Example Day 6 Challenge: find the number of unique characters in a string",
    input_file_directory: 'day6',
    input_file_name: '6_example.input.txt',
    input_parser: Parsers.challenge_6,
    first_line_parsed: [".",".",".",".","#",".",".",".",".",".",],
    challenge_solver: Solvers.challenge_6,
    expected_output: 41
};

export const challenge_6: Challenge = {
    description: "Day 6 Challenge: find the number of unique locations the moving guard has visited",
    input_file_directory: 'day6',
    input_file_name: '6_input.txt',
    input_parser: Parsers.challenge_6,
    first_line_parsed: "........#...#..................#.#............#....#....##.........#.............................................#................".split(''),
    challenge_solver: Solvers.challenge_6,
    expected_output: 4967
};

export const challenge_6_2_example: Challenge = {
    description: "Example Day 6 Part 2 Challenge: find the number of obstructions that would cause a cycle to occur",
    input_file_directory: 'day6',
    input_file_name: '6_example.input.txt',
    input_parser: Parsers.challenge_6,
    first_line_parsed: [".",".",".",".","#",".",".",".",".",".",],
    challenge_solver: Solvers.challenge_6_2,
    expected_output: 6
};

export const challenge_6_2: Challenge = {
    description: "Example Day 6 Part 2 Challenge: find the number of obstructions that would cause a cycle to occur",
    input_file_directory: 'day6',
    input_file_name: '6_input.txt',
    input_parser: Parsers.challenge_6,
    first_line_parsed: "........#...#..................#.#............#....#....##.........#.............................................#................".split(''),
    challenge_solver: Solvers.challenge_6_2,
    expected_output: 1789
};