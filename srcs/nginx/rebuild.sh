#! bin/bash

docker rmi -f nginx-image
docker build . -t nginx-image
