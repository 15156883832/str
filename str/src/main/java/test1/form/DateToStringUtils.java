package test1.form;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateToStringUtils {
	public static String DateToString(){  
	      
	    Date date=new Date();  
	    SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    String time=formatter.format(date); 
	    return time;
	} 
	
	public static String DateToStringParam(Date date){  
	      
	    SimpleDateFormat formatter=new SimpleDateFormat("MM-dd HH:mm:ss");  
	    String time=formatter.format(date); 
	    return time;
	} 
	
	public static String DateToStringParam1(Date date){  
	      
	    SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    String time=formatter.format(date); 
	    return time;
	} 

}
