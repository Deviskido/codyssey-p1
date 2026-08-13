# Dockerfile 기반 커스텀 웹 이미지 제작 및 운영 검증

## 구성 선택

- 베이스 이미지: `nginx:alpine`
  - NGINX 웹 서버가 준비되어 있어 정적 콘텐츠를 바로 제공할 수 있습니다.
  - Alpine Linux 기반이라 일반 NGINX 이미지보다 크기가 작습니다.
- `COPY app/ /usr/share/nginx/html/`
  - 프로젝트의 `app/index.html`을 NGINX 기본 콘텐츠 대신 제공하기 위한 커스텀 요소입니다.
- `EXPOSE 80`
  - 컨테이너의 웹 서버가 80번 포트를 사용한다는 정보를 명시합니다.

사용한 Dockerfile은 다음과 같습니다.

```dockerfile
FROM nginx:alpine

COPY app/ /usr/share/nginx/html/

EXPOSE 80
```

## 이미지 빌드

```console
$ docker build -t codyssey-web:1.0 .
#0 building with "orbstack" instance using docker driver
#1 [internal] load build definition from Dockerfile
#2 [internal] load metadata for docker.io/library/nginx:alpine
#5 [internal] load build context
#6 [2/2] COPY app/ /usr/share/nginx/html/
#7 exporting to image
#7 writing image sha256:744cded79a1cad784175afdfbb5ed786b83f3e56c9e505037d0817dfa6039ae6 done
#7 naming to docker.io/library/codyssey-web:1.0 done
#7 DONE 0.2s
```

이미지가 정상적으로 빌드되었으며 `codyssey-web:1.0` 태그가 생성되었습니다.

## 컨테이너 실행 및 이미지·상태 확인

```console
$ docker images
REPOSITORY     TAG       IMAGE ID       CREATED          SIZE
codyssey-web   1.0       744cded79a1c   24 seconds ago   62.4MB

$ docker run -d --name codyssey-web-ops codyssey-web:1.0
a8f54cfd7c81e445436cf7b7c8c244eb6cc2f33831e005a4da250753efa8a085

$ docker ps
CONTAINER ID   IMAGE              COMMAND                  STATUS          PORTS     NAMES
a8f54cfd7c81   codyssey-web:1.0   "/docker-entrypoint.…"   Up 10 seconds   80/tcp    codyssey-web-ops
```

`docker ps`의 `Up` 상태로 커스텀 이미지 기반 컨테이너가 백그라운드에서 정상 실행 중임을 확인했습니다.

## 로그 및 자원 사용량 확인

```console
% docker logs codyssey-web-ops
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/08/10 05:09:18 [notice] 1#1: using the "epoll" event method
2026/08/10 05:09:18 [notice] 1#1: nginx/1.31.3
2026/08/10 05:09:18 [notice] 1#1: built by gcc 15.2.0 (Alpine 15.2.0) 
2026/08/10 05:09:18 [notice] 1#1: OS: Linux 6.17.8-orbstack-00308-g8f9c941121b1
2026/08/10 05:09:18 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 20480:1048576
2026/08/10 05:09:18 [notice] 1#1: start worker processes
2026/08/10 05:09:18 [notice] 1#1: start worker process 30
2026/08/10 05:09:18 [notice] 1#1: start worker process 31
2026/08/10 05:09:18 [notice] 1#1: start worker process 32
2026/08/10 05:09:18 [notice] 1#1: start worker process 33
2026/08/10 05:09:18 [notice] 1#1: start worker process 34
2026/08/10 05:09:18 [notice] 1#1: start worker process 35

$ docker stats --no-stream codyssey-web-ops
CONTAINER ID   NAME               CPU %   MEM USAGE / LIMIT     MEM %   NET I/O         BLOCK I/O        PIDS
a8f54cfd7c81   codyssey-web-ops   0.00%   14.52MiB / 15.67GiB   0.09%   1.66kB / 126B   10.2MB / 4.1kB   7
```

로그의 `ready for start up`과 worker process 시작 메시지로 NGINX가 정상 기동했음을 확인했습니다. `--no-stream` 옵션은 지속 출력하지 않고 한 번의 자원 사용량만 기록하기 위해 사용했습니다.

## 컨테이너 중지 및 전체 목록 확인

```console
$ docker stop codyssey-web-ops
codyssey-web-ops

$ docker ps -a
CONTAINER ID   IMAGE              COMMAND                  CREATED          STATUS                     PORTS     NAMES
a8f54cfd7c81   codyssey-web:1.0   "/docker-entrypoint.…"   22 minutes ago   Exited (0) 5 seconds ago             codyssey-web-ops


$ docker rm codyssey-web-ops 
codyssey-web-ops

$ docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES


$ docker rmi codyssey-web:1.0
Untagged: codyssey-web:1.0
Deleted: sha256:cf33ad74947509eb07731bf5cddedc96d356fb4d8b9ba484f47b1333b1bb4099

$ docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE

```
