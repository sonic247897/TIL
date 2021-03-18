## 1. 함수

- 함수의 종류는 `단일행 함수`, `그룹 함수`가 있다.

  - `단일행 함수`를 정의하면 테이블의 모든 행에 각각 함수가 적용된다.

  - `그룹 함수`는 그룹으로 묶인 데이터에 적용되므로 <u>`where절`에 그룹함수를 사용할 수 없다</u>.

  > **함수의 결과는 하드디스크에 저장되는 데이터는 아니고, 출력되는 당시에 계산되어 나오는 연산이다.**

### 1) 단일행 함수

**select, where, order by절에 모두 사용할 수 있다.**

#### ① 문자함수

- lower(문자열 or 문자열이 저장되어 있는 컬럼명): 값을 소문자로 변환

- upper(문자열 or 문자열이 저장되어 있는 컬럼명): 값을 대문자로 변환

- `initcap(문자열 or 문자열이 저장되어 있는 컬럼명)`: 전달된 값의 첫 글자만 대문자로 변환

- substr(문자열 or 컬럼명, 시작위치, `추출할 문자열의 개수`)

  > Oracle에서 위치 index는 1부터 시작한다.

- length(문자열 or 컬럼명): 문자열의 길이를 반환

- `instr(문자열 or 컬럼명, 찾을 문자, 찾을 위치, n번째 문자)`

  : 특정 컬럼이나 문자열에서 문자의 위치를 찾을 때 사용하는 함수

  (찾을 위치를 주지 않으면 무조건 처음부터 찾는다.)

  **찾을 위치나 n번째 문자에 대한 매개변수는 생략이 가능**

  **찾을 위치를 -1로 정의하면 문자열의 오른쪽 끝에서 문자를 찾는다.**

  ``` sql
SQL> select substr('oracle',2) from dual;
  
SUBSTR('OR ')
----------
racle
  
SQL> select substr('oracle',2,2) from dual;
  
SUBS
----
ra
  
SQL> select length('oracle') from dual;
  
LENGTH('ORACLE')
----------------
               6
  
SQL> select length('오라클') from dual;
  
LENGTH('오라클')
----------------
               3
  ```

  ``` sql
SQL> select instr('oracle oracle oracle', 'a') from dual;
  
INSTR('ORACLEORACLEORACLE','A')
-------------------------------
                              3
  
SQL> select instr('oracle oracle oracle', 'a', 5) from dual;
  
INSTR('ORACLEORACLEORACLE','A',5)
---------------------------------
                               10
              -- 5번째 위치부터 찾는다.
SQL> select instr('oracle oracle oracle', 'a', 5, 2) from dual;
  
INSTR('ORACLEORACLEORACLE','A',5,2)
-----------------------------------
                                 17 --5번 위치에서부터 2번째 만나는 a의 위치 반환
SQL> select instr('oracle oracle oracle', 'a', -1, 2) from dual;
  
INSTR('ORACLEORACLEORACLE','A',-1,2)
------------------------------------
                                  10
-- -1은 lastindexof와 같다. 뒤에서부터 훑어서 2번째 만나는 a의 위치 변환
  ```

- concat(문자열 or 컬럼명, 문자열 or 컬럼명): `|| 연산자`와 동일. 문자열 연결

- lpad(문자열 or 컬럼명, 출력할 문자열의 길이, `채움 문자`)

  : 전체 출력할 문자열의 길이에 문자열을 출력한 후 남는 공간에 정의한 문자를 채워 출력해주는 함수(왼쪽)

- rpad(문자열 or 컬럼명, 출력할 문자열의 길이, `채움 문자`)

  : 오른쪽

  **주로 주민번호 같이 숨겨야 하는 정보에 사용한다.**

  ``` sql
SQL> select lpad('oracle', 10, '*') from dual;
  
LPAD('ORACLE',10,'*'
--------------------
****oracle
  
SQL> select rpad('oracle', 10, '*') from dual;
  
RPAD('ORACLE',10,'*'
--------------------
oracle****
  ```

- ltrim(문자열 or 컬럼명, `제거할 문자`)

  : 컬럼에서 매개변수로 정의한 문자를 왼쪽에서 찾아 모두 제거

  **연속된 문자만 제거한다.**

- rtrim(문자열 or 컬럼명, `제거할 문자`)

  : 오른쪽

  **주로 네트워크 전송시 발생하는 공백을 제거할 때 사용한다.**

- trim(문자열 or 컬럼명, 제거할 문자)

  : 제거할 문자를 양쪽에서 찾아 모두 제거

  ``` sql
SQL> select ltrim('              oracle',' ') from dual;
  
LTRIM('ORACL'
------------
oracle
  
SQL> select concat('oracle', concat('dbms', 'hello')) from dual;
  
CONCAT('ORACLE',CONCAT('DBMS',
------------------------------
oracledbmshello
  ```

 #### ② 숫자함수

- round(숫자, 반올림할 위치): 반올림

  ``` sql
SQL> select round(125.8888, 0) from dual;
  
ROUND(125.8888,0)
-----------------
              126
  
SQL> select round(125.8888, 1) from dual;
  
ROUND(125.8888,1)
-----------------
            125.9
  
SQL> select round(125.8888, -1) from dual;
  
ROUND(125.8888,-1)
------------------
               130
  ```

#### ③ 변환함수

   - 데이터의 **타입을 변환**하기 위한 함수

   - 또 다른 함수의 매개변수로 사용하게 될 경우, **매개변수의 타입이 컬럼의 타입과 일치해야 하기 때문에** `변환함수`를 사용해야 한다.

     - cast(값 or 컬럼명 as 타입)

       ​									====

       ​									날짜: date

       ​									숫자: integer

     - to_char(변환할 데이터or 컬럼명, `표시할 format`)

        : **표시할 format을 비워두면 그냥 문자열로 변환해준다.**

     *숫자를 문자열로 변환: 세 자리마다 ,를 출력하고 싶은 경우

     ​	숫자의 한 자리를 표시 => `9`, `0`

     ​	콤마 => `,`

     ​	소수점 => `.`

     ​	통화기호 => `\`,` $`, `L`(Locale, 지역별 통화기호를 출력)

     *날짜를 문자열로 변환: 년 월 일 각각의 데이터를 추출하고 싶은 경우

     ​	년도 => YYYY (2019)

     ​	월 => MM (12)

     ​	일 => DD (19)

     ``` sql
     SQL> select cast('2019/11/11' as date) from dual;
     
     CAST('0001'ASINTEGER)
     ---------------------
                         1
         
     SQL> select cast('2019년 11월 11일' as date) from dual;
        select cast('2019년 11월 11일' as date) from dual
                 *
        ERROR at line 1:
     ORA-01861: literal does not match format string
          
     --- 문자열이라도 /나 '이 들어 있는 date 형식이어야 한다.
               
     SQL> select ename, sal, to_char(sal, 'L9,999')
         2  from emp;
          
     
          ENAME                       SAL TO_CHAR(SAL,'L9,999')
          -------------------- ---------- -----------------------
          SMITH                       800           ￦800
          ALLEN                      1600         ￦1,600
          WARD                       1250         ￦1,250
          JONES                      2975         ￦2,975
          MARTIN                     1250         ￦1,250
          BLAKE                      2850         ￦2,850
          CLARK                      2450         ￦2,450
          SCOTT                      3000         ￦3,000
          KING                       5000         ￦5,000
          TURNER                     1500         ￦1,500
          ADAMS                      1100         ￦1,100
          
          ENAME                       SAL TO_CHAR(SAL,'L9,999')
          -------------------- ---------- -----------------------
          JAMES                       950           ￦950
          FORD                       3000         ￦3,000
          MILLER                     1300         ￦1,300
          
          14 rows selected.
          
          SQL> select ename, sal, to_char(sal, '9,999')
            2  from emp;
          
          ENAME                       SAL TO_CHAR(SAL,
          -------------------- ---------- ------------
          SMITH                       800    800
          ALLEN                      1600  1,600
          WARD                       1250  1,250
          JONES                      2975  2,975
          MARTIN                     1250  1,250
          BLAKE                      2850  2,850
          CLARK                      2450  2,450
          SCOTT                      3000  3,000
          KING                       5000  5,000
          TURNER                     1500  1,500
          ADAMS                      1100  1,100
          
          ENAME                       SAL TO_CHAR(SAL,
          -------------------- ---------- ------------
          JAMES                       950    950
          FORD                       3000  3,000
          MILLER                     1300  1,300
          
          14 rows selected.
                                                  
          SQL> select ename, hiredate, to_char(hiredate, 'MM')
            2  from emp
            3  order by to_char(hiredate, 'MM');
          
          ENAME                HIREDATE TO_C
          -------------------- -------- ----
          ADAMS                83/01/12 01
          MILLER               82/01/23 01
          ALLEN                81/02/20 02
          WARD                 81/02/22 02
          JONES                81/04/02 04
          BLAKE                81/05/01 05
          CLARK                81/06/09 06
          TURNER               81/09/08 09
          MARTIN               81/09/28 09
          KING                 81/11/17 11
          SCOTT                82/12/09 12
          
          ENAME                HIREDATE TO_C
          -------------------- -------- ----
          SMITH                80/12/17 12
          JAMES                81/12/03 12
          FORD                 81/12/03 12
          
          14 rows selected.
          SQL> select ename, to_char(hiredate, 'MON') 월,
            2                     to_char(hiredate, 'MONTH') 월
            3  from emp;
           -- 월 앞에 0이 사라짐 : 02월->2월 (한글 세션)
                                                  
          ENAME                월               월
          -------------------- ---------------- ----------------
          SMITH                12월             12월
          ALLEN                2월              2월
          WARD                 2월              2월
          JONES                4월              4월
          MARTIN               9월              9월
          BLAKE                5월              5월
          CLARK                6월              6월
          SCOTT                12월             12월
          KING                 11월             11월
          TURNER               9월              9월
          ADAMS                1월              1월
          
          ENAME                월               월
          -------------------- ---------------- ----------------
          JAMES                12월             12월
          FORD                 12월             12월
          MILLER               1월              1월
          
          14 rows selected.
            
          SQL> alter session set nls_language = 'american';
          
          Session altered.
                                               
          SQL> select ename, to_char(hiredate, 'mon') 월 from emp;
          
          ENAME                월
          -------------------- ------------------------
          SMITH                dec
          ALLEN                feb
          WARD                 feb
          JONES                apr
          MARTIN               sep
          BLAKE                may
          CLARK                jun
          SCOTT                dec
          KING                 nov
          TURNER               sep
          ADAMS                jan
          
          ENAME                월
          -------------------- ------------------------
          JAMES                dec
          FORD                 dec
          MILLER               jan
          
          14 rows selected.
          
          SQL> select ename, to_char(hiredate, 'month') 월 from emp;
          
          ENAME                월
          -------------------- -------------------------------------
          SMITH                december
          ALLEN                february
          WARD                 february
          JONES                april
          MARTIN               september
          BLAKE                may
          CLARK                june
          SCOTT                december
          KING                 november
          TURNER               september
          ADAMS                january
          
          ENAME                월
          -------------------- -------------------------------------
          JAMES                december
          FORD                 december
          MILLER               january
          
          14 rows selected.
     ```

#### ④ 날짜함수

  - 날짜 데이터는 **연산이 가능**하다.
   - sysdate - 오늘 날짜

``` sql
  SQL> select sysdate-5, sysdate, sysdate+5 from dual;
  
  SYSDATE- SYSDATE  SYSDATE+
  -------- -------- --------
  19/12/14 19/12/19 19/12/24
```

#### ⑤ null처리 함수

- nvl(컬럼, null인 경우 처리할 식이나 값) : null인 경우 대신할 식이나 값을 명시

- nvl2(컬럼, 표현값1, 표현값2)
  - 표현값 1 = null이 아닌 경우
  - 표현값 2 = null인 경우

***invliad number 발생의 기준: desc emp; 로 comm의 데이터 타입이 number인데 '신입사원'은 문자임**

**=> 타입을 맞춰줘야 한다!**

``` sql
  SQL> select ename, sal, comm, nvl(to_char(comm), '신입사원')
    2  from emp;
  
  ENAME                       SAL       COMM NVL(TO_CHAR(COMM),'신입사원')
-------------------- ---------- ---------- --------------------------------
  SMITH                       800            신입사원
ALLEN                      1600        300 300
  WARD                       1250        500 500
JONES                      2975            신입사원
  MARTIN                     1250       1400 1400
BLAKE                      2850            신입사원
  CLARK                      2450            신입사원
SCOTT                      3000            신입사원
  KING                       5000            신입사원
TURNER                     1500          0 0
  ADAMS                      1100            신입사원

  ENAME                       SAL       COMM NVL(TO_CHAR(COMM),'신입사원')
-------------------- ---------- ---------- --------------------------------
  JAMES                       950            신입사원
  FORD                       3000            신입사원
  MILLER                     1300            신입사원

  14 rows selected
  
  SQL> select ename, sal, comm, nvl2(to_char(comm), '영업부', '타부서')
    2  from emp;
  
  ENAME                       SAL       COMM NVL2(TO_CHAR(COMM)
  -------------------- ---------- ---------- ------------------
  SMITH                       800            타부서
  ALLEN                      1600        300 영업부
  WARD                       1250        500 영업부
  JONES                      2975            타부서
  MARTIN                     1250       1400 영업부
  BLAKE                      2850            타부서
  CLARK                      2450            타부서
  SCOTT                      3000            타부서
  KING                       5000            타부서
  TURNER                     1500          0 영업부
  ADAMS                      1100            타부서
  
  ENAME                       SAL       COMM NVL2(TO_CHAR(COMM)
  -------------------- ---------- ---------- ------------------
  JAMES                       950            타부서
  FORD                       3000            타부서
  MILLER                     1300            타부서
  
  14 rows selected.
```

  ### 2) 그룹함수

- group by를 적용한 후에 사용할 함수
- sum, avg, max, min, count 등



## 2. 그룹화

``` sql
select 컬럼...
from 테이블...
where 조건
group by 그룹화할 컬럼명(함수를 포함한 식도 가능)
having  group by한 결과에 적용할 조건
order by 정렬할 컬럼명								--순서주의!!
```

  - 테이블에 저장된 레코드를 그룹화 하여 분류하고 싶은 경우 사용

  - **그룹함수() -> 공백이 있으면 안 세므로 primary key인 컬럼을 지정한다.** ex) empno

  - **select절에는 group by절에 명시한 컬럼명과 그룹함수만 사용할 수 있다.**

    -> group by deptno,+a 했으면 select deptno,+a, 그룹함수()  만 가능

``` sql
  SQL> select deptno, count(empno)
  2  from emp
  3  group by deptno;
  
    	DEPTNO COUNT(EMPNO)
	---------- ------------
        	30            6
       		20            5
        	10            3
        	
SQL> select deptno, job, count(empno)
  2  from emp
  3  group by deptno;
select deptno, job, count(empno)
               *
ERROR at line 1:
ORA-00979: not a GROUP BY expression

-- 직업별 연봉 평균
SQL> select job, avg(sal)
  2  from emp
  3  group by job;

JOB                  AVG(SAL)
------------------ ----------
CLERK                  1037.5
SALESMAN                 1400
PRESIDENT                5000
MANAGER            2758.33333
ANALYST                  3000        
  
```

- 데이터가 복잡한 경우 group by 절에 두 개 이상의 컬럼을 명시할 수 있다.

``` sql
 -- 직업별, 부서별 인원수와 최대연봉
SQL> select job, deptno, count(empno), max(sal)
  2  from emp
  3  group by job, deptno
  4  order by job;
  
JOB                    DEPTNO COUNT(EMPNO)   MAX(SAL)
------------------ ---------- ------------ ----------
ANALYST                    20            2       3000
CLERK                      10            1       1300
CLERK                      20            2       1100
CLERK                      30            1        950
MANAGER                    10            1       2450
MANAGER                    20            1       2975
MANAGER                    30            1       2850
PRESIDENT                  10            1       5000
SALESMAN                   30            4       1600

9 rows selected.
```

- group by 하기 전에 적용해야 하는 조건은 where절에 정의

- gruop by 한 결과에 조건을 적용해야 하는 경우 having절을 이용

  (조건에 그룹함수를 써야 하면 having에 추가) 

  

### [실습예제]

##### 1. 이름의 맨 끝 자리가 H인 사람을 빼고 계산. group by를 한 후에 평균 연봉이 2000 이상인 데이터만 출력

>  조건이 있을때 group이 들어간 경우 2)번 구문 사용 (`Having`)

1) group by 전 각각 행에 대해 적용 -> where 절에 사용

``` sql
SQL> select *
  2  from emp
  3  where substr(ename,-1,1) = 'H';

SQL> select *
  2  from emp
  3  where substr(ename, length(ename), 1) = 'H';

SQL> select *
  2  from emp
  3  where ename like '%H';
```

=> 부정 

``` sql
SQL> select *
  2  from emp
  3  where ename not like '%H';
```

2) group by 한 후에 적용 -> group by 밑에 having절 추가 

​	: 그룹화한 결과에 조건 적용하기

``` sql
SQL> select job, avg(sal)
  2  from emp
  3  where ename not like '%H'
  4  group by job
  5  having avg(sal) >= 2000;

JOB                  AVG(SAL)
------------------ ----------
PRESIDENT                5000
MANAGER            2758.33333
ANALYST                  3000
```

##### 2. 직업별 인원수 구하기. 단, 1983년 입사자는 제외하고  최종 결과로는 인원수가 3명 이상인 직업만 출력

``` sql
									--실행 순서
SQL> select job, count(empno)			--5 (그룹함수는 primary key로 지정)
  2  from emp							--1
  3  where hiredate not like '83%'		--2
  4  group by job						--3
  5  having count(empno) >= 3;			--4

JOB                COUNT(EMPNO)
------------------ ------------
CLERK                         3
SALESMAN                      4
MANAGER                       3

SQL> select job, count(empno) num		--5
  2   from emp							--1
  3   where ename not like '%H'			--2
  4   group by job						--3
  5   having num >= 3;					--4
 having num >= 3
        *
ERROR at line 5:
ORA-00904: "NUM": invalid identifier
 	-- alias가 마지막에 정의되기 때문에 having에서 num을 인식할 수 없다.
SQL> select job, count(empno) num		--5 : 무엇을 출력할지 정하고
  2   from emp							--1
  3   where ename not like '%H'			--2
  4   group by job						--3
  5   having count(empno) >= 3			--4
  6  order by num desc;					--6 : 정렬한대로 출력

JOB                       NUM
------------------ ----------
SALESMAN                    4
MANAGER                     3
CLERK                       3
```



##### nvl함수

``` sql
select nvl(to_char(DEPARTMENT_ID), 'NO Department') 부서번호, round(avg(SALARY),0) 평균급여
from employees
where nvl(to_char(DEPARTMENT_ID), 'NO Department')
group by DEPARTMENT_ID
having round(avg(salary), 0)>6000;
// 왜 안되나 where절에 nvl 쓰면?  써도 되는데 "관계"가 있어야함
nvl은 void함수가 아니라 전체 표 리턴?(자바 메서드 아니다)
```

- 출력 - select절에서 함
- 비교 - where절에서 함
- 원본 데이터 가공해서 group - group by절에서 함