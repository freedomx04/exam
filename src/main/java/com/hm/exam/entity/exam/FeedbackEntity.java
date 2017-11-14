package com.hm.exam.entity.exam;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;
import com.hm.exam.entity.student.StudentEntity;

@Entity
@Table(name = "exam_feedback")
public class FeedbackEntity extends BaseEntity {
	
	/**
	 * 试卷
	 */
	@Column(name = "paper_id")
	private Long paperId;
	
	/**
	 * 考生
	 */
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "student_id")
	private StudentEntity student;
	
	/**
	 * 反馈内容
	 */
	private String content;
	
	public FeedbackEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public FeedbackEntity(Long paperId, StudentEntity student, String content, Date createTime, Date updateTime) {
		super();
		this.paperId = paperId;
		this.student = student;
		this.content = content;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public Long getPaperId() {
		return paperId;
	}

	public void setPaperId(Long paperId) {
		this.paperId = paperId;
	}

	public StudentEntity getStudent() {
		return student;
	}

	public void setStudent(StudentEntity student) {
		this.student = student;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}
