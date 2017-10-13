package com.hm.exam.service.exam;

import java.util.List;

import com.hm.exam.entity.exam.ExamEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.student.StudentEntity;

public interface ExamService {
	
	ExamEntity findOne(Long examId);
	
	ExamEntity findOne(PaperEntity paper, StudentEntity student);
	
	void save(ExamEntity exam);
	
	void delete(Long examId);
	
	List<ExamEntity> listByPaper(PaperEntity paper);
	
	List<ExamEntity> listByStudent(StudentEntity student);

}
