## 1. 조인

- 정규화된 테이블이나 혹은 일반적으로 작성된 여러 테이블의 컬럼을 이용해서 데이터를 조회하는 것을 

  **조인**이라고 한다.

- 조인은 `관계형 데이터베이스`에서 반드시 알아야 하는 개념

- 기본키와 외래키의 관계를 이용해서 테이블을 조인

  **=> 외래키를 가지고 기본키 테이블에서 값을 비교하여 작업이 진행된다.**

- 조인을 하는 경우 무조건 `where절`에 조인 조건을 정의해야 한다.(일치하는 것을 찾아와야 하기 때문에)

- 테이블을 여러 개 사용하는 경우 **모든 테이블들의 조인조건을 정의해야 하며**

  `select절`에서 사용하지 않고, 조건으로만 사용한다고 하더라도(from, where, ..) 조인조건은 정의해야 한다.

#### [조인방법]

1. **from절**에 조회하고 싶은 데이터가 저장된 테이블을 모두 명시

2. 조인을 하는 경우 컬럼이 어떤 테이블의 컬럼인지 명확하게 정의하기 위해 

   `"테이블명.컬럼명"`으로 액세스를 한다.

3. from절에 테이블명을 정의할때 alias를 함께 추가하여 alias를 통해 액세스하도록 한다.

   > select alias1.컬럼명, alias2.컬럼명 ...
   >
   > from 테이블1 alias1, 테이블2 alias2

4. where절에는 반드시 조인조건을 추가하며 조인조건에는 두 테이블의 값을 비교하기 위해 정의하는 것이므로 **외래키**와 **기본키**를 정의한다.

   **<기본 조인의 경우>**

   `외래키 테이블(child 테이블)`에 정의된 컬럼값을 `기본키테이블(parent 테이블)`에서 비교하여 정확하게 일치하는 경우 값을 가져온다.
   
   (테이블이 두 개-> 조인조건 1개, 테이블이 세 개-> 조인조건 2개)

``` sql
SQL> select d.dname, e.ename, e.sal
  2  from emp e, dept d
  3  where e.deptno = d.deptno and sal>=3000;

DNAME                        ENAME                       SAL
---------------------------- -------------------- ----------
ACCOUNTING                   KING                       5000
RESEARCH                     FORD                       3000
RESEARCH                     SCOTT                      3000
 --외래키인 e의 deptno를 가지고 d의 deptno로 가서 일치하는 것을 찾아온다

 -- 부서별 인원수 구하기(단, 부서명으로 출력하기)
SQL> select d.dname, count(e.empno)
  2  from emp e, dept d
  3  where e.deptno = d.deptno
  4  group by d.dname;

DNAME                        COUNT(E.EMPNO)
---------------------------- --------------
ACCOUNTING                                3
RESEARCH                                  5
SALES                                     6

--3.DALLAS에근무하는사원중급여1500 이상인사원의이름,급여,업무, 입사일, 보너스를조회
 -- 현재 내가 dept테이블의 데이터를 사용하지는 않지만, emp에서 locations테이블까지 가기 위해 연관된 테이블을 조인조건으로 전부 명시해야 한다.
SQL> select e.ename, e.sal, e.job, e.hiredate, e.comm
  2  from emp e, dept d, locations l
  3  where e.deptno = d.deptno and d.loc_code = l.loc_code
  4  and l.city = 'DALLAS' and e.sal>= 1500;

ENAME                       SAL JOB                HIREDATE       COMM
-------------------- ---------- ------------------ -------- ----------
FORD                       3000 ANALYST            81/12/03
SCOTT                      3000 ANALYST            82/12/09
JONES                      2975 MANAGER            81/04/02


```

### 조인 종류

- equi join(inner join) : 두 테이블에서 정확하게 일치하는 컬럼에 대한 데이터만 조인

- outer join: 두 개 이상의 테이블에 조인을 적용했을 때 join 조건을 만족하지 않아도 데이터를 

  ​				조회하고 싶은  경우 사용

  - 조인조건에 (+)을 추가한다.
  - join 조건을 만족하지 않아도 한 쪽 테이블의 모든 데이터를 출력하고 싶을 때 사용하는 조인방식으로 정보가 부족한 테이블의 컬럼에 (+)를 추가한다.

> select 테이블alias.컬럼명, ...
>
> from 테이블 alias
>
> where 테이블alias.컬럼명 = 테이블alias.
>
> 컬럼명(+)
>
> ​	**=> (+)기호는 한쪽에만 사용한다. 데이터가 확장되어야 하는 곳에 추가한다.**

#### [실습예제]

1. 부서별 인원수를 출력하기 **(기준: 인원수(사원) -> 부족한 데이터: 부서명`(+)`)**

   단, 부서명을 출력하고 인원이 없는 부서명도 모두 출력한다.

```sql
SQL> select d.dname, count(e.empno)
  2  from emp e, dept d
  3  where e.deptno(+) = d.deptno
  4  group by dname;

DNAME                        COUNT(E.EMPNO)
---------------------------- --------------
ACCOUNTING                                3
INSA                                      0
OPERATIONS                                0
RESEARCH                                  5
SALES                                     6
```

2. 부서별 인원수를 출력하기**(기준: 인원수(사원) -> 부족한 데이터: 부서명`(+)`)**

   단, 부서명을 출력하고 부서가 배치되지 않은 사원은 "신입사원"으로 표시한다.

``` sql
SQL> select nvl(d.dname, '신입사원'), count(e.empno)
  2  from emp e, dept d
  3  where d.deptno(+) = e.deptno
  4  group by d.dname;

NVL(D.DNAME,'신입사원')      COUNT(E.EMPNO)
---------------------------- --------------
ACCOUNTING                                3
신입사원                                  1
RESEARCH                                  5
SALES                                     6
```

- self 조인: 두 개 이상의 테이블에서 조인하지 않고 같은 테이블의 컬럼들을 이용해서 조인
  - 하나를 가상테이블로 만듬

``` sql
SQL> select e.empno, e.ename, e.mgr, m.ename
  2  from emp e,emp m
  3  where e.mgr = m.empno;

     EMPNO ENAME                       MGR ENAME
---------- -------------------- ---------- -----------
      7902 FORD                       7566 JONES
      7788 SCOTT                      7566 JONES
      7900 JAMES                      7698 BLAKE
      7844 TURNER                     7698 BLAKE
      7654 MARTIN                     7698 BLAKE
      7521 WARD                       7698 BLAKE
      7499 ALLEN                      7698 BLAKE
      7934 MILLER                     7782 CLARK
      7876 ADAMS                      7788 SCOTT
      7782 CLARK                      7839 KING
      7698 BLAKE                      7839 KING
      7566 JONES                      7839 KING
      7369 SMITH                      7902 FORD

13 rows selected.

-- 관리자명 인원수
SQL> select m.ename, count(e.empno)
  2  from emp e, emp m
  3  where e.mgr = m.empno -- inner join이면서 self join
  4  group by m.ename;

ENAME                COUNT(E.EMPNO)
-------------------- --------------
JONES                             2
FORD                              1
CLARK                             1
SCOTT                             1
BLAKE                             5
KING                              3

6 rows selected.

SQL>  select m.ename, count(e.empno)
  2   from emp e, emp m
  3   where e.mgr = m.empno(+)
  4  group by m.ename;

ENAME                COUNT(E.EMPNO)
-------------------- --------------
JONES                             2
                                  2 	-- 최고관리자, 신입사원
FORD                              1
CLARK                             1
SCOTT                             1
BLAKE                             5
KING                              3

7 rows selected.
```

## 2. 서브쿼리

- SQL문에 삽입된 query

- select문에서 주로 사용하고 select문에 삽입된 select문

  바깥쪽의 query를 main query, 안쪽에 삽입된 query를 sub query라고 한다.

- sub query는 괄호로 묶어 주어야 한다.

- sub query는 메인쿼리가 실행되기 전에 한 번 실행되며(가상 메모리 할당) 그 실행결과를 메인쿼리에 사용한다.  =>뷰: db 데이터가 변경되면 view가 실행되면서 변경된 내용이 갱신된다. 하지만 sub query는 실행될 때 메인쿼리보다 먼저 실행되어 가상메모리에 한번 올라왔다가 메인쿼리 실행 후에는 사라진다.

#### [실습]

10번 부서의 평균 급여보다 급여를 많이 받는 사원들을 조회

​	-> where절에 avg(sal) 못 씀

``` sql
SQL> select avg(sal)
  2  from emp
  3  where deptno = 10;

  AVG(SAL)
----------
2916.66667

SQL> select ename, sal
  2  from emp
  3  where sal > 2916.66667;

ENAME                       SAL
-------------------- ----------
JONES                      2975
SCOTT                      3000
KING                       5000
FORD                       3000

-- 두 개 쿼리를 하나의 쿼리로 묶음: 쿼리의 결과를 다른 쿼리에 삽입(서브쿼리)
-- 1행 1열 짜리 결과가 나와야 함(값 1개)
SQL> select ename, sal
  2  from emp
  3  where sal > (select avg(sal)
  4                     from emp
  5                     where deptno = 10);

ENAME                       SAL
-------------------- ----------
JONES                      2975
SCOTT                      3000
KING                       5000
FORD                       3000
```

### 서브쿼리의 종류

1. 단일행 서브쿼리 - 결과가 1행 1열인 서브쿼리

   ​							>, <=, <, <= 연산자와 함께 사용할 수 있다.

   ​							비교 연산자 오른쪽에 서브쿼리를 추가해야 한다.

##### [실습]

- 전체 평균보다 높은 급여를 받는 사원의 목록(ename, sal)

``` sql
SQL> select ename, sal
  2  from emp
  3  where sal > (select avg(sal)
  4                     from emp);

ENAME                       SAL
-------------------- ----------
JONES                      2975
BLAKE                      2850
CLARK                      2450
SCOTT                      3000
KING                       5000
FORD                       3000

6 rows selected.
```

- smith와 같은 job을 갖고 있는 사원의 목록(ename, job, hiredate)

```sql
SQL> select ename, job, hiredate
  2  from emp
  3  where job = (select job
  4                     from emp
  5                     where ename = 'SMITH');	--데이터는 대소문자 가림!!

ENAME                JOB                HIREDATE
-------------------- ------------------ --------
SMITH                CLERK              80/12/17
ADAMS                CLERK              83/01/12
JAMES                CLERK              81/12/03
MILLER               CLERK              82/01/23

-- SMITH 빼고
SQL>  select ename, job, hiredate
  2   from emp
  3   where job = (select job
  4                      from emp
  5                      where ename = 'SMITH')
  6  and ename not in ('SMITH');

ENAME                JOB                HIREDATE
-------------------- ------------------ --------
ADAMS                CLERK              83/01/12
JAMES                CLERK              81/12/03
MILLER               CLERK              82/01/23
```

- 10번 부서에 근무하는 사원들의 job과 같은 job을 갖고 있는 사원의 목록

``` sql
SQL> select ename, job, hiredate
  2  from emp
  3  where job = (select job
  4  from emp
  5  where deptno = 10);
where job = (select job
             *
ERROR at line 3:
ORA-01427: single-row subquery returns more than one row -- job이3개임
```

2. 다중행 서브쿼리

- 서브쿼리의 실행결과가 **열 하나**에 행이 여러개인 경우
- `=`연산자와 같은 비교연산자를 사용할 수 없다.
- in: 컬럼의 값이 정확하게 일치하는 경우
  - <any: 오른쪽에 나오는 어떤 값들보다 작으면 된다 = 서브쿼리 결과의 최대값보다 작은 값을 구하는 경우
  - '>any: 서브쿼리 결과의 최소값보다 큰 값을 구하는 경우
  - <all: 모든 값보다 작아야 한다 = 서브쿼리 결과의 최소값보다 작은 값을 구하는 경우
  - '>all: 서브쿼리 결과의 최대값보다 큰 값을 구하는 경우

``` sql
SQL> select ename, empno
  2  from emp
  3  where deptno in (select deptno
  4  from emp
  5  where ename like '%T%');

ENAME                     EMPNO
-------------------- ----------
FORD                       7902
ADAMS                      7876
SCOTT                      7788
JONES                      7566
SMITH                      7369
JAMES                      7900
TURNER                     7844
BLAKE                      7698
MARTIN                     7654
WARD                       7521
ALLEN                      7499

11 rows selected.

SQL> select sal
  2  from emp
  3  where deptno = 10;

       SAL
----------
      2450
      5000
      1300
      
 -- any: 어떤 값보다도 작기만 하면 된다.
SQL> select ename, sal
  2  from emp
  3  where sal <any(select sal
  4                     from emp
  5                     where deptno=10);

ENAME                       SAL
-------------------- ----------
SMITH                       800
JAMES                       950
ADAMS                      1100
WARD                       1250
MARTIN                     1250
MILLER                     1300
TURNER                     1500
ALLEN                      1600
CLARK                      2450
BLAKE                      2850
JONES                      2975
FORD                       3000
SCOTT                      3000

13 rows selected.
 -- all: 모든 값에 대해 작아야 한다.
SQL> select ename, sal
  2   from emp
  3   where sal <all(select sal
  4                      from emp
  5                      where deptno=10);

ENAME                       SAL
-------------------- ----------
WARD                       1250
MARTIN                     1250
ADAMS                      1100
JAMES                       950
SMITH                       800
```

3. 다중열 서브쿼리

- 두 개 이상의 컬럼과 다중행을 반환하는 서브쿼리
- 메인쿼리 비교 컬럼의 갯수, 종류가 서브쿼리의 반환 결과와 동일

> ....
>
> where (컬럼1, 컬럼2) in (select 컬럼1, 컬럼2
>
> ​											.....)

``` sql
--각 부서별로 최소급여를 받는 사원의 정보를 출력(사원명, 부서코드, 급여, 입사일)
SQL> select ename, deptno, sal from emp;

ENAME                    DEPTNO        SAL
-------------------- ---------- ----------
SMITH                        20        800
ALLEN                        30       1600
WARD                         30       1250
JONES                        20       2975
MARTIN                       30       1250
BLAKE                        30       2850
CLARK                        10       2450
SCOTT                        20       3000
KING                         10       5000
TURNER                       30       1500
ADAMS                        20       1100
JAMES                        30        950
FORD                         20       3000
MILLER                       10       1300
장동건                       20       1300

15 rows selected.

SQL> select ename, empno, sal, hiredate
  2  from emp
  3  where sal in (select min(sal) minSal
  4  from emp
  5  group by deptno);

ENAME                     EMPNO        SAL HIREDATE
-------------------- ---------- ---------- --------
SMITH                      7369        800 80/12/17
JAMES                      7900        950 81/12/03
MILLER                     7934       1300 82/01/23
장동건                     7777       1300 19/12/20

 -- 두 개의 컬럼이 일치하는 것만 조회
SQL> select ename, deptno, sal, hiredate
  2  from emp
  3  where (deptno, sal) in (select deptno, min(sal)
  4  from emp
  5  group by deptno);

ENAME                    DEPTNO        SAL HIREDATE
-------------------- ---------- ---------- --------
SMITH                        20        800 80/12/17
JAMES                        30        950 81/12/03
MILLER                       10       1300 82/01/23
```

4. 상관형 서브쿼리(상호연관 서브쿼리)

- 메인쿼리의 값이 서브쿼리에서 사용되는 경우
- 메인쿼리 한 row에 대해 서브쿼리가 한 번씩 실행된다.
- 메인쿼리의 값이 어떤 값이냐에 따라 서브쿼리의 결과가 달라진다.
- 실행
  1. 메인쿼리에서 비교할 값을 가져온다.
  2. 메인쿼리에서 받은 값을 이용해서 서브쿼리가 실행된다.
  3. 서브쿼리의 실행결과로 메인쿼리가 실행된다.
  4. 메인쿼리의 레코드 수만큼 반복된다.

``` sql
-- 소속부서의 급여 평균보다 급여가 많은 사원들의 정보를 출력
-- (ename, deptno, sal)
SQL> select ename, deptno, sal
  2  from emp outer
  3  where sal > (select avg(sal)
  4  from emp e
  5  where e.deptno = outer.deptno);

ENAME                    DEPTNO        SAL
-------------------- ---------- ----------
ALLEN                        30       1600
JONES                        20       2975
BLAKE                        30       2850
SCOTT                        20       3000
KING                         10       5000
FORD                         20       3000

6 rows selected.

SQL> select deptno, avg(sal)
  2  from emp
  3  group by deptno;

    DEPTNO   AVG(SAL)
---------- ----------
        30 1566.66667
        20 2029.16667
        10 2916.66667
```

5. from절에서 사용하는 서브쿼리(inline view)

- 뷰로 저장해서 사용하는 것이 아니라 직접 써서 사용하는 서브쿼리

- from절에 서브쿼리를 추가해서 사용

- 서브쿼리 결과를 가상 테이블로 사용하겠다는 의미

- from절에 추가되는 서브쿼리는 alias를 정의해야 한다.

- from절에 추가되는 서브쿼리 내부의 컬럼은 실제 컬럼처럼 메인쿼리에서 사용해야 하므로

  컬럼도 컬럼명이 존재하거나 alias를 정의해야 한다.

  **상관형 서브쿼리를 쓰는것보다  조인과 from절에 추가하는 서브쿼리를 이용해서 작업하면 속도가 더 빠르다.**

> select 컬럼명1, ...
>
> from (select 컬럼...
>
> ​			from 테이블명
>
> ​			where....
>
> ​			group by....) alias

``` sql
SQL> select deptcode, countdata
  2  from (select deptno as deptcode, count(empno) as countdata
  3             from emp
  4             group by deptno) mytable;

  DEPTCODE  COUNTDATA
---------- ----------
        30          6
        20          6
        10          3
        
-- 소속부서의 급여 평균보다 급여가 많은 사원들의 정보를 출력
SQL> select e.ename, e.deptno, e.sal, d.avgsal
  2  from emp e, (select deptno, avg(sal) avgsal--함수로 나온 결과는 alias가 있어야 한다.
  3  from emp
  4  group by deptno) d
  5  where e.deptno = d.deptno --조인
  6  and e.sal > d.avgsal;

ENAME                    DEPTNO        SAL     AVGSAL
-------------------- ---------- ---------- ----------
BLAKE                        30       2850 1566.66667
ALLEN                        30       1600 1566.66667
FORD                         20       3000 2029.16667
SCOTT                        20       3000 2029.16667
JONES                        20       2975 2029.16667
KING                         10       5000 2916.66667

6 rows selected.
```



## 3. DML

#### 복수행 insert

``` sql
SQL> create table member(
  2             id varchar2(10),
  3             pass varchar2(10),
  4             addr varchar2(20));

Table created.

SQL> insert into member values('jang','1234', '서울');

1 row created.
-- 서브쿼리의 실행 결과로 insert all 하는 것이므로 더미테이블 조회해서 select문을 
-- 추가해야 인식한다.
SQL> insert all
  2     into member values('lee', '1234', '인천')
  3     into member values('kang', '1234', '안산')
  4     into member values('hong', '1234', '수원')
  5  select * from dual;

3 rows created.

SQL> insert into member values('jjang', null, null);

1 row created.

SQL> select * from member;

ID                   PASS                 ADDR
-------------------- -------------------- ----------
jang                 1234                 서울
lee                  1234                 인천
kang                 1234                 안산
hong                 1234                 수원
jjang

SQL> commit;

Commit complete.
```

#### delete

``` sql
SQL> delete member;	--from 안 써줘도 된다.

5 rows deleted.

SQL> rollback;

Rollback complete.

SQL> delete from member;

SQL> delete from member
  2  where id = 'jjang';

1 row deleted.

SQL> select * from member;

ID                   PASS                 ADDR
-------------------- -------------------- -------
jang                 1234                 서울
lee                  1234                 인천
kang                 1234                 안산
hong                 1234                 수원

SQL> delete
  2  from member
  3  where addr = (select addr
  4             from member
  5             where id = 'jang');

1 row deleted.
```

#### update

- **set절, where절에도 subquery를 사용할 수 있다.**

``` sql
SQL> update member
  2  set addr = (select addr
  3             from member
  4             where id = 'jang')
  5  where id = 'lee';

1 row updated.

SQL> select * from member;

ID                   PASS                 ADDR
-------------------- -------------------- -----
jang                 1234                 서울
lee                  1234                 서울
kang                 1234                 안산
hong                 1234                 수원
jjang
```

**update ~ set hit = hit+1 표현 가능!**

``` sql
SQL>  update tb_board
  2   set hit = hit+1
  3   where boardnum = 42;
  
 1 row updated.
 -- 같은 표현을 위처럼 더 간결하게 할 수 있다. 
  SQL> update tb_board
  2  set hit = (select hit
  3  from tb_board
  4  where boardnum = 42) +1
  5  where boardnum = 42;

1 row updated.

SQL> select boardnum, id, hit from tb_Board;

  BOARDNUM ID                                              HIT
---------- ---------------------------------------- ----------
        31 dao                                               7
         2 kang                                              0
        24 Hyunjeong                                         0
        43 khj                                               0
        27 jjang                                             0
        42 hong1234                                          3
         1 lee                                               0
        30 나나                                              0

8 rows selected.
```

