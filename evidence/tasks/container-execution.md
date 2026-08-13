# 포트 매핑 및 접속 검증

## 검증 목적

컨테이너 내부의 NGINX는 80번 포트에서 실행되지만, 컨테이너의 포트는 호스트에서 바로 접근할 수 없습니다. `-p 8080:80` 옵션으로 호스트의 8080번 포트를 컨테이너의 80번 포트에 연결한 뒤 HTTP 접속을 검증했습니다.


## 컨테이너 이미지 생성

`docker build -f Dockerfile.ubuntu -t hello-world .`

## 컨테이너 실행

기존에 빌드한 `codyssey-web:1.0` 이미지를 사용했습니다.

```console
$ docker run -dit --name hello-world -p 8080:80 codyssey-web:1.0 sh
c8ec61d6697a58ed5253570d1e4c964545536bfa1b402b1b7bd21dede7ce83d4
```

`-p 8080:80`의 앞쪽 `8080`은 호스트 포트이고, 뒤쪽 `80`은 컨테이너에서 NGINX가 사용하는 포트입니다.
-d → 백그라운드 실행
-i → stdin(입력)은 열어둠
-t → 없음

## 실행 여부 및 포트 매핑 확인

```console
$ docker ps -a
CONTAINER ID   IMAGE              COMMAND                  CREATED         STATUS         PORTS                                     NAMES
16c7c40fcf17   codyssey-web:1.0   "/docker-entrypoint.…"   2 seconds ago   Up 2 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   hello-world
```

`PORTS` 열의 `0.0.0.0:8080->80/tcp`를 통해 IPv4 호스트 8080번 포트가 컨테이너 80번 포트로 연결된 것을 확인했습니다. `[::]:8080->80/tcp`는 같은 매핑이 IPv6 주소에도 적용되었음을 의미합니다.

## 컨테이너 ATTACH
```
docker attach hello-world
/ # ls
bin                   etc                   mnt                   run                   tmp
dev                   home                  opt                   sbin                  usr
docker-entrypoint.d   lib                   proc                  srv                   var
docker-entrypoint.sh  media                 root                  sys
/ # echo hello world!
hello world!
/ # 
```

## 컨테이너 EXECUTE 와비교

ATTACH는 이미 실행된 컨테이너의 메인프로세스를 현재의 터미널과 연결시키는것
EXECUTE는 해당 컨테이너에서 새로운 프로세스를 실행시키는것

`docker exec -it hello-world sh`
-d 옵션이 아니니 내부 쉘로 연결된다. 메인 프로세스가아닌 sh프로세스를 추가로 실행시킨다.
docker 컨테이너 내부에서 exec하는 경우에는 메인프로세스가 새로운 프로세스로 변경되는것과 다르다.

<!-- 
## HTTP 응답 확인

```console
$ curl -i http://localhost:8080
HTTP/1.1 200 OK
Server: nginx/1.31.3
Content-Type: text/html
Content-Length: 333
Connection: keep-alive

<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>개발 워크스테이션</title>
  </head>
  <body>
    <h1>개발 워크스테이션</h1>
    <p>Docker 웹 서버 실행 준비가 완료되었습니다.</p>
  </body>
</html>
```

`HTTP/1.1 200 OK`와 `app/index.html`의 내용이 반환되었으므로 호스트에서 컨테이너의 웹 서버로 정상 접속할 수 있습니다. 브라우저에서도 [http://localhost:8080](http://localhost:8080)에 접속해 같은 화면을 확인할 수 있습니다.
 -->
