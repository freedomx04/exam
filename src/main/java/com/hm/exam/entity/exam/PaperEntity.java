package com.hm.exam.entity.exam;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;
import com.hm.exam.entity.question.QuestionEntity;
import com.hm.exam.entity.student.StudentEntity;

@Entity
@Table(name = "exam_paper")
public class PaperEntity extends BaseEntity {

	/**
	 * 试卷状态 0：可用  1：不可用
	 */
	public class PaperStatus {
		public static final int STATUS_ENABLE = 0;
		public static final int STATUS_UNABLE = 1;
	}

	/**
	 * 试卷标题
	 */
	private String title;

	/**
	 * 试卷分类
	 */
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "classify_id")
	private ClassifyEntity classify;

	/**
	 * 描述
	 */
	private String description;

	/**
	 * 试题
	 */
	@ManyToMany(cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
	@JoinTable(name = "relate_paper_question", 
		joinColumns = {@JoinColumn(name = "paper_id", referencedColumnName = "id") }, 
		inverseJoinColumns = {@JoinColumn(name = "question_id", referencedColumnName = "id") })
	private List<QuestionEntity> questions = new LinkedList<>();
	
	/**
	 * 考生
	 */
	@ManyToMany(cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
	@JoinTable(name = "relate_paper_student",
		joinColumns = {@JoinColumn(name = "paper_id", referencedColumnName = "id") },
		inverseJoinColumns = {@JoinColumn(name = "student_id", referencedColumnName = "id") })
	private List<StudentEntity> students = new LinkedList<>();
	
	/**
	 * 反馈
	 */
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "paper_id")
	private List<FeedbackEntity> feedbacks = new LinkedList<>();

	/**
	 * 试卷状态
	 */
	private Integer status = PaperStatus.STATUS_ENABLE;

	/**
	 * 开始时间
	 */
	private Date startTime;

	/**
	 * 结束时间
	 */
	private Date endTime;

	/**
	 * 考试时长
	 */
	private Integer duration;

	public PaperEntity() {
		// TODO Auto-generated constructor stub
	}

	public PaperEntity(String title, ClassifyEntity classify, String description, Date createTime, Date updateTime) {
		super();
		this.title = title;
		this.classify = classify;
		this.description = description;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public ClassifyEntity getClassify() {
		return classify;
	}

	public void setClassify(ClassifyEntity classify) {
		this.classify = classify;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<QuestionEntity> getQuestions() {
		return questions;
	}

	public void setQuestions(List<QuestionEntity> questions) {
		this.questions = questions;
	}
	
	public List<StudentEntity> getStudents() {
		return students;
	}

	public void setStudents(List<StudentEntity> students) {
		this.students = students;
	}
	
	public List<FeedbackEntity> getFeedbacks() {
		return feedbacks;
	}

	public void setFeedbacks(List<FeedbackEntity> feedbacks) {
		this.feedbacks = feedbacks;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

}
