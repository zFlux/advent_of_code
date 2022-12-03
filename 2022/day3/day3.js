const input = require('fs').readFileSync('input.txt', 'utf8').split('\n');

const items = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
const itemsToPriorityMap = items.reduce((acc, letter, index) => {
    acc[letter] = index + 1;
    return acc;
}, {});

const splitCompartments = (str) => {
    const middle = Math.ceil(str.length / 2);
    return [str.slice(0, middle), str.slice(middle)];
};

const ruckSacks = input.map(splitCompartments);

const getPrioritiesForMatches = (list) => {
    const [first, second] = list;
    const firstLetters = first.split('');
    const secondLetters = second.split('');
    const match = firstLetters.find(letter => secondLetters.includes(letter));
    return match ? itemsToPriorityMap[match] : 0;
};

const prioritiesForMatched = ruckSacks.map(getPrioritiesForMatches);
const part1Result = prioritiesForMatched.reduce((acc, num) => acc + num, 0);

console.log(part1Result);

// Part 2
const getPrioritiesForGroupMatches = (list) => {
    const [first, second, third] = list;
    const firstLetters = first.split('');
    const secondLetters = second.split('');
    const thirdLetters = third.split('');
    const match = firstLetters.find(letter => secondLetters.includes(letter) && thirdLetters.includes(letter));
    return match ? itemsToPriorityMap[match] : 0;
};

const getGroupsOfThree = (list) => {
    const groups = [];
    for (let i = 0; i < list.length; i += 3) {
        groups.push(list.slice(i, i + 3));
    }
    return groups;
};

const groupsOfThree = getGroupsOfThree(input);
const prioritiesForGroupMatches = groupsOfThree.map(getPrioritiesForGroupMatches);
const part2Result = prioritiesForGroupMatches.reduce((acc, num) => acc + num, 0);
console.log(part2Result);