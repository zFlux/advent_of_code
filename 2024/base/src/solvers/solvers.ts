import { map_ith_elements_to_new_list, sum_absolute_differences, frequency_map, multiply_by_frequency_and_sum } from '../utils/day_1';
import { sub_lists, check_list } from '../utils/day_2';
import { check_x_mas, check_xmas_all_directions } from '../utils/day_4';
import { parse_rules_and_page_orders, create_rules_map, createPositionMap, topologicalSort, isValidList } from '../utils/day_5';
import { find_the_start_position, getNextPosition, hasCycle } from '../utils/day_6';

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

export const challenge_7 = (list: (number | number[])[][]): number => {

    let sum = 0;
    for (let equation of list) {
        // iterate through equation - the first value is the result
        // and the second value is a list of values to operate on
        let target = equation[0] as number;
        let operands = equation[1] as number[];

        if (canProduceValue(target, operands, ['+', '*'])) {
            sum += target;
        }
    }

    return sum;
}

export const challenge_7_2 = (list: (number | number[])[][]): number => {
    let sum = 0;
    for (let equation of list) {
        let target = equation[0] as number;
        let operands = equation[1] as number[];

        if (canProduceValue(target, operands, ['+', '*', '||'])) {
            sum += target;
        }
    }

    return sum;
}

const canProduceValue = (target: number, operands: number[], operations: string[]): boolean => {
    const memo: Map<string, boolean> = new Map();
  
    function dfs(index: number, currentValue: number): boolean {
      // Base case: reached the end of operands
      if (index === operands.length) {
        return currentValue === target;
      }
  
      // Memoization key
      const key = `${index},${currentValue}`;
  
      // Check if we've already computed this subproblem
      if (memo.has(key)) {
        return memo.get(key) as boolean;
      }
  
      // Try all operations given
      let add = false;
      let mult = false;
      let concat = false;

      for (let operation of operations) {
        if (operation === '+') {
          add = dfs(index + 1, currentValue + operands[index]);
        } else if (operation === '*') {
          mult = dfs(index + 1, currentValue * operands[index]);
        } else if (operation === '||') {
          concat = dfs(index + 1, parseInt(`${currentValue}${operands[index]}`));
        }
      }
  
      // Store result in memo and return
      const result = add || mult || concat;
      memo.set(key, result);
      return result;
    }
  
    // Start DFS from the first operand
    return dfs(1, operands[0]);
  }
  


