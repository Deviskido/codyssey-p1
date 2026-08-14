# Dockerfile 기반 커스텀 이미지 제작

## 목표

`nginx:alpine`을 기반으로 프로젝트의 정적 웹 페이지를 포함하는 이미지를 만들고,
컨테이너에서 해당 페이지가 정상적으로 제공되는지 확인한다.

## Dockerfile 구성

프로젝트 루트의 `Dockerfile`은 다음과 같다.

```dockerfile
FROM nginx:alpine

COPY app/ /usr/share/nginx/html/

EXPOSE 80
```

- `FROM nginx:alpine`: 용량이 작은 Alpine Linux 기반 NGINX 이미지를 사용한다.
- `COPY app/ /usr/share/nginx/html/`: 로컬의 `app/index.html`을 NGINX 기본 문서 경로에 복사한다.
- `EXPOSE 80`: 컨테이너가 HTTP 80번 포트를 사용한다는 정보를 명시한다. 실제 호스트 포트 연결은 실행 시 `-p` 옵션으로 설정한다.

## 이미지 빌드

이미지 빌드에는 프로젝트 루트의 `Dockerfile`을 사용했다. 별도의 `-f` 옵션을
지정하지 않았으므로 Docker는 빌드 컨텍스트의 기본 파일인 `./Dockerfile`을
자동으로 선택한다. 이 Dockerfile의 베이스 이미지는 Docker Hub의 공식 NGINX
Alpine 이미지인 `nginx:alpine`이다.

프로젝트 루트에서 다음 명령을 실행한다.

```console
$ docker build -t codyssey-web:1.1 .
#0 building with "orbstack" instance using docker driver
#1 [internal] load build definition from Dockerfile
#2 [internal] load metadata for docker.io/library/nginx:alpine
#5 [1/2] FROM docker.io/library/nginx:alpine
#6 [2/2] COPY app/ /usr/share/nginx/html/
#7 writing image sha256:5c1b4e315df2b94684a91eb2dedf3b803a24bb92037e94512e4576373db55a91 done
#7 naming to docker.io/library/codyssey-web:1.0 done
#7 DONE 0.2s
```

- `-t codyssey-web:1.1`: 이미지 이름을 `codyssey-web`, 태그를 `1.1`으로 지정한다.
- 마지막의 `.`: 현재 디렉터리를 빌드 컨텍스트로 전달한다.

빌드 후 이미지가 생성되었는지 확인한다.

```console
$ docker images
REPOSITORY     TAG       IMAGE ID       CREATED        SIZE
codyssey-web   1.0       cf33ad749475   20 hours ago   62.4MB
codyssey-web   1.1       cf33ad749475   20 hours ago   62.4MB
```

## 컨테이너 실행

호스트의 8080번 포트를 컨테이너의 80번 포트에 연결해 백그라운드로 실행한다.

```console
$ docker run -d --name codyssey-custom-image -p 8080:80 codyssey-web:1.0
66fca770f7dafde060a872f3d21bc589409b58196e0bc95dd0eda468a8768b1d
```

실행 상태와 포트 매핑은 다음 명령으로 확인한다.?

```console
$ docker ps
CONTAINER ID   IMAGE              COMMAND                  CREATED         STATUS        PORTS                                     NAMES
0c81f527cc72   codyssey-web:1.0   "/docker-entrypoint.…"   2 seconds ago   Up 1 second   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   codyssey-custom-image
```




