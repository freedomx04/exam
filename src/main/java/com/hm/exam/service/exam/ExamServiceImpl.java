package com.hm.exam.service.exam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.exam.ExamEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.repository.exam.ExamRepository;

@Service
public class ExamServiceImpl implements ExamService {

	@Autowired
	ExamRepository examRepository;

	@Override
	public ExamEntity findOne(Long examId) {
		return examRepository.findOne(examId);
	}
	
	@Override
	public ExamEntity findOne(PaperEntity paper, StudentEntity student) {
		return examRepository.findByPaperAndStudent(paper, student);
	}

	@Override
	public void save(ExamEntity exam) {
		examRepository.save(exam);
	}

	@Override
	public void delete(Long examId) {
		examRepository.delete(examId);
	}

}
