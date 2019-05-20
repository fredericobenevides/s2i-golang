FROM openshift/base-centos7

# Put the maintainer name in the image metadata
LABEL maintainer="Frederico Benevides <fredbene@gmail.com>"

ENV \
  APP_ROOT="/opt/app-root" \
  GO_VERSION="1.12" \
  GO_PATCH_VERSION="5" \
  GOPATH="/opt/app-root" \
  GOROOT="/opt/app-root/go" \
  GOBIN="/opt/app-root/go/bin" \
  PATH="${PATH}:/opt/app-root/go/bin"

# Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building golang that accept live code reloading in development mode" \
      io.k8s.display-name="Go ${GO_VERSION}" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,s2i,go,golang,go${GO_VERSION}"

# Install required packages here:
RUN \
  yum install -y rsync \
  && yum clean all -y

# Install go
RUN \
  curl -L https://dl.google.com/go/go${GO_VERSION}.${GO_PATCH_VERSION}.linux-amd64.tar.gz  \
  | tar -xz -C ${APP_ROOT}

# Install dep
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Install air
RUN curl -fLo ${APP_ROOT}/.air \
    https://raw.githubusercontent.com/cosmtrek/air/master/bin/linux/air \
    && chmod +x ${APP_ROOT}/.air

# Copy the S2I scripts to $STI_SCRIPTS_PATH
COPY ./s2i/ $STI_SCRIPTS_PATH

# Drop the root user and make the content of /go owned by user 1000
RUN chown -R 1001:0 ${APP_ROOT}
RUN chmod -R g+rw ${APP_ROOT}
RUN find ${APP_ROOT} -type d -exec chmod g+x {} +

# This default user
USER 1001

# Set the default port for applications built using this image
EXPOSE 8080

# Set the default CMD for the image
CMD ["$STI_SCRIPTS_PATH/usage"]
