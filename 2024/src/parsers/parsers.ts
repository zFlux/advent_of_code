const parse_into_array_of_numbers = (line: string): number[] => {
    return line.split(/\s+/).map((num: string) => parseInt(num));
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

export const challenge_6 = (line: string): string[]  => {
    return line.split('');
}

export const challenge_7 = (line: string): (number | number[])[] => {
    // parse a line that looks like this 3267: 81 40 27
    // where the first number is a single value and the rest are an array of numbers
    let parts = line.split(': ');
    let first = parseInt(parts[0]);
    let rest = parts[1].split(/\s+/).map((num: string) => parseInt(num));
    return [first, rest];
}

export const challenge_8 = (line: string): string[] => {
    return line.split('');
}

export const challenge_9 = (line: string): number[] => {
    return line.split('').map((num: string) => parseInt(num));
}

