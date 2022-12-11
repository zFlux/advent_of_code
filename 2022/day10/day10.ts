import { readFileSync } from "fs";

// create a map that maps 'noop' to the number 1 and 'addx' to the number 2
const cycleLengthMap = new Map<string, number>([
    ['noop', 1],
    ['addx', 2]
]);

// function to check if a number is 20 + 40n where n is zero or greater
const is20Plus40n = (n: number) => (n - 20) % 40 === 0;

// Read the input_sample.txt file into an array of string pairs, the first string is a 
// command and the second is an argument or undefined
const input = readFileSync('input.txt', 'utf8').split('\n').map((line) => {
    const [command, argument] = line.split(" ");
    return [command, argument, cycleLengthMap.get(command)];
});

// loop through the input array and execute the commands
let index = 0;
let register = 1;
let tick = 0;
let signalStrengthSums = 0;
const pixles: string[] = [];
while (index < input.length) {
    const [command, argument, cycles] = input[index];
    // loop down through the number of cycles
    for (let i = Number(cycles); i > 0; i--) {
        pixles[tick] = (register + 1 === (tick % 40) || register - 1 === (tick % 40)|| register === (tick % 40)) ? '#' : '.';
        tick++;
        if (is20Plus40n(tick)) {
            signalStrengthSums+= register * tick;
        }
    }
    // after the tick loop, execute the command
    switch (command) {
        case 'addx':
            register += Number(argument);
            break;
    }
    index++;
}

console.log("Part 1: " + signalStrengthSums);

console.log("Part 2:");
// print each 40 pixles on a new line
for (let i = 0; i < pixles.length; i += 40) {
    console.log(pixles.slice(i, i + 40).join(''));
}