# BFS



## Problem Solving

- BFS/DFS의 목적은 임의의 정점에서 시작해서, 모든 정점을 **한 번씩** 방문하는 것이다.

  > check[i] = i를 방문했는지
  >
  > dist[i] = i를 몇 번만에 방문했는지

- BFS는 **모든 가중치가 1일 때**, `최단 거리(최소 비용)`를 구할 수 있는 알고리즘

  => 간선의 가중치가 문제에서 구하려는 최소 비용과 의미가 일치해야 한다.

- BFS의 시간복잡도는 O(V+E) = **O(E)**이므로 정점과 간선의 개수가 충분히 적어야 한다.



### 1. 역추적 문제

- 어떤 값이 다른 값에 의해서 바뀔때, `왜 바뀌었는지 기록`하는 문제

  - **from[] 배열**을 사용해서 이전 방문한 정점을 기록한다. 

    `from[next] = now;`

    > 사이클을 제외하고 탐색하는 BFS/DFS는 일종의 `트리` 탐색 알고리즘과 같다. 따라서 역순으로 부모 노드를 기록하는 이유는 트리 형태에서 자식은 여러 개일 수 있지만, 부모는 하나밖에 없기 때문이다.

  - 역순으로 저장되기 때문에, 다시 역순으로 구하는 과정이 필요하다.

    1. 재귀함수 이용

    ``` java
    static void print(int n, int m, StringBuilder sb){
        if(n != m) // from[m] = n일 때 종료(n: 시작점)
        	print(n, from[m]);
        sb.append(m).append(' ');
    }
    ```

    2. 스택 이용

    ``` java
    Stack<Integer> stack = new Stack<>();
    stack.add(k); // 마지막 정점 넣기
    int prev = from[k];
    while(prev != -1) { // 시작점을 발견할 때까지 스택에 이전 정점 추가
    	stack.add(prev);
    	prev = from[prev]; 
    }
    while(!stack.isEmpty()) {
    	sb.append(stack.pop()).append(' ');
    }
    ```

  - (숨바꼭질 4)



### 2. 정점 분리하기

> BFS에서 하나의 정점이 서로 다른 두 개의 정보를 저장하고 있으면 안된다.

- (이모티콘)



### 3. 덱 사용하기

- 가중치가 `0과 1` 두 종류의 간선이 있을 때
  - (숨바꼭질 3, 알고스팟)