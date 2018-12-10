package test1.form.export;

import ivan.common.utils.excel.annotation.ExcelField;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.ManyToOne;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;

public class AddressBookExcel {
	
	private String name;
	private String sex;
	private String mobile;
	private String qq;
	private String e_mail;
	private String wx;
	private String zfb;
	private String type;
	private String address;
	private String descMark;
	private Date updateTime;
	private Date createTime;
	private String createBy;
	
	
	private List<Record> roleList = Lists.newArrayList(); 
	
	@ManyToOne
	@ExcelField(title="姓名", align=2, sort=10)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@ManyToOne
	@ExcelField(title="性别", align=2, sort=20)
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@ManyToOne
	@ExcelField(title="联系方式", align=2, sort=30)
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@ManyToOne
	@ExcelField(title="QQ", align=2, sort=40)
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	
	@ManyToOne
	@ExcelField(title="邮箱", align=2, sort=50)
	public String getE_mail() {
		return e_mail;
	}
	public void setE_mail(String e_mail) {
		this.e_mail = e_mail;
	}
	
	@ManyToOne
	@ExcelField(title="微信", align=2, sort=60)
	public String getWx() {
		return wx;
	}
	public void setWx(String wx) {
		this.wx = wx;
	}
	
	@ManyToOne
	@ExcelField(title="支付宝", align=2, sort=70)
	public String getZfb() {
		return zfb;
	}
	public void setZfb(String zfb) {
		this.zfb = zfb;
	}
	
	@ManyToOne
	@ExcelField(title="类型", align=2, sort=80)
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	@ManyToOne
	@ExcelField(title="地址", align=2, sort=90)
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	@ManyToOne
	@ExcelField(title="备注", align=2, sort=100)
	public String getDescMark() {
		return descMark;
	}
	public void setDescMark(String descMark) {
		this.descMark = descMark;
	}
	
	@ManyToOne
	@ExcelField(title="最近更新时间", align=2, sort=110)
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	@ManyToOne
	@ExcelField(title="创建时间", align=2, sort=120)
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	@ManyToOne
	@ExcelField(title="创建人", align=2, sort=130)
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public List<Record> getRoleList() {
		return roleList;
	}
	public void setRoleList(List<Record> roleList) {
		this.roleList = roleList;
	}
	
	
}
