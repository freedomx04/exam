package com.hm.exam.entity.authority;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;

@Entity
@Table(name = "authority_role")
public class RoleEntity extends BaseEntity {
	
	/**
	 * 角色名称
	 */
	@Column(unique = true)
	private String name;
	
	/**
	 * 角色描述
	 */
	private String description;
	
	/**
	 * 关联资源, 以','隔开
	 */
	@Column(length = 4000)
	private String resource;
	
	public RoleEntity() {
		// TODO Auto-generated constructor stub
	}

	public RoleEntity(String name, String description, String resource, Date createTime, Date updateTime) {
		super();
		this.name = name;
		this.description = description;
		this.resource = resource;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getResource() {
		return resource;
	}

	public void setResource(String resource) {
		this.resource = resource;
	}
	
}
