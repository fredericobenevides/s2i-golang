FROM golang:1.11.5

# Put the maintainer name in the image metadata
LABEL maintainer="Frederico Benevides <fredbene@gmail.com>"

# Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0
ENV GOCACHE /tmp

# Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building golang that accept live code reloading in development mode" \
      io.k8s.display-name="golang 1.11.5" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,golang,s2i" \
      io.openshift.s2i.scripts-url="image:///usr/local/s2i"

# Install required packages here:
RUN apt-get update -y \
  && apt-get install -y libnss-wrapper gettext \
  && apt-get install -y rsync \
  && apt-get clean

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Copy file to use with nss_wrapper
COPY files/nss_wrapper.sh /go/nss_wrapper.sh
COPY files/passwd.template /go/passwd.template

# Copy the S2I scripts to /usr/local/s2i
COPY ./s2i/bin/ /usr/local/s2i

# Drop the root user and make the content of /go owned by user 1000
RUN chown -R 0 /go
RUN chmod -R g+rw /go
RUN find /go -type d -exec chmod g+x {} +

# This default user
USER 1001

# Set the default port for applications built using this image
EXPOSE 8080

# Set the default CMD for the image
CMD ["/usr/local/s2i/usage"]
