package com.hm.exam.repository.student;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.entity.student.StudentEntity;

public interface StudentRepository extends PagingAndSortingRepository<StudentEntity, Long> {
	
	Iterable<StudentEntity> findByIdIn(List<Long> studentIdList);
	
	StudentEntity findByUsername(String username);
	
	Integer countByGroup(GroupEntity group);
	
	List<StudentEntity> findByOrderByUpdateTimeDesc();
	
	Page<StudentEntity> findByOrderByUpdateTimeDesc(Pageable pageable);
	
	List<StudentEntity> findByGroupOrderByUpdateTimeDesc(GroupEntity group);

}
