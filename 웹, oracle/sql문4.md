## DDL

#### 1. alter(테이블 수정)

- add (추가)

``` sql
SQL> alter table member
  2  add (point number, name varchar2(20), email varchar2(20));

Table altered.

SQL> alter table member
  2  add (tel varchar2(15), info varchar2(10));

Table altered.
```

- modify (수정)

``` sql
SQL> alter table member
  2  modify (tel char(11));

Table altered.
```

- drop (삭제)

``` sql
SQL> alter table member
  2  drop column info;

Table altered.
```

- rename (이름 재설정)

``` sql
SQL>  alter table member
  2   rename column addr to address;

Table altered.
```

#### 2. drop(테이블 삭제) --DML 아님. rollback으로 되돌릴 수 없다.

``` sql
SQL> drop table member;

Table dropped.

SQL> desc member;
ERROR:
ORA-04043: object member does not exist
```

#### 3. create(테이블 정의)

``` sql
SQL> create table member(
  2  id varchar2(10) primary key,
  3  pass varchar2(10),
  4  name varchar2(20) not null,
  5  addr varchar2(20));

Table created.
```

#### 4. 제약조건

- not null

``` sql
SQL> insert into member(id, name) values('jang', null) ;
insert into member(id, name) values('jang', null)
                                            *
ERROR at line 1:
ORA-01400: cannot insert NULL into ("SCOTT"."MEMBER"."NAME")
-- scott계정의 member테이블의 name에 null을 삽입할 수 없다.
```

``` sql
SQL> desc user_constraints;
 Name
 --------------------------------
 OWNER
 CONSTRAINT_NAME
 CONSTRAINT_TYPE
 TABLE_NAME
 
SQL> select owner,  CONSTRAINT_NAME,  CONSTRAINT_TYPE, TABLE_NAME
  2  from user_constraints;

OWNER		-- P: primary key, C: not null
--------------------------------------------------------------------------
CONSTRAINT_NAME                                              CO TABLE_NAME
------------------------------------------------------------ -- ----------
SCOTT		--계정 이름
SYS_C006997                                                  C  CUSTOMER

SCOTT
SYS_C006998                                                  P  CUSTOMER

SCOTT
SYS_C006999                                                  C  PRODUCT

SCOTT
SYS_C007000                                                  P  PRODUCT

SCOTT
SYS_C007001                                                  C  FACTORY

SCOTT
SYS_C007002                                                  P  FACTORY

SCOTT
SYS_C007004                                                  C  STORE

SCOTT
SYS_C007005                                                  P  STORE

SCOTT
SYS_C007006                                                  P  EMP

SCOTT
SYS_C007007                                                  C  MEMBER

SCOTT
SYS_C007008                                                  P  MEMBER


11 rows selected.
```

- unique

``` sql
SQL> alter table member
  2  add constraint mem_ssn_uni unique(ssn);

Table altered.

SQL>  select owner,  CONSTRAINT_NAME,  CONSTRAINT_TYPE, TABLE_NAME
  2   from user_constraints;

OWNER		--U: unique제약조건
--------------------------------------------------------------------------
CONSTRAINT_NAME                                              CO TABLE_NAME
------------------------------------------------------------ -- ----------
SCOTT
SYS_C006997                                                  C  CUSTOMER

SCOTT
SYS_C006998                                                  P  CUSTOMER

SCOTT
SYS_C006999                                                  C  PRODUCT

SCOTT
SYS_C007000                                                  P  PRODUCT

SCOTT
SYS_C007001                                                  C  FACTORY

SCOTT
SYS_C007002                                                  P  FACTORY

SCOTT
SYS_C007004                                                  C  STORE

SCOTT
SYS_C007005                                                  P  STORE

SCOTT
SYS_C007006                                                  P  EMP

SCOTT
SYS_C007007                                                  C  MEMBER

SCOTT
SYS_C007008                                                  P  MEMBER

SCOTT
MEM_SSN_UNI                                                  U  MEMBER


12 rows selected.

SQL> insert into member(id, name, ssn) values('jang', '장동건', '12345');
insert into member(id, name, ssn) values('jang', '장동건', '12345')
*
ERROR at line 1:
ORA-00001: unique constraint (SCOTT.SYS_C007008) violated
```

- foreign key

``` sql
SQL> alter table member
  2  add constraint mem_dcode_fk foreign key(deptcode)
  3             references mydept(code);

Table altered.

SQL>  select owner,  CONSTRAINT_NAME,  CONSTRAINT_TYPE, TABLE_NAME
  2   from user_constraints;

OWNER
--------------------------------------------------------------------------
CONSTRAINT_NAME                                              CO TABLE_NAME
------------------------------------------------------------ -- ----------
SCOTT
SYS_C006997                                                  C  CUSTOMER

SCOTT
SYS_C006998                                                  P  CUSTOMER

SCOTT
SYS_C006999                                                  C  PRODUCT

SCOTT
SYS_C007000                                                  P  PRODUCT

SCOTT
SYS_C007001                                                  C  FACTORY

SCOTT
SYS_C007002                                                  P  FACTORY

SCOTT
SYS_C007004                                                  C  STORE

SCOTT
SYS_C007005                                                  P  STORE

SCOTT
SYS_C007006                                                  P  EMP

SCOTT
SYS_C007007                                                  C  MEMBER

SCOTT
SYS_C007008                                                  P  MEMBER

SCOTT
MEM_SSN_UNI                                                  U  MEMBER

SCOTT
SYS_C007010                                                  P  MYDEPT

SCOTT
MEM_DCODE_FK                                                 R  MEMBER


14 rows selected.

SQL> insert into member(id, name, ssn, deptcode) values('lee', '이민호', '54321', '001');

1 row created.

SQL> insert into member(id, name, ssn, deptcode) values('lee2', '이민호', '543210', '003');
insert into member(id, name, ssn, deptcode) values('lee2', '이민호', '543210', '003')
*
ERROR at line 1:
ORA-02291: integrity constraint (SCOTT.MEM_DCODE_FK) violated - parent key not found

-- 기본키 테이블은 삭제할 수 없다.
-- foreign key 테이블을 다 삭제한 뒤에 삭제할 수 있다. or 제약조건 없애고 삭제(추천)
-- cascade 옵션으로 모든 연관된 테이블 삭제(위험함)
SQL> drop table mydept;
drop table mydept
           *
ERROR at line 1:
ORA-02449: unique/primary keys in table referenced by foreign keys

-- 테이블 정규화 할 때 중복된 값이 없는 primary key가 설정된 테이블 = parent table 

```

- check

``` sql
SQL> alter table member
  2  add constraint member_ck check(addr in ('인천', '서울', '경기'));

Table altered.

SQL> insert into member(id, name, addr) values('kang', '강감찬', '인천');

1 row created.

SQL> insert into member(id, name, addr) values('kang2', '강감찬2', '부산');
insert into member(id, name, addr) values('kang2', '강감찬2', '부산')
*
ERROR at line 1:
ORA-02290: check constraint (SCOTT.MEMBER_CK) violated

SQL> alter table member
  2  drop constraint MEMBER_CK;

Table altered.
```

- **primary key**

  **= NOT NULL + UNIQUE**



## 시퀀스

순차적으로 증가해야 하는 값이 저장되는 컬럼을 사용해야 할 때 사용.

ex) 게시판 글번호, 주문번호(20191223***), 

``` sql
-- 일반적인 내용을 먼저 저장해야 한다. (주문번호가 새로 순차적으로 발생)
SQL>  create table myorder(
  2      ord_num varchar2(10) primary key,
  3      id varchar2(20));

Table created.
-- 디테일한 구매내역 저장 (myorder에서 생성된 주문번호 그대로 받아옴)
SQL> create table order_detail(
  2             ord_num varchar2(10),
  3             prd_num varchar2(20));

Table created.

SQL> create sequence myorder_seq;

Sequence created.

-- 한번 주문에 3개 상품 주문. 주문번호 동일(curval)
SQL> insert into myorder values(myorder_seq.nextval, 'jang');

1 row created.

SQL> insert into order_detail values(myorder_seq.currval, 'prd001');

1 row created.

SQL> insert into order_detail values(myorder_seq.currval, 'prd002');

1 row created.

SQL> insert into order_detail values(myorder_seq.currval, 'prd003');

1 row created.

SQL> select * from myorder;

ORD_NUM              ID
-------------------- ----------------------------------------
1                    jang

SQL> select * from order_detail;

ORD_NUM              PRD_NUM
-------------------- ----------------------------------------
1                    prd001
1                    prd002
1                    prd003

SQL> insert into myorder values(myorder_seq.nextval, 'jang');

1 row created.

SQL> insert into myorder values(myorder_seq.nextval, 'jang');

1 row created.

SQL> insert into myorder values(myorder_seq.nextval, 'jang');

1 row created.

SQL> select * from myorder;

ORD_NUM              ID
-------------------- ----------------------------------------
1                    jang
2                    jang
3                    jang
4                    jang

SQL> select myorder_seq.currval from dual;

   CURRVAL
----------
         4
         
SQL> drop sequence myorder_seq;

Sequence dropped.
```

