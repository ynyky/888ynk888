
from flask import Flask, session

from checker import check_logged_in

app = Flask(__name__)


@app.route('/')
def hello():
    return 'Witaj, świecie, tu prosta aplikacja WWW.'


@app.route('/page1')
@check_logged_in
def page1():
    return 'To jest strona  1.'


@app.route('/page2')
@check_logged_in
def page2():
    return 'To jest strona  2.'


@app.route('/page3')
@check_logged_in
def page3():
    return 'To jest strona  3.'


@app.route('/login')
def do_login() -> str:
    session['logged_in'] = True
    return 'Teraz jesteś zalogowany.'


@app.route('/logout')
def do_logout() -> str:
    session.pop('logged_in')
    return 'Teraz jesteś wylogowany.'


app.secret_key = 'NigdyNieZgadnieszMojegoTajnegoKlucza'

if __name__ == '__main__':
    app.run(debug=True)
