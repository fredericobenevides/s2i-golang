#!/bin/sh

docker build -t s2i-golang .
s2i build test/test-app s2i-golang s2i-golang-app
