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
			// �о�� ������ ������ŭ ���� �����ϰ��Ѵ�.
			// byte �迭�� ������ ��Ű��,
			// �Ʊ� response���� ����� ��Ű���� �Ѵ�.
			// file -> application -> response �� ���ļ� client�� ���� �Ѵ�.
			// ��, �ٿ�ε尡 �ǰ� �ȴ�.
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