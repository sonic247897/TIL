package basic;

// �ϳ��� ������ �ϳ��� ������� �����!
class DigitThread extends Thread{
	public DigitThread(String name) {
		super(name);
	}
	public void run() {
		for(int i=1; i<=100; ++i) {
			System.out.print(i+"("+getName()+")");
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

class AlphaThread extends Thread{
	public AlphaThread(String name) {
		super(name);
	}
	public void run() {
		for(char c='A'; c<='Z'; ++c) {
			System.out.print(c+"("+getName()+")");
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

public class ThreadTest02 {
	public static void main(String[] args) {
		System.out.println("******���α׷� ����******");
		DigitThread t1 = new DigitThread("digital");
		AlphaThread t2 = new AlphaThread("alpha");
		t1.start();
		t2.start();
		System.out.println("******���α׷� ����******");
	}
}
