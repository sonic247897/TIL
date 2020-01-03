# Git

> Git은 분산형 버전 관리 시스템(DVS)이다.
>
> 소스코드 형상 관리 도구로써, 작성되는 코드의 이력을 관리한다.

과거의 중앙 집중형 관리 시스템 - 서버 컴퓨터에서 받아서 옴.

![dvcs vcs에 대한 이미지 검색결과](images/687474703a2f2f6769742d73636d2e636f6d2f666967757265732f3138333333666967303130332d746e2e706e67.png)



## 0. 기본 설정

아래의 설정은 이력 작석자(author)를 설정하는 것으로, 컴퓨터에서 최초에 한번만 설정하면 된다.

``` bash
$ git config --global user.name sonic247897
$ git config --global user.email sonic247897@gmail.com
// 작성자가 누군지 설정해줌
$ git config --global -l // 확인
```

## 1. 로컬 저장소(repository)

### 1. 저장소 초기화

``` bash
$ git init
Initialized empty Git repository in C:/Users/student/Desktop/TIL/.git/
//.git 폴더 생성(저장소 생성)
(master) $
```

코드의 결과도 같이 정리

* `(master)`는 현재 있는 브랜치 위치를 뜻하며, `.git`폴더가 생성된다.
  * .git 폴더가 보이는 곳에서만 git bash here 클릭

* 해당 폴더를 삭제하게 되면 모든 git과 관련된 이력이 삭제된다.

### 2. add

이력을 확정하기 위해서는 `add` 명령어를 통하여 `staging area`에 `stage`시킨다.

``` bash
$ git add .				# 현재 디렉토리를 stage
$ git add README.md 	# 특정 파일을 stage
$ git add images/		# 특정 폴더를 stage
```

`add`를 한 이후에는 항상 `status` 명령어를 통해 원하는 대로 되었는지 확인한다.

``` bash
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   git.md
        new file:   images/00500561_20180313.JPG
        new file:   images/687474703a2f2f6769742d73636d2e636f6d2f666967757265732f3138333333666967303130332d746e2e706e67.png
        new file:   markdown.md

```

### 3. commit

`git`은 `commit`을 통해 이력을 남긴다. 커밋 시에는 항상 메시지를 통해 해당 이력의 정보를 나타내야 한다.

``` bash
$ git commit -m 'Init'
[master (root-commit) d0fe4b7] Init
 4 files changed, 92 insertions(+)
 create mode 100644 git.md
 create mode 100644 images/00500561_20180313.JPG
 create mode 100644 images/687474703a2f2f6769742d73636d2e636f6d2f666967757265732f3138333333666967303130332d746e2e706e67.png
 create mode 100644 markdown.md

```

커밋 목록은 아래의 명령어를 통해 확인 가능하다.

``` bash
$ git log
commit d0fe4b73ae8587d85e85fbe3c398da9e7e13c09c (HEAD -> master)
Author: sonic247897 <sonic247897@gmail.com>
Date:   Thu Dec 5 16:52:46 2019 +0900

    Init

```



``` bash
$ git remote add origin https://github.com/sonic24789/TIL.git

student@M150121 MINGW64 ~/Desktop/TIL (master)
$ git push -u origin master
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 4 threads
Compressing objects: 100% (9/9), done.
Writing objects: 100% (10/10), 129.33 KiB | 16.17 MiB/s, done.
Total 10 (delta 0), reused 0 (delta 0)
To https://github.com/sonic24789/TIL.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```

## 2. 원격 저장소(remote repository) 활용

> 원격 저장소는 다양한 서비스를 통해 제공 받을 수 있다.
>
> github, gitlab, bitbucket

### 1. 원격 저장소 등록

``` bash
$ git remote add origin https~  #URL 다 등록
```

보노보노 암기법 - git아.. 원격 저장소에.. 등록해줘.. origin이라는 이름으로.. 이 URL을..

원격 저장소(remote)를 `origin`이라는 이름으로 해당 url로 설정한다.

- 다른 이름으로 등록될 수 있지만 기본으로 origin을 사용

등록된 원격 저장소는 아래의 명령어로 확인할 수 있다.

등록은 한번만 실행하면 된다.

``` bash
$ git remote -v
origin  https://github.com/sonic24789/TIL.git (fetch)
origin  https://github.com/sonic24789/TIL.git (push)
```

## 2. 원격 저장소  push

``` bash
$ git push origin master
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 4 threads
Compressing objects: 100% (9/9), done.
Writing objects: 100% (10/10), 129.33 KiB | 16.17 MiB/s, done.
Total 10 (delta 0), reused 0 (delta 0)
To https://github.com/sonic24789/TIL.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```

`origin` 원격 저장소에 `push`하게 되며,  `github`에서 확인할 수 있다.

이후 작업 과정에서는 `add ` -> `commit`으로 이력을 남기고 `push`로 업로드 하면 된다.

