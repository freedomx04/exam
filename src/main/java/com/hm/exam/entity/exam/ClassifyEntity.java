package com.hm.exam.entity.exam;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;

@Entity
@Table(name = "exam_classify")
public class ClassifyEntity extends BaseEntity {
	
	/**
	 * 试卷分类名称
	 */
	@Column(unique = true)
	private String name;
	
	/**
	 * 试卷数目
	 */
	private Integer count = 0;
	
	public ClassifyEntity() {
		// TODO Auto-generated constructor stub
	}

	public ClassifyEntity(String name, Date createTime, Date updateTime) {
		super();
		this.name = name;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
	
}
