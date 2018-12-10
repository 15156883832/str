package test1.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import test1.form.Result;
import ivan.common.service.BaseService;

@Component
@Transactional(readOnly = true)
public class ZxfUserMessageService extends BaseService{
	
	

}
