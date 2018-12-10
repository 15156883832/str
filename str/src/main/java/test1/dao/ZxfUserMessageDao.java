package test1.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import test1.entity.ZxfUserMessage;
import ivan.common.persistence.BaseDao;

@Repository
public class ZxfUserMessageDao extends BaseDao<ZxfUserMessage>{
	
	public ZxfUserMessage getUserMsgByUserId(String userId) {
		Query query = getSession().createSQLQuery("select * from zxf_user_message  where user_id='"+userId+"' and status='0' ").addEntity(ZxfUserMessage.class);
		List<ZxfUserMessage> zumList = query.list();
		return ((zumList.size() > 0) ? zumList.get(0) : null );
	}
	
}
