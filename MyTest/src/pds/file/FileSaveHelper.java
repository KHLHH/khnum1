package pds.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Random;

public class FileSaveHelper {
	private static Random random = new Random();
	
	// ���ε�� ���Ϸκ��� �����͸� ���� �� �ְ� ��ǲ��Ʈ���� ���� ��Ű���� �Ѵ�.
	public static String save(String directory, InputStream is)
			throws IOException {
		// ���� �̸��� ������ �ö󰡸�, ������ ���� ������ �ȴ�.
		// FileUploadAPI�� ���� �ߺ� ���� �����Ѵ�.
		// ��, �̸��� �ߺ��� ���� �ٲپ���Ѵ�.
		
		// ���ε��� �ð��� currentTime���� �����´�.
		long currentTime = System.currentTimeMillis();
		
		// 0~49������ Random ���� ��ȯ��Ű���� �Ѵ�. �μ��� ���� ���� �ٸ� ���� �ִ�.
		// Ȥ�ó� ������ �ð��� �� ���� �÷���, ���� �޶�����. - �������� ���ļ� ó���߱� �����̴�.
		int randomValue = random.nextInt(50);
		
		// ���ϸ��� ������ ���� �ð���, ���� ���� ���ļ� ���� ������ File ��ü�� ������ �ϵ��� �Ѵ�.
		String fileName = Long.toString(currentTime) + "_"
					+ Integer.toString(randomValue);
		File file = new File(directory, fileName);
		FileOutputStream os = null;
		try {
			// �ش� ��ο� �ִ� ���Ϸ� ����� �ش�. - ��θ� file ��ü�� �����, �̸� fos �� �ִ´�.
			// ex: ��� f://pds//����ð�_������ -> �� ��θ� ������ �ְ� �����.
			os = new FileOutputStream(file);
			
			// ���� ������ �������ϹǷ� ����Ʈ �迭 ����
			byte[] data = new byte[8096];
			int len = -1;
			
			// �о� �帰 ���� -1�� �ƴ϶�� -> 0�� �̻��� ���� �о� �������
			while( (len = is.read(data)) != -1  ) {
				// fos�� ����� ��Ű���� �Ѵ�.
				os.write(data, 0, len);
				// [�ӽ�] ==> [App] ==> [pds]
				// �ӽ� directory�� App�� ����� ��Ʈ���� getInputStream���� �Ʊ� upload.jsp���� �޾Ұ�
				// ���� �� Ŭ�������� pds�� ����� ��Ų��.
				// while������ �ݺ� ���Ѽ� �Ȱ��� ������ ���簡 �ǰ� �Ѵ�.
			}
			
		} finally {
			if (os != null ){
				try {
					os.close();
				} catch(IOException e){
					
				}
			}
		}
		// ���Ϸκ��� ��θ� �����ͼ� �� ���� ��� �״�� ���ư������Ѵ�.
		return file.getAbsolutePath();
	}
	
	
	
}

