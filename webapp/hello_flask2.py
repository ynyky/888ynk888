#!/usr/bin/python3
from flask import Flask, render_template, request
from vsearch import search4letters

app = Flask(__name__)


@app.route('/')
def hello() -> str:
   return 'Welcome on lab'


@app.route('/search4', methods=['POST'])
def do_search() -> str:
   phrase = request.form['phrase']
   letters = request.form['letters']
   title = 'Result:'
   results = str(search4letters(phrase, letters))
   return render_template('results.html',
                               the_phrase=phrase,
                               the_letters=letters,
                               the_title=title,
                               the_results=results,)

@app.route('/entry')
def entry_page() -> 'html':
    return render_template('entry.html',
                             the_title='Welcome on website')
app.run(debug=True)
