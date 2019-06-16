DOCKER = docker

TAG       = mc-dockerized
MCVERSION = 1.13.2
HOST_LOC  = $(PWD)/testing

##########################################################################

.PHONY: _checkadmin build prune run rund

build: _checkadmin
	docker build . -t $(TAG) \
		--build-arg MCVERSION=$(MCVERSION)

prune: _checkadmin
	docker system prune

rund: _checkadmin
	docker run \
		-p 45565:25565 -p 45575:25575 \
		-v $(HOST_LOC)/config:/etc/mcserver/config \
		-v $(HOST_LOC)/plugins:/etc/mcserver/plugins \
		-v $(HOST_LOC)/worlds:/etc/mcserver/worlds \
		-v $(HOST_LOC)/locals:/etc/mcserver/locals \
		-d \
		$(TAG)

run: _checkadmin
	docker run \
		-p 45565:25565 -p 45575:25575 \
		-v $(HOST_LOC)/config:/etc/mcserver/config \
		-v $(HOST_LOC)/plugins:/etc/mcserver/plugins \
		-v $(HOST_LOC)/worlds:/etc/mcserver/worlds \
		-v $(HOST_LOC)/locals:/etc/mcserver/locals \
		$(TAG)

_checkadmin:
	@if [ `whoami` != 'root' ]; then \
		printf "\n\n=== ERROR ===\nMAKEFILE MUST BE RUN AS ADMIN\n\n"; \
		exit 1; \
	fi

