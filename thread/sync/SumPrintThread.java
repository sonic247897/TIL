package sync;

public class SumPrintThread extends Thread{
	SharedObj obj;

	public SumPrintThread(SharedObj obj) {
		super();
		this.obj = obj;
	}
	
	public void run() {
		for(int i=1; i<=10; ++i) {
			// 두 스레드가 공유객체를 같이 사용 -> 블록이 끝날 때까지 다른 스레드 실행x
			// ex)서블릿 - 요청 하나당 서블릿 객체가 아닌 스레드를 하나씩 만들어지므로(WAS에 의해) 
			//			멤버변수가 공유되므로 멤버변수 선언x (객체는 하나만 생성됨)
			synchronized (obj) { //코드 블럭만 lock을 적용하겠다는 의미
				long total = obj.acc1.getBalance()+obj.acc2.getBalance();
				// 동기화 시키지 않으면 가끔 출금 직후에 출력해서 5900원 찍힘
				System.out.println("두 계좌의 잔액====>"+total);
			}
		}
	}
}
