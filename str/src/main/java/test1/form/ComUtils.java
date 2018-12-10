package test1.form;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import ivan.common.utils.StringUtils;
import test1.dao.ZxfUserMessageDao;
import test1.entity.ZxfUserMessage;

public class ComUtils {
	public static ZxfUserMessageDao zxfUserMessageDao;
	
	public static ZxfUserMessage getZxfUserMessageByUid(String userId) {
		return zxfUserMessageDao.getUserMsgByUserId(userId);
	}
	
	public static String joinInSql(String[] els) {
        if (els == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (String el : els) {
            sb.append("'").append(el).append("'");
            sb.append(",");
        }
        String ret = sb.toString();
        if (ret.endsWith(",")) {
            ret = ret.substring(0, ret.length() - 1);
        }
        return ret;
    }
	
	public static boolean checkParamsValid(Object obj){
		if(obj != null && StringUtils.isNotBlank(String.valueOf(obj))){
			return true;
		}
		return false;
	}
	
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
	 
	 public static List<Record> getDiolagChildList(String parentId){
		 List<Record> list = new ArrayList<Record>();
		 StringBuilder sf = new StringBuilder();
		 sf.append("select a.*,b.name as userName,DATE_FORMAT(a.create_time,'%Y/%m/%d %H:%i:%s') as createTime from zxf_diolag a left join zxf_user_message b on a.create_by=b.user_id and b.status='0' where a.type='1' and a.status='0' and a.parent_id=?");
		 sf.append(" order by a.create_time desc");
		 list = Db.find(sf.toString(),parentId);
		 return list;
	 }
	 
	 public static List<Record> getDiolagChildChList(String parentId){
		 List<Record> list = new ArrayList<Record>();
		 StringBuilder sf = new StringBuilder();
		 sf.append("select a.*,b.name as userName,c.name as replyName ,DATE_FORMAT(a.create_time,'%Y/%m/%d %H:%i:%s') as createTime from zxf_diolag a left join zxf_user_message b on a.create_by=b.user_id and b.status='0' LEFT JOIN zxf_user_message c ON a.reply_by=c.user_id AND b.status='0'  where a.type='2' and a.status='0' and a.parent_id=?");
		 sf.append(" order by a.create_time asc");
		 list = Db.find(sf.toString(),parentId);
		 return list;
	 }
}
