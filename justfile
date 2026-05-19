# =============================================================================
# Configuration
# =============================================================================

REGISTRY := "forgejo.kevinhmchan.com"
OWNER := "kevinhmchan"
IMAGE := "ariang"

# Base image name without tag
BASE_IMAGE := REGISTRY + "/" + OWNER + "/" + IMAGE

# Git
GIT_HASH := `git rev-parse --short=8 HEAD`

# Final tags
IMAGE_GIT := BASE_IMAGE + ":" + GIT_HASH
IMAGE_LATEST := BASE_IMAGE + ":latest"

[doc('List available recipes')]
[group('justfile')]
default:
    @just -f {{ justfile() }} --list

[doc('Build ariang Docker image')]
[group('Docker')]
build:
    docker build \
        -t {{ IMAGE_GIT }} \
        -t {{ IMAGE_LATEST }} \
        .

[doc('Push both git hash and latest tags')]
[group('Docker')]
push:
    docker push {{ IMAGE_GIT }}
    docker push {{ IMAGE_LATEST }}

[doc('Build + push in one go')]
[group('Docker')]
release:
    just build && just push
