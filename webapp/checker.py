from flask import session
from functools import wraps

def check_logged_in(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if 'logged in' in session:
            return func(*args, **kwargs)
        return 'Nie jesteś zalogowany'
    return wrapper