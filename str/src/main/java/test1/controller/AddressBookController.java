package test1.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

import test1.form.Result;
import test1.service.AddressBookService;
import ivan.common.web.BaseController;

@Controller
@RequestMapping(value = "/addBk")
public class AddressBookController extends BaseController {
	@Autowired
	private AddressBookService addressBookService;
	@ResponseBody
	@RequestMapping(value="addBkSave")
	public Result<T> addBkSave(HttpServletRequest request){
		Map<String,Object> map = getParams(request);
		return addressBookService.addBkSave(map);
	}
	
	
	
	
	
	
}
