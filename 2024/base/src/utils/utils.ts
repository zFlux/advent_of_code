export const map_ith_elements_to_new_list = (i: number, list: number[][]): number[] => {
    return list.map((_, index) => list[index][i]);
}

export const sum_absolute_differences = (list_1: number[], list_2: number[]): number => {
    let sum = 0;
    for (let i = 0; i < list_1.length; i++) {
        sum += Math.abs(list_1[i] - list_2[i]);
    }
    return sum;
}

export const frequency_map = (list: number[]): Map<number, number> => {
    const map = new Map<number, number>();
    list.forEach((num: number) => {
        map.set(num, (map.get(num) || 0) + 1);
    });
    return map;
}

export const multiply_by_frequency_and_sum = (list_1: number[], frequency_map: Map<number, number>): number => {
    let sum:number = 0;
    list_1.forEach((num: number) => {
        sum += num * (frequency_map.get(num) || 0);
    });

    return sum;
}

export const sub_lists = (list: number[]): number[][] => {
    let sub_lists = [];
    for (let i = 0; i < list.length; i++) {
        sub_lists.push(list.filter((_, index) => index !== i));
    }
    return sub_lists;
}

export const check_list = (list: number[], extra_check: boolean): boolean => {

    let i = 0; let j = 1;
    let prior_sign = Math.sign(list[j] - list[i]);

    while (j < list.length) {
        if (!is_safe(list, i, j, prior_sign)) {
            return false;
        }
        i++; j++;
    }

    return true;
}

export const check_list_v2 = (list: number[]): boolean => {

    let i = 0; let j = 1;
    let prior_sign = Math.sign(list[j] - list[i]);
    let removed_element = false;

    while (j < list.length) {

        let current_sign = Math.sign(list[j] - list[i]);

        if ((!abs_diff_between_1_and_3(list[i], list[j]) || prior_sign !== current_sign)) {
            
            if (!removed_element && !is_safe(list, i, j+1, prior_sign) && (i === 0 || j === list.length - 1)) {
                i++; j++;
                removed_element = true;
                prior_sign = Math.sign(list[j] - list[i]);
                continue;
            }

            if (!removed_element && is_safe(list, i, j+1, prior_sign)) {
                i+=2; j+=2;
                removed_element = true;
                prior_sign = Math.sign(list[j+1] - list[i]);
                continue;
            } else {
                return false;
            }
        } 
        
        prior_sign = Math.sign(list[j] - list[i]);
        i++; j++;
    }

    return true;
}

export const is_safe = (list: number[], index_1: number, index_2: number, prior_sign: number): boolean => {
    const current_sign = Math.sign(list[index_2] - list[index_1]);
    const is_abs_between_1_and_3 = abs_diff_between_1_and_3(list[index_1], list[index_2]);
    const is_matching_sign = current_sign === prior_sign;
    return is_matching_sign && is_abs_between_1_and_3;
}

export const abs_diff_between_1_and_3 = (first: number, second: number): boolean => {
    return Math.abs(first - second) >= 1 && Math.abs(first - second) <= 3;
}

export const check_x_mas = (grid: string[][], x: number, y: number): number => {
    const mas_map: { [key: string]: string } = {'M': 'S', 'S': 'M'}
    
    if (x - 1 >= 0 && y - 1 >= 0 && x + 1 < grid.length && y + 1 < grid[0].length) {
        if (mas_map[grid[x - 1][y + 1]] === grid[x + 1][y - 1] && mas_map[grid[x + 1][y + 1]] === grid[x - 1][y - 1]) {
            return 1;
        }
    }
    return 0;
}

export const check_xmas = (grid: string[][], x: number, y: number, direction: number): number => {
    const lower_boundary = grid.length - 1;
    const right_boundary = grid[0].length - 1;
    const word = ['X', 'M', 'A', 'S'];
    let char_position = 1;

    while (char_position < word.length) {
        let next_coordinates = move_direction(direction, x, y, lower_boundary, right_boundary);
        if (next_coordinates === false) {
            return 0;
        } else {
            next_coordinates = next_coordinates as [number, number];
            if (grid[next_coordinates[0]][next_coordinates[1]] === word[char_position]) {
                char_position += 1;
                x = next_coordinates[0];
                y = next_coordinates[1];
            } else {
                return 0;
            }
        }
    }
    return 1;
}

export const check_xmas_all_directions = (grid: string[][], x: number, y: number): number => {
    let sum = 0;
    sum += check_xmas(grid, x, y, UP);
    sum += check_xmas(grid, x, y, UP_RIGHT);
    sum += check_xmas(grid, x, y, RIGHT);
    sum += check_xmas(grid, x, y, DOWN_RIGHT);
    sum += check_xmas(grid, x, y, DOWN);
    sum += check_xmas(grid, x, y, DOWN_LEFT);
    sum += check_xmas(grid, x, y, LEFT);
    sum += check_xmas(grid, x, y, UP_LEFT);
    return sum;
}

const UP = 0;
const UP_RIGHT = 1;
const RIGHT = 2;
const DOWN_RIGHT = 3;
const DOWN = 4;
const DOWN_LEFT = 5;
const LEFT = 6;
const UP_LEFT = 7;

export const move_direction = (direction: number, x: number, y: number, lower_boundary: number, right_boundary: number): [number, number] | boolean => {
    const upper_boundary = 0;
    const left_boundary = 0;

    switch (direction) {
        case UP:
            return y - 1 < upper_boundary ? false : [x, y - 1];
        case UP_RIGHT:
            return x + 1 > right_boundary || y - 1 < upper_boundary ? false : [x + 1, y - 1];
        case RIGHT:
            return x + 1 > right_boundary ? false : [x + 1, y];
        case DOWN_RIGHT:
            return x + 1 > right_boundary || y + 1 > lower_boundary ? false : [x + 1, y + 1];
        case DOWN:
            return y + 1 > lower_boundary ? false : [x, y + 1];
        case DOWN_LEFT:
            return x - 1 < left_boundary || y + 1 > lower_boundary ? false : [x - 1, y + 1];
        case LEFT:
            return x - 1 < left_boundary ? false : [x - 1, y];
        case UP_LEFT:
            return x - 1 < left_boundary || y - 1 < upper_boundary ? false : [x - 1, y - 1];
        default:
            return false;
    }
}

type PositionMapType = Map<number, number>;

export function isValidList(list: number[], positionMap: PositionMapType): boolean {
    for (let i = 1; i < list.length; i++) {
        let position_1 = positionMap.get(list[i - 1]);
        let position_2 = positionMap.get(list[i]);
        if (position_1 !== undefined && position_2 !== undefined && position_1 > position_2) {
            return false;
        }
    }
    return true;
}

type RulesOrPageOrders = (number[] | string)[];
type RulesMap = { [key: number]: number[] };

export function createPositionMap(list: number[]): PositionMapType {
    let positionMap = new Map<number, number>();
    for (let i = 0; i < list.length; i++) {
        positionMap.set(list[i], i);
    }
    return positionMap;
}

export function topologicalSort(graph: RulesMap): number[] {
    const visited = new Set<number>();
    const stack: number[] = [];
    const inProgress = new Set<number>();

    function dfs(node: number): void {
        if (inProgress.has(node)) {
            throw new Error("The graph is not a DAG (contains a cycle)");
        }
        if (visited.has(node)) return;

        inProgress.add(node);
        visited.add(node);

        for (const neighbor of graph[node] || []) {
            dfs(neighbor);
        }

        inProgress.delete(node);
        stack.push(node);
    }

    // Ensure all nodes are visited
    for (const node in graph) {
        if (!visited.has(+node)) {
            dfs(+node);
        }
    }
    return stack.reverse();
}

export const create_rules_map = (rules: number[][], page_order: number[]): RulesMap => {

    // convert the page order into a set
    let page_order_set = new Set(page_order);

    let rules_map: RulesMap = {};
    for (let rule of rules) {
        if (page_order_set.has(rule[0])) {
            if (rules_map[rule[0]] === undefined) {
                rules_map[rule[0]] = []
            }
            if(page_order_set.has(rule[1])) {
                rules_map[rule[0]].push(rule[1]);
            }
        }
    }
    return rules_map;
}

export const parse_rules_and_page_orders = (rules_or_page_orders: RulesOrPageOrders): number[][][] => {
    let rules = [];
    while (true) {
        let rule = rules_or_page_orders.shift();
        if (rule === "End") {
            break;
        }
        rules.push(rule as number[]);
    }

    let page_orders = [];
    while (rules_or_page_orders.length > 0) {
        let page_order = rules_or_page_orders.shift();
        page_orders.push(page_order as number[]);
    }

    return [rules, page_orders]
}