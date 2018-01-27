# Random image generator

*description should be here*

## Building app
```sh
$ docker build -t random-image-generator .
```

## Running app
```sh
$ docker run --rm -it -v $(pwd):/app random-image-generator sbcl --script /app/generate.lisp 10
```
