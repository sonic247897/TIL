# Deadlock

교착상태(deadlock)

일련의 프로세스들이 서로가 가진 자원을 기다리며 block된 상태

- ex) 같은 줄의 차들을 묶어서 일련의 프로세스로 보면,

  왼쪽 하단의 프로세스는 왼쪽 하단 모서리를 점유하고 있는데 오른쪽 하단 모서리를 보유해야 계속 진행할 수 있다.

- 그러나 오른쪽 하단 모서리는 다른 프로세스가 점유하고 있다. 그런데 이 프로세스는 오른쪽 상단 모서리를 얻을 수 없으므로 영원히 프로세스가 끝나지 않고 자원도 내놓지 않게 된다.

자원(resource)

- 하드웨어, 소프트웨어 등을 포함하는 개념

- ex) I/O device, CPU cycle, memory space, semaphore 등

- 프로세스가 자원을 사용하는 절차

  1. Request

  2. Allocate

  3. Use

  4. Release

## 1. Deadlock 발생의 4가지 조건

> 이 4가지 조건이 deadlock의 필요 충분 조건인지는 교수님도 모르겠다고 함.
>
> 다만 오래전부터 학문적으로 정의되어 왔다.

- ㅈㄷㄱㄷㅈ



## 2. Resource-Allocation Graph(자원할당 그래프)

원은 프로세스, 사각형은 자원을 나타낸다.

사각형 안의 점은 자원의 개수를 나타낸다.

화살표는 2가지 종류가 있다.

- 자원 -> 프로세스

  : 자원이 프로세스에 속해 있다. 이 프로세스가 자원을 점유하고 있다.

- 프로세스 -> 자원

  : 프로세스가 자원을 요청(request)했는데 아직 할당(allocate)되지 않은 상태

그림

- 프로세스 P1은 2번 자원을 가지고 있으면서 1번 자원을 요청하고 있다.

  그런데 그 1번 자원은 프로세스 P2가 갖고 있다.

- 프로세스 P2는 1번 자원과 2번 자원을 가지고 있으며, 3번 자원을 요청하고 있다.

  그런데 그 3번 자원은 프로세스 P3가 갖고 있다.

=> 사이클이 없으므로 deadlock이 아니다.

deadlock이 발생하는지 여부

- 그래프에 cycle이 없으면 deadlock이 아니다.
- 그래프에 cycle이 있으면
  - 자원 당 인스턴스가 1개씩(자원의 개수가 1개씩)밖에 없다면, deadlock이 발생한 것이다.
  - 자원 당 인스턴스가 여러개이면, deadlock일 수도 있고 아닐 수도 있다.
    - 사이클의 개수 = 인스턴스 개수이면 deadlock이다.?? (왼쪽 그림)
    - P2, P4가 각 자원을 쓰고 나서 반납하면 사이클이 사라진다. (오른쪽 그림)

> 그래프로 체크하기 어려우므로 뒤에서 테이블로 체크하는 방법을 사용한다.

## Deadlock의 처리 방법

강한 순으로 방법을 나열하면 다음과 같다.

위의 2개 방법은 deadlock이 생기지 않도록 예방하는 방법, 아래 2개 방법은 deadlock이 생기도록 놔두고 detection/recovery 하거나 무시하는 방법이다.

- Deadlock Prevention
- Deadlock Avoidance
- deadlock de
- Deadlock Ignorance
  - 사람이 이상한 낌새를 보이면 프로세스를 줄여서 해결하는 방식

> deadlock은 빈번히 일어나는 현상이 아니기 때문에 미연에 방지하는 오버헤드를 포기한다.

### 1) Deadlock Prevention

### 2) Deadlock Avoidance

### 3) Deadlock Dection and Recovery

### 4) Deadlock Ignorance

