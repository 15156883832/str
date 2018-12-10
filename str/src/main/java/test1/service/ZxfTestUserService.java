package test1.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import ivan.common.service.BaseService;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import test1.dao.ZxfTestUserDao;
import test1.dao.ZxfUserMessageDao;
import test1.entity.AddressBook;
import test1.entity.ZxfTestUser;
import test1.entity.ZxfUserMessage;
import test1.form.Result;

@Component
@Transactional(rollbackFor=Exception.class)
public class ZxfTestUserService extends BaseService {
	@Autowired
	private ZxfTestUserDao zxfTestUserDao;
	@Autowired
	private ZxfUserMessageDao zxfUserMessageDao;
	
	@Transactional
	public Result<T> checkLogin(String loginName,String loginPassword){
		Result<T> rt = new Result<T>();
		Long num = Db.queryLong("select count(*) from zxf_user a where a.login_name=? and a.login_password=? and a.status='0'",loginName,loginPassword);
		/*SQLQuery sql = zxfTestUserDao.getSession().createSQLQuery("update zxf_user a set a.login_name='zxf' where a.login_name='"+loginName+"' and a.login_password='"+loginPassword+"' and a.status='0'");
		sql.executeUpdate();*/
		//sql.executeUpdate();
		if(num == 1){
			Record rd = Db.findFirst("select a.* from zxf_user a where a.login_name=? and a.login_password=? and a.status='0'",loginName,loginPassword);
			rt.setCode("200");
			rt.setId(rd.getStr("id"));
			rt.setMsg("success");
		}else if(num > 1){
			rt.setCode("421");
			rt.setErrMsg("user is more than one");
		}else{
			rt.setCode("422");
			rt.setErrMsg("user is not exist");
		}
		return rt;
	}
	
	public Result<T> confirmSign(Map<String,Object> map){
		Result<T> rt = new Result<T>();
		ZxfTestUser user = new ZxfTestUser();
		ZxfUserMessage userMsg = new ZxfUserMessage();
		Long count = Db.queryLong("select count(*) from zxf_user a where a.status='0' and a.login_name=?",map.get("email"));
		if(count > 0){
			rt.setCode("422");
			rt.setErrMsg("exist");
			return rt;
		}
		Long count1 = Db.queryLong("select count(*) from zxf_user_message a where a.status='0' and a.nick_name=?",map.get("ncName"));
		if(count1 > 0){
			rt.setCode("426");
			rt.setErrMsg("exist");
			return rt;
		}
		Date dt = new Date();
		user.setCreateBy("99");
		user.setCreateTime(dt);
		user.setLoginName(map.get("email").toString());
		user.setLoginPassword(map.get("password").toString());
		user.setType("1");
		
		user.setUpdateTime(dt);
		
		userMsg.setCreateTime(dt);
		userMsg.setType("1");
		if("1193453159@qq.com".equals(map.get("email").toString())) {
			user.setType("0");
			userMsg.setType("0");
		}
		userMsg.setSort("0");
		userMsg.setStatus("0");
		userMsg.setName(map.get("ncName").toString());
		userMsg.setNickName(map.get("ncName").toString());
		try {
			zxfTestUserDao.save(user);
			userMsg.setUserId(user.getId());
			zxfUserMessageDao.save(userMsg);
			rt.setCode("200");
			rt.setMsg("success");
		} catch (Exception e) {
			rt.setCode("424");
			rt.setErrMsg("wrong");
		}
		return rt;
	}
	
	public String checkEmailIfExist(Map<String,Object> map) {
		List<Record> list = new ArrayList<Record>();
		if(map.get("email")!=null && StringUtils.isNotBlank(map.get("email").toString())) {
			list = Db.find("select a.id from zxf_user a where a.status='0' and a.login_name=?",map.get("email"));
		}
		if(map.get("ncName")!=null && StringUtils.isNotBlank(map.get("ncName").toString())) {
			list = Db.find("select a.id from zxf_user_message a where a.status='0' and a.nick_name=?",map.get("ncName"));
		}
		if(list.size() > 0) {
			return "420";
		}
		return "200";
	}
	
	public String confirmResertPassword(String email,String password) {
		SQLQuery sql = zxfTestUserDao.getSession().createSQLQuery("update zxf_user a set a.login_password='"+password+"' where a.login_name='"+email+"' and a.status='0' ");
		sql.executeUpdate();
		return "200";
	}

}
