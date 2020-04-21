package sync;

public class TransferThread implements Runnable{
	SharedObj obj;
	
	public TransferThread(SharedObj obj) {
		super();
		this.obj = obj;
	}

	@Override
	public void run() {
		// 1. ������ü�� ���� �ִ� �޼ҵ带 ȣ��
		// 2. ���� ������ ����
		for(int i=1; i<=20; ++i) {
			synchronized (obj) {
				obj.acc1.withdraw(100);
				System.out.println("100������ ����߽��ϴ�.");
				obj.acc2.deposit(100);
				System.out.println("100������ �Ա��߽��ϴ�.");
			}
		}
	}

}
