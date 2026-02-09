SHELL := /usr/bin/env bash
# ^^^ use bash syntax, mitigates dash's printf on Debian(Ubuntu?), works on MacOS.

# Detect if podman is available, otherwise use docker.
CONTAINER_CMD := $(shell if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)

# The container name
IMAGE_NAME = amd-strix-halo-comfyui-f43

# Use version from the user or autodetect the latest.
VERSION := 0.0.0



.PHONY: help
help:
	@echo
	@echo "▍Help"
	@echo "▀▀▀▀▀▀"
	@echo
	@echo "Available targets:"
	@echo "    all, image:   Create the container image."
	@echo "    toolbox:      Create a toolbox from the container image."
	@echo "    clean:        Clean all generated files and images."
	@echo
	@echo "Usage:"
	@echo "    make image"
	@echo "    make image VERSION=0.3.11  # Build specific (older) version"
	@echo
	@echo "Developer info:"
	@printf -- "- CONTAINER_CMD=%q, VERSION=%q.\n\n" "$(CONTAINER_CMD)" "$(VERSION)"



.PHONY: all
all: image



.PHONY: image
image:
	"$(CONTAINER_CMD)" build --build-arg VERSION=$(VERSION) --platform linux/amd64 \
            --tag localhost/$(IMAGE_NAME):$(VERSION) --tag localhost/$(IMAGE_NAME):latest .



.PHONY: toolbox
toolbox:
	toolbox create "$(IMAGE_NAME)" --image "localhost/$(IMAGE_NAME):$(VERSION)" -- \
		--device /dev/dri --device /dev/kfd --group-add video --group-add render --security-opt seccomp=unconfined



.PHONY: clean
clean:
	-"$(CONTAINER_CMD)" image rm "localhost/$(IMAGE_NAME):$(VERSION)" "localhost/$(IMAGE_NAME):latest"
