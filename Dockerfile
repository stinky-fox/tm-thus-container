###############################################
#   Trend Micro CLI for C1 as a container     #
#   Version: early alpha                      #
#   Alpine Linux based with python 3.9        #
#   and jq included                           #
###############################################

# Pick up the image 
FROM alpine:latest


# Reserved for the future usage



# Labeling
LABEL maintainer="stinky-fox" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="stinky-fox" \
      org.label-schema.name="THUS CLI" \
      org.label-schema.license="no license" \
      org.label-schema.description="The THUS CLI is being used to manage Cloud One environment." \
      org.label-schema.vcs-url="https://github.com/stinky-fox/tm-thus-container.git" \
      org.label-schema.docker.cmd="docker run -d -v /path/to/config:/root/.thus/config -v /path/to/credentials:/root/.thus/credentials puffago/tm-thus-container:latest"


# Create install and thus folders. /install folder will be deleted.

RUN mkdir -p /install/python && mkdir -p ~/.thus/

# Install and configure thus in a single layer.

RUN apk add --no-cache --virtual 'temp-utils' \
    dos2unix \
    gcc \
    make \
    g++ \
    libffi-dev \
    openssl-dev \
    zlib-dev \
    git && \
    apk add --no-cache jq bash && \
    git clone --branch 3.9 https://github.com/python/cpython.git /install/python && \
    cd /install/python/ && \
    ./configure --with-ensurepip=install --enable-optimizations && \
    make install -j3 && \
    pip3 install tm-thus && \
    cat /usr/local/bin/thus_completer_bash.sh >> ~/.bashrc && \
    dos2unix ~/.bashrc &&\
    apk del 'temp-utils' && \
    rm -rf /install

# set SHELL

SHELL ["/bin/bash", "-c"]

# set CMD

CMD ["bash"]
