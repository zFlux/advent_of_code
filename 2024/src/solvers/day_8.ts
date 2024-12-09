export const challenge_8 = (map: string[][]): number => {

    const antennas: Map<string, number[][]> = parse_antennas(map);
    const antinode_positions: Set<string> = new Set();
    const max_x = map[0].length;
    const max_y = map.length;
    
    for (let key of antennas.keys()) { 
        let antenna_positions = antennas.get(key);
        let pairs = compute_all_pairs(antenna_positions!);
        // for each pair compute the antinode positions
        for (let pair of pairs) {
            let antinodes = compute_antinode_positions(pair, max_x, max_y);
            for (let antinode of antinodes) {
                antinode_positions.add(antinode.toString());
            }
        }
    }

    return antinode_positions.size;
}

export const challenge_8_2 = (map: string[][]): number => {

    const antennas: Map<string, number[][]> = parse_antennas(map);
    const antinode_positions: Set<string> = new Set();
    const max_x = map[0].length;
    const max_y = map.length;
    
    for (let key of antennas.keys()) { 
        let antenna_positions = antennas.get(key);
        let pairs = compute_all_pairs(antenna_positions!);
        // for each pair compute the antinode positions
        for (let pair of pairs) {
            let antinodes = compute_linear_antinode_positions(pair, max_x, max_y);
            for (let antinode of antinodes) {
                antinode_positions.add(antinode.toString());
            }
        }
    }

    return antinode_positions.size;
}

const compute_antinode_positions = (pair: number[][], max_x: number, max_y: number): number[][] => {
    // first figure how far apart the antennas are in the x and y directions
    let y_distance = pair[0][0] - pair[1][0];
    let x_distance = pair[0][1] - pair[1][1];

    let result = [];
    if (pair[0][0] + y_distance < max_y && pair[0][1] + x_distance < max_x && pair[0][0] + y_distance >= 0 && pair[0][1] + x_distance >= 0) {
        result.push([pair[0][0] + y_distance, pair[0][1] + x_distance]);
    }
    if (pair[1][0] - y_distance < max_y && pair[1][1] - x_distance < max_x && pair[1][0] - y_distance >= 0 && pair[1][1] - x_distance >= 0) {
        result.push([pair[1][0] - y_distance, pair[1][1] - x_distance]);
    }

    return result;
}

const compute_linear_antinode_positions = (pair: number[][], max_x: number, max_y: number): number[][] => {
    // first figure how far apart the antennas are in the x and y directions
    let y_distance = pair[0][0] - pair[1][0];
    let x_distance = pair[0][1] - pair[1][1];

    let result = [];

    // compute all anti-nodes in one direction along the slope between the two antennas
    let current_point = [pair[0][0], pair[0][1]];
    while (current_point[0] + y_distance < max_y && current_point[1] + x_distance < max_x && current_point[0] + y_distance >= 0 && current_point[1] + x_distance >= 0){
        result.push([current_point[0] + y_distance, current_point[1] + x_distance]);
        current_point = [current_point[0] + y_distance, current_point[1] + x_distance];
    }

    // compute all anti-nodes in the other direction along the slope between the two antennas
    current_point = [pair[1][0], pair[1][1]];
    while (current_point[0] - y_distance < max_y && current_point[1] - x_distance < max_x && current_point[0] - y_distance >= 0 && current_point[1] - x_distance >= 0){
        result.push([current_point[0] - y_distance,current_point[1] - x_distance]);
        current_point = [current_point[0] - y_distance,current_point[1] - x_distance];
    }

    result.push([pair[0][0], pair[0][1]]);
    result.push([pair[1][0], pair[1][1]]);
    return result;
}

const compute_all_pairs = (antenna_positions: number[][]): number[][][] => {
    let pairs: number[][][] = [];
    for (let i = 0; i < antenna_positions.length; i++) {
        for (let j = i + 1; j < antenna_positions.length; j++) {
            pairs.push([antenna_positions[i], antenna_positions[j]]);
        }
    }
    return pairs;
}


const parse_antennas = (list: string[][]): Map<string, number[][]> => {
    let antennas = new Map<string, number[][]>();
    for (let i = 0; i < list.length; i++) {
        for (let j = 0; j < list[i].length; j++) {
            if (list[i][j] !== '.') {
                let frequency = list[i][j];
                if (antennas.has(frequency)) {
                    antennas.set(frequency, antennas.get(frequency)!.concat([[i, j]]));
                } else {
                    antennas.set(frequency,[[i, j]]);
                }
            }
        }
    }
    return antennas;
}