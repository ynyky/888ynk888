#!/usr/bin/python3
def search_vowels():
    vowels = set('aeiouy')
    word = input("Podaj słowo: ")
    found = vowels.intersection(set(word))
    for vowel in found:
        print(vowel)
search_vowels()