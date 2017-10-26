package com.hm.exam.repository.exam;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.exam.ExamEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.student.StudentEntity;

public interface ExamRepository extends CrudRepository<ExamEntity, Long> {
	
	ExamEntity findByPaperAndStudent(PaperEntity paper, StudentEntity student);
	
}
