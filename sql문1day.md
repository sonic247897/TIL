## 1. Query - 기본 select

>  select 컬럼명1, 컬럼2....
>
> from 테이블

- sql문은 대소문자 구분하지 않는다.

- ;은 sql문의 종료를 의미

  ;을 입력하기 전에 여러 줄로 sql문을 작성할 수 있다.

``` sql
SQL> select empno, ename, hiredate, job
  2  from emp;

     EMPNO ENAME                HIREDATE JOB
---------- -------------------- -------- ------------------
      7369 SMITH                80/12/17 CLERK
      7499 ALLEN                81/02/20 SALESMAN
      7521 WARD                 81/02/22 SALESMAN
      7566 JONES                81/04/02 MANAGER
      7654 MARTIN               81/09/28 SALESMAN
      7698 BLAKE                81/05/01 MANAGER
      7782 CLARK                81/06/09 MANAGER
      7788 SCOTT                82/12/09 ANALYST
      7839 KING                 81/11/17 PRESIDENT
      7844 TURNER               81/09/08 SALESMAN
      7876 ADAMS                83/01/12 CLERK

     EMPNO ENAME                HIREDATE JOB
---------- -------------------- -------- ------------------
      7900 JAMES                81/12/03 CLERK
      7902 FORD                 81/12/03 ANALYST
      7934 MILLER               82/01/23 CLERK

14 rows selected.
```



- *는 모든 컬럼을 조회하겠다는 의미

- 컬럼에 null을 저장할 수 있다.

  null은 0이나 space만 입력해 놓은 값과 다른 값

  Oracle에서 null은 아무 값도 없는 것을 의미

  사용할 수 없고 저장되어 있지 않은 상태

- 컬럼명 대신 alias를 정의해서 사용할 수 있다.

  select 컬럼명 alias명, 컬럼명 as alias명, 컬럼명 "alias명"

  ​																		(alias명에 공백이 있는 경우 사용)

  -> alias에서만 " "을 쓸 수 있다.

``` sql
SQL> select ename 사원명, hiredate as 입사일, sal as "나의 급여" FROM emp;

사원명               입사일    나의 급여
-------------------- -------- ----------
SMITH                80/12/17        800
ALLEN                81/02/20       1600
WARD                 81/02/22       1250
JONES                81/04/02       2975
MARTIN               81/09/28       1250
BLAKE                81/05/01       2850
CLARK                81/06/09       2450
SCOTT                82/12/09       3000
KING                 81/11/17       5000
TURNER               81/09/08       1500
ADAMS                83/01/12       1100

사원명               입사일    나의 급여
-------------------- -------- ----------
JAMES                81/12/03        950
FORD                 81/12/03       3000
MILLER               82/01/23       1300

14 rows selected.
```

- 여러 컬럼을 합쳐서 하나의 컬럼으로 조회할 수 있다.

  |연산자 이용(String의 concat과 비슷한 개념으로 사용)

- 오라클의 문자열, 날짜 데이터는 ' '로 표현

``` sql
SQL> select '나의 입사일은' || hiredate || '입니다.'
  2  from emp;

'나의입사일은'||HIREDATE||'입니다.'
--------------------------------------------------------------------------
나의 입사일은80/12/17입니다.
나의 입사일은81/02/20입니다.
나의 입사일은81/02/22입니다.
나의 입사일은81/04/02입니다.
나의 입사일은81/09/28입니다.
나의 입사일은81/05/01입니다.
나의 입사일은81/06/09입니다.
나의 입사일은82/12/09입니다.
나의 입사일은81/11/17입니다.
나의 입사일은81/09/08입니다.
나의 입사일은83/01/12입니다.

'나의입사일은'||HIREDATE||'입니다.'
--------------------------------------------------------------------------
나의 입사일은81/12/03입니다.
나의 입사일은81/12/03입니다.
나의 입사일은82/01/23입니다.

14 rows selected.
```

- 연산의 결과로 컬럼을 생성할 수 있다. (+,*,/,- 함수...)
  - 원본 데이터는 변경할 수 없다.
  - 단, null이 포함되어 있는 컬럼은 연산할 수 없다.

``` sql
SQL> select ename, sal, comm, sal+comm 급여합
  2  from emp;

ENAME                       SAL       COMM     급여합
-------------------- ---------- ---------- ----------
SMITH                       800
ALLEN                      1600        300       1900
WARD                       1250        500       1750
JONES                      2975
MARTIN                     1250       1400       2650
BLAKE                      2850
CLARK                      2450
SCOTT                      3000
KING                       5000
TURNER                     1500          0       1500
ADAMS                      1100

ENAME                       SAL       COMM     급여합
-------------------- ---------- ---------- ----------
JAMES                       950
FORD                       3000
MILLER                     1300

14 rows selected.
```

- 중복이 있는 경우 중복을 제거하기 위해 select문에 distinct를 추가할 수 있다.

``` sql
SQL> select job from emp;

JOB
------------------
CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
ANALYST
PRESIDENT
SALESMAN
CLERK

JOB
------------------
CLERK
ANALYST
CLERK

14 rows selected.

SQL> select distinct job from emp;

JOB
------------------
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
```

### [실습예제]

1. 다음과 같은 내용을 하나의 컬럼으로 출력하세요

   XXXX의 급여는 ___________입니다.

   ``` sql
   SQL>  select ename ||'의 급여는 ' || sal || '입니다.'
     2  from emp;
   
   ENAME||'의급여는'||SAL||'입니다.'
   --------------------------------------------------------
   SMITH의 급여는 800입니다.
   ALLEN의 급여는 1600입니다.
   WARD의 급여는 1250입니다.
   JONES의 급여는 2975입니다.
   MARTIN의 급여는 1250입니다.
   BLAKE의 급여는 2850입니다.
   CLARK의 급여는 2450입니다.
   SCOTT의 급여는 3000입니다.
   KING의 급여는 5000입니다.
   TURNER의 급여는 1500입니다.
   ADAMS의 급여는 1100입니다.
   
   ENAME||'의급여는'||SAL||'입니다.'
   --------------------------------------------------------
   JAMES의 급여는 950입니다.
   FORD의 급여는 3000입니다.
   MILLER의 급여는 1300입니다.
   
   14 rows selected.
   ```

   

2. 사원번호(empno), 급여(sal), comm, 연봉(계산)을 조회한다.

   - sal는 월급여로 alias 추가

   - 연봉은 급여와 comm을 이용해서 계산

     (null이 포함된 항목은 계산되지 않는다)

``` sql
SQL> select empno, sal as 월급여,comm, sal*12+comm 연봉
  2  from emp;

     EMPNO     월급여       COMM       연봉
---------- ---------- ---------- ----------
      7369        800
      7499       1600        300      19500
      7521       1250        500      15500
      7566       2975
      7654       1250       1400      16400
      7698       2850
      7782       2450
      7788       3000
      7839       5000
      7844       1500          0      18000
      7876       1100

     EMPNO     월급여       COMM       연봉
---------- ---------- ---------- ----------
      7900        950
      7902       3000
      7934       1300

14 rows selected.
```

## 2. Select절에 조건 추가하기

select [distinct] 컬럼명, 컬럼명,....[alias명]

from 테이블명

where 조건

- 검색 결과를 제한(조건에 만족하는 데이터만 조회하겠다는 의미)
- where절은 from절 다음에 정의
- where절은 조건식이 true가 되도록 정의
- where절에 사용할 수 있는 비교 연산자: >, >=, <, <=, <>

> **=** 같다,  **!=**, **<>** 같지 않다

- where절에서 조건과 함께 비교하는 값을 추가해야 하는 경우 문자, 날짜는 작은 따옴표로 묶어줘야 한다.
- SQL은 대소문자를 구분하지 않는다. 그러나 값을 비교하는 경우 정확하게 대소문자까지 일치해야 한다.

``` sql
SQL> select ename, job, hiredate, sal
  2  from emp
  3  where job = 'manager';

no rows selected

SQL> select ename, job, hiredate, sal
  2  from emp
  3  where job = 'MANAGER';

ENAME                JOB                HIREDATE        SAL
-------------------- ------------------ -------- ----------
JONES                MANAGER            81/04/02       2975
BLAKE                MANAGER            81/05/01       2850
CLARK                MANAGER            81/06/09       2450

SQL> select ename, job, hiredate, sal
  2  from emp
  3  where sal >3000;

ENAME                JOB                HIREDATE        SAL
-------------------- ------------------ -------- ----------
KING                 PRESIDENT          81/11/17       5000

SQL> select ename, job, hiredate, sal
  2  from emp
  3  where hiredate > '1982/01/01';

ENAME                JOB                HIREDATE        SAL
-------------------- ------------------ -------- ----------
SCOTT                ANALYST            82/12/09       3000
ADAMS                CLERK              83/01/12       1100
MILLER               CLERK              82/01/23       1300


```

- 두 개 이상의 조건이 있는 경우 사용할 수 있는 연산자

  and 연산자: 모든 조건이 일치

  between A and B: `and연산`과 동일(같은 컬럼에서 조건을 비교하는 경우)

   2000<=sal & sal<=5000  **=** between 2000 and 5000

  or 연산자: 모든 조건 중 한 개만 일치(조건이 모두 다른 컬럼인 경우)

  in 연산자: `or연산자`의 의미와 동일

  ​				 컬럼명 in (비교할 값, 값, ..........)  

  (같은 컬럼에서 값을 여러개 비교해야 하는 경우 더 쉽게 비교하기 위해 만들어진 or)

  not 연산자: 부정

``` sql
SQL> select *
  2  from emp
  3  where deptno = 10
  4       and job= 'MANAGER';

     EMPNO ENAME                JOB                       MGR HIREDATE        SAL       COMM     DEPTNO
---------- -------------------- ------------------ ---------- -------- ---------- ---------- ----------
      7782 CLARK                MANAGER                  7839 81/06/09       2450                    10

SQL> select ename, job, deptno
  2  from emp
  3  where job in('MANAGER','PRESIDENT');

SQL> select ename, job, deptno
  2  from emp
  3  where job not in('MANAGER','PRESIDENT');
```

- null 값에 대한 비교

  is null: null인 데이터를 조회

  is not null: null이 아닌 데이터를 조회

``` sql
SQL> select ename, sal, comm
  2  from emp
  3  where comm is not null;

ENAME                       SAL       COMM
-------------------- ---------- ----------
ALLEN                      1600        300
WARD                       1250        500
MARTIN                     1250       1400
TURNER                     1500          0
```

- like 연산자: 대표문자와 함께 사용

  - 조건 비교를 위해 입력한 값이 문자열에 포함되어 있는 것을 찾는 경우
  - %: 모든 문자열
  - _: 한 자리 문자를 의미
  - 컬럼명 like 값% (값으로만 시작하면 어떤것이든 선택)

  ​					%값(값으로만 끝나면 어떤것이든 선택)

  ​					%값%(중간에 값이 있으면 어떤것이든 선택)

   		like _A_____ _ _  _ : 두번째에 A가 들어간 5자리

``` sql
SQL> select ename, sal, comm
  2  from emp
  3  where ename like 'A%';

ENAME                       SAL       COMM
-------------------- ---------- ----------
ALLEN                      1600        300
ADAMS                      1100

SQL> select ename, sal, comm
  2  from emp
  3   where ename like '_A%';

ENAME                       SAL       COMM
-------------------- ---------- ----------
WARD                       1250        500
MARTIN                     1250       1400
JAMES                       950
```

### 3. 정렬

> select [distinct] 컬럼명, 컬럼명, .... [alias명]
>
> from 테이블명
>
> where 조건
>
> order by 컬럼명 정렬기준
>
> ​							-------------> asc, desc

- asc: 오름차순 정렬

  desc: 내림차순 정렬

  정렬기준을 생략하면 기본은 오름차순

- 오름차순: 1 2 3 4 5 6 7 8 9...

  ​				ㄱ ㄴ ㄷ ㄹ ㅁ ㅂ ㅅ..

  ​				A B C D E F G H..

- 내림차순: 10 9 8 7 6 5 4 3...

  ​				ㅎ ㅍ ㅌ ㅋ ....

  ​				Z Y X W ....

  ``` sql
  SQL>  select ename, sal, job
    2   from emp
    3   order by sal desc;
  
  ENAME                       SAL JOB
  -------------------- ---------- ------------------
  KING                       5000 PRESIDENT
  FORD                       3000 ANALYST
  SCOTT                      3000 ANALYST
  JONES                      2975 MANAGER
  BLAKE                      2850 MANAGER
  CLARK                      2450 MANAGER
  ALLEN                      1600 SALESMAN
  TURNER                     1500 SALESMAN
  MILLER                     1300 CLERK
  WARD                       1250 SALESMAN
  MARTIN                     1250 SALESMAN
  
  ENAME                       SAL JOB
  -------------------- ---------- ------------------
  ADAMS                      1100 CLERK
  JAMES                       950 CLERK
  SMITH                       800 CLERK
  
  14 rows selected.
  
  ENAME                       SAL JOB
  -------------------- ---------- ------------------
  ALLEN                      1600 SALESMAN
  WARD                       1250 SALESMAN
  TURNER                     1500 SALESMAN
  MARTIN                     1250 SALESMAN
  KING                       5000 PRESIDENT
  BLAKE                      2850 MANAGER
  JONES                      2975 MANAGER
  CLARK                      2450 MANAGER
  MILLER                     1300 CLERK
  SMITH                       800 CLERK
  ADAMS                      1100 CLERK
  
  ENAME                       SAL JOB
  -------------------- ---------- ------------------
  JAMES                       950 CLERK
  FORD                       3000 ANALYST
  SCOTT                      3000 ANALYST
  
  14 rows selected.
  
  ```

  

  ​				