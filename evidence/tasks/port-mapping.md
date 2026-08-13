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
 `codyssey-web:1.0` 이미지 빌드, 컨테이너 실행, `8080:80` 포트 매핑, HTTP `200 OK` 응답을 확인했다. 검증 후 `codyssey-custom-image` 컨테이너는 중지하고 삭제했으며 빌드한 이미지는 유지했다.



## 정리

```console
$ docker logs codyssey-custom-image
$ docker stop codyssey-custom-image
$ docker rm codyssey-custom-image
```