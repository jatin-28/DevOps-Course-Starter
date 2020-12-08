FROM python:3.7 as base

RUN mkdir /app 
WORKDIR /app

ENV PYTHONPATH=${PYTHONPATH}:${PWD} 
RUN pip3 install poetry

# DEVELOPMENT
FROM base as development
ENV FLASK_APP=app \
    FLASK_ENV=development
    
#RUN poetry install --no-dev    
    
CMD ["poetry", "run", "flask", "run"]

# RUN TESTS
FROM base as runtests
ENV FLASK_APP=app \
    FLASK_ENV=development

#RUN poetry install --no-dev
    
CMD poetry run pytest --junit-xml test_results.xml

# PRODUCTION
FROM base as production

COPY . /app

RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

RUN cd /app

RUN chmod 755 runGunicorn.sh
RUN mkdir -p /var/log/gunicorn

ENV FLASK_APP=app \
    FLASK_ENV=production

ENTRYPOINT ["./runGunicorn.sh"]


