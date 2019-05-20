#!/bin/bash

# run development
run_development() {
  docker run --rm -p 8080:8080 -e APP_ENV="development" -e RUN_DEP="true" s2i-golang-app /usr/libexec/s2i/run
}

# run production
run_production() {
  docker run --rm -p 8080:8080 -e APP_ENV="production" -e RUN_DEP="true" s2i-golang-app /usr/libexec/s2i/run
}

run_development


