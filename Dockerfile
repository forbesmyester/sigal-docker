FROM ubuntu:artful

EXPOSE 80

VOLUME /pictures

RUN apt-get update && apt-get install -y \
    python-dev \
    python-pip \
    zlib1g-dev \
    libjpeg-dev \
    libfreetype6-dev \
    lighttpd \
    wget \
 && rm -rf /var/lib/apt/lists/*
RUN pip install sigal

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 && chmod +x /usr/local/bin/dumb-init
RUN mkdir /proj
WORKDIR /proj
COPY ./lighttpd.conf ./run ./sigal.conf.py /proj/

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["./run"]

