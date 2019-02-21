#!/bin/sh

docker build -t s2i-golang .
s2i build test/test.com/ s2i-golang s2i-golang-app
