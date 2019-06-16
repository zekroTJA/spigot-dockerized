# Minecraft Spigot Dockerized  🐳 💎

<a href="https://hub.docker.com/r/zekro/spigot-dockerized"><img alt="Docker Cloud Automated build" height="30" src="https://img.shields.io/docker/cloud/automated/zekro/spigot-dockerized.svg?color=cyan&logo=docker&logoColor=cyan&style=for-the-badge"></a>&nbsp;
<img height="30" src="https://forthebadge.com/images/badges/built-with-grammas-recipe.svg" />

## Self-Build Image

You can build your spigot Docker image for whatever Minecraft version supported by the official [spigot build tools](https://www.spigotmc.org/wiki/buildtools/#versions).

*This command below will create a Docker image with spigot supporting Minecraft version 1.13.2.*
```
# git clone https://github.com/zekroTJA/spigot-dockerized
# docker build . -t spigot-dockerized:1.13.2 \
    --build-arg MCVERSION="1.13.2"
```

## Starting Image Container

You need to bind the Minecraft server port (`25565`) and the RCON port (`25575`) to the host system. Also, you need to mount the configs location (`/etc/mcserver/config`), the plugins location (`/etc/mcserver/plugins`), the worlds container location (`/etc/mcserver/worlds`) and the location of local files like `ops.json` oder `banned-players.json` (`/etc/mcserver/locals`).

```
# docker run \
    -p 25565:25565 -p 25575:25575 \
    -v /home/mc/config:/etc/mcserver/config \
    -v /home/mc/plugins:/etc/mcserver/plugins \
    -v /home/mc/worlds:/etc/mcserver/worlds \
    -v /home/mc/locals:/etc/mcserver/locals \
    -d \
    spigot-dockerized:1.13.2
```
