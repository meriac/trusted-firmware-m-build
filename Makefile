IMAGE_TAG:="docker.io/meriac/tfm-dev"

.PHONY: run compile docker-build docker-publish docker-run docker-clean

run: docker-run

compile:
	rm -rf build
	mkdir -p build
	cd build && cmake ../submodules/trusted-firmware-m -G"Unix Makefiles" -DTARGET_PLATFORM=AN521 -DCOMPILER=GNUARM
	cmake --build build -- install

docker-build:
	docker build -t $(IMAGE_TAG) .
	docker history $(IMAGE_TAG)

docker-publish: docker-build
	docker push $(IMAGE_TAG)

docker-run:
	docker run --rm -ti -v $(CURDIR):/home/build/shared:Z $(IMAGE_TAG)

docker-clean:
	DOCKER_CONTAINERS="$(strip $(shell docker ps -a -q --filter ancestor=$(IMAGE_TAG)))"; \
	if [ "$$DOCKER_CONTAINERS" ]; then docker rm  -f $$DOCKER_CONTAINERS; fi

	DOCKER_IMAGES="$(strip $(shell docker images -q $($IMAGE_TAG)))"; \
	if [ "$$DOCKER_IMAGES" ]; then docker rmi -f $$DOCKER_IMAGES; fi
