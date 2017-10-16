package com.hm.exam.service.exam;

import com.hm.exam.entity.exam.ExamEntity;

public interface ExamService {
	
	ExamEntity findOne(Long examId);
	
	void save(ExamEntity exam);
	
	void delete(Long examId);

}
