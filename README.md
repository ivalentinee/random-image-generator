# Random image generator

Simple script to generate sample images. It draws colored circles with text "Test image #N".

Images are hardcoded to 1920x1080 resolution.

## A note on history of this project
I was young and naive so I wrote this app in common lisp. Sorry.

## Building app
```sh
$ docker build -t random-image-generator .
```

## Running app
```sh
$ docker run --rm -it -v $(pwd):/app random-image-generator sbcl --script /app/generate.lisp 10
```

Where `10` is number of images required.
