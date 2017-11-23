package com.hm.exam.entity.system;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;
import com.hm.exam.entity.authority.UserEntity;

@Entity
@Table(name = "system_notice")
public class NoticeEntity extends BaseEntity {
	
	/**
	 * 公告标题
	 */
	private String title;
	
	/**
	 * 公告内容
	 */
	@Column(length = 4000)
	private String content;
	
	/**
	 * 发布人
	 */
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	private UserEntity user;
	
	public NoticeEntity() {
		// TODO Auto-generated constructor stub
	}

	public NoticeEntity(String title, String content, UserEntity user, Date createTime, Date updateTime) {
		super();
		this.title = title;
		this.content = content;
		this.user = user;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}
	
}
