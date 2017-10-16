package com.hm.exam.repository.exam;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.exam.ExamEntity;

public interface ExamRepository extends CrudRepository<ExamEntity, Long> {
	
}
