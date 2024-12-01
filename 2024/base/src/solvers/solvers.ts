export const example = (input: number[][]): number => {
    return input[0][0] + input[0][1];
}

export const challenge_1 = (input: number[][]): number => {
    const list_1 = input.map((list: number[]) => list[0]);
    const list_2 = input.map((list: number[]) => list[1]);
    const sorted = [list_1.sort((a, b) => a - b), list_2.sort((a, b) => a - b)];
    let sum = 0;
    for (let i = 0; i < sorted[0].length; i++) {
        sum += Math.abs(sorted[0][i] - sorted[1][i]);
    }
    return sum;
}

export const challenge_1_2 = (input: number[][]): number => {
    const list_1 = input.map((list: number[]) => list[0]);
    const list_2 = input.map((list: number[]) => list[1]);
    
    // create a hashmap using the second list. The key is the number and the value is the number of times it appears
    const list_2_map = new Map<number, number>();
    list_2.forEach((num: number) => {
        list_2_map.set(num, (list_2_map.get(num) || 0) + 1);
    });

    // using the list_2_map to multiply each number in list_1 by the number of times it appears in list_2
    let sum = 0;
    list_1.forEach((num: number) => {
        sum += num * (list_2_map.get(num) || 0);
    });

    return sum;
}

