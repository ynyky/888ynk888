
vowels = set('aeiou')
word = input("Podaj słowo, w którym należy wyszukać samogłoski: ")
found = vowels.intersection(set(word))
for vowel in found:
   print(vowel)
