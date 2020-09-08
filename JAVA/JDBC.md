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