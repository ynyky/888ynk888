# Use an official Python runtime as a parent image
FROM python:3.9-slim
ARG SECRET_KEY=$SECRET_KEY
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
WORKDIR /code

ENV SECRET_KEY="default_xyz"
ENV POSTGRES_DB='test'
ENV POSTGRES_USER=test
ENV POSTGRES_PASSWORD='test'
ENV POSTGRES_DB_ADDRESS='test'
COPY ./app /code
RUN chmod +x entrypoint.sh
RUN apt-get update -y
RUN apt-get install -y build-essential python3-dev libpcre3-dev libssl-dev pip libpq-dev
RUN pip install virtualenv
RUN python -m venv $VIRTUAL_ENV
RUN pip uninstall decouple
RUN pip install django python-decouple psycopg2
RUN pip install --no-cache-dir -r /code/requirements.txt
EXPOSE 8080
ENTRYPOINT ["./entrypoint.sh"]

# I should ad it some tests
# no route , i don't have time
