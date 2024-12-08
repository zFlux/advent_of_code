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

export const is_safe = (list: number[], index_1: number, index_2: number, prior_sign: number): boolean => {
    const current_sign = Math.sign(list[index_2] - list[index_1]);
    const is_abs_between_1_and_3 = abs_diff_between_1_and_3(list[index_1], list[index_2]);
    const is_matching_sign = current_sign === prior_sign;
    return is_matching_sign && is_abs_between_1_and_3;
}

export const abs_diff_between_1_and_3 = (first: number, second: number): boolean => {
    return Math.abs(first - second) >= 1 && Math.abs(first - second) <= 3;
}