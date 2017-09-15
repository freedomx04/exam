package com.hm.exam.repository.student;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.student.GroupEntity;

public interface GroupRepository extends CrudRepository<GroupEntity, Long> {
	
	Iterable<GroupEntity> findByIdIn(List<Long> groupIdList);
	
	GroupEntity findByName(String name);

}
