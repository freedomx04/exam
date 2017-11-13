package com.hm.exam.service.exam;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.exam.ClassifyEntity;
import com.hm.exam.repository.exam.ClassifyRepository;

@Service
public class ClassifyServiceImpl implements ClassifyService {
	
	@Autowired
	ClassifyRepository classifyRepository;

	@Override
	public ClassifyEntity findOne(Long classifyId) {
		return classifyRepository.findOne(classifyId);
	}

	@Override
	public ClassifyEntity findByName(String name) {
		return classifyRepository.findByName(name);
	}

	@Override
	public ClassifyEntity save(ClassifyEntity classify) {
		return classifyRepository.save(classify);
	}

	@Override
	public void delete(Long classifyId) {
		classifyRepository.delete(classifyId);
	}

	@Override
	public void delete(List<Long> classifyIdList) {
		Iterable<ClassifyEntity> it = classifyRepository.findByIdIn(classifyIdList);
		classifyRepository.delete(it);
	}

	@Override
	public List<ClassifyEntity> list() {
		return (List<ClassifyEntity>) classifyRepository.findAll();
	}

}
