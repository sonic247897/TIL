# Django intro

## Start Django

1. 장고 설치

   ``` bash
   pip install django==2.1.15
   pip list
   ```

2. 프로젝트 생성

   ``` bash
   django-admin startproject <프로젝트명>
   ```

   ``` bash
   python manage.py runserver
   # http://127.0.0.1:8000/로 접속할 수 있다.
   ```

3. 프로젝트 생성시 제공하는 파일

   - manage.py 
     - 전체 django와 관련된 모든 명령어를 manage.py를 통해 실행합니다. (프로젝트 생성 때만 장고에게 시키고 이후는 전부 파이썬에게 시킨다)
   - `__init__.py`
     - 현재 `__init__.py`파일이 존재하는 폴더를 하나의 프로젝트, 혹은 패키지로 인식하게 해주는 파일
   - `settings.py`
     - 현재 프로젝트의 전체적인 설정 및 관리를 위해 존재하는 파일
   - `urls.py`
     - 내 프로젝트에 접근할 수 있는 경로를 설정하기 위한 파일

4. 명령어

   ``` bash
   python manage.py startapp <어플리케이션(기능 단위) 이름>
   # 프로젝트에게 출생신고 해야 함 - settings.py에 INSTALLED_APPS라는 리스트에 어플리케이션 이름 넣기
   # LANGUAGE_CODE = 'ko-kr' / TIME_ZONE = 'Asia/Seoul' / DEBUG = True: 현재 개발중이기 때문에 다른 사람들이 내 서비스에 마음대로 접근할 수 없다. 오류를 잡아준다.
   ```

   