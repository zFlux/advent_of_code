import { map_ith_elements_to_new_list, sum_absolute_differences, frequency_map, multiply_by_frequency_and_sum } from '../utils/day_1';
import { sub_lists, check_list } from '../utils/day_2';
import { check_x_mas, check_xmas_all_directions } from '../utils/day_4';
import { parse_rules_and_page_orders, create_rules_map, createPositionMap, topologicalSort, isValidList } from '../utils/day_5';

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

type RulesOrPageOrders = (number[] | string)[];

export const challenge_5 = (rules_or_page_orders: RulesOrPageOrders): number => {
    let [rules, page_orders] = parse_rules_and_page_orders(rules_or_page_orders);

    let middle_sum = 0;
    for (let page_order of page_orders) {
        let rules_map = create_rules_map(rules, page_order);
        let position_map = createPositionMap(topologicalSort(rules_map));
        if (isValidList(page_order, position_map)) {
            let middle_index = Math.floor(page_order.length / 2);
            middle_sum += page_order[middle_index];
        }
    }
    return middle_sum;
}

export const challenge_5_2 = (rules_or_page_orders: RulesOrPageOrders): number => {
    let [rules, page_orders] = parse_rules_and_page_orders(rules_or_page_orders);

    let middle_sum = 0;
    for (let page_order of page_orders) {
        let rules_map = create_rules_map(rules, page_order);
        let sorted_rules = topologicalSort(rules_map);
        let position_map = createPositionMap(sorted_rules);
        if (!isValidList(page_order, position_map)) {
            let middle_index = Math.floor(page_order.length / 2);
            middle_sum += sorted_rules[middle_index];
        }
    }
    return middle_sum;
}

export const challenge_6 = (grid: string[][]): number | string => {
    let start = find_the_start_position(grid);
    let visited_positions = new Set<string>();
    if (!start) return 0;
    let [i, j, direction] = start;
    visited_positions.add(`${i},${j}`);
    
    let nextPosition = getNextPosition(grid, [i, j, direction]);

    while (nextPosition) {
        [i, j, direction] = nextPosition;
        visited_positions.add(`${i},${j}`);
        nextPosition = getNextPosition(grid, [i, j, direction]);
    }

    return visited_positions.size;
}

export const challenge_6_2 = (grid: string[][]): number => {
    // loop through each position in the grid.
    // if the position is a '.' replace it with an '#' and
    // see if it causes a cycle. If it does, then count it.
    // as a valid "obstruction" position
    let obstruction_count = 0;
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] === '.') {
                grid[i][j] = '#';
                if (hasCycle(grid)) {
                    obstruction_count += 1;
                }
                grid[i][j] = '.';
            }
        }
    }

    return obstruction_count;
}

// Floyd's cycle-finding algorithm
const hasCycle = (grid: string[][]): boolean => {
    let slow = find_the_start_position(grid);
    let fast = find_the_start_position(grid);

    while (slow && fast) {
        slow = getNextPosition(grid, slow);

        // fast moves twice as fast as slow
        fast = getNextPosition(grid, fast);
        if (!fast) break;
        fast = getNextPosition(grid, fast);

        // if the positions are the same, then there is a cycle according to floyds alogo
        if (slow && fast && slow[0] === fast[0] && slow[1] === fast[1] && slow[2] === fast[2]) {
            return true;
        }
    }

    return false;
}

const getNextPosition = (grid: string[][], position: [number, number, string]): [number, number, string] | null => {
    let [i, j, direction] = position;

    if (direction === '^' && i - 1 >= 0) {
        if (grid[i - 1][j] !== '#') {
            return [i - 1, j, '^'];
        } else {
            return [i, j, '>'];
        }
    } else if (direction === '>' && j + 1 < grid[i].length) {
        if (grid[i][j + 1] !== '#') {
            return [i, j + 1, '>'];
        } else {
            return [i, j, 'v'];
        }
    } else if (direction === 'v' && i + 1 < grid.length) {
        if (grid[i + 1][j] !== '#') {
            return [i + 1, j, 'v'];
        } else {
            return [i, j, '<'];
        }
    } else if (direction === '<' && j - 1 >= 0) {
        if (grid[i][j - 1] !== '#') {
            return [i, j - 1, '<'];
        } else {
            return [i, j, '^'];
        }
    }

    return null;
}

const print_grid = (grid: string[][]): void => {
    // build the grid as a formatted string
    let grid_str = '';
    for (let i = 0; i < grid.length; i++) {
        grid_str += grid[i].join('') + '\n';
    }
}    

const find_the_start_position = (grid: string[][]): [number, number, string] | null => {
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] === '^') {
                return [i, j, '^'];
            }
        }
    }
    return null;
}