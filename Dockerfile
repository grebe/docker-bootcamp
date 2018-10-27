FROM jupyter/minimal-notebook

USER root

RUN echo 'deb http://cdn-fastly.deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends \
    curl verilator openssh-client && \
    apt-get install --no-install-recommends -t jessie-backports -y openjdk-8-jre-headless openjdk-8-jdk-headless ca-certificates-java && \
    rm /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

RUN cd && git clone -b v0.1.9 https://github.com/almond-sh/almond.git \
    cd almond \
    curl -L -o coursier https://git.io/coursier && chmod +x coursier \
    SCALA_VERSION=2.11.12 ALMOND_VERSION=0.1.9 \
    ./coursier bootstrap \
        -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
        sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
        -o almond \
    ./almond --install

# USER root

Add generator-bootcamp generator-bootcamp

# RUN cd && chown -R $NB_USER generator-bootcamp

# USER $NB_USER

