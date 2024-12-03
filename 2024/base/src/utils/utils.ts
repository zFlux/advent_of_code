export const map_ith_elements_to_new_list = (i: number, list: number[][]): number[] => {
    return list.map((_, index) => list[index][i]);
}

export const sum_absolute_differences = (list_1: number[], list_2: number[]): number => {
    let sum = 0;
    for (let i = 0; i < list_1.length; i++) {
        sum += Math.abs(list_1[i] - list_2[i]);
    }
    return sum;
}

export const frequency_map = (list: number[]): Map<number, number> => {
    const map = new Map<number, number>();
    list.forEach((num: number) => {
        map.set(num, (map.get(num) || 0) + 1);
    });
    return map;
}

export const multiply_by_frequency_and_sum = (list_1: number[], frequency_map: Map<number, number>): number => {
    let sum:number = 0;
    list_1.forEach((num: number) => {
        sum += num * (frequency_map.get(num) || 0);
    });

    return sum;
}

export const sub_lists = (list: number[]): number[][] => {
    let sub_lists = [];
    for (let i = 0; i < list.length; i++) {
        sub_lists.push(list.filter((_, index) => index !== i));
    }
    return sub_lists;
}

export const check_list = (list: number[], extra_check: boolean): boolean => {

    let i = 0; let j = 1;
    let prior_sign = Math.sign(list[j] - list[i]);

    while (j < list.length) {
        if (!is_safe(list, i, j, prior_sign)) {
            return false;
        }
        i++; j++;
    }

    return true;
}

export const check_list_v2 = (list: number[]): boolean => {

    let i = 0; let j = 1;
    let prior_sign = Math.sign(list[j] - list[i]);
    let removed_element = false;

    while (j < list.length) {

        let current_sign = Math.sign(list[j] - list[i]);

        if ((!abs_diff_between_1_and_3(list[i], list[j]) || prior_sign !== current_sign)) {
            
            if (!removed_element && !is_safe(list, i, j+1, prior_sign) && (i === 0 || j === list.length - 1)) {
                i++; j++;
                removed_element = true;
                prior_sign = Math.sign(list[j] - list[i]);
                continue;
            }

            if (!removed_element && is_safe(list, i, j+1, prior_sign)) {
                i+=2; j+=2;
                removed_element = true;
                prior_sign = Math.sign(list[j+1] - list[i]);
                continue;
            } else {
                return false;
            }
        } 
        
        prior_sign = Math.sign(list[j] - list[i]);
        i++; j++;
    }

    return true;
}

export const is_safe = (list: number[], index_1: number, index_2: number, prior_sign: number): boolean => {
    const current_sign = Math.sign(list[index_2] - list[index_1]);
    const is_abs_between_1_and_3 = abs_diff_between_1_and_3(list[index_1], list[index_2]);
    const is_matching_sign = current_sign === prior_sign;
    return is_matching_sign && is_abs_between_1_and_3;
}

export const abs_diff_between_1_and_3 = (first: number, second: number): boolean => {
    return Math.abs(first - second) >= 1 && Math.abs(first - second) <= 3;
}