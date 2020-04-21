package basic;

/*
 * 멀티쓰레드 프로그래밍
 * 1. Runnable인터페이스를 구현하는 클래스를 생성
 * 2. Runnable인터페이스가 갖고 있는 추상메소드인 run메소드를 오버라이딩
 * 		=> 동시 작업하고 싶은 내용을 정의
 * 3. 작성한 Runnable객체를 이용해서 Thread객체를 생성
 * 		=> Thread객체를 생성하면서 매개변수로 Runnable객체를 전달(매핑)
 * 4. 생성한 Thread객체의 start 호출
*/
class RunnableDemo1 implements Runnable{
	public void run() {
		// 1부터 20까지 출력하는 코드
		for (int i = 1; i <= 20; i++) {
			// Thread.currentThread() - 현재 실행중인 스레드 객체를 리턴
			System.out.print(i+"("+Thread.currentThread().getName()+")");
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
public class RunnableTest01 {
	public static void main(String[] args) {
		System.out.println("******프로그램 시작******");
		RunnableDemo1 r1 = new RunnableDemo1();
		RunnableDemo1 r2 = new RunnableDemo1();
		// Thread객체의 start()를 실행해야 하기 때문에 마지막에는 Thread를 만들어야 한다.
		Thread t1 = new Thread(r1);
		Thread t2 = new Thread(r2);
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
