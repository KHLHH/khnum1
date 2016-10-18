package pds.file;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

public class FileDownloadHelper {

	public static void copy(String filePath, OutputStream os)
			throws IOException {
		FileInputStream is = null;
		try {
			is = new FileInputStream(filePath);
			byte[] data = new byte[8096];
			// 읽어온 글자의 갯수만큼 리턴 가능하게한다.
			// byte 배열에 저장을 시키고,
			// 아까 response한테 출력을 시키도록 한다.
			// file -> application -> response 를 거쳐서 client로 가게 한다.
			// 즉, 다운로드가 되게 된다.
			int len = -1;
			while ((len = is.read(data)) != -1) {
				os.write(data, 0, len);
			}
		} finally {
			if (is != null)
				try {
					is.close();
				} catch (IOException e) {
				}
		}
	}
}