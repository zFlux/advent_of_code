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