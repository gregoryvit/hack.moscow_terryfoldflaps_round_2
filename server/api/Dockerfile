FROM python:3.7-alpine

MAINTAINER Gregory Berngardt

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY app app

ENTRYPOINT [ "python" ]
CMD [ "app/app.py" ]