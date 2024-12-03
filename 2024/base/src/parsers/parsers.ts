
export const example = (line: string): number[] => {
    return parse_into_array_of_numbers(line);
}
export const challenge_1 = (line: string): number[] => {
    return parse_into_array_of_numbers(line);
}

export const challenge_2 = (line: string): number[] => {
    return parse_into_array_of_numbers(line);
}

const parse_into_array_of_numbers = (line: string): number[] => {
    return line.split(/\s+/).map((num: string) => parseInt(num));
}