# 개발 워크스테이션 구축

## 1. 프로젝트 개요

터미널, 파일 권한, Docker, Git/GitHub를 직접 사용해 재현 가능한 개발 환경을 구축하고, 각 단계의 명령과 검증 결과를 문서화하는 프로젝트입니다.

## 1.1 프로젝트 구조

```text
.
├── app/                    # 웹 컨테이너에서 제공할 정적 페이지
│   └── index.html          # 개발 워크스테이션 안내 페이지
├── evidence/               # 과제 수행 및 검증 자료
│   ├── images/             # 실행 결과 스크린샷
│   └── tasks/              # 항목별 수행 과정과 결과 문서
├── practice/               # 터미널 및 파일 권한 실습 파일
│   ├── permission-practice/
│   └── terminal-practice/
├── Dockerfile              # Alpine 기반 기본 컨테이너 예제
├── Dockerfile.ubuntu       # Ubuntu 기반 이미지 예제
└── README.md               # 프로젝트 개요 및 수행 내역
```

## 2. 실행 환경

- OS: macOS 15.7.4 (Build 24G517, x86_64)
- Shell: zsh (`/bin/zsh`)
- Terminal: Apple Terminal
- Docker version: 28.5.2, build ecc6942
- Git: 2.53.0

-[./evidence/tasks/evidence.md](./evidence/tasks/environement.md)

## 3. 수행 항목 체크리스트

- 터미널 조작
- 권한 실습
- Docker 설치 및 점검
- Docker 기본 운영 명령 수행
- 컨테이너 실행 실습
- 기존 Dockerfile 기반 커스텀 이미지 제작
- 포트매팅 및 접속 증거
- Docker 볼륨 영속성 검증
- Git 설정 및 GitHub 연동

수행 항목별 입출력 로그는 [./evidence/tasks/](./evidence/tasks/)에 저장합니다.

## 3.1 터미널 조작

-[./evidence/tasks/terminal.md](./evidence/tasks/terminal.md)

## 3.2 권한 실습

-[./evidence/tasks/permissions](./evidence/tasks/permissions.md)

## 3.3 Docker 설치 및 점검

-[./evidence/docker-installation.md](./evidence/tasks/docker-installation.md)

## 3.4 Docker 기본 운영 명령 수행

-[./evidence/tasks/docker-basic.md](./evidence/tasks/docker-basic.md)

## 3.5 컨테이너 실행 실습

- [./evidence/tasks/container-execution.md](./evidence/tasks/container-execution.md)

## 3.6 기존 Dockerfile 기반 커스텀 이미지 제작

- [./evidence/tasks/custom-image.md](./evidence/tasks/custom-image.md)

## 3.7 포트매팅 및 접속 증거

- [./evidence/tasks/port-mapping.md](./evidence/tasks/port-mapping.md)

## 3.8 Docker 볼륨 영속성 검증

- [./evidence/tasks/docker-volume.md](./evidence/tasks/docker-volume.md)

## 3.9 Git 설정 및 GitHub 연동

- [./evidence/tasks/git-github-vscode.md](./evidence/tasks/git-github-vscode.md)

## 3.10 트러블슈팅

- [./evidence/tasks/trouble-shooting.md](./evidence/tasks/trouble-shooting.md)