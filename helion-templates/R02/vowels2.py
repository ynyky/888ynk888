
vowels = ['a', 'e', 'i', 'o', 'u']
word = "Miliard"
found = []
for letter in word:
   if letter in vowels:
      if letter not in found:
         found.append(letter)
for vowel in found:
   print(vowel)
