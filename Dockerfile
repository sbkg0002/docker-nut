FROM alpine as downloader
RUN apk add --upgrade git
WORKDIR /git
RUN git clone --depth 1 --branch master https://github.com/blawar/nut.git /git/nut

FROM python:3-alpine

RUN apk update && apk upgrade --no-cache && apk add --upgrade --no-cache gcc python3-dev jpeg-dev zlib-
RUN  pip3 install --upgrade setuptools pip colorama requests bs4 tqdm unidecode Pillow urllib3 pyusb go

COPY --from=downloader /git/nut/ /nut

ENTRYPOINT [ "/usr/local/bin/python", "/nut/nut.py", "--usb" ]
