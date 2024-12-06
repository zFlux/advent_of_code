import { endianness } from "os";

export const example = (line: string): number[] => {
    return parse_into_array_of_numbers(line);
}
export const challenge_1 = (line: string): number[] => {
    return parse_into_array_of_numbers(line);
}

export const challenge_2 = (line: string): number[] => {
    return parse_into_array_of_numbers(line);
}

export const challenge_3 = (line: string): RegExpMatchArray | null  => {
    const regex = /mul\(\d{1,3},\d{1,3}\)/g;
    let result = line.match(regex);
    return result
}

export const challenge_3_2 = (line: string): RegExpMatchArray | null  => {
    const regex = /mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/g;
    let result = line.match(regex);
    return result
}

export const challenge_4 = (line: string): string[] => {
    return line.split('');
}

export const challenge_5 = (line: string): number[] | string => {
    // check if the line is of the form ##|## and split it into an array of numbers
    if (line.match(/\d{2}\|\d{2}/)) {
        return line.split('|').map((num: string) => parseInt(num));
    }
    // check if the line is of any number of numbers separated by commas and split it into an array of numbers
    else if (line.match(/\d+(,\d+)+/)) {
        return line.split(',').map((num: string) => parseInt(num));
    } else {
        return 'End';
    }
}

const parse_into_array_of_numbers = (line: string): number[] => {
    return line.split(/\s+/).map((num: string) => parseInt(num));
}