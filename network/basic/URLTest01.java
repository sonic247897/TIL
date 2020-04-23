package basic;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

// URL 클래스
//	=> 인터넷에서 확인할 수 있는 자원을 추출
public class URLTest01 {
	public static void main(String[] args) {
		// 네트워크 상에서 컴퓨터 = 노드, 호스트
		try {
			URL url = new URL("https://www.daum.net");
			System.out.println("url.toString()=> "+url.toString());
			System.out.println("url.getHost()=> "+url.getHost()); 
			System.out.println("url.getPath()=> "+url.getPath());
			// port가 -1
			// -1포트로 접속했다는 의미가 아니라 http의 기본 포트가 80port
			// 우리가 접속한 url이 기본 포트를 사용하고 있다는 의미
			System.out.println("url.getPort()=> "+url.getPort()); 
			System.out.println("url.getProtocol()=> "+url.getProtocol());
			System.out.println("url.getFile()=> "+url.getFile());
			
			// 지정한 url에서 자원을 읽어오기
			// InputStream: 바이트 단위로 입력할 수 있는 클래스의 상위 클래스
			// (바이트 단위 입출력) - 한글이 깨진다.
			// 	=> Reader의 하위 클래스를 추가해서 읽어오기 - 이미지, 동영상, ...
			InputStream data = url.openStream();
			InputStreamReader isr = new InputStreamReader(data);
			// 성능향상 - 한 문장씩 버퍼에 쌓았다가 읽음
			BufferedReader br = new BufferedReader(isr);
			// html문서 가져옴 - 바이트 단위로 읽으면 한글(2byte) 깨져서 옴
			while(true) {
				// 바이트(한 문자) 리턴
				/*int data_byte = data.read();
				if(data_byte == -1) {
					break;
				}
				System.out.print((char)data_byte);
				*/
				String data_byte = br.readLine();
				if(data_byte == null) { //스트림의 끝을 만나면 while을 빠져나가기
					break;
				}
				System.out.println(data_byte);
			}
		} catch (MalformedURLException e) {
			// URL 형식이 잘못됐을 때 오류
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
