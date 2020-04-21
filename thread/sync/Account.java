package sync;

public class Account{
	private String accId;//계좌번호
	private long balance;//잔액
	private String ownerName;//예금주
	
	public Account(){
		
	}
	
	public Account(String accId, long balance, String ownerName) {
		super();
		this.accId = accId;
		this.balance = balance;
		this.ownerName = ownerName;
	}
	public void deposit(long amount){//입금하기
		balance = balance+amount;
	}
	public void withdraw(long amount){//출금하기
		balance = balance - amount;
	}
	public String getAccId() {
		return accId;
	}
	public void setAccId(String accId) {
		this.accId = accId;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public long getBalance() {
		return balance;
	}
	
}