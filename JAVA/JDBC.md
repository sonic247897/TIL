# JDBC

> 자바로 DBMS를 연결하는 기술
>
> (java database connectivity)

**SQL문**을 자바로 만든 시스템을 통해 실행할 수 있도록 만들어진 `자바의 기술`

JDBC의 동작원리는 `OOP`를 따른다.

<img src=".\images\JDBC_class.PNG" style="zoom:60%;" />

*java.sql 패키지에는 '인터페이스'가 많다. 대용량 데이터 처리 로직은 기업 노하우이므로 오픈되지 않기 때문.

​	=> 따라서 new()를 사용하여 객체를 생성하지 않고, 메소드의 리턴값을 받아오는 방식으로 접근한다.

![](.\images\JDBC_driver.PNG)

Java의 인터페이스(`Connection`)를 상속 받았기 때문에 특정 함수를 호출하면, **각 DBMS의 오버라이딩 메소드가 호출된다**. (함수 이름을 같게 설계했기 때문에 DBMS를 다른 제품으로 바꾸었을 때 코드를 일부만 수정해도 된다)



## 오라클-JDBC

### [JDBC api 사용 전 처리 순서]

#### 1. jdbc드라이버를 제조사 홈페이지에서 다운로드 받는다.
​	=> C:\oraclexe\app\oracle\product\11.2.0\server\jdbc\lib 폴더에 있는 `ojdbc6.jar` 파일

#### 2. JVM이 인식할 수 있는 위치에 연결

​	1) 이클립스를 사용하는 경우(`Application`)

​		① 작업중인 프로젝트 선택

​		② 프로젝트에서 단축메뉴 선택(오른쪽 버튼) -> [build path]-[configure build path]

​		③ 대화상자에서 세 번째 탭인 [libraries]탭 선택

​		④ [Add external jar...]선택하고 1번 위치에 있는 `ojdbc6.jar`파일을 등록



### [JDBC api 사용하기]

#### 1. 오라클 드라이버 로딩
> JVM에서 드라이버 내의 api를 접근해서 사용할 수 있도록 java.lang에 있는 **Class클래스의 forName 메소드를 이용해서 핵심 클래스를 로딩**하는 작업

##### [문법]

``` java
Class.forName("DBMS드라이버의 핵심클래스명-패키지명까지 명시-")
```

- 오라클: oracle.jdbc.driver.OracleDriver
- MySQL: com.mysql.jdbc.Driver	
- 나머지는 제조사 홈페이지에서 확인



#### 2. DBMS에 연결하기

> **DriverManager클래스**의 getConnection메소드를 통해 작업

##### DriverManager클래스란?

 : connection객체를 계속 만들어내기만 하는 `factory class`(매핑되는 dbms가 없으므로 인터페이스X)

​	1) static 메소드이므로 클래스 이름으로 액세스

​	2) throws SQLException하고 있고 SQLException은 RuntimeException의 하위가 아니므로 try~catch를 이용해서 exception에 대한 처리를 해야 한다.

​	3) 매개변수
 	url : DBMS내부에서 인식할 연결문자열 (어떤 DBMS를 쓰냐에 따라 달라진다.)

 		**[오라클]** 

``` java
jdbc:oracle:thin:@70.12.115.55:1521:xe
- jdbc:oracle:thin : 오라클에서 사용하는 프로토콜
- 70.12.115.55 : DBMS가 설치되어 있는 PC의 ip
- 1521 : port
- xe : 서비스명
ex) jdbc:oracle:thin:@127.0.0.1:1521:xe
- 127.0.0.1 : localhost와 동일 - 로컬에 연결
```

 		**[mysql]**

``` 
jdbc:mysql://ip:port/데이터베이스명(port - 3306)
- user : 접속계정
- password : 접속할 계정의 패스워드
```


​	4) 리턴타입
 	- 연결정보를 java.sql.Connection타입으로 리턴
 	- DriverManager의 getConnection메소드를 이용하면  DBMS에 연결 후 연결정보를 객체로 만들어서 리턴한다.
 	- 연결객체의 타입은 java.sql.Connection이지만 어떤 DBMS를 접속했냐에 따라 Connection의 하위 객체가 리턴된다. (인터페이스이므로)
  - 내부에서는 접속된 DBMS회사에서 제공하는 라이브러리 속 Connection이 리턴되도록 다형성이 적용되어 있다.

​	5) 사용방법

``` java
Connection con = DriverManager.getConnection(url, user, password)	
```

- 어떤 DBMS를 쓰냐에 따라 다르게 리턴되는 Connection객체를 con이라는 참조변수를 통해 접근할 수 있도록 할당

 		**[오라클]** Connection 하위의 T4CConnection 객체 리턴

- 리소스를 많이 사용하므로 시간이 걸린다.

#### 3. SQL을 실행하는 역할을 담당하는 statement객체 생성
  Statement		: 정적 SQL을 실행
  	^			   보안에 취약 - SQLInjection에 취약
  	|
  PreparedStatement	: 동적 SQL을 실행
  	^			   시큐어코딩에 적합
  	|
  CallableStatement	: 각 DBMS에 특화된 SQL을 실행
  				  ex) 오라클 - PL-SQL

1) Statement객체를 이용
	Connection객체에 있는 createStatement메소드를 통해 생성(연결정보 전달 가능)
	Connection정보를 유지해야 한다.
	Statement stmt = con.createStatement()
	\---------
		java.sql.Statement타입이지만 
		드라이버 파일에 포함된 Statement객체가 리턴(오라클 내부 제공 객체)		
		[오라클]Statement 하위의 OracleStatementWrapper 객체 리턴
		
2) PreparedStatement객체를 이용
	=> 동적 SQL문을 사용해야 하기 때문에 이용
	sql문이 실행되는 과정은
	- 쿼리문을 읽고 분석
	- 컴파일
	- 실행
	

Statement는 위의 단계를 모두 반복해서 실행하고 작업하지만 PreparedStatement는
	한 번만 실행하고 캐쉬에 저장하고 캐쉬에서 읽어서 작업
	

PreparedStatement는 sql문을 실행하는 방식이 sql문을 미리 파싱한 후 동적으로 바인딩해서 작업해야 하는 값들만 나중에 연결해서 인식시키고 실행한다.
	
① sql문을 작성할 때 외부에서 입력받아서 처리해야 하는 부분을 ? 로 정의한다.
② sql문을 미리 파싱해야 하므로 실행execute할 때 sql을 전달하지 않고 
	PreparedStatement 객체를 생성할 때 sql문을 전달한다.
	(Statement는 stmt.executeUpdate(sql) 때 전달,
	PreparedStatement는 con.prepareStatement(sql) 때 전달)
		=> 미리 분석하므로 실행속도가 빨라진다.
		PreparedStatement ptmt = con.prepareStatement(sql문)
	③ ?에 값을 셋팅
	 PreparedStatement객체에 정의되어 있는 setXXXX메소드를 이용
	 ResultSet과 동일한 방식으로 메소드를 구성
	 setXXXXX(index, 값)
	 \-------- \-----	\---
	 컬럼의 타입	  ?순서	 |_____컬럼에 설정할 값
			(1부터 시작)		
			

	 오라클 타입과 매칭되는 setXXXX메소드
	 	char, varchar2 -> setString(1, "XXXX")
	 	number, integer -> setInt(1, 0000)
	 	소수점이 있는 number -> setDouble(1, 0.0)
	 	date -> setDate(1, java.sql.Date객체) 
	 	
	 ④ 실행메소드 호출
	 	- insert, delete, update
	 	 int result = ptmt.executeUpdate() //매개변수 x
	 	- select
	 	 ResultSet rs = ptmt.executeQuery() //매개변수 x 

#### 4. SQL 실행
	1) Statement 이용
		① executeUpdate : insert, update, delete문(DML)을 실행.
			int 결과값 = stmt.executeUpdate(sql문)
			\--------					 \------
			sql문 실행 결과					insert, delete, update
		몇 개의 row가 변경되었는지 리턴('3' rows deleted.)
		***** JAVA언어로 실행하는 DML은 자동으로 commit된다!! *****
		
		② executeQuery : select문을 실행
						select문의 실행 결과로 리턴되는 2차원 표를 자바에서 사용할 수 있도록
						모델링 해놓은 객체가 ResultSet이고 
						executeQuery메소드는 결과로 ResultSet객체를 반환하므로
						이 객체를 반환받을 수 있도록 정의한다.
			ResultSet rs = stmt.executeQuery("sql문")	
	
	2) PreparedStatement 이용
		=> 3번 참조

#### 5. 결과값 처리
	1) insert, delete, update 모두 동일
		=> int로 결과를 리턴하므로 결과값을 출력
	
	2) select 
		① select문의 실행결과로 반환되는 ResultSet을 참조할 수 있도록 정의
			ResultSet rs = stmt.executeQuery("sql문")
			[오라클] ResultSet의 하위 OracleResultSetImpl 객체 리턴
		② ResultSet 안에서 모든 레코드를 읽어서 처리할 수 있도록 반복문을 이용해서 처리
		  처음 반환되는 ResultSet에서 Cursor가 레코드에 위치하지 않으므로 Cursor를 
		 ResultSet 안의 레코드에 위치할 수 있도록 내부 메소드를 이용해서 처리한다.
		 while(rs.next()){
		 	  \-----------
		 	  	|_ 다음 레코드로 Cursor를 이동하고 레코드가 존재하면 true를 리턴하고
		 	  		레코드가 존재하지 않으면 false를 리턴한다.
		 }
		 
		 ③ 레코드의 값을 읽는다.
		 	=> 한 번에 하나의 컬럼만 읽을 수 있다.
		 		ResultSet 내부에서 제공되는 getXXXXX(데이터 타입)메소드를 이용
					rs.getXXXXX(1)
						  \----- --
					    데이터 타입	|_ 테이블에 존재하는 컬럼의 원래 순서가 아니라
					    			!!조회된 컬럼의 순서!!(매번 바뀔 수 있다)
					    				=> index는 1부터 시작
				
				오라클(DBMS)의 타입과 매칭되는 자바의 타입으로 메소드명이 구성
				varchar2 or char로 정의된 컬럼값 => getString(컬럼의 순서  or 컬럼명)
				소수점 없는 number or integer => getInt(컬럼의 순서 or 컬럼명)	
				소수점이 있는 number => getDouble(커럼의 순서 or 컬럼명)
				날짜데이터 => getDate(컬럼의 순서 or 컬럼명)
			
				while(rs.next()){
					 \-----------
					 	조회된 테이블의 모든 레코드에 반복 작업 수행
					sysout(rs.getString(1)) -> 조회된 레코드의 첫 번째 컬럼값
					sysout(rs.getString("ename")) -> 조회된 레코드의 컬럼명이
													ename인 컬럼의 값
				}

#### 6. 자원반납
	자원을 반납하지 않으면 계속 메모리에 할당되어 있는 상태
	ResultSet, Statement, Connection 모두 반납해야 한다.
	close메소드를 이용해서 자원해제
	가장 마지막에 만들어진 객체부터 해제


​	
​	
​	

***** SQL cmd창에서 DML commit 안하고 작업하면 이클립스에서 계속 실행될 수 있다.
(무결성) commit 안 한 상태에서 롤백할지 말지 모르기 때문