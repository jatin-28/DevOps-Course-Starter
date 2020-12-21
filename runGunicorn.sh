#!/bin/bash
LOG_PATH=/var/log/gunicorn
poetry run gunicorn --workers=2 --threads=4 --worker-class=gthread --bind 0.0.0.0:5000  --error-logfile $LOG_PATH/gunicorn_error.log --log-file $LOG_PATH/gunicorn.log 'todoapp.wsgi:create_app()'
