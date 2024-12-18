export const challenge_10 = (input: string[][]): number => {
    let trail_heads = findTrailHeads(input);

    let count = 0;
    for (let i = 0; i < trail_heads.length; i+=1) {
        count += findTrailScore(input, trail_heads[i])[0];
    }

    return count;
}

export const challenge_10_2 = (input: Grid): number => {
    let trail_heads = sumTrailheadRatings(input);
    return trail_heads;
}

type Grid = number[][];
type Memo = Map<string, number>; // Memoization: position + height -> trail count

// Directions for moving up, down, left, right
const DIRECTIONS = [
    [0, 1],   // Right
    [0, -1],  // Left
    [1, 0],   // Down
    [-1, 0],  // Up
];

// Main function to solve Part 2
function sumTrailheadRatings(grid: Grid): number {
    const rows = grid.length;
    const cols = grid[0].length;
    let totalTrails = 0;

    // Memoization cache
    const memo: Memo = new Map();

    // DFS function with backtracking and memoization
    function dfs(row: number, col: number, currentHeight: number): number {
        // Base case: Reached height 9 → Valid trail endpoint
        if (grid[row][col] === 9) return 1;

        // Memoization key for the current position and height
        const key = `${row},${col},${currentHeight}`;
        if (memo.has(key)) return memo.get(key)!;

        let trails = 0;

        // Explore all 4 directions
        for (const [dr, dc] of DIRECTIONS) {
            const newRow = row + dr;
            const newCol = col + dc;

            // Check bounds and ensure height increases by exactly 1
            if (
                newRow >= 0 && newRow < rows &&
                newCol >= 0 && newCol < cols &&
                grid[newRow][newCol] === currentHeight + 1
            ) {
                trails += dfs(newRow, newCol, currentHeight + 1);
            }
        }

        // Cache the result and return
        memo.set(key, trails);
        return trails;
    }

    // Iterate through the grid to find all trailheads (cells with height 0)
    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid[r][c] === 0) {
                // Start DFS from this trailhead
                totalTrails += dfs(r, c, 0);
            }
        }
    }

    return totalTrails;
}


const findTrailScore = (input: string[][], trail_head: number[]): number[] => {
    // perform a depth-first search to find all possible trails
    // for this trail hea. For each down a trail we can only go up, down, 
    // left or right and only if the next position is 1 greater 
    // than the value of the current position.

    let visited_nines = new Set();
    let count = 0;
    let stack = [trail_head];
    let visited = new Set();
    while (stack.length > 0) {
        let current = stack.pop()!;
        let [i, j] = current;
        let value = parseInt(input[i][j]);
        if (value === 9) {
            visited_nines.add(current.toString());
            count+=1;
            continue;
        }
        visited.add(current.toString());
        let neighbors = [[i-1, j], [i+1, j], [i, j-1], [i, j+1]];
        for (let k = 0; k < neighbors.length; k+=1) {
            let [x, y] = neighbors[k];
            if (x >= 0 && x < input.length && y >= 0 && y < input[x].length) {
                let next_value = parseInt(input[x][y]);
                if (next_value === value + 1 && !visited.has([x, y].toString())) {
                    stack.push([x, y]);
                }
            }
        }
    }

    return [visited_nines.size, count];
}

const findTrailHeads = (input: string[][]): number[][] => {
    let trail_heads = [];
    for (let i = 0; i < input.length; i+=1) {
        for (let j = 0; j < input[i].length; j+=1) {
            if (input[i][j] === '0') {
                trail_heads.push([i, j]);
            }
        }
    }
    return trail_heads;
}
