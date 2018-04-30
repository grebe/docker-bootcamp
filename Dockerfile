FROM jupyter/minimal-notebook

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl verilator openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo 'deb http://cdn-fastly.deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get -y update && \
    apt-get install --no-install-recommends -t jessie-backports -y openjdk-8-jre-headless openjdk-8-jdk-headless ca-certificates-java && \
    rm /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

RUN cd && git clone https://github.com/jupyter-scala/jupyter-scala.git && \
   cd jupyter-scala && ./jupyter-scala

RUN cd && git clone https://github.com/ucb-art/dsp-framework.git;  \
   cd dsp-framework && ./update.bash no_hwacha && SBT="java -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256m -Xmx8G -Xss128M -jar $PWD/rocket-chip/sbt-launch.jar" make libs;  cd && rm -rf dsp-framework

USER root

Add generator-bootcamp generator-bootcamp

RUN cd && chown -R $NB_USER generator-bootcamp

USER $NB_USER

