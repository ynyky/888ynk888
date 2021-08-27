#!/usr/bin/python3
word = input("Podaj nazwę: ")
#word = 'Miliard'
found = []
vowels = ['a', 'e', 'o', 'u']
for letter in word:
    if letter in vowels:
        if letter not in found:
            found.append(letter)
for vowel in found:
    print(vowel)
