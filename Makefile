
LOGIN_USERNAME=$(shell echo "$DOCKER_LOGIN_USERNAME")
LOGIN_PASSWORD=$(shell echo "$DOCKER_LOGIN_PASSWORD")
CACHED=$(TAG)

.PHONY: build deploy ci

default: build

build:
	@echo "building arch"
	@cd arch && ./build $(TAG)
	@echo "building debian"
	@cd debian && ./build $(TAG)
	@echo "building ubuntu bionic"
	@cd ubuntu/bionic && ./build $(TAG)
	@echo "building ubuntu cosmic"
	@cd ubuntu/cosmic && ./build $(TAG)
deploy:
	@echo "logging into docker"
	@docker login -u $(LOGIN_USERNAME) -p $(LOGIN_PASSWORD)
	@echo "deplying arch"
	@cd arch && ./deploy $(TAG)
	@echo "deplying debian"
	@cd debian && ./deploy $(TAG)
	@echo "deplying ubuntu bionic"
	@cd ubuntu/bionic && ./deploy $(TAG)
	@echo "deplying ubuntu cosmic"
	@cd ubuntu/cosmic && ./deploy $(TAG)
ci: build deploy