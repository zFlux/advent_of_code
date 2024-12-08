import { parse_rules_and_page_orders, create_rules_map, createPositionMap, topologicalSort, isValidList } from '../utils/day_5';

type RulesOrPageOrders = (number[] | string)[];

export const challenge_5 = (rules_or_page_orders: RulesOrPageOrders): number => {
    let [rules, page_orders] = parse_rules_and_page_orders(rules_or_page_orders);

    let middle_sum = 0;
    for (let page_order of page_orders) {
        let rules_map = create_rules_map(rules, page_order);
        let position_map = createPositionMap(topologicalSort(rules_map));
        if (isValidList(page_order, position_map)) {
            let middle_index = Math.floor(page_order.length / 2);
            middle_sum += page_order[middle_index];
        }
    }
    return middle_sum;
}

export const challenge_5_2 = (rules_or_page_orders: RulesOrPageOrders): number => {
    let [rules, page_orders] = parse_rules_and_page_orders(rules_or_page_orders);

    let middle_sum = 0;
    for (let page_order of page_orders) {
        let rules_map = create_rules_map(rules, page_order);
        let sorted_rules = topologicalSort(rules_map);
        let position_map = createPositionMap(sorted_rules);
        if (!isValidList(page_order, position_map)) {
            let middle_index = Math.floor(page_order.length / 2);
            middle_sum += sorted_rules[middle_index];
        }
    }
    return middle_sum;
}