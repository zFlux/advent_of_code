import { Space, File } from "../types/challenge_types";

export const compute_checksum = (files: File[]): number => {
    return files.reduce((acc, file) => {
        for (let i = 0; i < file.size; i+=1) {
            acc += file.id * (file.position + i);
        }
        return acc;
    }, 0);
}

export const categorizeInput = (input: number[]):  {files: File[], spaces: Space[]} => {
    let spaces: Space[] = [];
    let files: File[] = [];
    let total_count = 0;
    let position = 0;
    let spaces_count = 0;
    let files_count = 0;

    input.forEach((num) => {
        if (total_count % 2 === 0 && num > 0) {
            let file = {
                id: files_count,
                size: num,
                position: position
            }
            position += num;
            files.push(file);
            files_count += 1;
        } else if (total_count % 2 !== 0 && num > 0) {
            let space = {
                id: spaces_count,
                size: num,
                position: position
            }
            spaces_count += 1;
            position += num;
            spaces.push(space);
        }
        total_count += 1;
    });

    return { files: files, spaces: spaces };
}

export const handleLargerFile = (file: File, space: Space) => {
    let new_file = {
        id: file.id,
        size: space.size,
        position: space.position
    }
    let new_space = {
        id: space.id,
        size: space.size,
        position: file.position + (file.size - space.size)
    }
    let remaining_file = {
        id: file.id,
        size: file.size - space.size,
        position: file.position
    }
    return { new_file, new_space, remaining_file };
}

export const handleSmallerFile = (file: File, space: Space) => {
    let new_file = {
        id: file.id,
        size: file.size,
        position: space.position
    }
    let new_space = {
        id: space.id,
        size: file.size,
        position: file.position
    }
    let remaining_space = {
        id: space.id,
        size: space.size - file.size,
        position: space.position + file.size
    }
    return { new_file, new_space, remaining_space };
}

export const handleEqualSize = (file: File, space: Space) => {
    let new_file = {
        id: file.id,
        size: file.size,
        position: space.position
    }
    let new_space = {
        id: space.id,
        size: file.size,
        position: file.position
    }
    return { new_file, new_space };
}