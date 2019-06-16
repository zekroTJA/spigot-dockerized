DOCKER = docker

TAG    = mc-dockerized

##########################################################################

.PHONY: _checkadmin build prune

build: _checkadmin
	docker build . -t $(TAG)

prune: _checkadmin
	docker system prune

run: _checkadmin
	docker run \
		-p 45565:25565 -p 45575:25575 \
		-v $(PWD)/testing/config:/etc/mcserver/config \
		-v $(PWD)/testing/plugins:/etc/mcserver/plugins \
		-v $(PWD)/testing/worlds:/etc/mcserver/worlds \
		mc-dockerized

_checkadmin:
	@if [ `whoami` != 'root' ]; then \
		printf "\n\n=== ERROR ===\nMAKEFILE MUST BE RUN AS ADMIN\n\n"; \
		exit 1; \
	fi

