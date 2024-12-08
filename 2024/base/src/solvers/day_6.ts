import { find_the_start_position, getNextPosition, hasCycle } from '../utils/day_6';

export const challenge_6 = (grid: string[][]): number | string => {
    let start = find_the_start_position(grid);
    let visited_positions = new Set<string>();
    if (!start) return 0;
    let [i, j, direction] = start;
    visited_positions.add(`${i},${j}`);
    
    let nextPosition = getNextPosition(grid, [i, j, direction]);

    while (nextPosition) {
        [i, j, direction] = nextPosition;
        visited_positions.add(`${i},${j}`);
        nextPosition = getNextPosition(grid, [i, j, direction]);
    }

    return visited_positions.size;
}

export const challenge_6_2 = (grid: string[][]): number => {
    let obstruction_count = 0;
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] === '.') {
                grid[i][j] = '#';
                if (hasCycle(grid)) {
                    obstruction_count += 1;
                }
                grid[i][j] = '.';
            }
        }
    }

    return obstruction_count;
}