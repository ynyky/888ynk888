
from functools import wraps

def decorator_name(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        # 1. Kod, który ma być wykonany PRZED wywołaniem dekorowanej funkcji.

        # 2. Wywołanie dekorowanej funkcji zgodnie z potrzebą,
        #    zwrócenie jej wyniku, jeśli to konieczne.
             return func(*args, **kwargs)

        # 3. Kod, który ma być wykonany ZAMIAST wywołania dekorowanej funkcji.
    return wrapper

