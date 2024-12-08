import { check_x_mas, check_xmas_all_directions } from '../utils/day_4';

export const challenge_4 = (grid: string[][]): number => {
    let sum = 0
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] === 'X') {
                sum += check_xmas_all_directions(grid, i, j);
            }
        }
    }
    return sum;
}

export const challenge_4_2 = (grid: string[][]): number => {
    let sum = 0
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] === 'A') {
                sum += check_x_mas(grid, i, j);
            }
        }
    }
    return sum;
}