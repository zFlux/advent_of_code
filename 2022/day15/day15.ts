import * as fs from 'fs';

const findDistance = (x1:number, y1:number, x2:number, y2:number) => {
    return Math.abs(x1 - x2) + Math.abs(y1 - y2);
}

class Sensor {
    x: number;
    y: number;
    closestBeacon: {x: number, y: number, distance?: number};
    constructor(x: number, y: number, beaconX: number, beaconY: number) {
        this.x = x;
        this.y = y;
        this.closestBeacon = {x: beaconX, y: beaconY, distance:findDistance(x, y, beaconX, beaconY)};
    }
}

const sensors: Sensor[] = [];
const input = fs.readFileSync('input.txt', 'utf8').split('\n');
input.forEach(line => {
    const matches = line.match(/Sensor at x=(\d+), y=(\d+): closest beacon is at x=(\d+), y=(\d+)/);
    if (matches) {
        sensors.push(
            new Sensor(parseInt(matches[1]), parseInt(matches[2]), 
            parseInt(matches[3]), parseInt(matches[4])));
        }
});

const findBeaconlessCoordsAlongY = (sensor: Sensor, y:number, beaconLess: Set<string>,  knownBeacons: Set<string> ): Set<string> => {
    // find the distance from the query y to the sensor y
    const queryDist = Math.abs(y - sensor.y);
    // if the query distance is greater than the closest beacon distance
    // then no point can be ruled out as beaconless
    if (queryDist > sensor.closestBeacon.distance) return beaconLess;
    // if it's equal only the point at sensor's x is beaconless
    // except if it's a known beacon
    const point = sensor.x.toString() + ',' + y.toString()
    if(!knownBeacons.has(point)) beaconLess.add(point);
    for (let i = 1; i <= sensor.closestBeacon.distance - queryDist; i++) {
        const pointPlus = (sensor.x + i).toString() + ',' + y.toString();
        const pointMinus = (sensor.x - i).toString() + ',' + y.toString();
        if(!knownBeacons.has(pointPlus)) beaconLess.add(pointPlus);
        if(!knownBeacons.has(pointMinus)) beaconLess.add(pointMinus);
    }

    return beaconLess;
}

let result: Set<string> = new Set<string>();
let knownBeacons: Set<string> = new Set<string>();
sensors.forEach( sensor => {
    knownBeacons.add(sensor.closestBeacon.x.toString() + ',' + sensor.closestBeacon.y.toString());
})
sensors.forEach( sensor => {
    result = findBeaconlessCoordsAlongY(sensor, 2000000, result, knownBeacons);
})

console.log('Part 1: ' + result.size);

