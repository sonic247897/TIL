package basic;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

public class URLTest02 {
	public static void main(String[] args) {
		FileOutputStream fos = null;
		try {
			// 이미지 url
			URL url = new URL("http://cafefiles.naver.net/20120209_226/pododumok_13287752996753FNE4_jpg/%C0%E5%B5%BF%B0%C7_5_pododumok.jpg");
		
			// 성능향상을 위해 BufferedInputStream으로 읽어서
			// FileOutputStream으로 copy
			BufferedInputStream bis = 
					new BufferedInputStream(url.openStream());
			// 바이너리 파일 출력 I/O
			fos = new FileOutputStream("src/image/jangImg.jpg");
			while(true) {
				// 한 바이트 단위로 읽으므로 int형
				int data_byte = bis.read();
				if(data_byte == -1) {
					break;
				}
				fos.write(data_byte);
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				// 종료 안 할 경우 write 안되는 경우 발생한다!
				if(fos != null) fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
