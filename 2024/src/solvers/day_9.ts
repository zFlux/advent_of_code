import { Space, File } from "../types/challenge_types";
import { categorizeInput, compute_checksum, handleEqualSize, handleLargerFile, handleSmallerFile } from "../utils/day_9";

export const challenge_9 = (input: number[][]): number => {
    let {files, spaces} = categorizeInput(input[0]);

    let new_files = [];
    let new_spaces = [];
    let file: File | undefined;
    let space: Space | undefined;
    let new_file: File;
    let new_space: Space;
    let remaining_file: File;
    let remaining_space: Space;

    while (files.length > 0 && spaces.length > 0 ) {
        if (file === undefined) {
            file = files.pop()!;
        }
        if (space === undefined) {
            space = spaces.shift()!;
        }

        if (file.position < space.position) { break; }

        if (file.size > space.size) {
            ({ new_file, new_space, remaining_file } = handleLargerFile(file, space));
            file = remaining_file;
            space = undefined;
            new_files.push(new_file);
            new_spaces.push(new_space);
        } else if (file.size < space.size) {
            ({ new_file, new_space, remaining_space } = handleSmallerFile(file, space));
            new_files.push(new_file);
            new_spaces.push(new_space);
            space = remaining_space;
            file = undefined;
        } else {
            ({ new_file, new_space } = handleEqualSize(file, space));
            new_files.push(new_file);
            new_spaces.push(new_space);
            file = undefined;
            space = undefined;
        }
    }

    new_files.push(file!);
    new_files = new_files.concat(files);
    new_spaces = new_spaces.concat(spaces);
    new_files.sort((a, b) => a.position - b.position);

    return compute_checksum(new_files);
}

export const challenge_9_2 = (input: number[][]): number => {
    let {files, spaces} = categorizeInput(input[0]);

    for (let i = files.length-1; i >= 0; i-=1 ) {
        for (let j = 0; j < spaces.length; j+=1) {
            if (files[i].size <= spaces[j].size && files[i].position >= spaces[j].position) {
                files[i].position = spaces[j].position;
                spaces[j].size -= files[i].size;
                spaces[j].position += files[i].size;
                break;
            }
        }
    }

    return compute_checksum(files);
}

