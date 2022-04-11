#!/usr/bin/python3
from itertools import cycle
mad_dogs = ['rudy', 'ryc', 'malik', 'mata', 'tata']
mad_dogs_cycle = cycle(mad_dogs)

# x = '1'
# # while x == 'ryc':
for x in mad_dogs_cycle:
    print(x)
    # if x == 'szczepan' :
    # #   break
    # # else:
    # #     continue