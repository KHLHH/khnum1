package d;
import java.util.*;

public class H<K,V> extends HashMap<K,V>{
	static final int debug = 1;
	
	private static final long serialVersionUID = 1L;
	
	public V put(K key, V value){
		value = super.put(key, value);
		return value;
	}
	
	
	
	public static void p(String str1){
		if(debug == 1){
			d.D.p(""+Thread.currentThread().getStackTrace()+"#Message: "+str1);			
		}
	}
	
	public static void main(String[] args){
		p("Test");
		H h1 = new H();
		h1.put("key1","value1");
		System.out.println("h1.get('key1')"+h1.get("key1"));
	}
	
}
