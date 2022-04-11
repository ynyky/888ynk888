
paranoid_android = "Marvin, paranoiczny android"
letters = list(paranoid_android)
for char in letters[:6]:
   print('\t', char)
print()
for char in letters[-7:]:
   print('\t'*2, char)
print()
for char in letters[8:19]:
   print('\t'*3, char)
