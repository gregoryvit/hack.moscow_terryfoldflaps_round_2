FROM python:3.7-alpine

MAINTAINER Gregory Berngardt

COPY requirements.txt requirements.txt

RUN apk --no-cache --update-cache add gcc gfortran build-base wget freetype-dev libpng-dev openblas-dev
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

RUN pip install -r requirements.txt

COPY app app

ENTRYPOINT [ "python" ]
CMD [ "app/app.py" ]