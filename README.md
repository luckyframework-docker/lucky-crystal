# Lucky Crystal

A minimal Docker image that has Lucky and Crystal in it. A Github action pushes up a new image whenever a tag is added here. The tag format right now is:

1. Full `lucky` version prefixed with `l`;
2. Full `crystal` version prefixed with `c`;
3. `-`
4. Linux distro.

Example:

`l0.22.0c0.35.0-alpine`

## Dockerhub

This image gets built and pushed to docker hub whenever the repo is tagged:

https://hub.docker.com/repository/docker/luckyframeworkdocker/lucky-crystal

## Future Ideas

* Add a default non-root user like Node does?
* Add a default entrypoint to `lucky init` to use as an executable?
* Nightly builds / regular builds instead of push only?
  * This would probably include more of a matrix of versions, linux distros etc.
