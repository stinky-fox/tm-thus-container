###############################################
#   Trend Micro CLI for C1 as a container     #
#   Version: early alpha                      #
#   Alpine Linux based with python 3.9        #
#   and jq included                           #
###############################################

# Pick up the image 
FROM alpine:latest


# Reserved for the future usage



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
