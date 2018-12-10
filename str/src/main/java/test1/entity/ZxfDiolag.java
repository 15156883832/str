package test1.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "zxf_diolag")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存注解
public class ZxfDiolag implements Serializable {
	private static final long serialVersionUID = 1L;//序列化
	private String id;
	private String diolagContent;
	private String parentId;
	private String pParentId;
	private String createBy;
	private String replyBy;
	private String imgs;
	private String byDesc;
	private String status;
	private String type;
	private Date createTime;
	private Date replyTime;
	
	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name ="idGenerator" , strategy ="uuid")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDiolagContent() {
		return diolagContent;
	}
	public void setDiolagContent(String diolagContent) {
		this.diolagContent = diolagContent;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getpParentId() {
		return pParentId;
	}
	public void setpParentId(String pParentId) {
		this.pParentId = pParentId;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getReplyBy() {
		return replyBy;
	}
	public void setReplyBy(String replyBy) {
		this.replyBy = replyBy;
	}
	public String getImgs() {
		return imgs;
	}
	public void setImgs(String imgs) {
		this.imgs = imgs;
	}
	public String getByDesc() {
		return byDesc;
	}
	public void setByDesc(String byDesc) {
		this.byDesc = byDesc;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}
	
}
