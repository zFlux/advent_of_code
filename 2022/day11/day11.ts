class Monkey {
    items: number[];
    failTestMonkey: number;
    passTestMonkey: number;
    operation: (n: number) => number;
    testDivisor: number;
    itemsInspected: number = 0;

    constructor(items: number[], failTestMonkey: number, passTestMonkey: number, 
        operation: (n: number) => number, testDivisor: number) {
        this.items = items;
        this.failTestMonkey = failTestMonkey;
        this.passTestMonkey = passTestMonkey;
        this.operation = operation;
        this.testDivisor = testDivisor;
    }
}

function readInputFile(file: string): Monkey[] {
    const fs = require('fs');
    const input = fs.readFileSync(file, 'utf8');
    const lines = input.split('\n');
    const monkeys: Monkey[] = [];
    for (let i = 0; i < lines.length; i += 7) {
        const monkeyId = parseInt(lines[i].split(' ')[1]);
        const items = lines[i + 1].split(' ').slice(4).map((n: string) => parseInt(n));
        const operation = createOperationFunction(lines[i + 2].split('=')[1].trim().split(' '));
        const testOperation = lines[i + 3].split(' ');
        const testDivisor = parseInt(testOperation[5]);
        const passTestMonkey = parseInt(lines[i + 4].split(' ')[9]);
        const failTestMonkey = parseInt(lines[i + 5].split(' ')[9]);
        monkeys[monkeyId] = new Monkey(items, failTestMonkey, passTestMonkey, operation, testDivisor);
    }
    return monkeys;
}

function createOperationFunction(operation: string[]): (n: number) => number {
    if (operation[1] === '*') {
        if (operation[0] === 'old' && operation[2] === 'old') {
            return (n: number) => n * n;
        } else if (operation[0] === 'old') {
            return (n: number) => n * parseInt(operation[2]);
        } else return (n: number) => parseInt(operation[0]) * parseInt(operation[2]);
    } else if (operation[1] === '+') {
        if (operation[0] === 'old' && operation[2] === 'old') {
            return (n: number) => n + n;
        } else if (operation[0] === 'old') {
            return (n: number) => n + parseInt(operation[2]);
        } else return (n: number) => parseInt(operation[0]) + parseInt(operation[2]);
    }
    return (n: number) => 0;
}

function executeMonkeyAntics(monkeys: Monkey[], monkeyIndex: number, gcdOfTestDivisors: number) {
    const monkey = monkeys[monkeyIndex];
    // while the monkey has items in its list of items
    while (monkey.items.length > 0) {
        const item = monkey.items.shift();
        monkey.itemsInspected++;
        const result = monkey.operation(item ? item : 0);
        const resultReducedWorry = gcdOfTestDivisors === 0 ? Math.floor(result / 3): result % gcdOfTestDivisors;
        if (resultReducedWorry % monkey.testDivisor === 0) {
            monkeys[monkey.passTestMonkey].items.push(resultReducedWorry);
        } else {
            monkeys[monkey.failTestMonkey].items.push(resultReducedWorry);
        }
    }
}

function executeRounds(monkeys: Monkey[], numberOfRounds: number, gcdOfTestDivisors: number) {
    for (let roundNumber = 0; roundNumber < numberOfRounds; roundNumber++) {
        for (let i = 0; i < monkeys.length; i++) {
            executeMonkeyAntics(monkeys, i, gcdOfTestDivisors);

        }
    }
}

function multiplyTestDivisors(monkeys: Monkey[]): number {
    const testDivisors: number[] = [];
    for (let i = 0; i < monkeys.length; i++) {
        testDivisors.push(monkeys[i].testDivisor);
    }
    return testDivisors.reduce((a, b) => a * b);
}

// Main program

// Part 1
// execute 20 rounds
const monkeys = readInputFile('input.txt');
executeRounds(monkeys, 20, 0);
monkeys.sort((a, b) => a.itemsInspected - b.itemsInspected);
console.log("Part 1: " + 
monkeys[monkeys.length - 1].itemsInspected * 
monkeys[monkeys.length - 2].itemsInspected); 

// Part 2
// execute 10000 rounds
const monkeys2 = readInputFile('input.txt');
const testDivisorProduct = multiplyTestDivisors(monkeys2);
executeRounds(monkeys2, 10000, testDivisorProduct);
monkeys2.sort((a, b) => a.itemsInspected - b.itemsInspected);
console.log("Part 2: " + monkeys2[monkeys2.length - 1].itemsInspected * 
monkeys2[monkeys2.length - 2].itemsInspected); 