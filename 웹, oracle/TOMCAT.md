## TOMCAT

> WAS(Web Application Server) = Web Server(정적 데이터 처리) + Web Container(동적 데이터 처리 ex.DB..)

- 웹 요청 방식

  http://127.0.0.1:8088/context명/폴더명.../요청할 web application

  ===    =======   ===   =======

  프로	웹서버	 port		기본 context는 생략(root) - default가 아니면 server.xml의  Context - path에

  토콜		ip		(web의													적힌 경로 출력 

  ​							기본 port는 80이고 생략 가능하다.)

  - 127.0.0.1:8088 이 서버의 루트다. webapps폴더 또는 server.xml의 Context에 설정되어 있는 위치

    (이클립스`J2EE`는 서버의 루트 위치가 다름)

    ``` xml
    <Context docBase="clientweb" path="/clientweb" reloadable="true" source="org.eclipse.jst.jee.server:clientweb"/></Host>
        </Engine>
      </Service>
    </Server>
    ```

    ->`http://127.0.0.1:8088/context명`은 보통 도메인으로 묶는다. ex) naver.com

  ex) http://127.0.0.1:8088/docs/index.html

  ​	http://127.0.0.1:8088/manager/html

  ​	http://127.0.0.1:8088/examples/servlets/index.html

-  **정적문서**: 파일로 만들어져 있는 문서.(html파일) 정적웹에서 실행된다.

  context는 `표준화`된 폴더 구조를 갖고 있다. (파일의 위치를 정해줌)
  
  - 표준화:
  
    어떤 WAS를 쓰냐에 따라 기본으로 인식하는 위치는 달라지지만, 웹시스템의 폴더구조는 동일해야 한다.
  
    [Context명]
  
    ​		|________jsp, html, css, js, image파일(jpg, gif, png, ...) **<client단에 보여줄 것>**
  
    ​		|________[WEB-INF] **<백엔드>**
  
    ​						|________ web.xml: 설정파일
  
    ​						|________ [lib]: 라이브러리
  
    ​						|________ [classes]: 자바파일(.class)
  
    ​														|________로직(DAO, DTO, 서블릿)
  
    ​						

## 이클립스에서 실행

- 외부의 tomcat종료 (하나만 실행할 수 있기 때문)
- Java EE를 사용한다.

-server.xml 더블 클릭해서 포트 설정: cmd에서 `netstat -ano`명령어로 현재 점유된 port확인

1. C:\iot\work\webwork\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps

   이클립스 상 서버가 인식하는 위치 -> 표준화된 폴더 구조 형태로 들어가 있다.

   (이클립스IDE에서 보는 폴더는 우리가 보기 편하도록 따로 정리해둔 것)
   
2. clientweb에 관련된 jsp, html, css, js, image 등은 webContent 바로 밑에 폴더를 생성하거나 하지 않고 바로 작성하거나 해서 넣는다. 자바파일은 모두 java Resources에 작성하면 된다.

   - Ant: 옛날 자동 build tool. 이 Ant라는 tool이 서버가 인식하는 위치로 파일들을 복사해준다.
   - 자동으로 안 넘어갈 때가 있으니 직접 폴더로 가서 check해 볼 것!



## HTML

- 중복해서 쓸 수 있다.  **순서 주의!**

  ``` html
  <h1><a>태그</a></h1>
  ```

- 부연설명

``` html
<a 속성="값" >속성</a>
```

- 웹에서 긁어올 때  UTF-8인코딩으로 저장하여 한글이 깨질 경우

  : `save as UTF-8` 선택x -> 메모장에 복사하고 다시 이클립스에 복사

#### [Cross Browsing]

http://html5test.com/ 으로 접속해서 각 브라우저의 기능 확인

=>웹사이트를 만들 때 참고해야 한다!

ex) 인터넷 익스플로러 312, 크롬 481, Microsoft edge 492

​	-자바 스크립트를 사용했을 때는 크롬에서 사용해야 한다.