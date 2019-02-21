
# Creating a basic S2I builder image

This source to image create a imagem to work with golang in development or
production mode.

## Build and Running

Development mode allows to use hot code using the lib CompileDaemon.

To build this s2i, you can run the command

`$ ./build.sh`

To run this image in development mode:
`$ docker run -d -p 8080:8080 s2i-golang-app`

To run in production mode:
`$ docker run -p 8080:8080 -e APP_ENV=production -it s2i-golang-app /bin/bash`
