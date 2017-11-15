package com.hm.exam.entity.student;

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
@Table(name = "student_student", indexes = {
	@Index(name = "index_student_student_updateTime", columnList = "updateTime"),
	@Index(name = "index_student_student_group_updateTime", columnList = "group_id, updateTime")
})
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
	
	/**
	 * 当前试卷
	 */
	private Long paperId;
	
	public StudentEntity() {
		// TODO Auto-generated constructor stub
	}

	public StudentEntity(GroupEntity group, String username, String password, String name, Date createTime, Date updateTime) {
		super();
		this.group = group;
		this.username = username;
		this.password = password;
		this.name = name;
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

	public Long getPaperId() {
		return paperId;
	}

	public void setPaperId(Long paperId) {
		this.paperId = paperId;
	}
	
}
