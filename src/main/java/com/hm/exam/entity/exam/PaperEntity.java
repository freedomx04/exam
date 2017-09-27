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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;
import com.hm.exam.entity.question.QuestionEntity;

@Entity
@Table(name = "exam_paper")
public class PaperEntity extends BaseEntity {
	
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
	 * 多对多关联试题
	 */
	@ManyToMany(cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
	@JoinTable(name = "relate_paper_question", 
		joinColumns={@JoinColumn(name = "paper_id", referencedColumnName="id")},
		inverseJoinColumns = {@JoinColumn(name = "question_id", referencedColumnName="id")})
	private List<QuestionEntity> questions = new LinkedList<>();
	
	/**
	 * 链接
	 */
	private String link;
	
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

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

}