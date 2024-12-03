import {
    map_ith_elements_to_new_list,
    sum_absolute_differences,
    frequency_map,
    multiply_by_frequency_and_sum,
    sub_lists,
    check_list,
    check_list_v2,
    is_safe,
    abs_diff_between_1_and_3,
} from '../utils/utils';

describe('map_ith_elements_to_new_list', () => {
    it('should map the i-th elements of each subarray to a new list', () => {
        const list = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
        const i = 1;
        const expected = [2, 5, 8];
        const result = map_ith_elements_to_new_list(i, list);
        expect(result).toEqual(expected);
    });
});

describe('sum_absolute_differences', () => {
    it('should calculate the sum of absolute differences between corresponding elements of two lists', () => {
        const list1 = [1, 2, 3];
        const list2 = [4, 5, 6];
        const expected = 9;
        const result = sum_absolute_differences(list1, list2);
        expect(result).toEqual(expected);
    });
});

describe('frequency_map', () => {
    it('should create a frequency map of the elements in the list', () => {
        const list = [1, 2, 2, 3, 3, 3];
        const expected = new Map([[1, 1], [2, 2], [3, 3]]);
        const result = frequency_map(list);
        expect(result).toEqual(expected);
    });
});

describe('multiply_by_frequency_and_sum', () => {
    it('should multiply each element in list1 by its frequency in the frequency map and return the sum', () => {
        const list1 = [1, 2, 3];
        const frequencyMap = new Map([[1, 2], [2, 3], [3, 1]]);
        const expected = 11;
        const result = multiply_by_frequency_and_sum(list1, frequencyMap);
        expect(result).toEqual(expected);
    });
});

describe('sub_lists', () => {
    it('should generate all possible sublists missing one element for the given list', () => {
        const list = [1, 2, 3];
        const expected = [[2, 3], [1, 3], [1, 2]];
        const result = sub_lists(list);
        expect(result).toEqual(expected);
    });
});

describe('check_list', () => {
    it('should check if the list satisfies the extra check condition', () => {
        const list = [1, 2, 3];
        const extraCheck = true;
        const expected = true;
        const result = check_list(list, extraCheck);
        expect(result).toEqual(expected);
    });
});

describe('is_safe', () => {
    it('should check if the element at index_1 is safe to be replaced by the element at index_2 with the given prior sign', () => {
        const list = [1, 2, 3];
        const index_1 = 0;
        const index_2 = 2;
        const priorSign = 1;
        const expected = true;
        const result = is_safe(list, index_1, index_2, priorSign);
        expect(result).toEqual(expected);
    }); 
});

describe('abs_diff_between_1_and_3', () => {
    it('should check if the absolute difference between first and second is between 1 and 3', () => {
        const first = 2;
        const second = 5;
        const expected = true;
        const result = abs_diff_between_1_and_3(first, second);
        expect(result).toEqual(expected);
    });
});