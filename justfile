REGISTRY := "forgejo.kevinhmchan.com"
OWNER := "kevinhmchan"
IMAGE := "ariang"
GIT_HASH := `git rev-parse --short HEAD`
FULL_IMAGE_NAME := REGISTRY + '/' + OWNER + '/' + IMAGE + ':' + GIT_HASH

[doc('List available recipes')]
[group('justfile')]
default:
    @just -f {{ justfile() }} --list

[doc('Build ariang image')]
[group('Docker')]
build:
    docker build -t {{ FULL_IMAGE_NAME }} .
