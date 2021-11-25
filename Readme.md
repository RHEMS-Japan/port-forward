Port Forwarding for Docker
==========================

Simple docker image to forward ports using socat.

## Usage

Define the following environment variables to configure port-forwarding.
In one definition, the three values ​​in the table below are separated by colons(:).

`FORWARD_{NAME}={LOCAL_PORT}:{REMOTE_HOST}:{REMOTE_PORT}`

Variable | Description 
-------- | ----------- 
NAME | If you include `FORWARD`, you can set it to any environment variable name you like.
LOCAL_PORT | Port where container listens 
REMOTE_HOST | IP or address of the host you want to forward traffic to 
REMOTE_PORT | Port on remote host to forward traffic to 

The `socat` process within the container will listen by default to port 80, use `-p`docker
flag to map the port of the local machine where it will listen to traffic to be forwarded.

```
docker run -e FORWARD_TEST=<local_port>:<remote_host>:<remote_port>  -p <exposed_local_port>:<local_port> rhemsjapan/port-forward
```

In addition, you can run multiple `socat` processes by setting multiple environment variables.
The following is a sample setting of AWS RDS and Redis in docker-compose.yml.

```
    environment:
      - FORWARD_RDS=3306:sample-rds.xxx.ap-northeast-1.rds.amazonaws.com:3306
      - FORWARD_ELASTICACHE=6379:sample-redis.xxx.apne1.cache.amazonaws.com:6379
```



## Examples

The following commands will all forward 8080 traffic to a remote machine located at www.rhems-japan.com
in the http port

```
docker run -e FORWARD_TEST=80:www.rhems-japan.com:80 -p 8080:80 rhemsjapan/port-forward
```

## Docker hub

Docker image hosted at Docker Hub:
https://github.com/RHEMS-Japan/port-forward
