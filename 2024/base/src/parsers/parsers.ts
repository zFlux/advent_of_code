import { endianness } from "os";

export const example = (line: string, line_number: number): number[] => {
    return parse_into_array_of_numbers(line);
}
export const challenge_1 = (line: string, line_number: number): number[] => {
    return parse_into_array_of_numbers(line);
}

export const challenge_2 = (line: string, line_number: number): number[] => {
    return parse_into_array_of_numbers(line);
}

export const challenge_3 = (line: string, line_number: number): RegExpMatchArray | null  => {
    const regex = /mul\(\d{1,3},\d{1,3}\)/g;
    let result = line.match(regex);
    return result
}

export const challenge_3_2 = (line: string, line_number: number): RegExpMatchArray | null  => {
    const regex = /mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/g;
    let result = line.match(regex);
    return result
}

export const challenge_4 = (line: string, line_number: number): string[] => {
    return line.split('');
}

export const challenge_5 = (line: string, line_number: number): number[] | string => {
    // check if the line is of the form ##|## and split it into an array of numbers
    if (line.match(/\d{2}\|\d{2}/)) {
        return line.split('|').map((num: string, line_number: number) => parseInt(num));
    }
    // check if the line is of any number of numbers separated by commas and split it into an array of numbers
    else if (line.match(/\d+(,\d+)+/)) {
        return line.split(',').map((num: string, line_number: number) => parseInt(num));
    } else {
        return 'End';
    }
}

type GridResult = {
    start_position: number[];
    list: number[];
};

const challenge_6 = (line: string, line_num: number): GridResult  => {
    let start_position: number[] = [];
    let line_list = parse_into_array_of_numbers(line);

    if (line_list.includes(94)) {
        start_position = [line_list.indexOf(94), line_num];
    }
    return {start_position: start_position, list: line_list};
}

const parse_into_array_of_numbers = (line: string): number[] => {
    return line.split(/\s+/).map((num: string) => parseInt(num));
}