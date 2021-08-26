#!/usr/bin/python3
# def searcher(word:str) -> set:
#     """koment"""
#     vowels = set('aeiou')
#     found = vowels.intersection(word)
#     # for vowel in found:
#     #     print(vowel)
#     print(vowels.intersection(set(word)))
#     return vowels.intersection(set(word))
#
# def searcher4letters(phrase:str, letters:str) -> set:
#     return set(letters).intersection(phrase)

def double(arg):
    print('Przed: ', arg)
    arg = arg * 2
    print('Po: ', arg)

double(2)

def change(arg):
    print('Przed: ', arg)
    arg.append('Wiecej danych')
    print('Po: ', arg)
numbers = [42, 246, 70]
change(numbers)