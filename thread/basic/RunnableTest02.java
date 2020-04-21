package basic;

class DigitThread2 implements Runnable{
	public void run() {
		for(int i=1; i<=100; ++i) {
			System.out.print(i+"("+Thread.currentThread().getName()+")");
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(i%5 == 0) {
				System.out.println();
			}
		}
	}
}

class AlphaThread2 implements Runnable{
	public void run() {
		for(char c='A'; c<='Z'; ++c) {
			System.out.print(c+"("+Thread.currentThread().getName()+")");
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if((c-'A')%5 == 0) {
				System.out.println();
			}
		}
	}
}

public class RunnableTest02 {
	public static void main(String[] args) {
		System.out.println("******프로그램 시작******");
		
		new Thread(new AlphaThread2()).start();
		Thread thread2 = new Thread(new DigitThread2());
		thread2.start();
		System.out.println("******프로그램 종료******");
	}
}
