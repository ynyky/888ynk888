#!/usr/bin/python3
from flask import Flask, render_template
from vsearch import search4letters

app = Flask(__name__)


@app.route('/')
def hello() -> str:
   return 'Witaj, świecie, tu Flask!'


@app.route('/search4')
def do_search() -> str:
   return str(search4letters('życie, wszechświat i cała reszta', 'eiru,!'))

@app.route('/entry')
def entry_page() -> 'html':
    return render_template('entry.html',
                             the_title='Welcome on website')
app.run()
