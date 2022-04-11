
from flask import Flask, render_template, request, escape
from vsearch import search4letters

<<<<<<< HEAD
import mysql.connector

app = Flask(__name__)


def log_request(req: 'flask_request', res: str) -> None:
   """Loguje szczegóły żądania sieciowego oraz wyniki."""
   dbconfig = { 'host': '127.0.0.1',
                'user': 'vsearch',
                'password': 'vsearchpasswdd',
                'database': 'vsearchlogDB', }

   conn = mysql.connector.connect(**dbconfig)
   cursor = conn.cursor()
=======
from DBcm import UserDatabase

app = Flask(__name__)

app.config['dbconfig'] = { 'host': '127.0.0.1',
                           'user': 'vsearch',
                           'password': 'vsearchlogDB', }


def log_request(req: 'flask_request', res: str) -> None:
   """Loguje szczegóły żądania sieciowego oraz wyniki."""
   with UserDatabase(app.config['dbconfig']) as cursor:
   #
   # conn = mysql.connector.connect(**dbconfig)
   # cursor = conn.cursor()
>>>>>>> fdf0ec156210c6aea6cadb9cf7a12452ccebb957

   _SQL = """insert into log
             (phrase, letters, ip, browser_string, results)
             values
             (%s, %s, %s, %s, %s)"""
   cursor.execute(_SQL, (req.form['phrase'],
                         req.form['letters'],
                         req.remote_addr,
                         req.user_agent.browser,
                         res, ))
<<<<<<< HEAD
   conn.commit()
   cursor.close()
   conn.close()
=======
   # conn.commit()
   # cursor.close()
   # conn.close()
>>>>>>> fdf0ec156210c6aea6cadb9cf7a12452ccebb957


@app.route('/search4', methods=['POST'])
def do_search() -> 'html':
   """Wydobywa przekazane dane; przeprowadza wyszukiwanie; zwraca wyniki."""
   phrase = request.form['phrase']
   letters = request.form['letters']
   title = 'Oto Twoje wyniki:'
   results = str(search4letters(phrase, letters))
   log_request(request, results)
   return render_template('results.html',
                          the_title=title,
                          the_phrase=phrase,
                          the_letters=letters,
                          the_results=results,)


@app.route('/')
@app.route('/entry')
def entry_page() -> 'html':
   """Wyświetla formularz HMTL tej aplikacji WWW."""
   return render_template('entry.html',
                          the_title='Witamy na stronie internetowej search4letters!')


<<<<<<< HEAD
"""Kod zakomentowany, ponieważ funkcja nie obsługuje jeszcze odczytu z bazy
@app.route('/viewlog')
def view_the_log() -> 'html':
"""
   """Wyświetla zawartość pliku logu w tabeli HTML."""
"""
=======

@app.route('/viewlog')
def view_the_log() -> 'html':

>>>>>>> fdf0ec156210c6aea6cadb9cf7a12452ccebb957
contents = []
   with open('vsearch.log') as log:
      for line in log:
         contents.append([])
         for item in line.split('|'):
            contents[-1].append(escape(item))
   titles = ('Dane z formularza', 'Adres klienta', 'Agent użytkownika', 'Wyniki')
   return render_template('viewlog.html',
                          the_title='Widok logu',
                          the_row_titles=titles,
                          the_data=contents,)
<<<<<<< HEAD
"""
=======
>>>>>>> fdf0ec156210c6aea6cadb9cf7a12452ccebb957


if __name__ == '__main__':
   app.run(debug=True)
