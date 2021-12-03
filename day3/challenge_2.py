#!/usr/bin/python

def most_common_bit_at_index(list, bit_index):
    indicator = 0
    for item in list:
        if item[bit_index] == '0':
            indicator-=1
        else:
            indicator+=1
    if indicator >= 0:
        return "1"
    else:
        return "0"

def filter_by_bit(list, bit_val, bit_index):
    result_list = []
    for item in list:
        if item[bit_index] == bit_val:
            result_list.append(item)

    return result_list
    
with open('input.txt') as f:
    lines = f.read().splitlines() 

oxy_list = lines
for i in range(0, 12):
    most_common_bit = most_common_bit_at_index(oxy_list, i)
    oxy_list = filter_by_bit(oxy_list, most_common_bit, i)
    if len(oxy_list) == 1:
        break

co_list = lines
for i in range(0, 12):
    most_common_bit = most_common_bit_at_index(co_list, i)
    if most_common_bit == '1':
        least_common_bit = '0'
    else:
        least_common_bit = '1'
    co_list = filter_by_bit(co_list, least_common_bit, i)
    if len(co_list) == 1:
        break

print(oxy_list)
print(co_list)
print(int(oxy_list[0], 2) * int(co_list[0], 2))



    
    



