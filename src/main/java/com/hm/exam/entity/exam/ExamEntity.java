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
@Table(name = "exam_exam")
public class ExamEntity extends BaseEntity {
	
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
	 * 答对题数
	 */
	private Integer correctNum;
	
	/**
	 * 题数
	 */
	private Integer totalNum;
	
	/**
	 * 正确率
	 */
	private Double correctRate;
	
	/**
	 * 考试分数
	 */
	private Integer score = 0;
	
	public ExamEntity() {
		// TODO Auto-generated constructor stub
	}

	public ExamEntity(PaperEntity paper, StudentEntity student, Date createTime, Date updateTime) {
		super();
		this.paper = paper;
		this.student = student;
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
	
	public Integer getCorrectNum() {
		return correctNum;
	}

	public void setCorrectNum(Integer correctNum) {
		this.correctNum = correctNum;
	}
	
	public Integer getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}

	public Double getCorrectRate() {
		return correctRate;
	}

	public void setCorrectRate(Double correctRate) {
		this.correctRate = correctRate;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}
	
}
