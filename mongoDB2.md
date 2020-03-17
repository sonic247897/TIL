*cls명령어 ->화면 비우기

5. mongoDB에 저장된 데이터 조회하기 - find()

   ##### [실습1]

   score의 모든 document에 num필드(1000)가 추가되도록 작업

   ​	-insert: 중복된 데이터 넣을 수 없음

   ​	 save: 중복된 데이터 넣을 수 있으므로 전체 데이터 수정할 때 사용

   ``` mysql
   MongoDB Enterprise > var x = db.score.find()
   MongoDB Enterprise > while(x.hasNext()){
   ... var one = x.next();
   ... one.num = 1000;
   ... db.score.save(one);
   ... }
   WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
   ```

   1) find

   ​	db.컬렉션명.find(조건, 조회할 필드에 대한 명시)

     - db.컬렉션명.find({})와 동일: {}안에 아무것도 없으면 전체 데이터 조회

     - 조건, 조회할 필드에 대한 명시 모두 json

     - 조회할 필드의 정보 명시

       형식- {필드명:1} : 화면에 표시하고 싶은 필드

       ​		{필드명:0} : 명시한 필드가 조회되지 않도록 처리

       [조건]

       -비교조건

       ​	$lt: <

       ​	$gt: \>

       ​	$lte: <=

       ​	$gte: \>=

       -논리조건

       ​	$or: 여러 필드를 이용해서 같이 비교 가능. 조건은 하나가 아니라 여러개이기 때문에 <b>배열</b>로 표기한다.<b>(JSON에서 하나 이상은 무조건 배열)</b>

       ​	$and: and연산

       ​	$in: 하나의 필드에서만 비교

       ​	$nin: 오라클의 not in과 같음. $in으로 정의한 조건을 제외한 document를 조회

       

       - addr이 "인천"인 데이터: id, name, dept, addr

         db.score.find({addr:"인천"},

         ​						{id:1,name:1,dept:1,addr:1,_id:0}) 

         ->기본적으로 1을 표기한 필드만 나오는데 _id는 항상 같이 나오므로 0을 표기해줘야 한다.

       - score컬렉션에서 java가 90점 이상인 document조회. id, name, dept, java만 출력

         db.score.find({java:{$gte:90}}, 

         ​							{id:1, name:1, dept:1, java:1, _id:0})

       - dept가 "인사"이거나 addr이 "인천"인 데이터 조회

         db.score.find({$or:[{dept:"인사"},

         ​									{addr:"인천"}]})

       - id가 song, kang, hong인 데이터 조회 (하나의 필드에 조건을 주는 경우 in을 써도 된다)

         db.score.find({$or:[{id:"song"},

         ​									{id:"hong"},

         ​									{id:"kang"}]})

         db.score.find({id:{$in:["song","hong","kang"]}})

       - id가 song, kang, hong이 아닌 데이터 조회

         db.score.find({id:{$nin:["song","hong","kang"]}})
         
       - num필드가 null인 데이터 조회

   ``` mysql
   MongoDB Enterprise > db.score.find({num:null})
   { "_id" : ObjectId("5e703196b29503691360912d"), "id" : "hong123", "name" : "홍길동", "dept" : "인사", "addr" : "서울", "java" : 100, "servlet" : 88 }
   ```

   2) 조회 메소드

   - findOne(): 첫 번째 document만 리턴
   - find(): 모든 document 리턴

   <find() 뒤에 쓰는 메소드> (javascript이므로 함수들끼리 체이닝 가능)

   - count(): 행의 개수를 리턴

   - sort({필드명:sort옵션}): 정렬

     ​										 1 => 오름차순

     ​										-1 => 내림차순

   - limit(숫자): 숫자만큼의 document만 출력

   - skip(숫자): 숫자만큼의 document를 skip하고 조회

   

   3) 정규표현식을 적용

    - db.컬렉션명.find({조건필드명:/정규표현식/옵션})

      [기호]

      ​	|: or

      ​	^: ^뒤의 문자로 시작하는지 체크

      ​	[]: 영문자 하나는 한 글자를 의미하고 []로 묶으면 여러 글자를 표현

      ​		[a-i] - a에서 i까지의 모든 영문자

      [옵션]

      ​	i: 대소문자 구분 없이 조회 가능

      

       - id가 kim과 park인 document 조회

         db.score.find({id:/kim|park/})

         db.score.find({id:/kim|park/i})

      - id가 k로 시작하는 document 조회

        db.score.find({id:/^k/})

      - [a-i]까지 영문이 있는 id를 조회 a,b,c,d,e,f,g,h,i

        db.score.find({id:/[a-i]/})

      - id가 k-p로 시작하는 document 조회 k,l,m,n,o,p

        db.score.find({id:/^[k-p]/})

      - id에 k 또는 p가 있는 document 조회

        db.score.find({id:/[kp]/})

6. mongoDB에 저장된 데이터 삭제하기 - remove()

   -조건을 정의하는 방법은 find()나 update()와 동일

   - db.score.remove({servlet:{$lt:80}})

   ##### [실습2]

   ``` mysql
   1. Score collection에서 이름과 주소와 servlet점수를 출력해보자
   db.score.find({},{name:1, addr:1, servlet:1, _id:0})
   
   2. Score collection에서 java점수 중 70점 이상을 출력해보자
   db.score.find({java:{$gte:70}})
   
   3. Score collection에서 이름, java점수를 출력하고 bonus가 2000이상인 사람만 출력해보자
   db.score.find({bonus:{$gte:2000}}, {name:1, java:1, _id:0})
   
   4. score에서 dept가 인사이면서 addr이 안양이거나 대구인 document 출력
   db.score.find({$and:[{dept:"인사"}, {addr:/안양|대구/}]})
   
   5. servlet이 70에서 90사이이며 dept가 총무인 document 조회
   db.score.find({$and:[{servlet:{$gte:70}},{servlet:{$lte:90}},{dept:"총무"}]})
   
   6. score에서 이름에 김씨인 사람 조회해보기
   db.score.find({name:/^김/})
   
   7. score에서 servlet점수가 가장 낮은 document와 가장 높은 document 출력하기
   db.score.find({servlet:{$nin:[null]}}).sort({servlet:1}).limit(1)
   db.score.find({servlet:{$not:{$exists:null}}}).sort({servlet:1}).limit(1)
   db.score.find({servlet:{$nin:[null]}}).sort({servlet:-1}).limit(1)
   
   8. java점수가 가장 높은 document중에 7개를 출력하되 2개를 건너뛰고 출력해보자
   db.score.find({java:{$nin:[null]}}).sort({java:-1}).skip(2).limit(7)
   
   9. 아이디에 n과 o가 들어가는 document 구하기
   db.score.find({id:/n/,id:/o/})
   ```

7. Aggregation

   -group by와 동일한 개념

   -간단한 집계를 구하는 경우 mapreduce를 적용하는 것보다 간단하게 작업

   -Pipeline을 내부에서 구현

   ​	: 한 연산의 결과가 또 다른 연산의 input 데이터로 활용

   `https://docs.mongodb.com/v3.6/core/aggregation-pipeline/`의 그림 참고

   ![Diagram of the annotated aggregation pipeline operation. The aggregation pipeline has two stages: ``$match`` and ``$group``. — Enlarged](images/aggregation-pipeline.bakedsvg.svg)

   1) 명령어(RDBMS와 비교)

   ​	$match: where절, having절

   ​	$group: group by

   ​	$sort: order by

   ​	$avg: avg그룹함수

   ​	$sum: sum그룹함수

   ​	$max: max그룹함수

   ​	

   ​	[형식]

   ​	db.컬렉션명.aggregate(aggregate명령어를 정의)

   ​											\------------------------------------

   ​										여러가지를 적용해야 하는 경우 배열 사용(JSON)

   ​		$group:{_id:그룹으로 표시할 필드명, 

   ​						연산결과를 저장할 필드명:{연산함수:값}}

   ​																						\--- 숫자나 필드 참조

   ​		$match: {필드명:{연산자:조건값}}

   ​									   \-------------------- 비교연산 or 조건이 여러개(find에서 사용했던 조건 그대로 사용가능)

    - addr별 인원수

      db.exam.aggregate([

      ​									{$group:{_id:"$addr", 

      ​													num:{$sum:1}}

      ​									}

      ​									])

      <b>-> `$: 연산자 명령어, "$~": 참조해서 불러오는 값`</b>

      -> addr로 묶어서 유일한 값 _id로 묶으라는 뜻/ 하나씩 더해라

      ``` mysql
      MongoDB Enterprise > db.exam.aggregate([{$group:{_id:"$addr", num:{$sum:1}}}])
      { "_id" : "대구", "num" : 2 }
      { "_id" : "제주", "num" : 2 }
      { "_id" : "인천", "num" : 4 }
      { "_id" : "서울", "num" : 3 }
      ```

      - dept별 인원수

        db.exam.aggregate([{$group:{_id:"$dept", num:{$sum:1}}}])

      - dept별 java점수의 평균

        db.exam.aggregate([{$group:{_id:"$dept", 평균:{$avg:"$java"}}}])

      - addr별 servlet 합계

        db.exam.aggregate([{$group:{_id:"$addr", 서블릿합계:{$sum:"$servlet"}}}])

   - dept별 java점수의 평균 단, addr이 인천인 데이터만 작업 ($match를 추가)

     db.exam.aggregate([

     ​									{$match:{addr:"인천"}},

     ​									{$group:{_id:"$dept", 

     ​													평균:{$avg:"$java"}}

     ​								}])

   ``` mysql
   MongoDB Enterprise > db.exam.aggregate([{$match:{addr:"인천"}},{$group:{_id:"$dept", 평균:{$avg:"$java"}}}])
   { "_id" : "인사", "평균" : 72.66666666666667 }
   { "_id" : "전산", "평균" : 99 }
   
   1. dept가 인사인 document의 servlet평균 구하기
   db.exam.aggregate([{$match:{dept:"인사"}},{$group:{_id:"$dept", servlet평균:{$avg:"$servlet"}}}])
   2. java가 80점이 넘는 사람들의 부서별로 몇 명인지 구하기
   db.exam.aggregate([{$match:{java:{$gt:80}}},{$group:{_id:"$dept", num:{$sum:1}}}])
   3. 2번 결과를 인원수데이터를 내림차순으로 정렬해 보세요.
   db.exam.aggregate([{$match:{java:{$gt:80}}},{$group:{_id:"$dept", num:{$sum:1}}},{$sort:{num:-1}}])
   
   ```

   

