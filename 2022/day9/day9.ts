import * as fs from 'fs';

// create a movement class which has a direction and a distance
class Movement {
    direction: string;
    distance: number;
    constructor(direction: string, distance: number) {
        this.direction = direction;
        this.distance = distance;
    }
}

// create a point class which has an x and a y
class Point {
    x: number;
    y: number;
    constructor(x: number, y: number) {
        this.x = x;
        this.y = y;
    }
}

// function to move a point in a direction
function movePoint(direction: string, point: Point): Point {
    let newPoint: Point = new Point(point.x, point.y);
    switch (direction) {
        case 'U':
        newPoint.y -= 1;
        break;
        case 'D':
        newPoint.y += 1;
        break;
        case 'L':
        newPoint.x -= 1;
        break;
        case 'R':
        newPoint.x += 1;
        break;
    }
    return newPoint;
}

// function to check if one point is in any position surrounding another point
function isSurroundingPoint(point1: Point, point2: Point): boolean {
    return (point1.x === point2.x && point1.y === point2.y) || 
    (point1.x === point2.x && point1.y === point2.y + 1) || 
    (point1.x === point2.x && point1.y === point2.y - 1) || 
    (point1.x === point2.x + 1 && point1.y === point2.y) || 
    (point1.x === point2.x - 1 && point1.y === point2.y) ||
    (point1.x === point2.x + 1 && point1.y === point2.y + 1) ||
    (point1.x === point2.x - 1 && point1.y === point2.y - 1) ||
    (point1.x === point2.x + 1 && point1.y === point2.y - 1) ||
    (point1.x === point2.x - 1 && point1.y === point2.y + 1);
}

function correctFollowingPoint(leadPoint: Point, followPoint: Point): Point  {
    let newPoint: Point = new Point(followPoint.x, followPoint.y);
    if (!isSurroundingPoint(leadPoint, followPoint)) {
        // if the lead point is in the same row or column as the follow point then move 1 towards the lead point
        if (leadPoint.x === followPoint.x) {
            if (leadPoint.y > followPoint.y) {
                newPoint.y += 1;
            } else {
                newPoint.y -= 1;
            }
        } else if (leadPoint.y === followPoint.y) {
            if (leadPoint.x > followPoint.x) {
                newPoint.x += 1;
            } else {
                newPoint.x -= 1;
            }
        } else {
            // if the lead point is not in the same row or column as the follow point then move 1 space diagonally towards the lead point
            if (leadPoint.x > followPoint.x) {
                newPoint.x += 1;
            } else {
                newPoint.x -= 1;
            }
            if (leadPoint.y > followPoint.y) {
                newPoint.y += 1;
            } else {
                newPoint.y -= 1;
            }
        }
    }
    return newPoint;
}

function moveRopeSteps(steps: Movement[], ropePoints: Point[], tailPositions: Map<string, boolean>): Point[] {
    for (let i = 0; i < steps.length; i++) {
        for (let j = 0; j < steps[i].distance; j++) {

            ropePoints[0] = movePoint(steps[i].direction, ropePoints[0]);

            // loop through the remaining position points and correct them
            for (let k = 1; k < ropePoints.length; k++) {
                ropePoints[k] = correctFollowingPoint(ropePoints[k - 1], ropePoints[k]);
                if (k === ropePoints.length-1) tailPositions.set(pointString(ropePoints[k]), true);
            } 
        }
    }
    return ropePoints;
}

// create a function that converts a point to a string
function pointString(point: Point): string {
    return point.x + ',' + point.y;
}

// Main program
const input = fs.readFileSync('input.txt', 'utf8').split('\n').map((line) => {
    return new Movement(line.split(' ')[0], parseInt(line.split(' ')[1]));
});


// Part 1
let tailPositions = new Map<string, boolean>();
let ropePoints = [ { x: 0, y: 0 },{ x: 0, y: 0 }];
ropePoints = moveRopeSteps(input, ropePoints, tailPositions);

// Part 2
let tailPositionsPart2 = new Map<string, boolean>();
let ropePointsPart2 = [ { x: 0, y: 0 }, { x: 0, y: 0 },{ x: 0, y: 0 }, { x: 0, y: 0 },{ x: 0, y: 0 }, { x: 0, y: 0 },{ x: 0, y: 0 }, { x: 0, y: 0 },{ x: 0, y: 0 }, { x: 0, y: 0 } ];
ropePointsPart2 = moveRopeSteps(input, ropePointsPart2, tailPositionsPart2);

console.log("Part 1: " + tailPositions.size);
console.log("Part 2: " + tailPositionsPart2.size);