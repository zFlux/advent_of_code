import * as fs from 'fs';

const findDistance = (x1:number, y1:number, x2:number, y2:number) => {
    return Math.abs(x1 - x2) + Math.abs(y1 - y2);
}

const findRangeSize = (r: Range) => {
    return Math.abs(r.x2 - r.x1);
}

class Sensor {
    x: number;
    y: number;
    closestBeacon: {x: number, y: number, distance: number};
    constructor(x: number, y: number, beaconX: number, beaconY: number) {
        this.x = x;
        this.y = y;
        this.closestBeacon = {x: beaconX, y: beaconY, distance:findDistance(x, y, beaconX, beaconY)};
    }
}

class Range {
    x1: number;
    x2: number;
    constructor(x1: number, x2: number) {
        this.x1 = x1;
        this.x2 = x2;
    }
}

const sensors: Sensor[] = [];
const input = fs.readFileSync('input.txt', 'utf8').split('\n');
input.forEach(line => {
    const matches = line.match(/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/);
    if (matches) {
        sensors.push(
            new Sensor(parseInt(matches[1]), parseInt(matches[2]), 
            parseInt(matches[3]), parseInt(matches[4])));
        }
});

const findBeaconlessRange = (sensor: Sensor, y:number): Range | undefined => {
    const queryDist = Math.abs(y - sensor.y);
    if (queryDist > sensor.closestBeacon.distance) return undefined;
    const manhattanX = sensor.closestBeacon.distance - queryDist;
    return new Range(sensor.x - manhattanX, sensor.x + manhattanX);
}

let knownBeacons: Set<string> = new Set<string>();
sensors.forEach( sensor => {
    knownBeacons.add(`${sensor.closestBeacon.x},${sensor.closestBeacon.y}`);
})

const findBeaconlessRanges = (sensors: Sensor[], y:number): Range[] => {
    // list of ranges that are beaconless
    let beaconlessRanges: Range[] = [];
    sensors.forEach( sensor => {
        const newRange = findBeaconlessRange(sensor, y);
        if (newRange) {
            if (beaconlessRanges.length === 0) beaconlessRanges.push(newRange);
            else {
                let newBeaconlessRanges: Range[] = [];
                let merged = false;
                for(let i = 0; i < beaconlessRanges.length; i++) {
                    const range = beaconlessRanges[i];
                    if (range.x2 < newRange.x1 - 1 || range.x1 > newRange.x2 + 1) {
                        newBeaconlessRanges.push(range);
                    } else {
                        merged = true;
                        newRange.x1 = Math.min(range.x1, newRange.x1);
                        newRange.x2 = Math.max(range.x2, newRange.x2);
                    }                
                }
                newBeaconlessRanges.push(newRange);
                beaconlessRanges = newBeaconlessRanges;
            }
        }
    });

    let resultSum = 0;
    beaconlessRanges.forEach( range => {
        resultSum+= Math.abs(range.x2 - range.x1) + 1;
        knownBeacons.forEach( beacon => {
            const beaconX = parseInt(beacon.split(',')[0]);
            const beaconY = parseInt(beacon.split(',')[1]);
            if (beaconX >= range.x1 && beaconX <= range.x2 && beaconY === y) resultSum--;
        });
    });

    return beaconlessRanges;
};

const ranges = findBeaconlessRanges(sensors, 10);
console.log(`Part 1: ${findRangeSize(ranges[0])}`);

// Part 2
const findBeaconRanges = (beaconless: Range[], searchArea: Range, row:number, result: {x: number, y: number}) => {
    // if the beaconless ranges are greater than 1 then find the ranges that are between 
    // beaconless ranges
    if (beaconless.length > 1) {
        for(let i = 0; i < beaconless.length - 1; i++) {
            const range1 = beaconless[i];
            const range2 = beaconless[i+1];
            if (range1.x2 < range2.x1 - 1) {
                const newRange = new Range(range1.x2 + 1, range2.x1 - 1);
                if (newRange.x1 >= searchArea.x1 && newRange.x2 <= searchArea.x2) {
                    result.x = newRange.x1, 
                    result.y = row;
                    return;
                }
            }
        }
    } 
    return result;
}

let beaconRanges: {x: number, y: number} = {x: 0, y: 0};
for (let i = 0; i < 4_000_000; i++) {
    const beaconlessRanges = findBeaconlessRanges(sensors, i);
    if (beaconlessRanges.length > 1) {
        findBeaconRanges(beaconlessRanges, new Range(0, 4_000_000), i, beaconRanges);
    }
}
console.log(`Part 2: ${beaconRanges.x * 4_000_000 + beaconRanges.y}`);

