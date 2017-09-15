package com.hm.exam.entity;

import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class BaseEntity {
	
	/**
	 * 是否能编辑
	 * 		0: 可编辑
	 * 		1: 不可编辑
	 */
	public class Editable {
		public static final int ENABLE = 0;	
		public static final int UNABLE = 1;
	}
	
	/**
	 * 通用唯一主键
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	protected long id;
	
	/**
	 * 是否能编辑
	 */
	private Integer editable = Editable.ENABLE;
	
	/**
	 * 创建时间
	 */
	protected Date createTime;
	
	/**
	 * 更新时间
	 */
	protected Date updateTime;

	public BaseEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public Integer getEditable() {
		return editable;
	}

	public void setEditable(Integer editable) {
		this.editable = editable;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

}
