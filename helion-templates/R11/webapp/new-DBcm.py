"""Menedżer kontekstu UseDatabase umożliwiający korzystanie z bazy MySQL/MariaDB.

Więcej informacji na jego temat można znaleźć w rozdziałach 7, 8, 9 oraz 11 
książki "Python. Rusz głową! Wydanie II".

Prosty przykład jego użycia:

    from DBcm import UseDatabase, SQLError

    config = { 'host': '127.0.0.1',
               'user': 'mojUzytkownik',
               'password': 'mojeHaslo',
               'database': 'mojaBazaDanych' }

    with UseDatabase(config) as cursor:
        try:
            _SQL = "select * from log"
            cursor.execute(_SQL)
            data = cursor.fetchall()
        except SQLError as err:
            print('Twoje zapytanie jest nieprawidłowe:', str(err))

Powodzenia i dobrej zabawy! (Niestety kod przeznaczony jest do użytku wyłącznie 
w Pythonie 3, z powodu zastosowania podpowiedzi typów i nowej składni).
"""

##############################################################################
# Menedżer kontekstu umożliwiający łączenie się z bazą danych i rozłączanie.
##############################################################################

import mysql.connector


class ConnectionError(Exception):
    """Zgłaszany, gdy nie można się połączyć z bazą danych."""
    pass


class CredentialsError(Exception):
    """Zgłaszany, gdy baza danych działa, ale nie da się zalogować."""
    pass


class SQLError(Exception):
    """Zgłaszany, gdy zapytanie powoduje problemy."""
    pass


class UseDatabase:

   def __init__(self, config: dict) -> None:
      """Dodaje parametry konfiguracji bazy danych do obiektu.

      Ta funkcja oczekuje argumentu będącego słownikiem, w którym odpowiednie
      wartości muszą być przypisane do (przynajmniej) tych kluczy:

         host - adres IP hosta, na którym działa baza MySQL/MariaDB.
         user - użytkownik bazy MySQL/MariaDB, z którego należy skorzystać.
         password - hasło tego użytkownika.
         database - nazwa bazy danych, której należy użyć.

      Więcej informacji na ten temat można znaleźć w dokumentacji narzędzia
      mysql-connector-python."""
      self.configuration = config

   def __enter__(self) -> 'cursor':
      """Łączy się z bazą danych i tworzy kursor.
      Zwraca kursor do menedżera kontekstu.
      Zgłasza wyjątek ConnectionError, gdy nie da się znaleźć bazy danych.
      Zgłasza wyjątek CredentialsError, gdy używany jest zły login lub hasło.
      """
      try:
         self.conn = mysql.connector.connect(**self.configuration)
         self.cursor = self.conn.cursor()
         return self.cursor
      except mysql.connector.errors.InterfaceError as err:
         raise ConnectionError(err)
      except mysql.connector.errors.ProgrammingError as err:
         raise CredentialsError(err)


   def __exit__(self, exc_type, exc_value, exc_trace) -> None:
      """Niszczy kursor oraz połączenie (po skomitowaniu).
      Zgłasza wyjątek ProgrammingError jako SQLError lub ponownie zgłasza
      wszystkie inne wyjątki."""
      self.conn.commit()
      self.cursor.close()
      self.conn.close()
      if exc_type is mysql.connector.errors.ProgrammingError:
         raise SQLError(exc_value)
      elif exc_type:
         raise exc_type(exc_value)
