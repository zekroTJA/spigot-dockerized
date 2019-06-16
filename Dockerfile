FROM openjdk:11.0.3-jdk-stretch

LABEL maintainer="contact@zekro.de"

### VARIABLES ###################################

ARG MCVERSION="1.13.2"

#################################################

RUN apt install -y \
    git

RUN mkdir -p /var/mcserver &&\
    mkdir -p /etc/mcserver/worlds &&\
    mkdir -p /etc/mcserver/plugins &&\
    mkdir -p /etc/mcserver/config

WORKDIR /var/mcserver

ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar .
ADD ./scripts ./scripts

RUN java -jar BuildTools.jar --rev $MCVERSION

RUN printf "\neula=true" | tee eula.txt

EXPOSE 25565
EXPOSE 25575

ENV MCV ${MCVERSION}

CMD bash ./scripts/runner.sh \
        /etc/mcserver/config/jvmsettings.sh \
        spigot-${MCV}.jar \
        /etc/mcserver/config \
        /etc/mcserver/plugins \
        /etc/mcserver/worlds