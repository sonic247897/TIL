# Device Controller

- I/O device controller
  - 해당 I/O 장치유형을 관리하는 일종의 작은 CPU
  - 제어 정보를 위해 control register, status register를 가짐
    - CPU가 지시를 내리기 위해 사용하는 제어 정보를 저장한다.
  - 로컬 버퍼를 가짐 (일종의 data register)
- I/O는 실제 device와 로컬 버퍼 사이에서 일어남
- Device controller는 I/O가 끝났을 경우 interrupt로 CPU에 그 사실을 알린다.

> CPU는 메모리 접근도 할 수 있고, 로컬 버퍼도 접근 가능하다.
>
> device controller들은 자기 자신의 로컬 버퍼만 접근 가능하다.
>
> ​	=> 따라서 CPU는 인터럽트를 너무 많이 당하기 때문에 DMA가 필요하다.



*device driver (장치 구동기)

​	: OS 코드 중 각 장치별 처리루틴 -> `software`

​	디바이스 드라이버가 디스크에서 실제로 헤드를 움직여서 읽고 쓰는 코드는 아니다.

​	디스크를 실제로 작동시키는 일은 디바이스 `컨트롤러(HW)`가 컨트롤러 안의 **펌웨어 코드(SW)**의 지시를 받아서 하는 것이다. (컴퓨터 외부에서 동작)

​	**드라이버(SW)**는 `CPU(HW)`가 장치를 수행하기 위해 필요한 코드를 담고있다. (컴퓨터 내부에서 동작)

*device controller (장치 제어기)

​	: 각 장치를 통제하는 일종의 작은 CPU -> `hardware`



- memory controller

  : 메모리도 하나의 디바이스이기 때문에 컨트롤러가 따로 붙어있다.