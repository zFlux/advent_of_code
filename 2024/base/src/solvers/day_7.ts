import { canProduceValue } from '../utils/day_7';

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