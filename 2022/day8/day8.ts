import * as fs from 'fs';

let input = fs.readFileSync('input.txt', 'utf8').split('\n');

// convert the input into a 2D array of numbers
let inputArray = input.map((row) => {
    return row.split('').map((number) => {
        return parseInt(number);
    });
});

// a function to determine if a tree is visible from outside the grid along with its visibility score
function isTreeVisible(x: number, y: number): {visible: boolean, score: number} {
    // if the tree is at the edge of the grid, it is visible
    if (x === 0 || y === 0 || x === inputArray.length - 1 || y === inputArray.length - 1) {
        return {visible: true, score: 0};
    }

    // create visible variables for each direction
    let visibleUp = true;
    let visibleDown = true;
    let visibleLeft = true;
    let visibleRight = true;

    // create variables for the visible distance in each direction
    let visibleDistanceUp = 0;
    let visibleDistanceDown = 0;
    let visibleDistanceLeft = 0;
    let visibleDistanceRight = 0;

    // check if all trees above the current tree are smaller than the current tree
    for (let i = y - 1; i >= 0 && visibleUp; i--) {
        if (inputArray[i][x] >= inputArray[y][x]) {
            visibleUp = false;
            // record the distance to the first tree that is equal or smaller than the current tree
            visibleDistanceUp = y - i;
        }
        // if the tree is at the of the grid also record its distance
        if (i === 0) {
            visibleDistanceUp = y - i;
        }
    }
    // check if all trees below the current tree are smaller than the current tree
    for (let i = y + 1; i < inputArray.length && visibleDown; i++) {
        if (inputArray[i][x] >= inputArray[y][x]) {
            visibleDown = false;
            // record the distance to the first tree that is equal or smaller than the current tree
            visibleDistanceDown = i - y;
        }
        // if the tree is at the of the grid also record its distance
        if (i === inputArray.length - 1) {
            visibleDistanceDown = i - y;
        }
    }
    // check if all trees to the left of the current tree are smaller than the current tree
    for (let i = x - 1; i >= 0 && visibleLeft; i--) {
        if (inputArray[y][i] >= inputArray[y][x]) {
            visibleLeft = false;
            // record the distance to the first tree that is equal or smaller than the current tree
            visibleDistanceLeft = x - i;
        }
        // if the tree is at the of the grid also record its distance
        if (i === 0) {
            visibleDistanceLeft = x - i;
        }
    }
    // check if all trees to the right of the current tree are smaller than the current tree
    for (let i = x + 1; i < inputArray.length && visibleRight; i++) {
        if (inputArray[y][i] >= inputArray[y][x]) {
            visibleRight = false;
            // record the distance to the first tree that is equal or smaller than the current tree
            visibleDistanceRight = i - x;
        }
        // if the tree is at the of the grid also record its distance
        if (i === inputArray.length - 1) {
            visibleDistanceRight = i - x;
        }
    }

    // if any of the directions are visible, the tree is visible
    return {visible: visibleUp || visibleDown || visibleLeft || visibleRight, score: visibleDistanceUp * visibleDistanceDown * visibleDistanceLeft * visibleDistanceRight};
}

// loop through the inputArray and count the number of trees that are visible
let visibleTrees = 0;
let maxScore = 0;
for (let y = 0; y < inputArray.length; y++) {
    for (let x = 0; x < inputArray.length; x++) {
        let result = isTreeVisible(x, y);
        if (result.visible) {
            visibleTrees++;
        }
        if (result.score > maxScore) {
            maxScore = result.score;
        }
    }
}

console.log("Part 1: " + visibleTrees);
console.log("Part 2: " + maxScore);






