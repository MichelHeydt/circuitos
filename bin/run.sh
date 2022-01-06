#!/bin/sh

CONTAINER_NAME="b2c_tours_up"
IMAGE_NAME="ruby_slim"

stop_container_if_already_running()
{
  echo -e " \n*** Stop container ***"
  docker stop ${CONTAINER_NAME}
  echo -e "\n*** Remove container ***"
  docker rm ${CONTAINER_NAME} -f
  echo -e "\n"
}

check_image_exist()
{
  echo -e "List of the available images \n"
  docker images -a | grep "b2c_" | awk '{print $3}' | xargs docker rmi -f
  docker images
  if docker images | grep -w "${IMAGE_NAME}"
  then
  echo -e "\n*** Image already exists. We can run container... ***\n"
  else
  echo -e "\n ** No Image found, please build image"
  build_image
  fi
}

build_image()
{
  echo -e "\n*** Building the image ***\n"
  docker build -t ${IMAGE_NAME} -f Dockerfile .
  echo -e "\n*** Finished building the image ***\n"
}

exec_container()
{
  echo "Run container"
  docker run --shm-size=2g --name ${CONTAINER_NAME} -v $PWD:/app ${IMAGE_NAME} \
  # docker run --shm-size=2g --name ${CONTAINER_NAME} -v /tmp/.X11-unix:/tmp/.X11-unix \
	# -v $PWD:/app ${IMAGE_NAME} \
   sh -c "bundle exec cucumber chrome_headless=true prod=true -t@002"
   exit $?
}

stop_container_if_already_running
check_image_exist
exec_container
stop_container_if_already_running
