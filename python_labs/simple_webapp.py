
from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello():
    return 'Witaj, świecie, tu prosta aplikacja WWW.'


@app.route('/page1')
def page1():
    return 'To jest strona  1.'


@app.route('/page2')
def page2():
    return 'To jest strona  2.'


@app.route('/page3')
def page3():
    return 'To jest strona  3.'


if __name__ == '__main__':
    app.run(debug=True)
