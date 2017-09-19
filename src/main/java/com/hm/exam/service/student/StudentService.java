package com.hm.exam.service.student;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.entity.student.StudentEntity;

public interface StudentService {

	StudentEntity findOne(Long studentId);
	
	StudentEntity findByUsername(String username);
	
	void save(StudentEntity student);
	
	void delete(Long studentId);
	
	void delete(List<Long> studentIdList);
	
	List<StudentEntity> list();
	
	Page<StudentEntity> list(int page, int size);
	
	Integer countByGroup(GroupEntity group);
	
	List<StudentEntity> listByGroup(GroupEntity group);
	
}
