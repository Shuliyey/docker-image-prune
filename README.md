# docker-image-prune
cleans up dangling docker images

# bash
```bash
docker run -d -v /var/run/docker.socket:/var/run.docker.socket -e CRONSCHEDULE="0 0 0 * * *" shuliyey/docker-image-prune
```
