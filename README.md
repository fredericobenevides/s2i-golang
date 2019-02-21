
# Creating a basic S2I builder image

This source to image create a image to work with golang in development or
production mode.

## Development mode

Development mode allows to use the image with hot code using the lib
CompileDaemon.

This is the default mode for this image

## Production mode

Production mode will build the main go app and execute it.

To use this mode it needs to set up the environment APP_ENV=production

## Build and Running the S2I

Development mode allows to use hot code using the lib CompileDaemon.

To build this s2i, you can run the command

`$ ./build.sh`

To run this image in development mode:

`$ docker run -d -p 8080:8080 s2i-golang-app`

To run in production mode:

`$ docker run -d -p 8080:8080 -e APP_ENV=production s2i-golang-app`

To run manually access with the following command

`$ docker run -p 8080:8080 -it s2i-golang-app /bin/bash`
`$ cd /go/src/test.com/myapp`
`$ go run main.go`


## More info

The repository of this S2I in dockerhub is: fredericobenevides/s2i-golang.
