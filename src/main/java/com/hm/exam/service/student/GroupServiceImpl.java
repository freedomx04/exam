package com.hm.exam.service.student;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.repository.student.GroupRepository;

@Service
public class GroupServiceImpl implements GroupService {
	
	@Autowired
	GroupRepository groupRepository;

	@Override
	public GroupEntity findOne(Long groupId) {
		return groupRepository.findOne(groupId);
	}
	
	@Override
	public GroupEntity findByName(String name) {
		return groupRepository.findByName(name);
	}

	@Override
	public void save(GroupEntity group) {
		groupRepository.save(group);
	}

	@Override
	public void delete(Long groupId) {
		groupRepository.delete(groupId);
	}

	@Override
	public void delete(List<Long> groupIdList) {
		Iterable<GroupEntity> it = groupRepository.findByIdIn(groupIdList);
		groupRepository.delete(it);
	}

	@Override
	public List<GroupEntity> list() {
		return (List<GroupEntity>) groupRepository.findAll();
	}

}
