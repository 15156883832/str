package test1.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import test1.entity.AddressBook;
import test1.form.ComUtils;
import ivan.common.persistence.BaseDao;
import ivan.common.utils.StringUtils;

@Repository
public class AddressBookDao extends BaseDao<AddressBook>{
	
	@SuppressWarnings("unchecked")
	public AddressBook getById(String id) {
		Query query = getSession().createSQLQuery("select * from address_book where id='"+id+"' and status='0'").addEntity(AddressBook.class);
		List<AddressBook> list = query.list();
		return ((list.size() > 0) ? list.get(0) : null);
	}
	
	public String moblesConditions(Map<String,Object> map) {
		StringBuilder sb = new StringBuilder();
		if(ComUtils.checkParamsValid(map.get("name"))){
			sb.append(" and a.name like '%"+map.get("name")+"%'");
		}
		if(ComUtils.checkParamsValid(map.get("mobile"))){
			sb.append(" and (a.mobile like '%"+map.get("mobile")+"%' or a.mobile1 like '%"+map.get("mobile")+"%' or a.mobile2 like '%"+map.get("mobile")+"%') ");
		}
		if(ComUtils.checkParamsValid(map.get("type"))){
			sb.append(" and a.type = '"+map.get("type")+"'");
		}
		if(ComUtils.checkParamsValid(map.get("createBy"))){
			sb.append(" and m.name like '%"+map.get("createBy")+"%'");
		}
		if(ComUtils.checkParamsValid(map.get("createTimeMin"))){
			sb.append(" and a.create_time >= '"+map.get("createTimeMin")+" 00:00:00'");
		}
		if(ComUtils.checkParamsValid(map.get("createTimeMax"))){
			sb.append(" and a.create_time <= '"+map.get("createTimeMax")+" 23:59:59'");
		}
		if(ComUtils.checkParamsValid(map.get("descMark"))){
			sb.append(" and a.desc_mark like '%"+map.get("descMark")+"%'");
		}
		return sb.toString();
	}
	
}
