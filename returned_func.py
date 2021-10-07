
def outer():
   def inner():
      print('To jest funkcja inner.')

   print('To jest funkcja outer, zwracająca funkcję inner.')
   return inner()
