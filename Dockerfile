FROM ubuntu

RUN apt update -qq && \
    apt install -y sbcl curl libev4 imagemagick --no-install-recommends && \
    apt clean

# RUN curl -O https://beta.quicklisp.org/quicklisp.lisp && \
#     sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)'

RUN mkdir -p /app/
WORKDIR /app/

ADD . /app
