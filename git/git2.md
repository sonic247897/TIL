# git

- DVCS: 분산형 버전 관리 시스템
- 원격 저장소에 commit(이력)도 같이 저장. 분산형이기 때문에 로컬에서도 이력을 볼 수 있다.

` $ git status `

#### GUI vs CLI(Command Line Interface)

- GUI: 오류가 나면 알람창 뜸

- CLI: 명령하기 전까지는 오류를 알려주지 않는다.

  `ls` : 폴더에 들어와서 구조 보기

  `ls -al` : 숨김파일 포함

  `touch a.txt` : a.txt파일 생성(빈파일) - 김춘수 꽃

# Git Status를 통해 정리하기

## CLI 기초 명령어 

``` bash
# bash 기초 명령어(리눅스)
# list(파일 목록)
$ ls
# change directory(디렉토리 변경)
$ cd
# 빈 파일 생성
$ touch <파일명>
```

## 상황

### 1. `add`

``` bash
$ touch a.txt
$ git status
On branch master

No commits yet
# 트래킹X. 새로 생성된 파일. 한번도 git commit에 담긴 적 없기 때문에 트래킹 된 적 없는 파일
Untracked files:
	# 커밋을 하기 위한 곳에 포함시키려면
	# Staging area로 이동시키려면, git add
  (use "git add <file>..." to include in what will be committed)
        a.txt
# 마지막 줄: 전체 상황 총평
# WD(Working Directory)에 새로운 내용 존재, but. Staging area에는 아무 내용X
nothing added to commit but untracked files present (use "git add" to track)
```

``` bash
$ git add a.txt
$ git status
On branch master

No commits yet
# 커밋될 변경사항들(staging area O)
Changes to be committed:
	# unstage를 위해서 활용할 명령어(add 취소)
  (use "git rm --cached <file>..." to unstage)
        new file:   a.txt
$ git rm --cached a.txt
rm 'a.txt'
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        a.txt

nothing added to commit but untracked files present (use "git add" to track)

```

### 2. `commit`

``` bash
$ git commit -m 'Create a.txt'
[master (root-commit) 05b9302] Create a.txt
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a.txt
 
$ git status
On branch master
# staging area, working tree(working directory) 비어있음
nothing to commit, working tree clean
```

- 커밋 내역 확인

``` bash
$ git log
commit 05b93029032b1304472792920fbd175b7515c077 (HEAD -> master)
Author: sonic247897 <sonic247897@gmail.com>
Date:   Thu Apr 23 10:37:37 2020 +0900

    Create a.txt
# log 한줄로 출력
$ git log --oneline
05b9302 (HEAD -> master) Create a.txt
```

### 3. 추가 파일 변경 상태

``` bash
# a.txt는 수정하고 b.txt 생성
$ touch b.txt
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   a.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        b.txt

no changes added to commit (use "git add" and/or "git commit -a")

```

``` bash
$ git add a.txt

student@M150121 MINGW64 ~/Desktop/test (master)
$ git status
On branch master
Changes to be committed:
	# 트래킹이 되는 파일에 대해 restore --staged 사용:
  (use "git restore --staged <file>..." to unstage)
        modified:   a.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        b.txt
$ git add .

student@M150121 MINGW64 ~/Desktop/test (master)
$ git status
On branch master
Changes to be committed:
	# 트래킹 된 파일도 add에 포함되어 있으므로 rm --cached 대신 restore --staged명령어 사용 (rm --cached를 사용하면 b.txt만 사라진다.)
  (use "git restore --staged <file>..." to unstage)
        modified:   a.txt
        new file:   b.txt


```

### 4. 커밋 취소

> <b>주의!!</b> 커밋 메시지 변경시 해시값 자체가 변경되어, 이미 원격저장소에 push한 이력에 대해서는 메시지 변경을 하면 안된다.

``` bash
$ git commit -m 'a.txt 추'
[master 95adba5] a.txt 추
 1 file changed, 10 insertions(+), 1 deletion(-)

# CLI전용 텍스트창 vim편집기 창으로 들어가서 수정한 후 :wq 
$ git commit --amend
[master 1f6fa7e] a.txt 추가
 Date: Thu Apr 23 10:48:26 2020 +0900
 1 file changed, 10 insertions(+), 1 deletion(-)
 # 이미 push를 한 경우 commit 메시지를 변경하면 안된다! 해시코드가 달라져서 다른 버전이 되어버리기 때문

```

- `vim` 텍스트 편집기가 실행된다.
  - `i` : 편집모드
  - ` esc ` : 편집모드를 종료하고, 명령 모드에서
    - `:wq`
      - `write+quit` 의 명령어 조합 뜻



#### 4-1. 특정 파일을 빼놓고 커밋 했을 때

``` bash
$ git add <빼놓은 파일>
$ git commit --amend
```

- 빠뜨린 파일을 add한 이후에 `commit --amend`를 하면, 해당 파일까지 포함하여 재커밋이 이뤄진다.

  (이력이 바뀌는 것은 맞음)

### 5. 작업 내용을 이전 버전으로 되돌리기(working directory)

- a.k.a. 작업 하던 내용 버리기

``` bash
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   b.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  # working directory 내용을 버리기 위해서는 restore!(수정한 내용을 버림)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   a.txt
# 직전까지 commit한 내용을 복구할 수 있다.
$ git restore a.txt

$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   b.txt

```

### 6. 특정 파일/폴더 삭제 커밋

> 해당 명령어는 실제 파일이 삭제되는 것은 아니지만, git에서 삭제되었다라는 이력을 남기는 것

``` bash
$ git rm --cached b.txt
rm 'b.txt'

$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    b.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        b.txt
# 주의!! 해당 파일이 물리적으로 삭제되는 것은 아니다.

```

- 일반적으로는 `.gitignore`와 함께 활용한다.

  1. `.gitignore`에 해당 파일 등록

  2. `git rm --cached`를 통해 삭제 커밋

     => 이렇게 작업을 하면, 실제 파일은 삭제되지 않지만 이후로 git으로 전혀 관리되지 않는다.

``` bash
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    b.txt

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    a.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .gitignore
        b.txt


# 텍스트 편집기로 사용하면 한글의 경우 인코딩 때문에 깨지기 때문에 vim 사용
$ vi .gitignore

$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    b.txt

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    a.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .gitignore


```

## 7. 원격 저장소 활용 명령어

1. 원격 저장소 목록 조회

``` bash
# 원격 저장소 목록
$ git remote -v
```

2. 원격 저장소 설정 삭제

``` bash
$ git remote rm origin
```

3. 원격 저장소 설정

``` bash
# git아 원격 저장소에 추가해줘 origin이라고, url을
$ git remote add origin URL
```

4. 원격 저장소에 push

``` bash
$ git push origin master
```

