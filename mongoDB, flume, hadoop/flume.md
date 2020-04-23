## flume

-> 데이터를 추출하기 위해 사용되는 프로그램

​	시스템 로그, 웹 서버의 로그, 클릭 로그, 보안 로그, ... 등 비정형 데이터를

​	HDFS에 적재하기 위해 사용하는 프로그램

​	대규모의 로그 데이터가 발생하면 효율적으로 수집하고 저장하기 위해 관리

-> flume, chukwa, scribe, fluented(상용), splunk(상용, 시계열 데이터, 보안)

​	cf. 로그분석: elastic search

#### [설정]

1. 다운로드(압축풀기)

2. .bashrc에 설정 정보 등록
3. flume-env.sh rename하고 정보 등록
   - jdk 홈디렉토리
   - hadoop 홈디렉토리
4. flume설정 파일에 등록
   - flume-conf.properties.template을 rename해서 XXXX.properties로
   - flume agent의 source, channel, sink에 대한 정보를 등록

#### [Flume의 구성요소]

flume의 실행 중인 프로세스를 agent라 부르며 source, channel, sink로 구성

1. source

   => 데이터가 유입되는 지점(어떤 방식으로 데이터가 유입되는지 type으로 명시)

   agent명.sources.source명.type=값

   1) type

    - netcat: telnet을 통해서 터미널로 들어오는 입력데이터

      ​			(같이 쓸 수 있는 속성- bind: 접속IP, port: 접속할 port)

    - spoolDir: 특정 폴더에 저장된 파일

      ​			(같이 쓸 수 있는 속성- spoolDir: 폴더명)
      
   - exec: 파일 시스템을 거치지 않고 바로 넘겨준다. 

     ​			(같이 쓸 수 있는 속성- shell: /bin/bash -c로 배쉬셸 쓸 수 있다, command: 셸 명령어 넘겨준다. for문은 cat, tail정도에만 사용)

     ->default: 기본 10줄 씩, 파일별로 넘기는 것이 아니라 파일을 여러개 읽어서 10줄 단위로 잘라서 넘긴다.

2. channel

   => 데이터를 보관하는 곳(source와 sink 사이의 Queue)

3. sink

   => 데이터를 내보내는 곳(어떤 방식으로 내보낼지 정의)

   1) type

    - logger: flume서버 콘솔에 출력이 전달

      (flume이 실행될 때 -Dflume.root.logger=INFO,console를 추가해야 함) 

   - file_roll: file을 읽어서 가져오는 경우 [roll: 계속 파일들을 가져오는 작업]

     ​			(같이 쓸 수 있는 속성- sink.directory: 읽어온 파일을 저장할 output폴더를 명시)

     ->default: 정해진 시간마다 계속 롤링(파일을 다 읽지 않고 만드는 경우도 있음)
     
   - hdfs: hdfs로 출력이 전달 

     ​			(같이 쓸 수 있는 속성- fileType: DataStream은 우리가 쓴 그대로 읽음, writeFormat: text로 지정해야 네트워크로 전송 가능, filePrefix: 파일 앞에 붙일 이름, fileSuffix: 파일 뒤에 붙일 이름, useLocalTimeStamp: true로 설정하면 시간 관련 alias 사용 가능)

     ->default: 30초 마다 10줄 씩 롤링(로컬에 저장)

#### [flume의 실행]

[hadoop@hadoop01 apache-flume-1.6.0-bin]$ ./bin/flume-ng agent --conf conf --conf-file ./conf/console.properties --name myConsole -Dflume.root.logger=INFO,console 

​																				 ============================

​																			source가 telnet으로 입력하는 데이터인 경우

- INFO,console 사이에 띄어쓰기x

​	(현재 flume홈에 위치)

​	실행명령어: ./bin/flume-ng agent

​	옵션

​		--conf: 설정파일이 저장된 폴더명 (줄여서 -c로 쓸 수 있다.)

​		--conf-file: 설정파일명 (줄여서 -f로 쓸 수 있다.)

​		--name: agent의 이름 (줄여서 -n으로 쓸 수 있다.)

​	-Dflume root.logger=INFO, console: flume의 로그창에 기록

다 끝나면 Ctrl+C로 빠져나간다.

[hadoop@hadoop01 apache-flume-1.6.0-bin]$ ./bin/flume-ng agent -c conf -f ./conf/myfolder.properties -n myConsole
Info: Sourcing environment configuration script /home/hadoop/apache-flume-1.6.0-bin/conf/flume-env.sh