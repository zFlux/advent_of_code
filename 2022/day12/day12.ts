
import * as fs from 'fs';
const heightMap = fs.readFileSync('input.txt', 'utf8').split('\n').map(line => line.split(''));

class Position {
    x: number;
    y: number;
    constructor(x: number, y: number) {
        this.x = x;
        this.y = y;
    }
}

class PositionPath {
    position: Position;
    path: Position[];
    constructor(position: Position, path: Position[]) {
        this.position = position;
        this.path = path;
    }
}

const findPosition = (character: string): Position => {
    for (let y = 0; y < heightMap.length; y++) {
        for (let x = 0; x < heightMap[y].length; x++) {
            if (heightMap[y][x] === character) {
                return { x, y };
            }
        }
    }
    return { x: 0, y: 0 };
};

const startPosition: Position = findPosition('S');
const endPosition: Position = findPosition('E');

// replace startPosition with the character a and endPosition with the character z
heightMap[startPosition.y][startPosition.x] = 'a';
heightMap[endPosition.y][endPosition.x] = 'z';

// using the startPosition as a starting point, implement a breadth first search to find the shortest
// path to the endPosition. The path should be a list of positions that the player should move to
// in order to reach the endPosition.



const findPath = (startPosition: Position, endPosition: Position) => {
    const queue: PositionPath[] = [];
    const visited = new Set();
    queue.push({ position: startPosition, path: [] });

    while (queue.length > 0) {
        // destructure the position and path from the queue
        const current = queue.shift();
        if (current === undefined) continue;
        const { position, path } = current;
        if (position.x === endPosition.x && position.y === endPosition.y) return path;
        if (visited.has(`${position.x},${position.y}`)) continue;
        visited.add(`${position.x},${position.y}`);

        const { x, y } = position;
        const currentHeight = heightMap[y][x];
        if (heightMap[y][x - 1] && currentHeight.charCodeAt(0) + 1 >= heightMap[y][x - 1].charCodeAt(0)) {
            queue.push({ position: { x: x - 1, y }, path: path.concat({ x: x - 1, y }) });
        }

        if (heightMap[y][x + 1] && currentHeight.charCodeAt(0) + 1 >= heightMap[y][x + 1].charCodeAt(0)) {
            queue.push({ position: { x: x + 1, y }, path: path.concat({ x: x + 1, y }) });
        }

        if (heightMap[y - 1] && currentHeight.charCodeAt(0) + 1 >= heightMap[y - 1][x].charCodeAt(0)) {
            queue.push({ position: { x, y: y - 1 }, path: path.concat({ x, y: y - 1 }) });
        }

        if (heightMap[y + 1] && currentHeight.charCodeAt(0) + 1 >= heightMap[y + 1][x].charCodeAt(0)) {
            queue.push({ position: { x, y: y + 1 }, path: path.concat({ x, y: y + 1 }) });
        }
    }

    return null;
};

const findAPositions = () => {
    const aPositions: Position[] = [];
    for (let y = 0; y < heightMap.length; y++) {
        for (let x = 0; x < heightMap[y].length; x++) {
            if (heightMap[y][x] === 'a') {
                aPositions.push({ x, y });
            }
        }
    }
    return aPositions;
}

const part1 = findPath(startPosition, endPosition);
console.log(part1?.length);
const aPositions = findAPositions();
const shortestPaths = aPositions.map(aPosition => 
    {
        const path = findPath(aPosition, endPosition);
        return path ? path.length : Number.MAX_SAFE_INTEGER;
    }
);
const part2 = Math.min(...shortestPaths);
console.log(part2);