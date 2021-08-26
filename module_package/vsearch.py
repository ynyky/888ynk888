
def search4vowels(phrase: str) -> set:
    """Zwraca samogłoski znalezione w słowie podanym jako argument."""
    vowels = set('aeiou')
    return vowels.intersection(set(phrase))


def search4letters(phrase: str, letters: str='aeiou') -> set:
    """Zwraca zbiór liter ze zmiennej letters znalezionych
       w zmiennej phrase."""
    return set(letters).intersection(set(phrase))
