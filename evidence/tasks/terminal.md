현재 위치와 숨김 파일을 포함한 목록을 확인했습니다.

```console
$ pwd
/Users/rkdsim900244/codyssey/codyssey-p1

$ ls -la
total 32
drwxr-xr-x  11 rkdsim900244  rkdsim900244   352 Aug 13 16:03 .
drwxr-x---+ 17 rkdsim900244  rkdsim900244   544 Aug 13 16:03 ..
drwxr-xr-x  13 rkdsim900244  rkdsim900244   416 Aug 13 16:05 .git
-rw-r--r--   1 rkdsim900244  rkdsim900244    17 Aug 13 16:03 .gitignore
-rw-r--r--   1 rkdsim900244  rkdsim900244    64 Aug 13 16:03 Dockerfile
-rw-r--r--   1 rkdsim900244  rkdsim900244    17 Aug 13 16:03 Dockerfile.ubuntu
-rw-r--r--   1 rkdsim900244  rkdsim900244  2073 Aug 13 16:10 README.md
drwxr-xr-x   3 rkdsim900244  rkdsim900244    96 Aug 13 16:03 app
drwxr-xr-x   4 rkdsim900244  rkdsim900244   128 Aug 13 16:08 evidence
drwxr-xr-x   4 rkdsim900244  rkdsim900244   128 Aug 13 16:03 practice
```

디렉토리를 생성하고 `cd`로 이동한 뒤, 빈 파일과 숨김 파일을 만들었습니다.

```console
$ mkdir -p practice/terminal-practice/source practice/terminal-practice/archive
$ cd practice/terminal-practice
$ pwd
/Users/rkdsim900244/codyssey/codyssey-p1/practice/terminal-practice

$ touch empty-file.txt .hidden-file
$ ls -la
total 0
drwxr-xr-x   6 rkdsim900244  rkdsim900244  192 Aug 10 11:26 .
drwxr-xr-x  10 rkdsim900244  rkdsim900244  320 Aug 10 11:26 ..
-rw-r--r--   1 rkdsim900244  rkdsim900244    0 Aug 10 11:26 .hidden-file
drwxr-xr-x   2 rkdsim900244  rkdsim900244   64 Aug 10 11:26 archive
-rw-r--r--   1 rkdsim900244  rkdsim900244    0 Aug 10 11:26 empty-file.txt
drwxr-xr-x   2 rkdsim900244  rkdsim900244   64 Aug 10 11:26 source
```

상대 경로를 이용해 웹 파일을 복사한 다음 다른 디렉토리로 이동하면서 이름을 변경했습니다.

```console
$ cp ../../app/index.html source/page-copy.html
$ ls -la source
total 8
drwxr-xr-x  3 rkdsim900244  rkdsim900244   96 Aug 10 11:26 .
drwxr-xr-x  6 rkdsim900244  rkdsim900244  192 Aug 10 11:26 ..
-rw-r--r--  1 rkdsim900244  rkdsim900244  333 Aug 10 11:26 page-copy.html

$ mv source/page-copy.html archive/page-renamed.html
$ ls -la source archive
archive:
total 8
drwxr-xr-x  3 rkdsim900244  rkdsim900244   96 Aug 10 11:26 .
drwxr-xr-x  6 rkdsim900244  rkdsim900244  192 Aug 10 11:26 ..
-rw-r--r--  1 rkdsim900244  rkdsim900244  333 Aug 10 11:26 page-renamed.html

source:
total 0
drwxr-xr-x  2 rkdsim900244  rkdsim900244   64 Aug 10 11:26 .
drwxr-xr-x  6 rkdsim900244  rkdsim900244  192 Aug 10 11:26 ..
```

이동한 파일의 내용을 확인했습니다.

```console
$ cat archive/page-renamed.html
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

숨김 파일을 삭제하고 목록에서 사라진 것을 확인했습니다. `empty-file.txt`는 크기가 0인 빈 파일 생성 증거로 유지했습니다.

```console
$ rm .hidden-file
$ ls -la
total 0
drwxr-xr-x   5 rkdsim900244  rkdsim900244  160 Aug 10 11:26 .
drwxr-xr-x  10 rkdsim900244  rkdsim900244  320 Aug 10 11:26 ..
drwxr-xr-x   3 rkdsim900244  rkdsim900244   96 Aug 10 11:26 archive
-rw-r--r--   1 rkdsim900244  rkdsim900244    0 Aug 10 11:26 empty-file.txt
drwxr-xr-x   2 rkdsim900244  rkdsim900244   64 Aug 10 11:26 source
```
