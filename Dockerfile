FROM ubuntu:16.04

MAINTAINER Felipe Carlos Werlang <felipewer@gmail.com>

# Install JDK 8
RUN apt-get update && apt-get install -y software-properties-common curl && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN groupadd --gid 1000 developer && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash developer

RUN echo 'Downloading Intellij...' && \
	wget -O /tmp/intellij.tar.gz -q "https://download.jetbrains.com/idea/ideaIU-2016.3.2-no-jdk.tar.gz" && \
	echo 'Installing Intellij...' && \
    tar -xf /tmp/intellij.tar.gz -C /opt && \
    rm /tmp/intellij.tar.gz

USER developer:developer
ENV HOME /home/developer
WORKDIR /home/developer

CMD ["/opt/idea-IU-163.10154.41/bin/idea.sh"]
