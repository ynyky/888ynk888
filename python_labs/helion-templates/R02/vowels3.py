
vowels = ['a', 'e', 'i', 'o', 'u']
word = input("Podaj słowo, w którym należy wyszukać samogłoski: ")
found = []
for letter in word:
   if letter in vowels:
      if letter not in found:
         found.append(letter)
for vowel in found:
   print(vowel)
