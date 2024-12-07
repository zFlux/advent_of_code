// Floyd's cycle-finding algorithm
export const hasCycle = (grid: string[][]): boolean => {
    let slow = find_the_start_position(grid);
    let fast = find_the_start_position(grid);

    while (slow && fast) {
        slow = getNextPosition(grid, slow);

        // fast moves twice as fast as slow
        fast = getNextPosition(grid, fast);
        if (!fast) break;
        fast = getNextPosition(grid, fast);

        // if the positions are the same, then there is a cycle according to floyds alogo
        if (slow && fast && slow[0] === fast[0] && slow[1] === fast[1] && slow[2] === fast[2]) {
            return true;
        }
    }

    return false;
}

export const getNextPosition = (grid: string[][], position: [number, number, string]): [number, number, string] | null => {
    let [i, j, direction] = position;

    if (direction === '^' && i - 1 >= 0) {
        if (grid[i - 1][j] !== '#') {
            return [i - 1, j, '^'];
        } else {
            return [i, j, '>'];
        }
    } else if (direction === '>' && j + 1 < grid[i].length) {
        if (grid[i][j + 1] !== '#') {
            return [i, j + 1, '>'];
        } else {
            return [i, j, 'v'];
        }
    } else if (direction === 'v' && i + 1 < grid.length) {
        if (grid[i + 1][j] !== '#') {
            return [i + 1, j, 'v'];
        } else {
            return [i, j, '<'];
        }
    } else if (direction === '<' && j - 1 >= 0) {
        if (grid[i][j - 1] !== '#') {
            return [i, j - 1, '<'];
        } else {
            return [i, j, '^'];
        }
    }

    return null;
}

export const print_grid = (grid: string[][]): void => {
    // build the grid as a formatted string
    let grid_str = '';
    for (let i = 0; i < grid.length; i++) {
        grid_str += grid[i].join('') + '\n';
    }
}    

export const find_the_start_position = (grid: string[][]): [number, number, string] | null => {
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            if (grid[i][j] === '^') {
                return [i, j, '^'];
            }
        }
    }
    return null;
}