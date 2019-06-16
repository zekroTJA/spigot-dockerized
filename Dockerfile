FROM openjdk:11.0.3-jdk-stretch

LABEL maintainer="contact@zekro.de"
LABEL version="1.1.0"
LABEL description="Minecraft spigot dockerized with selectable version on build and customizable start parameters."

### VARIABLES ###################################

ARG MCVERSION="latest"

#################################################

RUN apt update -y &&\
    apt install -y \
    git \
    dos2unix

RUN mkdir -p /var/mcserver &&\
    mkdir -p /etc/mcserver/worlds &&\
    mkdir -p /etc/mcserver/plugins &&\
    mkdir -p /etc/mcserver/config &&\
    mkdir -p /etc/mcserver/locals

WORKDIR /var/mcserver

ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar .

# This is just for debugging purposes
# ADD https://cdn.getbukkit.org/spigot/spigot-${MCVERSION}.jar .

ADD ./scripts ./scripts
ADD ./config  ./config

RUN java -jar BuildTools.jar --rev $MCVERSION

RUN dos2unix /var/mcserver/*/*.sh

EXPOSE 25565
EXPOSE 25575

WORKDIR /etc/mcserver/locals

ENV MCV ${MCVERSION}

CMD bash /var/mcserver/scripts/runner.sh \
        /etc/mcserver/config/jvmsettings.sh \
        /var/mcserver/config/jvmsettings.sh \
        /var/mcserver/spigot-${MCV}.jar \
        /etc/mcserver/config \
        /etc/mcserver/plugins \
        /etc/mcserver/worlds \
        /etc/mcserver/locals/eula.txt