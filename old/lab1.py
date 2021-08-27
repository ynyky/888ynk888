#!/usr/bin/python3
class CountFromBy:
    def __init__(self, v: int=0, i: int=1) -> None:
        self.val = v
        self.incr = i
    def increase(self) -> None:
        self.val += self.incr
    def __repr__(self) -> str:
        return str(self.val)
g = CountFromBy()
k = g.increase()
print (g)
# f = g.increase()
# print(f)
# j = CountFromBy(100, 10)
# print(j)
# b = type(j)
# print(b)
# c = id(j)
# print(c)
# l = hex(id(j))
# print(l)