# docker-image-prune
cleans up dangling docker images

# bash
```bash
# you might need "sudo" for the below command
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -e CRONSCHEDULE="0 0 0 * * *" shuliyey/docker-image-prune
```
