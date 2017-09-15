package com.hm.exam.service.student;

import java.util.List;

import com.hm.exam.entity.student.GroupEntity;

public interface GroupService {
	
	GroupEntity findOne(Long groupId);
	
	GroupEntity findByName(String name);
	
	void save(GroupEntity group);
	
	void delete(Long groupId);
	
	void delete(List<Long> groupIdList);
	
	List<GroupEntity> list();

}
