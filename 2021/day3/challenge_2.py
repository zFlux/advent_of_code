#!/usr/bin/python

def most_and_least_common_bit_lists(list, bit_index):
    ones = []; zeros = []
    
    for item in list:
        if item[bit_index] == '0': zeros.append(item)
        else: ones.append(item)
    if len(ones) >= len(zeros): return {'most common': ones, 'least common': zeros}
    else: return {'most common': zeros, 'least common': ones}

def life_support_rating(input):
    lists = most_and_least_common_bit_lists(input, 0)
    oxy_gen_rating = lists['most common']
    co2_scrub_rating = lists['least common']

    for i in range(1, 12):
        if len(oxy_gen_rating) > 1:
            oxy_gen_rating = most_and_least_common_bit_lists(oxy_gen_rating, i)['most common']
        if len(co2_scrub_rating) > 1:
            co2_scrub_rating = most_and_least_common_bit_lists(co2_scrub_rating, i)['least common']
        
    return int(oxy_gen_rating[0],2) * int(co2_scrub_rating[0], 2)

with open('input.txt') as file: input = file.read().splitlines()

print(life_support_rating(input))