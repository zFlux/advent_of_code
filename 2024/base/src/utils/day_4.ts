export const check_x_mas = (grid: string[][], x: number, y: number): number => {
    const mas_map: { [key: string]: string } = {'M': 'S', 'S': 'M'}
    
    if (x - 1 >= 0 && y - 1 >= 0 && x + 1 < grid.length && y + 1 < grid[0].length) {
        if (mas_map[grid[x - 1][y + 1]] === grid[x + 1][y - 1] && mas_map[grid[x + 1][y + 1]] === grid[x - 1][y - 1]) {
            return 1;
        }
    }
    return 0;
}

export const check_xmas = (grid: string[][], x: number, y: number, direction: number): number => {
    const lower_boundary = grid.length - 1;
    const right_boundary = grid[0].length - 1;
    const word = ['X', 'M', 'A', 'S'];
    let char_position = 1;

    while (char_position < word.length) {
        let next_coordinates = move_direction(direction, x, y, lower_boundary, right_boundary);
        if (next_coordinates === false) {
            return 0;
        } else {
            next_coordinates = next_coordinates as [number, number];
            if (grid[next_coordinates[0]][next_coordinates[1]] === word[char_position]) {
                char_position += 1;
                x = next_coordinates[0];
                y = next_coordinates[1];
            } else {
                return 0;
            }
        }
    }
    return 1;
}

export const check_xmas_all_directions = (grid: string[][], x: number, y: number): number => {
    let sum = 0;
    sum += check_xmas(grid, x, y, UP);
    sum += check_xmas(grid, x, y, UP_RIGHT);
    sum += check_xmas(grid, x, y, RIGHT);
    sum += check_xmas(grid, x, y, DOWN_RIGHT);
    sum += check_xmas(grid, x, y, DOWN);
    sum += check_xmas(grid, x, y, DOWN_LEFT);
    sum += check_xmas(grid, x, y, LEFT);
    sum += check_xmas(grid, x, y, UP_LEFT);
    return sum;
}

const UP = 0;
const UP_RIGHT = 1;
const RIGHT = 2;
const DOWN_RIGHT = 3;
const DOWN = 4;
const DOWN_LEFT = 5;
const LEFT = 6;
const UP_LEFT = 7;

export const move_direction = (direction: number, x: number, y: number, lower_boundary: number, right_boundary: number): [number, number] | boolean => {
    const upper_boundary = 0;
    const left_boundary = 0;

    switch (direction) {
        case UP:
            return y - 1 < upper_boundary ? false : [x, y - 1];
        case UP_RIGHT:
            return x + 1 > right_boundary || y - 1 < upper_boundary ? false : [x + 1, y - 1];
        case RIGHT:
            return x + 1 > right_boundary ? false : [x + 1, y];
        case DOWN_RIGHT:
            return x + 1 > right_boundary || y + 1 > lower_boundary ? false : [x + 1, y + 1];
        case DOWN:
            return y + 1 > lower_boundary ? false : [x, y + 1];
        case DOWN_LEFT:
            return x - 1 < left_boundary || y + 1 > lower_boundary ? false : [x - 1, y + 1];
        case LEFT:
            return x - 1 < left_boundary ? false : [x - 1, y];
        case UP_LEFT:
            return x - 1 < left_boundary || y - 1 < upper_boundary ? false : [x - 1, y - 1];
        default:
            return false;
    }
}