package test1.service;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import ivan.common.service.BaseService;

@Component
@Transactional(readOnly = true)
public class DiolagService extends BaseService {
	
	public List<Record> getDiolagList(String userId){
		StringBuilder sf = new StringBuilder();
		sf.append("select a.*,b.name as userName,DATE_FORMAT(a.create_time,'%Y-%m-%d %H:%i:%s') as createTime from zxf_diolag a left join zxf_user_message b on a.create_by=b.user_id and b.status='0' where a.type='0' and a.status='0'");
		sf.append(" order by a.create_time desc");
		return Db.find(sf.toString());
	}
}
