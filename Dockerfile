FROM alpine:3.9

# Put the maintainer name in the image metadata
LABEL maintainer="Frederico Benevides <fredbene@gmail.com>"

ENV \
  APP_ROOT=/opt/app-root \
  GOPATH=/opt/app-root \
  GOBIN=/opt/app-root/bin \
  HOME=/opt/app-root/src \
  STI_SCRIPTS_PATH=/usr/local/s2i \
  PATH=${PATH}:/opt/app-root/bin

# Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building golang that accept live code reloading in development mode" \
      io.k8s.display-name="Go 1.11.5" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
      io.openshift.tags="builder,s2i,go,golang,go${GO_VERSION}"

# Install required packages here:
RUN apk update \
  && apk add --no-cache bash curl findutils git go make musl-dev rsync

RUN mkdir -p ${APP_ROOT}/src ${APP_ROOT}/bin

# Install dep
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Install air
RUN curl -fLo ${GOBIN}/.air \
    https://raw.githubusercontent.com/cosmtrek/air/master/bin/linux/air \
    && chmod +x ${GOBIN}/.air

# Copy the S2I scripts to $STI_SCRIPTS_PATH
COPY ./s2i/ $STI_SCRIPTS_PATH

# Copy extra files to the image.
COPY ./files/fix-permissions /usr/local/bin

# Add the default user and change permission
RUN \
    adduser -u 1001 -S -G root -h ${HOME} -s /sbin/nologin default \
    && chown -R 1001:0 ${APP_ROOT}

WORKDIR ${HOME}

# This default user
USER 1001

# Set the default port for applications built using this image
EXPOSE 8080

# Set the default CMD for the image
CMD ["$STI_SCRIPTS_PATH/usage"]
