package basic;
/*
 * 쓰레드 종료
 * 1. 임의의 변수를 선언해서 종료하는 방법
 * 	  --------
 * 	   flag변수
 * 		- 변수에 저장된 값에 따라서 처리할 수 있도록 구현(실행 or 종료 - boolean)
 * 		- 변수값을 체크(오래 걸리는 작업이 있는 경우 중간에 이 값을 체크해서 쓰레드를 종료할 수 있다.)
 * 
*/
class StopThread01 extends Thread{
	private boolean state = true;
	public void run() {
		while(state) {
			System.out.println("쓰레드 실행중~~~");
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("현재상태: 종료상태.....");
	}
	// 쓰레드의 상태를 조절할 수 있는 변수의 값을 변경하는 메소드
	public void stopThread() {
		// 쓰레드는 한 번 종료됐던 것은 못 살리고 새로 만들어야 하므로 토글 필요x
		state = false; 
	}
	
}

public class StopThreadTest01 {
	public static void main(String[] args) {
		System.out.println("main쓰레드 시작");
		StopThread01 t1 = new StopThread01();
		t1.start();
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		// 3초 지나면 쓰레드 종료
		t1.stopThread();
		System.out.println("main쓰레드 종료");
	}
}
