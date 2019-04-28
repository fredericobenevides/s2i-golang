#!/bin/sh

# Define the environment APP_FOLDER used by assemble from openshift while building the imagestreams

# define the app root folder from /go/src/${root_folder}
export APP_ROOT_FOLDER=test.com

# define the app_folder
export APP_FOLDER=${APP_ROOT_FOLDER}/myapp
