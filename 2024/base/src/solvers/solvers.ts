import { map_ith_elements_to_new_list, sum_absolute_differences, frequency_map, multiply_by_frequency_and_sum, check_list, sub_lists } from '../utils/utils';

export const example = (input: number[][]): number => {
    return input[0][0] + input[0][1];
}

export const challenge_1 = (list_of_lists: number[][]): number => {
    const list_1 = map_ith_elements_to_new_list(0, list_of_lists);
    const list_2 = map_ith_elements_to_new_list(1, list_of_lists);
    const sorted = [list_1.sort(), list_2.sort()];

    return sum_absolute_differences(sorted[0], sorted[1]);
}

export const challenge_1_2 = (list_of_lists: number[][]): number => {
    const list_1 = map_ith_elements_to_new_list(0, list_of_lists);
    const list_2 = map_ith_elements_to_new_list(1, list_of_lists);    
    const list_2_frequency_map = frequency_map(list_2);

    return multiply_by_frequency_and_sum(list_1, list_2_frequency_map);
}

export const challenge_2 = (list_of_lists: number[][]): number => {
    let sum = 0;
    for (let list of list_of_lists) {
        if (check_list(list, false)) {
            sum+=1;
        }
    }

    return sum;
}

export const challenge_2_2 = (list_of_lists: number[][]): number => {
    let sum = 0;
    for (let list of list_of_lists) {
        if (check_list(list, true)) {
            sum+=1;
        } else {
            const sub_lists_of_list = sub_lists(list);
            for (let sub_list of sub_lists_of_list) {
                if (check_list(sub_list, true)) {
                    sum+=1;
                    break;
                }
            }
        }
    }

    return sum;
}

export const challenge_3 = (instructions: string[]): number => {
    let result = 0;
    for (let instruction_set of instructions) {
        for (let instruction of instruction_set) {
            let numbers = instruction.match(/\d{1,3}/g);
            if (numbers !== null && numbers[0] !== null && numbers[1] !== null) {
                result += parseInt(numbers[0]) * parseInt(numbers[1]);
            } 
        }
    }
    return result;
}

export const challenge_3_2 = (instructions: string[]): number => {
    let result = 0;
    let do_mult = true;
    for (let instruction_set of instructions) {
        for (let instruction of instruction_set) {
            let numbers = instruction.match(/\d{1,3}/g);
            if (numbers !== null && numbers[0] !== null && numbers[1] !== null) {
                if (do_mult) {
                    result += parseInt(numbers[0]) * parseInt(numbers[1]);
                }
            } else {
                if (instruction === "do()") {
                    do_mult = true;
                } else {
                    do_mult = false;
                }
            }
        }
    }
    return result;
}

const UP = 0;
const UP_RIGHT = 1;
const RIGHT = 2;
const DOWN_RIGHT = 3;
const DOWN = 4;
const DOWN_LEFT = 5;
const LEFT = 6;
const UP_LEFT = 7;

const move_direction = (direction: number, x: number, y: number, lower_boundary: number, right_boundary: number): [number, number] | boolean => {
    const upper_boundary = 0;
    const left_boundary = 0;

    switch (direction) {
        case UP:
            return y - 1 < upper_boundary ? false : [x, y - 1];
        case UP_RIGHT:
            return x + 1 > right_boundary || y - 1 < upper_boundary ? false : [x + 1, y - 1];
        case RIGHT:
            return x + 1 > right_boundary ? false : [x + 1, y];
        case DOWN_RIGHT:
            return x + 1 > right_boundary || y + 1 > lower_boundary ? false : [x + 1, y + 1];
        case DOWN:
            return y + 1 > lower_boundary ? false : [x, y + 1];
        case DOWN_LEFT:
            return x - 1 < left_boundary || y + 1 > lower_boundary ? false : [x - 1, y + 1];
        case LEFT:
            return x - 1 < left_boundary ? false : [x - 1, y];
        case UP_LEFT:
            return x - 1 < left_boundary || y - 1 < upper_boundary ? false : [x - 1, y - 1];
        default:
            return false;
    }
}

const check_xmas = (grid: string[][], x: number, y: number, direction: number): number => {
    const lower_boundary = grid.length - 1;
    const right_boundary = grid[0].length - 1;
    const word = ['X', 'M', 'A', 'S'];
    let char_position = 1;

    while (char_position < word.length) {
        let next_coordinates = move_direction(direction, x, y, lower_boundary, right_boundary);
        if (next_coordinates === false) {
            return 0;
        } else {
            next_coordinates = next_coordinates as [number, number];
            if (grid[next_coordinates[0]][next_coordinates[1]] === word[char_position]) {
                char_position += 1;
                x = next_coordinates[0];
                y = next_coordinates[1];
            } else {
                return 0;
            }
        }
    }
    return 1;
}

const check_xmas_all_directions = (grid: string[][], x: number, y: number): number => {
    let sum = 0;
    sum += check_xmas(grid, x, y, UP);
    sum += check_xmas(grid, x, y, UP_RIGHT);
    sum += check_xmas(grid, x, y, RIGHT);
    sum += check_xmas(grid, x, y, DOWN_RIGHT);
    sum += check_xmas(grid, x, y, DOWN);
    sum += check_xmas(grid, x, y, DOWN_LEFT);
    sum += check_xmas(grid, x, y, LEFT);
    sum += check_xmas(grid, x, y, UP_LEFT);
    return sum;
}


export const challenge_4 = (grid: string[][]): number => {
    let sum = 0
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] === 'X') {
                sum += check_xmas_all_directions(grid, i, j);
            }
        }
    }
    return sum;
}

const check_x_mas = (grid: string[][], x: number, y: number): number => {
    const mas_map: { [key: string]: string } = {'M': 'S', 'S': 'M'}
    
    if (x - 1 >= 0 && y - 1 >= 0 && x + 1 < grid.length && y + 1 < grid[0].length) {
        if (mas_map[grid[x - 1][y + 1]] === grid[x + 1][y - 1] && mas_map[grid[x + 1][y + 1]] === grid[x - 1][y - 1]) {
            return 1;
        }
    }
    return 0;
}

export const challenge_4_2 = (grid: string[][]): number => {
    let sum = 0
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] === 'A') {
                sum += check_x_mas(grid, i, j);
            }
        }
    }
    return sum;
}




   