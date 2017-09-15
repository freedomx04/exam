package com.hm.exam.entity.question;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;

@Entity
@Table(name = "question_question")
public class QuestionEntity extends BaseEntity {
	
	public class QuestionType {
		public static final int SINGLE_CHOICE = 1;
		public static final int MULTIPLE_CHOICE = 2;
		public static final int TRUE_FALSE = 3;
	}
	
	/**
	 * 题库
	 */
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "library_id")
	private LibraryEntity library;
	
	/**
	 * 试题类型
	 */
	private Integer type = QuestionType.SINGLE_CHOICE;
	
	/**
	 * 试题
	 */
	@Column(length = 2000)
	private String title;
	
	/**
	 * 答案选项
	 */
	private String optionA;
	private String optionB;
	private String optionC;
	private String optionD;
	private String optionE;
	private String optionF;
	
	/**
	 * 正确答案
	 */
	private String answer;
	
	/**
	 * 解析
	 */
	@Column(length = 2000)
	private String analysis;
	
	/**
	 * 分数
	 */
	private Integer score;
	
	public QuestionEntity() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QuestionEntity(LibraryEntity library, Integer type, String title, String optionA, String optionB, String optionC, String optionD,
			String optionE, String optionF, String answer, String analysis, Integer score, Date createTime, Date updateTime) {
		super();
		this.library = library;
		this.type = type;
		this.title = title;
		this.optionA = optionA;
		this.optionB = optionB;
		this.optionC = optionC;
		this.optionD = optionD;
		this.optionE = optionE;
		this.optionF = optionF;
		this.answer = answer;
		this.analysis = analysis;
		this.score = score;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public LibraryEntity getLibrary() {
		return library;
	}

	public void setLibrary(LibraryEntity library) {
		this.library = library;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOptionA() {
		return optionA;
	}

	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}

	public String getOptionB() {
		return optionB;
	}

	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}

	public String getOptionC() {
		return optionC;
	}

	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}

	public String getOptionD() {
		return optionD;
	}

	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}

	public String getOptionE() {
		return optionE;
	}

	public void setOptionE(String optionE) {
		this.optionE = optionE;
	}

	public String getOptionF() {
		return optionF;
	}

	public void setOptionF(String optionF) {
		this.optionF = optionF;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getAnalysis() {
		return analysis;
	}

	public void setAnalysis(String analysis) {
		this.analysis = analysis;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}
	
}
