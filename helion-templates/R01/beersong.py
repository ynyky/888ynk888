
word = "butelki"
for beer_num in range(99, 0, -1):
   print(beer_num, word, "piwa na ścianie.")
   print(beer_num, word, "piwa.")
   print("Jedną weź.")
   print("Podaj w koło.")
   if beer_num == 1:
      print("Nie ma już butelek piwa na ścianie.")
   else:
      new_num = beer_num - 1
      if new_num == 1:
         word = "butelka"
      print(new_num, word, "piwa na ścianie.")
   print()
