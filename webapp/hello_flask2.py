#!/usr/bin/python3
from flask import Flask, render_template, request, escape
import mysql.connector
#redirect
from vsearch import search4letters

app = Flask(__name__)


# @app.route('/')
#standdard
# def hello() -> str:
#    return 'Welcome on lab'
#forwarding
# def hello() -> '302':
#    return redirect('/entry')
def log_request(req: 'flask_request', res: str) -> None:
   """Loguje szczegóły żądania sieciowego oraz wyniki."""
   dbconfig = { 'host': '127.0.0.1',
                'user': 'vsearch',
                'password': 'vsearchpasswdd',
                'database': 'vsearchlogDB', }

   conn = mysql.connector.connect(**dbconfig)
   cursor = conn.cursor()
   with UseDatabase(dbconfig) as cursor:
    _SQL = """insert into log
             (phrase, letters, ip, browser_string, results)
             values
             (%s, %s, %s, %s, %s)"""
    cursor.execute(_SQL, (req.form['phrase'],
                         req.form['letters'],
                         req.remote_addr,
                         req.user_agent.browser,
                         res, ))
   conn.commit()
   cursor.close()
   conn.close()

@app.route('/search4', methods=['POST'])
def do_search() -> 'html':
   phrase = request.form['phrase']
   letters = request.form['letters']
   title = 'Result:'
   results = str(search4letters(phrase, letters))
   log_request(request, results)
   return render_template('results.html',
                               the_phrase=phrase,
                               the_letters=letters,
                               the_title=title,
                               the_results=results,)

@app.route('/')
@app.route('/entry')
def entry_page() -> 'html':
    return render_template('entry.html',
                             the_title='Welcome on website')
@app.route('/viewlog')
def view_the_log() -> 'html':
    contents = []
    with open('vsearch.log') as log:
        for line in log:
            contents.append([])
            for item in line.split('|'):
                contents[-1].append(escape(item))
    titles = ('Date from forms', 'Address client', 'User Agent', 'Results')
    return render_template('viewlog.html',
                             the_title='Logs lookup',
                             the_row=titles,
                             the_data=contents,)

if __name__ == '__main__':
    app.run(debug=True)

