import * as Utils from '../utils/utils';

export const example = (input: number[][]): number => {
    return input[0][0] + input[0][1];
}

export const challenge_1 = (list_of_lists: number[][]): number => {
    const list_1 = Utils.map_element_i_in_each_list_to_new_list(0, list_of_lists);
    const list_2 = Utils.map_element_i_in_each_list_to_new_list(1, list_of_lists);
    const sorted = [list_1.sort(), list_2.sort()];

    let sum = 0;
    for (let i = 0; i < sorted[0].length; i++) {
        sum += Math.abs(sorted[0][i] - sorted[1][i]);
    }
    return sum;
}

export const challenge_1_2 = (list_of_lists: number[][]): number => {
    const list_1 = Utils.map_element_i_in_each_list_to_new_list(0, list_of_lists);
    const list_2 = Utils.map_element_i_in_each_list_to_new_list(1, list_of_lists);    
    const list_2_map = Utils.frequency_map(list_2);

    return Utils.multiply_by_frequency_and_sum(list_1, list_2_map);
}



