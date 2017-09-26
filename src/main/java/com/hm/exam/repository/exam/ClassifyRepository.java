package com.hm.exam.repository.exam;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.exam.ClassifyEntity;

public interface ClassifyRepository extends CrudRepository<ClassifyEntity, Long> {
	
	Iterable<ClassifyEntity> findByIdIn(List<Long> classifyIdList);
	
	ClassifyEntity findByName(String name);

}
