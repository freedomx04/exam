package com.hm.exam.entity.question;

public class TypeEntity {

	/**
	 * 题型
	 */
	private Integer type;
	
	/**
	 * 题型名称
	 */
	private String name;
	
	/**
	 * 题型数目
	 */
	private Integer count = 0;
	
	public TypeEntity() {
		// TODO Auto-generated constructor stub
	}

	public TypeEntity(Integer type, String name, Integer count) {
		super();
		this.type = type;
		this.name = name;
		this.count = count;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
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
