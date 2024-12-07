import fs from 'fs';
import path from 'path';

export function parseInput(inputFile: string, parser: (line: string, line_number: number) => any): any {
    const inputPath = path.join(__dirname, `../inputs/${inputFile}`);
    const val = fs.readFileSync(inputPath, 'utf8')
    // run the parser on each line of the input file
    // passing the string and the line number

    let result = []
    const lines = val.split('\n')
    for (let i = 0; i < lines.length; i++) {
        result.push(parser(lines[i], i));
    }
    return result;
}

export function parseFirstLine(inputFile: string, parser: (line: string, line_number: number) => any): any {
    const inputPath = path.join(__dirname, `../inputs/${inputFile}`);
    const val = fs.readFileSync(inputPath, 'utf8').split('\n')[0];
    return parser(val, 0);
}