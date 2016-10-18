package util;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

// 클래스 실행 순서
// 1. 클래스 정보 2. static 정보 3. main 메서드 실행...
// 클래스를 객체로 만들면 - 인스턴스 멤버/메서드 올라가고 - 생성자가 실행됨
// 그 객체 안의 멤버를 꺼내서 쓰면 된다.

public class CookieBox{
	private Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
	public CookieBox(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(int i=0; i<cookies.length; i++){
				cookieMap.put(cookies[i].getName(), cookies[i]);
			}
		}
	}
	// create Cookie 메서드가 3개가 있다.
	// overloading임, 매개변수가 다름
	// cf. 메서드 구현부를 바꿈. 바디를 바꿈
	
	//makeCookieUsingBox에서 매개변수를 넣어서 매개변수 두 개짜리 실행
	// 이를 return 하면서 return new Cookie가 감 -> JSP에서 response.addCookie로 넣음
	public static Cookie createCookie(String name, String value)
		throws IOException{
		return new Cookie(name, URLEncoder.encode(value, "utf-8"));
	}
	
	// JSP에서 매개변수 4개 짜리 넣음 -> path  -1: 브라우저가 닫히면 사라짐. - 브라우저가 열리면 닫힐 때 사라짐
	// 이를 받아서 response로 받아서 쿠키로 addCookie 해서 JSP에서 가져옴
	public static Cookie createCookie(String name, String value, String path, int maxAge)
		throws IOException{
		Cookie cookie = new Cookie(name, URLEncoder.encode(value, "utf-8"));
		cookie.setPath(path);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
	
	public static Cookie createCookie(String name, String value, String domain, String path, int maxAge)
			throws IOException{
		Cookie cookie = new Cookie(name, URLEncoder.encode(value, "utf-8"));
		cookie.setDomain(domain);
		cookie.setPath(path);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
	
	public Cookie getCookie(String name){
		return cookieMap.get(name);
	}
	
	public String getValue(String name) throws IOException {
		Cookie cookie = cookieMap.get(name);
		if(cookie == null){
			return null;
		}
		return URLDecoder.decode(cookie.getValue(), "utf-8");
	}
	
	public boolean exists(String name) {
		return cookieMap.get(name)!=null;
	}
}


