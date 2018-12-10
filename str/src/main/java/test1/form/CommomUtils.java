package test1.form;

import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class CommomUtils {
	
	/*邮箱验证*/
	 public static void email(String email,String authcode)throws Exception {  
       Properties properties = new Properties();  
       properties.setProperty("mail.transport.protocol", "smtp");//发送邮件协议  
       properties.setProperty("mail.smtp.auth", "true");//需要验证  
        //properties.setProperty("mail.debug", "true");//设置debug模式 后台输出邮件发送的过程  
       Session session = Session.getInstance(properties);  
       session.setDebug(true);//debug模式  
       //邮件信息  
       Message messgae = new MimeMessage(session);  
       messgae.setFrom(new InternetAddress("1193453159@qq.com"));//设置发送人  
       messgae.setText("你的验证码为："+authcode+"。请注意，验证码有效时间为2分钟！！！");//设置邮件内容  
       messgae.setSubject("邮箱验证");//设置邮件主题  
       //发送邮件  
       Transport tran = session.getTransport();  
        tran.connect("smtp.qq.com", 587, "1193453159@qq.com", "aocnvwxkbquujchh");//连接到qq邮箱服务器 smtp.sina.com新浪
       // tran.connect("smtp.qq.com",587, "Michael8@qq.vip.com", "xxxx");//连接到QQ邮箱服务器  
       tran.sendMessage(messgae, new Address[]{ new InternetAddress(email)});//设置邮件接收人  
       tran.close();  
   }  
	 
	public static String getRandomNumber(Integer length) {
		 Random rand = new Random();
		 String str = "";
		 for(int i=0;i<length;i++) {
			 Integer one = rand.nextInt(10);
			 str += one.toString();
		 }
		return str;
	 }
}
