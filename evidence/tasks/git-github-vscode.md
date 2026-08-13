# Git 설정 및 GitHub/VS Code 연동

## Git 사용자 정보 및 기본 브랜치 설정

다음 명령으로 전역 사용자 정보와 새 저장소의 기본 브랜치를 설정했다.

```bash
git config --global user.name "강동하"
git config --global user.email "rkdsim28@gmail.com"
git config --global init.defaultBranch main

git config --global credential.helper osxkeychain
git credential approve
protocol=https
host=github.com
username=USERNAME
password=PAT
```

### `git config --list` 결과

```text
credential.helper=osxkeychain
user.name=강동하
user.email=rkdsim28@gmail.com
init.defaultbranch=main
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
```
```
git init
Initialized empty Git repository in /Users/rkdsim900244/tmp/.git/

git status
On branch main

No commits yet
touch test.txt
git status
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	test.txt

nothing added to commit but untracked files present (use "git add" to track)
git add test.txt 
git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   test.txt

git commit -m "Initial commit"
```

## 3. GitHub 저장소 연동 확인


깃헙에서 repo를 만들고 설명대로 다음을 수행한다

```
echo "# test" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/Deviskido/test.git
git push -u origin main
```

만약 keychain permission문제로 push가 안된다면 지워고 다시 시도하라

`git credential-osxkeychain erase`
엔터
```
host=github.com
protocol=https
```
엔터
엔터

PAT을 Fine-grained tokens only select repositories read and write contents 권한으로 토큰생성



## 4. VS Code GitHub 연동



[VS Code GitHub 연동 확인](../images/vscode-github.png)
