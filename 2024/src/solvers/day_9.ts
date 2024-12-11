export const challenge_9 = (input: number[][]): number => {
    let {files, spaces} = categorizeInput(input[0]);

    // treat the files and spaces like stacks
    // take the last file off the file stack and the first space of the space stack
    // and use them to create a new file in the space
    // and convert where the file was previously into a new space

    // if the file is bigger than the space, then the a file of the size of the space is created and
    // the remained of the file goes into the next availble space off the stack. This continues
    // until there is no space left. If there is still a partial file left then put that file back on the stack

    // if the file is smaller than the space, then the file is put into the space and the remainder of the space
    // is kept for the next available file to be compacted.

    let new_files = [];
    let new_spaces = [];
    let file: File | undefined;
    let space: Space | undefined;
    while (files.length > 0 && spaces.length > 0 ) {

        if (file === undefined) {
            file = files.pop()!;
        }
        if (space === undefined) {
            space = spaces.shift()!;
        }

        if (file.position < space.position) { break; }

        if (file.size > space.size) {
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
            file = remaining_file;
            space = undefined;
            new_files.push(new_file);
            new_spaces.push(new_space);
        } else if (file.size < space.size) {
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
            new_files.push(new_file);
            new_spaces.push(new_space);
            space = remaining_space;
            file = undefined;
        } else {
            let new_file =  {
                id: file.id,
                size: file.size,
                position: space.position
            }
            let new_space = {
                id: space.id,
                size: file.size,
                position: file.position
            }
            new_files.push(new_file);
            new_spaces.push(new_space);
            file = undefined;
            space = undefined;
        }
    }

    // add any remaining files from the process to the new files
    new_files.push(file!);
    // add any remaining files and spaces to the new files and new spaces
    new_files = new_files.concat(files);
    new_spaces = new_spaces.concat(spaces);
    // sort new files in order of position
    new_files.sort((a, b) => a.position - b.position);

    return compute_checksum(new_files);
}

export const challenge_9_2 = (input: number[][]): number => {
    let {files, spaces} = categorizeInput(input[0]);

    // treat the files and spaces like stacks
    // take the last file off the file stack and the first space of the space stack
    // and use them to create a new file in the space
    // and convert where the file was previously into a new space

    // if the file is bigger than the space, then the a file of the size of the space is created and
    // the remained of the file goes into the next availble space off the stack. This continues
    // until there is no space left. If there is still a partial file left then put that file back on the stack

    // if the file is smaller than the space, then the file is put into the space and the remainder of the space
    // is kept for the next available file to be compacted.

    let i = 0; let j = 0;
    for (i = files.length-1; i >= 0; i-=1 ) {
        for (j = 0; j < spaces.length; j+=1) {
            if (files[i].size <= spaces[j].size && files[i].position >= spaces[j].position) {
                files[i].position = spaces[j].position;
                spaces[j].size = spaces[j].size - files[i].size,
                spaces[j].position = spaces[j].position + files[i].size;
                break;
            }
        }
    }


    return compute_checksum(files);
}

const compute_checksum = (files: File[]): number => {
    return files.reduce((acc, file) => {
        // the checksum is all the positions the file occupies, each multiplied 
        // by the id of the file
        for (let i = 0; i < file.size; i+=1) {
            acc += file.id * (file.position + i);
        }
        return acc;
    }, 0);
}

type Space = {
    id: number;
    size: number;
    position: number;
};

type File = {
    id: number;
    size: number;
    position: number;
};

const categorizeInput = (input: number[]):  {files: File[], spaces: Space[]}=> {
    let spaces: Space[] = [];
    let files: File[] = [];
    let total_count = 0;
    let position = 0;
    let spaces_count = 0;
    let files_count = 0;

    input.forEach((num) => {
        // every odd number is a file and every even number is a space
        if (total_count % 2 === 0 && num > 0) {
            let file = {
                id: files_count,
                size: num,
                position: position
            }
            position+=num;
            files.push(file);
            files_count+=1;
        } else if (total_count % 2 !== 0 && num > 0) {
            let space = {
                id: spaces_count,
                size: num,
                position: position
            }
            spaces_count+=1;
            position+=num;
            spaces.push(space);
        }
        total_count+=1;
    });

    return { files: files, spaces: spaces};
}