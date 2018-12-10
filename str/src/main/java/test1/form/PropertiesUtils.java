package test1.form;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public enum  PropertiesUtils {
	
	
		ADMINPATH("adminPath"),
	    USERS_PATH("jdbc.validationQuery"),
	    PICTURES_PATH("pictures_path"),
	    FILES_PATH("files_path"),
	    LOGS_PATH("logs_path");
	    
	    private String title;
	    private static Properties props;
	    private PropertiesUtils(String title){
	        this.title = title;
	    }

	    private static final String PROPERTIES = "spring/config.properties";
	    
	    private static final Pattern PATTERN = Pattern.compile("\\$\\{([^\\}]+)\\}");
	    
	    static{
	        try {
	            props = new Properties();
	            InputStream ins = PropertiesUtils.class.getClassLoader().getResourceAsStream(PROPERTIES);
	            props.load(ins);
	            ins.close();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    private String getTitle() {
	        return title;
	    }
	
    public static String get(PropertiesUtils prop){
        String value = props.getProperty(prop.getTitle());
        return value==null?null:loop(value);
    }
    
    @SuppressWarnings("static-access")
    private static String loop(String key){
        //定义matcher匹配其中的路径变量
        Matcher matcher = PATTERN.matcher(key);
        StringBuffer buffer = new StringBuffer();
        boolean flag = false;
        while (matcher.find()) {
            String matcherKey = matcher.group(1);//依次替换匹配到的路径变量
            String matchervalue = props.getProperty(matcherKey);
            if (matchervalue != null) {
                matcher.appendReplacement(buffer, matcher.quoteReplacement(matchervalue));//quoteReplacement方法对字符串中特殊字符进行转化
                flag = true;
            }
        }
        matcher.appendTail(buffer);
        //flag为false时说明已经匹配不到路径变量，则不需要再递归查找
        return flag?loop(buffer.toString()):key;
    }

}
