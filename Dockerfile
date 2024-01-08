#
# Scala and Mill Dockerfile
#
# https://github.com/nightscape/scala-mill
#

# Pull base image
FROM timbru31/java-node:17-jdk-hydrogen

# Env variables
ENV SCALA_VERSION 2.13.10
ENV MILL_VERSION 0.11.6

# Define working directory
# WORKDIR /root

RUN npm --version

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

# Install mill
RUN \
  curl -L -o /usr/local/bin/mill https://github.com/lihaoyi/mill/releases/download/$MILL_VERSION/$MILL_VERSION && \
  chmod +x /usr/local/bin/mill && \
  touch build.sc && \
  mill -i resolve _ && \
  rm build.sc
