package sync;

public class ThreadSyncTest01 {
	public static void main(String[] args) {
		// 모든 쓰레드가 공유해서 사용할 객체
		Toilet toilet = new Toilet();
		
		// 공유객체를 사용하는 쓰레드 객체를 생성
		User user1 = new User("장동건", toilet);
		User user2 = new User("고라니", toilet);
		User user3 = new User("공유", toilet);
		User user4 = new User("버마비단뱀", toilet);
		User user5 = new User("모란앵무", toilet);
		User user6 = new User("삵", toilet);
		User user7 = new User("햄스터", toilet);
		
		// 쓰레드 시작 - open을 같이 사용하면 데이터의 무결성이 보장되지 않는다.
		user1.start();
		user2.start();
		user3.start();
		user4.start();
		user5.start();
		user6.start();
		user7.start();
	}
}
