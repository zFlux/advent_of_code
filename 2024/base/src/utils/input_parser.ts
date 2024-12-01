import fs from 'fs';
import path from 'path';

export function parseInput(inputFile: string, parser: (line: string) => any): any {
    const inputPath = path.join(__dirname, `../inputs/${inputFile}`);
    const val = fs.readFileSync(inputPath, 'utf8')
    return val.split('\n').map((line: string) => parser(line));
}

export function parseFirstLine(inputFile: string, parser: (line: string) => any): any {
    const inputPath = path.join(__dirname, `../inputs/${inputFile}`);
    const val = fs.readFileSync(inputPath, 'utf8').split('\n')[0];
    return parser(val);
}