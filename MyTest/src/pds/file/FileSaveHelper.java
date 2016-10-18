package pds.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Random;

public class FileSaveHelper {
	private static Random random = new Random();
	
	// 업로드된 파일로부터 데이터를 읽을 수 있게 인풋스트림을 연결 시키도록 한다.
	public static String save(String directory, InputStream is)
			throws IOException {
		// 동일 이름의 파일이 올라가면, 기존의 것이 삭제가 된다.
		// FileUploadAPI의 경우는 중복 파일 삭제한다.
		// 즉, 이름의 중복이 없게 바꾸어야한다.
		
		// 업로드한 시간을 currentTime으로 가져온다.
		long currentTime = System.currentTimeMillis();
		
		// 0~49까지의 Random 값을 반환시키도록 한다. 인수로 넣은 값은 다를 수가 있다.
		// 혹시나 동일한 시간에 두 명이 올려도, 값이 달라진다. - 랜덤으로 합쳐서 처리했기 때문이다.
		int randomValue = random.nextInt(50);
		
		// 파일명을 위에서 만든 시간과, 랜덤 값을 합쳐서 만든 다음에 File 객체에 저장을 하도록 한다.
		String fileName = Long.toString(currentTime) + "_"
					+ Integer.toString(randomValue);
		File file = new File(directory, fileName);
		FileOutputStream os = null;
		try {
			// 해당 경로에 있는 파일로 만들어 준다. - 경로를 file 객체에 만들고, 이를 fos 에 넣는다.
			// ex: 경로 f://pds//현재시간_랜덤값 -> 이 경로를 가지고 있게 만든다.
			os = new FileOutputStream(file);
			
			// 이제 내용을 보내야하므로 바이트 배열 선언
			byte[] data = new byte[8096];
			int len = -1;
			
			// 읽어 드린 값이 -1이 아니라면 -> 0개 이상의 값이 읽어 와질경우
			while( (len = is.read(data)) != -1  ) {
				// fos로 출력을 시키도록 한다.
				os.write(data, 0, len);
				// [임시] ==> [App] ==> [pds]
				// 임시 directory와 App과 연결된 스트림은 getInputStream으로 아까 upload.jsp에서 받았고
				// 여기 이 클래스에서 pds로 출력을 시킨다.
				// while문으로 반복 시켜서 똑같은 내용이 복사가 되게 한다.
			}
			
		} finally {
			if (os != null ){
				try {
					os.close();
				} catch(IOException e){
					
				}
			}
		}
		// 파일로부터 경로를 가져와서 그 값을 들고 그대로 돌아가도록한다.
		return file.getAbsolutePath();
	}
	
	
	
}

