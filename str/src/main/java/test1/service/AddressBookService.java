package test1.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import test1.dao.AddressBookDao;
import test1.dao.ZxfUserMessageDao;
import test1.entity.AddressBook;
import test1.entity.ZxfUserMessage;
import test1.form.ComUtils;
import test1.form.Result;

@Component
@Transactional(readOnly = true)
public class AddressBookService extends BaseService {
	@Autowired
	private AddressBookDao addressBookDao;
	@Autowired
	private ZxfUserMessageDao zxfUserMessageDao;
	
	@Transactional
	public Result<T> addBkSave(Map<String,Object> map){
		Result<T> rt = new Result<T>();
		Date dt =  new Date();
		AddressBook addBk = new AddressBook();
		addBk.setAddress(objToStr(map.get("addBkAddress")));
		addBk.setCreateBy(objToStr(map.get("addBkCreateBy")));
		addBk.setCreateTime(dt);
		addBk.setDescMark(objToStr(map.get("addBkDesc")));
		addBk.setMobile(objToStr(map.get("addBkMobile")));
		addBk.setMobile1(objToStr(map.get("addBkMobile1")));
		addBk.setMobile2(objToStr(map.get("addBkMobile2")));
		addBk.setName(objToStr(map.get("addBkName")));
		addBk.setSex(objToStr(map.get("addBkSex")));
		addBk.setType(objToStr(map.get("addBkType")));
		addBk.setQq(objToStr(map.get("qq")));
		addBk.setWx(objToStr(map.get("wx")));
		addBk.setZfb(objToStr(map.get("zfb")));
		addBk.seteMail(objToStr(map.get("eMail")));
		addBk.setStatus("0");
		addressBookDao.save(addBk);
		/*SQLQuery sql = addressBookDao.getSession().createSQLQuery("INSERT INTO address_book (address, create_by, create_time, `desc`, flag, mobile, mobile1, mobile2, `name`, sex, `status`, `type`, update_time, id) VALUES ('2', '1', null, null, null, null,null, null, '哈哈', null, null, null, null, '3')");
		sql.executeUpdate();*/
		rt.setCode("200");
		rt.setMsg("addBk success");
		return rt;
	}
	
	public String objToStr(Object params){
		if(params==null){
			return "";
		}
		return params.toString().trim();
	}
	
	public Map<String,Object> getAddBkPages(Map<String,Object> map,String userId){
		Map<String,Object> maps = new HashedMap();
		List<Record> list = getAddBkList(map,userId);
		Long count = getAddBkCount(map,userId);
		maps.put("list", list);
		maps.put("count", count);
		return maps;
		
	}
	
	public Map<String,Integer> returnPageSizeAndNo(Map<String,Object> map){
		Map<String,Integer> maps = new HashMap();
		Integer pageSize = 20;
		Integer pageNo = 1;
		Object ps = map.get("pageSize");
		Object pn = map.get("pageNo");
		if(ps!=null) {
			if(StringUtils.isNotBlank(ps.toString())){
				pageSize = Integer.valueOf(ps.toString());
			}
		}
		if(pn!=null) {
			if(StringUtils.isNotBlank(pn.toString())){
				pageNo = Integer.valueOf(pn.toString());
			}
		}
		map.put("pageSize", pageSize);
		map.put("pageNo", pageNo);
		return maps;
	}
	
	public List<Record> getAddBkList(Map<String,Object> map,String userId){
		Map<String,Integer> map1 = returnPageSizeAndNo(map);
		Integer pageSize = map1.get("pageSize");
		Integer pageNo = map1.get("pageNo");
		if(map.containsKey("pageSize")) {
			pageSize = map.get("pageSize")!=null ? Integer.valueOf(map.get("pageSize").toString()) : 10;
			pageNo = map.get("pageNo")!=null ? Integer.valueOf(map.get("pageNo").toString()) : 1;
		}
		StringBuffer sf = new StringBuffer();
		sf.append("select a.*,m.name as userName from address_book a left join zxf_user u on u.id=a.create_by left join zxf_user_message m on m.user_id=a.create_by where a.status='0' and (a.create_by=? or a.type='0' )");
		sf.append(addressBookDao.moblesConditions(map));
		sf.append(" order by a.create_time desc");
		sf.append(" limit " + pageSize + " offset " + (pageNo-1)*pageSize);
		return Db.find(sf.toString(),userId);
	}
	
	public Long getAddBkCount(Map<String,Object> map,String userId){
		Map<String,Integer> map1 = returnPageSizeAndNo(map);
		Integer pageSize = map1.get("pageSize");
		Integer pageNo = map1.get("pageNo");
		StringBuffer sf = new StringBuffer();
		sf.append("select count(1) from address_book a left join zxf_user u on u.id=a.create_by left join zxf_user_message m on m.user_id=a.create_by  where a.status='0' and (a.create_by=? or a.type='0' )");
		sf.append(addressBookDao.moblesConditions(map));
		return Db.queryLong(sf.toString(),userId);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public String saveEdit(Map<String,Object> map,String uId) {
		String id = map.get("editId").toString();
		AddressBook ab = addressBookDao.getById(id);
		if(ab==null) {
			return "420";
		}
		Date dt = new Date();
		ZxfUserMessage zum = zxfUserMessageDao.getUserMsgByUserId(uId);
		ab.setAddress(objToStr(map.get("addBkAddress")));
		ab.setDescMark(objToStr(map.get("addBkDesc")));
		ab.setMobile(objToStr(map.get("addBkMobile")));
		ab.setMobile1(objToStr(map.get("addBkMobile1")));
		ab.setMobile2(objToStr(map.get("addBkMobile2")));
		ab.setName(objToStr(map.get("addBkName")));
		ab.setSex(objToStr(map.get("addBkSex")));
		ab.setType(objToStr(map.get("addBkType")));
		ab.setUpdateTime(dt);
		ab.setUpdateBy(zum.getName());
		ab.setQq(objToStr(map.get("qq")));
		ab.setWx(objToStr(map.get("wx")));
		ab.setZfb(objToStr(map.get("zfb")));
		ab.seteMail(objToStr(map.get("eMail")));
		addressBookDao.save(ab);
		return "200";
	}
	
	public Record getAddressBookById(String id) {
		return Db.findFirst("select * from address_book a where a.id=?",id);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public String deleteMobiles(String ids) {
		SQLQuery sql = addressBookDao.getSession().createSQLQuery("delete from address_book where id in ("+ComUtils.joinInSql(ids.split(","))+")");
		sql.executeUpdate();
		return "200";
	}
	
	@SuppressWarnings("unchecked")
	public List<AddressBook> getAddressBookByIds(String ids){
		Query sql = addressBookDao.getSession().createSQLQuery("select * from address_book   where id in ("+ComUtils.joinInSql(ids.split(","))+")").addEntity(AddressBook.class);
		return (sql.list().size() > 0) ? sql.list() : null;
	}
	
}
