# Docker 볼륨 영속성 및 바인드 마운트 변경 반영 검증

## 검증 환경

- Docker: 28.5.2
- 컨테이너 이미지: `nginx:alpine`
- named volume: `codyssey-persistent-data`
- 바인드 마운트 호스트 경로: `practice/docker-bind`
- 바인드 마운트 컨테이너 경로: `/usr/share/nginx/html`

## 1. Docker 볼륨 생성 및 연결

Docker가 관리하는 named volume을 생성했다.

```console
$ docker volume create codyssey-persistent-data
codyssey-persistent-data
```

Docker 볼륨을 확인한다.

```console
$ docker volume ls
```


생성한 볼륨을 컨테이너의 `/data`에 연결했다. 컨테이너는 볼륨에 문자열을
기록한 뒤 NGINX를 포그라운드에서 실행하여 계속 실행 상태를 유지한다.
`-c 옵션은 커맨드`

```console
$ docker run -d --name codyssey-volume-before \
    --mount source=codyssey-persistent-data,target=/data \
    nginx:alpine \
    sh -c 'printf "volume data survives container deletion\n" > /data/message.txt; exec nginx -g "daemon off;"'
52f1ef773d47180e5712706e95c21872e94e8730c25104d580b1ade2f6bf1e4f
```

`nginx 프로그램을 daemon off로 전역에서 실행시킨다.`

## 2. 컨테이너 삭제 전 데이터 확인

첫 번째 컨테이너에서 볼륨에 기록된 파일을 확인했다.

```console
$ docker exec codyssey-volume-before cat /data/message.txt
volume data survives container deletion
```

## 3. 컨테이너 삭제 후 데이터 유지 확인

첫 번째 컨테이너를 강제로 삭제했다. `docker rm -f`는 컨테이너만 삭제하며,
별도로 생성한 named volume은 삭제하지 않는다.

```console
$ docker rm -f codyssey-volume-before
codyssey-volume-before
```

컨테이너 삭제 이후에도 named volume은 살아있음을 확인한다.

```
docker volume ls                   
DRIVER    VOLUME NAME
local     codyssey-persistent-data
```

동일한 볼륨을 새 컨테이너에 연결하고 기존 파일을 다시 읽었다.

```console
$ docker run --rm --name codyssey-volume-after \
    --mount source=codyssey-persistent-data,target=/data \
    nginx:alpine cat /data/message.txt
volume data survives container deletion
```

컨테이너 삭제 전과 삭제 후에 같은 문자열이 출력되었다. 따라서 데이터는
컨테이너의 쓰기 계층이 아니라 named volume에 저장되며, 컨테이너가 삭제되어도
유지됨을 확인했다. 두 번째 컨테이너는 `--rm` 옵션으로 실행 종료 후 자동 삭제됐다.


<!-- How to remove docker volume
`docker volume rm codyssey-persistent-data` -->

## 결론

- named volume의 데이터는 해당 볼륨을 사용하던 컨테이너를 삭제해도 유지된다.
- 같은 named volume을 새 컨테이너에 연결하면 기존 데이터를 다시 사용할 수 있다.
