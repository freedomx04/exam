package com.hm.exam.service.exam;

import java.util.List;

import com.hm.exam.entity.exam.ClassifyEntity;

public interface ClassifyService {
	
	ClassifyEntity findOne(Long classifyId);
	
	ClassifyEntity findByName(String name);
	
	void save(ClassifyEntity classify);
	
	void delete(Long classifyId);
	
	void delete(List<Long> classifyIdList);
	
	List<ClassifyEntity> list();

}
