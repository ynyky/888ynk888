#!/bin/sh

cd polls/
python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --noinput
python manage.py loaddata fixtures/initial_data.json
uwsgi --ini uwsgi.ini