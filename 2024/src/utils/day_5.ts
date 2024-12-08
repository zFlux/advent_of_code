type PositionMapType = Map<number, number>;
type RulesOrPageOrders = (number[] | string)[];
type RulesMap = { [key: number]: number[] };

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