package sync;

public class SumPrintThread extends Thread{
	SharedObj obj;

	public SumPrintThread(SharedObj obj) {
		super();
		this.obj = obj;
	}
	
	public void run() {
		for(int i=1; i<=10; ++i) {
			// �� �����尡 ������ü�� ���� ��� -> ����� ���� ������ �ٸ� ������ ����x
			// ex)���� - ��û �ϳ��� ���� ��ü�� �ƴ� �����带 �ϳ��� ��������Ƿ�(WAS�� ����) 
			//			��������� �����ǹǷ� ������� ����x (��ü�� �ϳ��� ������)
			synchronized (obj) { //�ڵ� ���� lock�� �����ϰڴٴ� �ǹ�
				long total = obj.acc1.getBalance()+obj.acc2.getBalance();
				// ����ȭ ��Ű�� ������ ���� ��� ���Ŀ� ����ؼ� 5900�� ����
				System.out.println("�� ������ �ܾ�====>"+total);
			}
		}
	}
}
