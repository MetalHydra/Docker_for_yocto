#!/bin/bash

SERVICE_NAME="docker"
IMAGE_NAME="yocto_dev:v1"
CONTAINER_NAME="yocto_dev_container"

if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "$SERVICE_NAME is running"
else
    echo "$SERVICE_NAME is not running, it will start now"
    systemctl start "$SERVICE_NAME"
fi

if docker image inspect $IMAGE_NAME >/dev/null 2>&1; then
    echo "Image exists locally, nothing to do"
else
    echo "Image does not exist. start building from Dockerfile"
    docker build -t $IMAGE_NAME . --no-cache
fi

if docker inspect "$CONTAINER_NAME" > /dev/null 2>&1; then
    echo "The container $CONTAINER_NAME exists."
else
    echo "The container $CONTAINER_NAME does not exist. start creating."
    docker create -it --name $CONTAINER_NAME -v /home/dennis/yocto:/home/dev/yocto $IMAGE_NAME
fi

if $(docker inspect -f '{{.State.Status}}' "$CONTAINER_NAME" | grep -q "running"); then
        echo "The container $CONTAINER_NAME is running."
    else
        echo "The container $CONTAINER_NAME is not running. the container will be started."    
        docker start "$CONTAINER_NAME"
fi

docker exec -it $CONTAINER_NAME /bin/bash
