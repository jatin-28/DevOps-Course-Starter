FROM python:3.7
RUN mkdir /app 
COPY . /app

WORKDIR /app

RUN chmod 755 runGunicorn.sh
RUN mkdir -p /var/log/gunicorn

ENV PYTHONPATH=${PYTHONPATH}:${PWD} 
RUN pip3 install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

#CMD ["poetry", "run", "gunicorn", "--daemon", "--bind", "0.0.0.0:5000", "-w", "1", "'wsgi:create_app()'", "--error-logfile", "/var/log/gunicorn/gunicorn_error.log,", "--log-file", "/var/log/gunicorn/gunicorn.log"]
#CMD ["poetry", "run", "gunicorn", "--bind", "0.0.0.0:5000", "-w", "1", "'wsgi:create_app()'", "--error-logfile", "/var/log/gunicorn/gunicorn_error.log,", "--log-file", "/var/log/gunicorn/gunicorn.log"]

EXPOSE 5000

RUN cd /app
ENTRYPOINT ["./runGunicorn.sh"]
#CMD ["poetry", "run", "flask", "run"]