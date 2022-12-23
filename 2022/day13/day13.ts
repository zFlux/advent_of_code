import * as fs from "fs";
const input = fs.readFileSync('input.txt', 'utf8').split(/\n/);

type ValueOrArray<T> = T | ArrayOfValueOrArray<T>;
interface ArrayOfValueOrArray<T> extends Array<ValueOrArray<T>> { }

function parse(input: string): ArrayOfValueOrArray<number> | undefined {

    let stack: ArrayOfValueOrArray<number>[] = [];

    for (let i = 0; i < input.length; i++) {
        if (input[i] === '[') {
            let newList: ArrayOfValueOrArray<number> = [];
            stack.push(newList);
            if (stack.length > 1) {
                stack[stack.length - 2].push(newList);
            }
        } else if (input[i] === ']') {
            if (stack.length === 1) return stack[0];
            else stack.pop();
        }
        else if (input[i] === ',') {
            continue;
        } else {
            if (input[i + 1] && input[i + 1].match(/[0-9]/)) {
                let value = parseInt(input[i] + input[i + 1]);
                stack[stack.length - 1].push(value);   
            } else {
                let value = parseInt(input[i]);
                stack[stack.length - 1].push(value);
            }
        }
    }

    return undefined;
}

// Parse the input into a list of ArrayOfValueOrArray<number>
let packets = input.map(parse).filter((x): x is ArrayOfValueOrArray<number> => x !== undefined);

// function packetCompare that takes a left and a right packet
function comparePacket(leftPacket: ArrayOfValueOrArray<number>, rightPacket: ArrayOfValueOrArray<number>): number {

    if (typeof leftPacket === 'number' && typeof rightPacket === 'number') {
        if ( leftPacket < rightPacket) {
            return 1;
        } else if (leftPacket > rightPacket) {
            return -1;
        } else return 0;
    }

    if (Array.isArray(leftPacket) && typeof rightPacket === 'number') {
        return comparePacket(leftPacket, [rightPacket]);
    }   
    if (Array.isArray(rightPacket) && typeof leftPacket === 'number') {
        return comparePacket([leftPacket], rightPacket);
    }

    if (Array.isArray(leftPacket) && Array.isArray(rightPacket)) {
        let i = 0;
        while (i < leftPacket.length && i < rightPacket.length) {
            let result = comparePacket(leftPacket[i] as ArrayOfValueOrArray<number>, rightPacket[i] as ArrayOfValueOrArray<number>);
            if (result !== 0) {
                return result;
            }
            i++;
        }

        if (i === leftPacket.length && i < rightPacket.length) {
            return 1;
        } else if (i === rightPacket.length && i < leftPacket.length) {
            return -1;
        } else return 0;
    }

    return 0;
}

// Part 1
let resultList:number[] = [];
for (let i = 0; i < packets.length; i+=2) {
    let leftPacket = packets[i];
    let rightPacket = packets[i + 1];
    let result = comparePacket(leftPacket, rightPacket);
    if (result === 1) {
        resultList.push((i+2)/2)
    }
}
let result = resultList.reduce((acc, curr) => acc + curr, 0);
console.log('Part 1: ' + result);

// Part 2
packets.push([[2]]);
packets.push([[6]]);
packets.sort((packet1, packet2) => comparePacket(packet2, packet1));
let index2 = packets.findIndex((packet) => comparePacket(packet, [[2]]) === 0);
let index6 = packets.findIndex((packet) => comparePacket(packet, [[6]]) === 0);
console.log('Part 2: ' + (index2 + 1) * (index6 + 1));
