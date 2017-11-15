package com.hm.exam.entity.question;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;

@Entity
@Table(name = "question_library")
public class LibraryEntity extends BaseEntity {
	
	/**
	 * 题库名称
	 */
	@Column(unique = true)
	private String name;
	
	/**
	 * 试题数目
	 */
	private Integer count = 0;
	
	public LibraryEntity() {
		// TODO Auto-generated constructor stub
	}

	public LibraryEntity(String name, Date createTime, Date updateTime) {
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
