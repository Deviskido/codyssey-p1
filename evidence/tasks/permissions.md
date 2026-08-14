

실습 대상을 만들고 파일에는 `644`, 디렉토리에는 `755` 권한을 설정한 뒤 현재 상태를 확인합니다.

각 비트는 file or directory_owner_group_other 의 권한을 나타낸다.

```console
$ cd ~/codyssey-p1/practice
$ mkdir -p permission-practice/shared-dir
$ touch permission-practice/sample.txt
$ chmod 644 permission-practice/sample.txt
$ chmod 755 permission-practice/shared-dir

$ ls -l permission-practice/sample.txt
-rw-r--r--  1 <USER>  <USER>  0 Aug 10 11:29 permission-practice/sample.txt

$ ls -ld permission-practice/shared-dir
drwxr-xr-x  2 <USER>  <USER>  64 Aug 10 11:29 permission-practice/shared-dir
```

파일은 소유자만 읽고 쓸 수 있도록 `600`으로, 디렉토리는 소유자만 접근할 수 있도록 `700`으로 변경합니다.

```console
$ chmod 600 permission-practice/sample.txt
$ chmod 700 permission-practice/shared-dir

$ ls -l permission-practice/sample.txt
-rw-------  1 <USER>  <USER>  0 Aug 10 11:29 permission-practice/sample.txt

$ ls -ld permission-practice/shared-dir
drwx------  2 <USER>  <USER>  64 Aug 10 11:29 permission-practice/shared-dir

$ stat -f '%N: %Sp (%OLp)' permission-practice/sample.txt permission-practice/shared-dir
permission-practice/sample.txt: -rw------- (600)
permission-practice/shared-dir: drwx------ (700)
```

```console
$ ls -l permission-practice
total 0
-rw-------  1 <USER>  <USER>   0 Aug 13 18:15 sample.txt
drwx------  2 <USER>  <USER>  64 Aug 13 18:15 shared-dir
$ rm -f permission-practice/sample.txt 
$ rm -rf permission-practice/shared-dir 
$ ls -l permission-practice 
total 0
```
