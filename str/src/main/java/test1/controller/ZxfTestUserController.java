package test1.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jfinal.plugin.activerecord.Record;

import ivan.common.config.Global;
import ivan.common.utils.DateUtils;
import ivan.common.utils.excel.ExportExcel;
import ivan.common.web.BaseController;
import test1.dao.ZxfUserMessageDao;
import test1.form.CommomUtils;
import test1.form.Result;
import test1.form.export.AddressBookExcel;
import test1.service.AddressBookService;
import test1.service.DiolagService;
import test1.service.ZxfTestUserService;
import test1.service.ZxfUserMessageService;


@Controller
@RequestMapping(value = "/user")
public class ZxfTestUserController extends BaseController{
	@Autowired
	private ZxfTestUserService zxfTestUserService;
	@Autowired
	private ZxfUserMessageService zxfUserMessageService;
	@Autowired
	private AddressBookService addressBookService;
	@Autowired
	private DiolagService diolagService;
	@Autowired
	private ZxfUserMessageDao zxfUserMessageDao;
	
	//登陆
	@RequestMapping(value="login")
	public String toLoginPage() {
		
		return "views/login/login";
	}
	//注册
	@RequestMapping(value="registerPage")
	public String toRegisterPage() {
		
		return "views/login/register";
	}
	
	/*
	 * 登陆校验
	 */
	@ResponseBody
	@RequestMapping(value="/loginCheck")
	public Result<T> firstPage(HttpServletRequest request,HttpServletResponse response,Model model){
		//User user = UserUtils.getUser();
		System.out.print("ajax路径正确；");
		String loginName = request.getParameter("loginName");
		String loginPassword = request.getParameter("loginPassword");
		return zxfTestUserService.checkLogin(loginName,loginPassword);
	}
	
	/*
	 * 登陆成功跳转的主页面
	 */
	@RequestMapping(value="toMainPage")
	public String toMainPage(HttpServletRequest request,HttpServletResponse response,Model model){
		String userId = request.getParameter("id");
		request.getSession().setAttribute("userId",userId);
		//List<Record> addBkList = addressBookService.getAddBkList(userId);
		/*try {
			ComUtils.email("2378343115@qq.com", "7894");
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		model.addAttribute("type", "params");//根据需要传值
		model.addAttribute("userId", userId);
		model.addAttribute("ZxfUserMessage", zxfUserMessageDao.getUserMsgByUserId(userId));
		return "views/loginSign/mainPage";
	}
	
	//密码重置
	@RequestMapping(value="toResertPasswordPage")
	public String toResertPasswordPage(HttpServletRequest request,HttpServletResponse response,Model model) {
		return "views/login/resertPassword";
	}
	
	/*
	 * 注册
	 */
	@ResponseBody
	@RequestMapping(value="register")
	public Result<T> resister(HttpServletRequest request,HttpServletResponse response,Model model){
		 Result<T> rt = new Result<T>();
		Map<String,Object> map = getParams(request);
		String verify = request.getParameter("verify");
		if(request.getSession().getAttribute("cacheYzm")==null) {
			rt.setCode("421");
			return rt;//验证码已失效
		}
		if(!verify.equals(request.getSession().getAttribute("cacheYzm").toString())) {
			rt.setCode("420");
			return rt;//验证码不正确
		}
		return zxfTestUserService.confirmSign(map);
	}
	
	@ResponseBody
	@RequestMapping(value="sendYzm")
	public String sendYzm(String email,HttpServletRequest request)  {
		String numbers = CommomUtils.getRandomNumber(4);
		request.getSession().setAttribute("cacheYzm", numbers);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("email", email);
		if("420".equals(zxfTestUserService.checkEmailIfExist(map))) {
			return "430";
		}
		System.out.println("验证码为："+numbers);
		try {
			CommomUtils.email(email, numbers);
		} catch (Exception e) {
			return "420";
		}
		return "200";
	}
	
	@ResponseBody
	@RequestMapping(value="confirmCode")
	public String confirmCode(String code,HttpServletRequest request)  {
		Object obj = request.getSession().getAttribute("cacheYzmConfirm");
		if(obj==null) {
			obj = "";
		}
		String cacheCode = obj.toString();
		if(StringUtils.isBlank(code) || !code.equals(cacheCode)) {
			return "420";
		}
		request.getSession().setAttribute("cacheYzmConfirm", "");
		return "200";
	}
	
	@ResponseBody
	@RequestMapping(value="confirmResertPassword")
	public String confirmResertPassword(String email,String password,HttpServletRequest request)  {
		if(StringUtils.isBlank(email) || StringUtils.isBlank(password)) {
			return "420";
		}
		zxfTestUserService.confirmResertPassword(email,password);
		return "200";
	}
	
	@ResponseBody
	@RequestMapping(value="sendYzmConfirm")
	public String sendYzmConfirm(String email,HttpServletRequest request)  {
		
		if(StringUtils.isBlank(email)) {
			return "420";
		}
		String numbers = CommomUtils.getRandomNumber(4);
		request.getSession().setAttribute("cacheYzmConfirm", numbers);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("email", email);
		System.out.println("验证码为："+numbers);
		try {
			CommomUtils.email(email, numbers);
		} catch (Exception e) {
			return "420";
		}
		return "200";
	}
	
	@ResponseBody
	@RequestMapping(value="checkEmailIfExist")
	public String checkEmailIfExist(HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String, Object>();
		String email = request.getParameter("email");
		String ncName = request.getParameter("ncName");
		map.put("email", email);
		map.put("ncName", ncName);
		return zxfTestUserService.checkEmailIfExist(map);
	}
	
	@ResponseBody
	@RequestMapping(value="loadingAddBkList")
	public Map<String,Object> loadingAddBkList(HttpServletRequest request){
		String userId = request.getSession().getAttribute("userId").toString();
		Map<String,Object> map = getParams(request);
		return addressBookService.getAddBkPages(map,userId);
	}
	
	@RequestMapping(value="toMobileList")
	public String toMobileList() {
		
		return "views/loginSign/addressBooks/mobileList";
	}
	
	@RequestMapping(value="toDiolagList")
	public String toDiolagList(HttpServletRequest request,Model model) {
		String userId = request.getSession().getAttribute("userId").toString();
		List<Record> list = diolagService.getDiolagList(userId);
		model.addAttribute("list", list);
		return "views/loginSign/diolag/diolagList";
	}
	
	@RequestMapping(value="toPersonMsg")
	public String toPersonMsg() {
		
		return "views/loginSign/personMessage/personMsg";
	}
	
	@ResponseBody
	@RequestMapping(value="saveEdit")
	public String saveEdit(HttpServletRequest request,HttpServletResponse response) {
		Map<String,Object> map = getParams(request);
		String uId = request.getSession().getAttribute("userId").toString();
		return addressBookService.saveEdit(map,uId);
	}
	
	@RequestMapping(value="toAddMobile")
	public String toAddMobile(HttpServletRequest request,Model model) {
		return "views/loginSign/addressBooks/addMobile";
	}
	
	@RequestMapping(value="toEditMobile")
	public String toEditMobile(HttpServletRequest request,Model model) {
		String id = request.getParameter("id");
		model.addAttribute("book", addressBookService.getAddressBookById(id));
		return "views/loginSign/addressBooks/editMobile";
	}
	
	@ResponseBody
	@RequestMapping(value="deleteMobiles")
	public String deleteMobiles(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		if(StringUtils.isBlank(ids)) {
			return "420";
		}
		return addressBookService.deleteMobiles(ids);
	}
	
	/** 
	 * 导出Excel数据 
	 
	 */  
	@RequestMapping(value="export")
	public String exportFile(AddressBookExcel addressBookExcel,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
	        String fileName = "霸气人生通讯录"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx"; 
	        String userId = request.getSession().getAttribute("userId").toString();
			Map<String,Object> map = getParams(request);
			map.put("pageSize", 1000000);
			map.put("pageNo", 1);
	        List<Record> list = addressBookService.getAddBkList(map,userId);;
	        List<AddressBookExcel> list1 = new ArrayList<AddressBookExcel>();
	        if(list.size()>0){
		        for(Record rd : list){
		        	AddressBookExcel oe = new AddressBookExcel();
		        	oe.setName(rd.getStr("name"));
		        	oe.setSex("1".equals(rd.getStr("sex")) ? "男" : "女");
		        	oe.setMobile(getMobiles(rd.getStr("mobile"),rd.getStr("mobile1"),rd.getStr("mobile2")));
		        	oe.setQq(rd.getStr("qq"));
		        	oe.setE_mail(rd.getStr("e_mail"));
		        	oe.setAddress(rd.getStr("address"));
		        	oe.setCreateBy(rd.getStr("userName"));
		        	oe.setCreateTime(rd.getDate("create_time"));
		        	oe.setDescMark(rd.getStr("desc_mark"));
		        	oe.setType("1".equals(rd.getStr("sex")) ? "私用" : "公用");
		        	oe.setUpdateTime(rd.getDate("update_time"));
		        	oe.setWx(rd.getStr("wx"));
		        	oe.setZfb(rd.getStr("zfb"));
		        	list1.add(oe);
		        }
	        }
			new ExportExcel("霸气人生通讯录", AddressBookExcel.class)
	                     .setDataList(list1)
	                     .write(response, fileName)
	                     .dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes,"导出工单报表失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sys/user/?repage";
	}
	
	public String getMobiles(String m1,String m2,String m3) {
		String mobile = m1;
		if(StringUtils.isNotBlank(m2)) {
			if(StringUtils.isNotBlank(mobile)) {
				mobile=mobile+","+m2;
			}else {
				mobile=m2;
			}
		}
		if(StringUtils.isNotBlank(m3)) {
			if(StringUtils.isNotBlank(mobile)) {
				mobile=mobile+","+m3;
			}else {
				mobile=m3;
			}
		}
		return mobile;
	}
	
	@RequestMapping(value="printMobiles")
	public String printMobiles(HttpServletRequest request,Model model) {
		String ids = request.getParameter("ids");
		String userId = request.getSession().getAttribute("userId").toString();
		System.out.println(ids);
		model.addAttribute("list", addressBookService.getAddressBookByIds(ids));
		model.addAttribute("printName", zxfUserMessageDao.getUserMsgByUserId(userId).getName());
		return "views/loginSign/addressBooks/printMobiles";
	}
	
	@ResponseBody
	@RequestMapping(value="loadDiolagList")
	public List<Record> loadDiolagList(HttpServletRequest request){
		String userId = request.getSession().getAttribute("userId").toString();
		List<Record> list = diolagService.getDiolagList(userId);
		return list;
	}
	
	@RequestMapping(value="toAddDiolag")
	public String toAddDiolag(HttpServletRequest request) {
		return "views/loginSign/diolag/addHfDiolag";
	}
	
	
	  
}
