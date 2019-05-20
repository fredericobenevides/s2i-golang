#!/bin/bash

run_development() {
  docker run --rm -p 8080:8080 -e APP_ENV="development" -e RUN_DEP="true" s2i-golang-app /usr/libexec/s2i/run
}

bash_development() {
  docker run --rm -p 8080:8080 -e APP_ENV="development" -e RUN_DEP="true" -it s2i-golang-app /bin/bash

}

run_production() {
  docker run --rm -p 8080:8080 -e APP_ENV="production" -e RUN_DEP="true" s2i-golang-app /usr/libexec/s2i/run
}

# run_development
bash_development


