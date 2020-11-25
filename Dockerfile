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

EXPOSE 5000

RUN cd /app
ENTRYPOINT ["./runGunicorn.sh"]