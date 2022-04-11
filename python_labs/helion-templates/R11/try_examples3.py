
try:
   with open('myfile.txt') as fh:
      file_data = fh.read()
   print(file_data)
except FileNotFoundError:
   print('Brak pliku z danymi.')
except PermissionError:
   print('Brak odpowiednich uprawnień.')
