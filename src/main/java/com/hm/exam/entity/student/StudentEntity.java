package com.hm.exam.entity.student;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;

@Entity
@Table(name = "student_student")
public class StudentEntity extends BaseEntity {

	/**
	 * 分组
	 */
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "group_id")
	private GroupEntity group;
	
	/**
	 * 考试号, 唯一
	 */
	@Column(unique = true)
	private String username;
	
	/**
	 * 密码
	 */
	private String password;
	
	/**
	 * 姓名
	 */
	private String name;
	
	public StudentEntity() {
		// TODO Auto-generated constructor stub
	}

	public StudentEntity(GroupEntity group, String username, String name, String password, Date createTime, Date updateTime) {
		super();
		this.group = group;
		this.username = username;
		this.name = name;
		this.password = password;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public GroupEntity getGroup() {
		return group;
	}

	public void setGroup(GroupEntity group) {
		this.group = group;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}
