

### build image
docker build -t cmssw/confdb .

### list images
docker images

### list of running containers
docker ps --no-trunc -aq

### remove all running containers
docker rm -f `docker ps --no-trunc -aq`

### run given image
docker run --rm -h `hostname -f` -v /tmp/vk:/etc/secrets -i -t cmssw/confdb /bin/bash

### remove existing image
docker rmi cmssw/confdb

### inspect running container
docker ps # find docker id
docker inspect <docker_id> | grep IPAddress

### push image to docker.com
docker push cmssw/confdb

### references
https://stackoverflow.com/questions/18497688/run-a-docker-image-as-a-container#18498313
https://stackoverflow.com/questions/17236796/how-to-remove-old-docker-containers#17237701
http://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/
