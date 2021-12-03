#!/usr/bin/python

def most_common_bit_at_index(list, bit_index):
    indicator = 0
    for item in list:
        if item[bit_index] == '0':
            indicator-=1
        else:
            indicator+=1
    return indicator >= 0

def filter_by_bit(list, bit_val, bit_index):
    result_list = []
    str_bit_val = str(int(bit_val))
    for item in list:
        if item[bit_index] == str_bit_val:
            result_list.append(item)
    return result_list
    
with open('input.txt') as f:
    lines = f.read().splitlines() 

oxy_list = lines
co_list = lines
for i in range(0, 12):
    most_common_bit = most_common_bit_at_index(oxy_list, i)
    least_common_bit = not most_common_bit_at_index(co_list, i)
    if len(oxy_list) > 1:
        oxy_list = filter_by_bit(oxy_list, most_common_bit, i)
    if len(co_list) > 1:
        co_list = filter_by_bit(co_list, least_common_bit, i)

print(int(oxy_list[0], 2) * int(co_list[0], 2))



    
    



