#!/bin/bash

xhost +

image="latex"
tag="latest"
exec_pwd=$(cd $(dirname $0); pwd)
home_dir="/home/user"

docker run \
	-it \
	--rm \
	-e local_uid=$(id -u $USER) \
	-e local_gid=$(id -g $USER) \
	--net=host \
	--privileged \
	-e "DISPLAY" \
	-v "/tmp/.X11-unix:/tmp/.X11-unix" \
	-v $exec_pwd/mount:$home_dir/latex_ws \
	$image:$tag