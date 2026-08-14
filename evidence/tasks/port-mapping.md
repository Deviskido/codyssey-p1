## 웹 페이지 검증

```console
$ curl -i http://localhost:8080
HTTP/1.1 200 OK
Server: nginx/1.31.3
Content-Type: text/html
Content-Length: 333

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


## 수행 결과
  localhost는 루프백주소로서 자기 자신 디바이스에서만 접근가능하다. 이런식으로 포트노출을 제한하여 보안성을 높인다. 컨테이너는 호스트와 별개의 네임스페이스를 갖는다. 이를 포트를 연결한다.
 `codyssey-web:1.0` 이미지 빌드, 컨테이너 실행, `8080:80` 포트 매핑, HTTP `200 OK` 응답을 확인했다. 검증 후 `codyssey-custom-image` 컨테이너는 중지하고 삭제했으며 빌드한 이미지는 유지했다.

컨테이너는 독립된 네트워크 네임스페이스를 사용하므로 내부 80번 포트에 외부에서 접근하려면 호스트 포트와 매핑해야 한다. 포트를 노출하면 외부 공격 경로가 생길 수 있으므로 필요한 포트만 열고, 외부 공개가 불필요하면 `127.0.0.1:8080:80`처럼 접근 범위를 로컬로 제한해야 한다.

## 포트 확인
```
$ lsof -P -iTCP:8080 -sTCP:LISTEN
  COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
  nginx    4321 user    6u  IPv4  ...        0t0  TCP *:8080 (LISTEN)
  ```

  각 항목의 의미는 다음과 같습니다.

  - COMMAND: 포트를 사용하는 프로그램 이름
  - PID: 프로세스 ID
  - USER: 프로세스 실행 사용자
  - FD: 파일 디스크립터. u는 읽기·쓰기가 가능하다는 뜻
  - TYPE: IPv4 또는 IPv6 사용 여부
  - NAME: 주소, 포트, 연결 상태
  - *:8080: 모든 네트워크 인터페이스에서 8080번 포트 수신
  - 127.0.0.1:8080: 로컬 컴퓨터에서만 접속 가능
  - (LISTEN): 연결 요청을 기다리는 상태

  옵션은 -P가 포트 번호를 서비스명으로 바꾸지 않으며, iTCP:8080 인 인터넷프로토콜이 TCP이고 8080인것만 -sTCP:LISTEN은 state가 수신 대기 중인 프로세스만 표시합니다.

  확인한 프로세스가 종료해도 되는 대상이라면 먼저 정상 종료를 요청합니다.


## 정리

```console
$ docker logs codyssey-custom-image
$ docker stop codyssey-custom-image
$ docker rm codyssey-custom-image
```
