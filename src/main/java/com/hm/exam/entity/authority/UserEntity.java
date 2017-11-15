package com.hm.exam.entity.authority;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;

@Entity
@Table(name = "authority_user")
public class UserEntity extends BaseEntity {
	
	/**
	 * 用户状态 0: 有效 1：无效
	 */
	public class UserStatus {
		public static final int STATUS_VALID = 0;
		public static final int STATUS_NO_VALID = 1;
	}
	
	/**
	 * 用户名,唯一
	 */
	@Column(unique = true)
	private String username;
	
	/**
	 * MD5加密后的密码
	 */
	private String password;
	
	/**
	 * 姓名
	 */
	private String name;
	
	/**
	 * 
	 */
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "role_id")
	private RoleEntity role;
	
	/**
	 * 用户状态
	 */
	private Integer status = UserStatus.STATUS_VALID;
	
	public UserEntity() {
		// TODO Auto-generated constructor stub
	}

	public UserEntity(String username, String password, String name, RoleEntity role, Date createTime, Date updateTime) {
		super();
		this.username = username;
		this.password = password;
		this.name = name;
		this.role = role;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public RoleEntity getRole() {
		return role;
	}

	public void setRole(RoleEntity role) {
		this.role = role;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
