
def outer():
   def inner():
      print('To jest funkcja inner.')

   print('To jest funkcja outer, wywołująca funkcję inner.')
   inner()
