# UVMHS-Nix

A nix flake and docker image for [UVMHS]() development.

## Develop Natively

Run
```shell
nix develop
```
to enter the shell.

## Building the Docker Image

Generate the image via Nix
```shell
nix build .#dockerImage
```

Run the image
```shell
docker load < result
```
