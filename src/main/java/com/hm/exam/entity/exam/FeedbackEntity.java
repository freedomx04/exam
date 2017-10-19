package com.hm.exam.entity.exam;

import java.util.Date;

import javax.persistence.CascadeType;
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
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "paper_id")
	private PaperEntity paper;
	
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
	
	public FeedbackEntity(PaperEntity paper, StudentEntity student, String content, Date createTime, Date updateTime) {
		super();
		this.paper = paper;
		this.student = student;
		this.content = content;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public PaperEntity getPaper() {
		return paper;
	}

	public void setPaper(PaperEntity paper) {
		this.paper = paper;
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
