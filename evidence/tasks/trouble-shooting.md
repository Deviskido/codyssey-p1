


사례1

이미 존재하는 이미지명으로 빌드 하는 경우 원래 이미지는 이름을 뺐긴다. 
이미지들을 삭제하고 다시 시도하라.
```
docker images
REPOSITORY     TAG       IMAGE ID       CREATED        SIZE
codyssey-web   1.1       cf33ad749475   23 hours ago   62.4MB
codyssey-web   1.0       3221e95fa79d   13 days ago    78.2MB
hello-world    latest    e2ac70e7319a   4 months ago   10.1kB
% docker build -t codyssey-web:1.0 .
[+] Building 1.6s (7/7) FINISHED                                                                                  docker:orbstack
 => [internal] load build definition from Dockerfile                                                                         0.1s
 => => transferring dockerfile: 245B                                                                                         0.0s
 => [internal] load metadata for docker.io/library/nginx:alpine                                                              1.0s
 => [internal] load .dockerignore                                                                                            0.0s
 => => transferring context: 2B                                                                                              0.0s
 => [internal] load build context                                                                                            0.1s
 => => transferring context: 59B                                                                                             0.0s
 => [1/2] FROM docker.io/library/nginx:alpine@sha256:4a73073bd557c65b759505da037898b61f1be6cbcc3c2c3aeac22d2a470c1752        0.0s
 => CACHED [2/2] COPY app/ /usr/share/nginx/html/                                                                            0.0s
 => exporting to image                                                                                                       0.1s
 => => exporting layers                                                                                                      0.0s
 => => writing image sha256:cf33ad74947509eb07731bf5cddedc96d356fb4d8b9ba484f47b1333b1bb4099                                 0.0s
 => => naming to docker.io/library/codyssey-web:1.0                                                                          0.0s
% docker images
REPOSITORY     TAG       IMAGE ID       CREATED        SIZE
codyssey-web   1.0       cf33ad749475   23 hours ago   62.4MB
codyssey-web   1.1       cf33ad749475   23 hours ago   62.4MB
<none>         <none>    3221e95fa79d   13 days ago    78.2MB
hello-world    latest    e2ac70e7319a   4 months ago   10.1kB
```

docker rmi로 삭제한뒤 다시 빌드하라.

사례2

프로세스를 이미 실행중인경우는 docker rm -f를 사용해서 지워야한다.
```
docker ps -a
CONTAINER ID   IMAGE              COMMAND                  CREATED          STATUS                      PORTS                                     NAMES
f0d7acd6a174   hello-world        "/hello"                 2 minutes ago    Exited (0) 2 minutes ago                                              nostalgic_ptolemy
cdca5504184e   codyssey-web:1.1   "/docker-entrypoint.…"   8 minutes ago    Up 8 minutes                0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   codyssey-custom-image
6010189c7a39   3221e95fa79d       "sh"                     11 minutes ago   Exited (0) 11 minutes ago                                             hello-world
63a580c197d0   hello-world        "/hello"                 15 minutes ago   Exited (0) 15 minutes ago                                             stupefied_pare
% docker rm codyssey-custom-image
Error response from daemon: cannot remove container "codyssey-custom-image": container is running: stop the container before removing or force remove
% docker rm -f codyssey-custom-imnage
```