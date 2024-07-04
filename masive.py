import array

masive = array.array('i',[5,1,12,3,6,2])
sorted_masive = sorted(masive, reverse=True)
filter = [number for number in sorted_masive if number <= 5]
print(filter)

print(sorted_masive)

