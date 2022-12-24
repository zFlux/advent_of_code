import * as fs from 'fs';

const drawPath = (coords: number[][], grid: number[][]) => {
    for (let i = 1; i < coords.length; i++) {
        if (coords[i-1][0] === coords[i][0]) {
            for (let y = Math.min(coords[i-1][1], coords[i][1]); y <= Math.max(coords[i-1][1], coords[i][1]); y++) {
                grid[coords[i-1][0]][y] = 1;
            }
        }
        else if (coords[i-1][1] === coords[i][1]) {
            for (let x = Math.min(coords[i-1][0], coords[i][0]); x <= Math.max(coords[i-1][0], coords[i][0]); x++) {
                grid[x][coords[i-1][1]] = 1;
            }
        }
    }
}

const printGrid = (grid: number[][], minX: number = 0, maxX: number = 600, minY: number = 0, maxY: number = 600) => {
    for (let y = minY; y < maxY; y++) {
        let line = '';
        for (let x = minX; x < maxX; x++) {
            if (grid[x][y] === 0) {
                line += '.';
            } else if (grid[x][y] === 1) {
                line += '#';
            } else if (grid[x][y] === 2) {
                line += '+';
            } else if (grid[x][y] === 3) {
                line += 'o';
            } else if (grid[x][y] === 4) {
                line += '~';
            }
        }
        console.log(line);
    }
}

const dropSand = (grid: number[][], source: number[], record: boolean): boolean => {
    let pos = source;

    while (pos[1] < grid[0].length - 1) {
        if (grid[pos[0]][pos[1] + 1] === 0) {
            pos = [pos[0], pos[1] + 1];
            if (record) grid[pos[0]][pos[1]] = 4;
        }
        else {
            if (grid[pos[0] - 1][pos[1] + 1] === 0) {
                pos = [pos[0] - 1, pos[1] + 1];
                if (record) grid[pos[0]][pos[1]] = 4;
            }
            else if (grid[pos[0] + 1][pos[1] + 1] === 0) {
                pos = [pos[0] + 1, pos[1] + 1];
                if (record) grid[pos[0]][pos[1]] = 4;
            }
            // else if the grid position is still the starting position return false
            else if (pos[0] === source[0] && pos[1] === source[1]) {
                grid[pos[0]][pos[1]] = 3;
                return false;
            }
            else {
                grid[pos[0]][pos[1]] = 3;
                return true;
            }

        }
    }
    return false;
}

// Main program
const main = async () => {

    const input = fs.readFileSync('input.txt', 'utf8').split('\n');
    const coordinates = input.map((line) => line.split('->').map((coord) => coord.split(',').map((num) => parseInt(num, 10))));
    let grid = Array.from(Array(800), () => new Array(800).fill(0));
    coordinates.forEach((coords) => drawPath(coords, grid));
    grid[500][0] = 2;

    // Part 1
    let stoppedGrains = 0;
    while (dropSand(grid, [500, 0], false)) {
        stoppedGrains++;
        // Fun text animation
        // printGrid(grid, 493, 504, 0, 13);
        // await new Promise((resolve) => setTimeout(resolve, 500));
        //console.log('\x1Bc');
    };
    dropSand(grid, [500, 0], true);
    printGrid(grid, 493, 504, 0, 13);
    console.log('Part 1: ' + stoppedGrains);

    // Part 2
    grid = Array.from(Array(800), () => new Array(800).fill(0));
    coordinates.forEach((coords) => drawPath(coords, grid));
    grid[500][0] = 2;
    stoppedGrains = 0;
    // find the highest row with a 1
    let highestRow = 0;
    // search through grid and find the highest y position
    for (let y = 0; y < grid[0].length; y++) {
        for (let x = 0; x < grid.length; x++) {
            if (grid[x][y] === 1) {
                highestRow = y;
                break;
            }
        }
    }

    // create path starting at the highest row plus two 
    // and moving the entire width of the grid
    const path = [];
    path.push([0, highestRow + 2], [grid.length - 1, highestRow + 2]);
    drawPath(path, grid);

    stoppedGrains = 0;
    while (dropSand(grid, [500, 0], false)) {
        stoppedGrains++;
        // Fun text animation
        // printGrid(grid, 470, 554, 0, 13);
        // await new Promise((resolve) => setTimeout(resolve, 500));
        // console.log('\x1Bc');
    };
    printGrid(grid, 470, 554, 0, 13);
    console.log('Part 2: ' + (stoppedGrains + 1));

}

main();
