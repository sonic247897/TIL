package basic;

/*
 * 멀티쓰레드 프로그래밍
 * 1. Thread 클래스를 상속
 * 2. run메소드를 오버라이딩
 * 		=> 쓰레드 프로그래밍으로 작업하고 싶은 내용을 구현
 * 			(동시의 실행 흐름으로 표현하고 싶은 내용을 구현) 
 * 3. Thread클래스의(Thread의 하위클래스) start메소드를 호출
 * 		=> 동시작업 시작
 * 		=> run을 직접 호출하지 않고 start메소드를 호출하면 JVM이 실행할 수 있는 상태가 되면
 * 			자동으로 Thread클래스의 run메소드를 호출하면서 동시 실행 흐름을 만들어냄
*/
class ThreadDemo1 extends Thread{
	public ThreadDemo1(String name) {
		// Thread(String name)
		super(name);
	}
	
	public void run() {
		// 1부터 20까지 출력하는 코드
		for (int i = 1; i <= 20; i++) {
			System.out.print(i+"("+getName()+")");
			try {
				Thread.sleep(500); // 실행흐름을 멈춘다.
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(i%5 ==0) {
				System.out.println();
			}
		}
	}
	
}
// ThreadDemo01 객체를 활용하여 멀티쓰레드 프로그래밍 구현
public class ThreadTest01 {
	public static void main(String[] args) {
		System.out.println("******프로그램 시작******");
		ThreadDemo1 t1 = new ThreadDemo1("t1");
		ThreadDemo1 t2 = new ThreadDemo1("t2");
		//t1.run(); -> 단순한 메소드 호출(쓰레드 프로그래밍을 할 수 없다.)
		t1.start();
		t2.start();
		System.out.println("작업 중......");
		for (int i = 1; i <= 10; i++) {
			System.out.println("main");
			try {
				Thread.sleep(200); // 실행흐름을 멈춘다.
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("******프로그램 종료******");
	}

}
