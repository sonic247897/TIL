package sync;

public class ThreadSyncTest02 {
	public static void main(String[] args) {
		// 1. 공유객체 만들기
		SharedObj obj = new SharedObj();
		obj.acc1 = new Account("111-222-3333", 5000, "현빈");
		obj.acc2 = new Account("444-555-6666", 1000, "김현정");
		
		// 2. 쓰레드 생성
		SumPrintThread t1 = new SumPrintThread(obj);
		Thread t2 = new Thread(new TransferThread(obj));
		
		// 3. 생성한 쓰레드 start 시키기
		// 동일한 스레드가 아니더라도 공유객체가 같기 때문에 
		t1.start();
		t2.start();
	}

}