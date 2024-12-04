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




   