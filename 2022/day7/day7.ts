import * as fs from 'fs';

class File {
    name: string;
    size: number;
    constructor(name: string, size: number) {
        this.name = name;
        this.size = size;
    }
}

class Directory {
    name: string;
    files: File[];
    directories: Directory[];
    parent: Directory | undefined;
    constructor(name: string, files: File[], directories: Directory[], parent: Directory | undefined) {
        this.name = name;
        this.files = files;
        this.directories = directories;
        this.parent = parent;
    }
}

function executeCommand(command: string) {
    const commandList = command.split(' ');
    if (commandList[0] === 'cd') {
        changeDirectory(commandList[1]);
    } 
    else if (commandList[0] === 'ls') {
        listCurrentDirectory();
    }
 }

function changeDirectory(directory: string) {
    if (directory === '..') {
        currentDirectory = currentDirectory?.parent;
    } else if (directory === '/') {
        rootDirectory = new Directory(directory, [], [], undefined);
        currentDirectory = rootDirectory;
    } else {
        const newDirectory = currentDirectory?.directories.find((dir) => dir.name === directory);
        if (newDirectory) {
            currentDirectory = newDirectory;
        }
    }
}

function listCurrentDirectory() {
    while (inputIndex + 1 < input.length && input[inputIndex+1].charAt(0) !== '$') {
        inputIndex++;
        const line = input[inputIndex];
        if (line.charAt(0) === 'd') {
            const directoryName = line.substring(4);
            const newDirectory = new Directory(directoryName, [], [], currentDirectory);
            currentDirectory?.directories.push(newDirectory);
        } else {
            const fileDetails = line.split(' ');
            const fileName = fileDetails[1];
            const fileSize = parseInt(fileDetails[0]);
            const newFile = new File(fileName, fileSize);
            currentDirectory?.files.push(newFile);
        }
    }
}

// function to print the contents of a input directory
function printDirectory(directory: Directory | undefined, indent: string = '') {
    if (!directory) {
        return;
    }

    console.log(indent + directory.name);
    for (const file of directory.files) {
        console.log(indent + ' ' + file.name);
    }
    for (const dir of directory.directories) {
        printDirectory(dir, indent + ' ');
    }
}

// create a function to traverse rootDirectory, calculate the size of each directory, 
// and return a list with the size and name of each directory
function calculateDirectorySize(directory: Directory | undefined): [number, string][] {
    if (!directory) {
        return [];
    }

    let size = 0;
    for (const file of directory.files) {
        size += file.size;
    }
    for (const dir of directory.directories) {
        size += calculateDirectorySize(dir)[0][0];
    }
    return [[size, directory.name]];
}

function calculateAllDirectorySizes(directory: Directory | undefined): [number, string][] {
    if (!directory) {
        return [];
    }

    let results: [number, string][] = [];
    results.push(calculateDirectorySize(directory)[0]);
    for (const dir of directory.directories) {
        results = results.concat(calculateAllDirectorySizes(dir));
    }
    return results;
}

// Main Program
let input = fs.readFileSync('input.txt', 'utf8').split('\n');
let rootDirectory: Directory | undefined = undefined;
let currentDirectory: Directory | undefined = undefined;
let inputIndex = 0;

// Create the file system tree
while (inputIndex < input.length) {
    const line = input[inputIndex]
    if (line.charAt(0) === '$') {
        executeCommand(line.substring(2));
    }
    inputIndex++
}


// Part 1
const allDirectorySizes = calculateAllDirectorySizes(rootDirectory);
let totalSize = 0;
for (const [size, name] of allDirectorySizes) {
    if (size <= 100000) {
        totalSize += size;
    }
}
console.log("Part 1: " + totalSize);

// Part 2
const rootSize = calculateDirectorySize(rootDirectory)[0][0];
const unUsedSpace = 70000000 - rootSize;
const neededSpace = 30000000 - unUsedSpace;

let smallestDirectory = {size: 0, name: ''};
for (const [size, name] of allDirectorySizes) {
    if (size >= neededSpace) {
        if (smallestDirectory.size === 0 || size < smallestDirectory.size) {
            smallestDirectory = {size, name};
        }
    }
}

console.log("Part 2: " + smallestDirectory.size);
