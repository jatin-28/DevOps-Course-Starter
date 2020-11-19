#!/bin/bash
poetry run gunicorn --workers=2 --threads=4 --worker-class=gthread --bind 0.0.0.0:5000  --error-logfile /var/log/gunicorn/gunicorn_error.log --log-file /var/log/gunicorn/gunicorn.log 'wsgi:create_app()'
