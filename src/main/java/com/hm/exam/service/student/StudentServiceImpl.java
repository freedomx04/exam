package com.hm.exam.service.student;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.repository.student.StudentRepository;

@Service
public class StudentServiceImpl implements StudentService {
	
	@Autowired
	StudentRepository studentRepository;

	@Override
	public StudentEntity findOne(Long studentId) {
		return studentRepository.findOne(studentId);
	}
	
	@Override
	public StudentEntity findByUsername(String username) {
		return studentRepository.findByUsername(username);
	}

	@Override
	public void save(StudentEntity student) {
		studentRepository.save(student);
	}

	@Override
	public void delete(Long studentId) {
		studentRepository.delete(studentId);
	}

	@Override
	public void delete(List<Long> studentIdList) {
		Iterable<StudentEntity> it = studentRepository.findByIdIn(studentIdList);
		studentRepository.delete(it);
	}

	@Override
	public List<StudentEntity> list() {
		return (List<StudentEntity>) studentRepository.findByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<StudentEntity> list(int page, int size) {
		return studentRepository.findByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public Integer countByGroup(GroupEntity group) {
		return studentRepository.countByGroup(group);
	}

	@Override
	public List<StudentEntity> listByGroup(GroupEntity group) {
		return studentRepository.findByGroupOrderByUpdateTimeDesc(group);
	}

}
