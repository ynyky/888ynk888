#!/usr/bin/python3
from flask import Flask, render_template, request
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
def log_request(req: 'flask_requst', res: str) -> None:
    with open('vsearch.log', 'a') as log:
        print(req, res, file=log)

@app.route('/search4', methods=['POST'])
def do_search() -> str:
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
@app.route('/viewlog')
def view_the_log() -> str:
    with open('vsearch.log') as log:
        contents = log.read()
        return contents
@app.route('/entry')

def entry_page() -> 'html':
    return render_template('entry.html',
                             the_title='Welcome on website')
if __name__ == '__main__':
    app.run(debug=True)

