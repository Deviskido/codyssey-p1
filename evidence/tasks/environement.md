```console
$ sw_vers
ProductName:            macOS
ProductVersion:         15.7.4
BuildVersion:           24G517

$ printf '%s\n' "$SHELL"
/bin/zsh

$ printf '%s\n' "${TERM_PROGRAM}"
Apple_Terminal

$ docker --version
Docker version 28.5.2, build ecc6942

$ git --version
git version 2.53.0
```


<!-- $ uname -m
x86_64 -->

<!-- orbStack을 실행한 뒤 컨테이너 환경을 확인했습니다.

```console
$ orb
$ orb version
Version: 2.0.5 (2000500)
Commit: cfe47627f138ffd822c958553b0a93eaf2692c71 (v2.0.5)


$ docker context show
orbstack

$ docker info --format $'Server Version: {{.ServerVersion}}\nOperating System: {{.OperatingSystem}}\nArchitecture: {{.Architecture}}\nCPUs: {{.NCPU}}\nTotal Memory: {{.MemTotal}}\nContainers: {{.Containers}}\nImages: {{.Images}}'
Server Version: 28.5.2
Operating System: OrbStack
Architecture: x86_64
CPUs: 6
Total Memory: 16829087744
Containers: 0
Images: 0
``` -->