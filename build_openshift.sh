#!/bin/bash

if [ -z "$1" ]; then
  echo "Argument should have the project namespace"
  exit 1
fi

eval $(minishift oc-env)


echo "Login on openshift's repository"
docker login -u `oc whoami` -p `oc whoami -t` 172.30.1.1:5000

echo "Building using openshift's environment"
./build.sh

echo "Creating the tag"
docker tag s2i-golang 172.30.1.1:5000/$1/s2i-golang

echo "Pushing to openshift's repostiroy"
docker push 172.30.1.1:5000/$1/s2i-golang
