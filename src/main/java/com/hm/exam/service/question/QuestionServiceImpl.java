package com.hm.exam.service.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.QuestionEntity;
import com.hm.exam.repository.question.QuestionRepository;

@Service
public class QuestionServiceImpl implements QuestionService {
	
	@Autowired
	QuestionRepository questionRepository;

	@Override
	public QuestionEntity findOne(Long questionId) {
		return questionRepository.findOne(questionId);
	}

	@Override
	public void save(QuestionEntity question) {
		questionRepository.save(question);
	}

	@Override
	public void delete(Long questionId) {
		questionRepository.delete(questionId);
	}

	@Override
	public void delete(List<Long> questionIdList) {
		Iterable<QuestionEntity> it = questionRepository.findByIdIn(questionIdList);
		questionRepository.delete(it);
	}

	@Override
	public List<QuestionEntity> list() {
		return (List<QuestionEntity>) questionRepository.findByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<QuestionEntity> list(int page, int size) {
		return questionRepository.findByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

	@Override
	public Integer countByLibrary(LibraryEntity library) {
		return questionRepository.countByLibrary(library);
	}

	@Override
	public List<QuestionEntity> listByLibrary(LibraryEntity library) {
		return questionRepository.findByLibraryOrderByUpdateTimeDesc(library);
	}

}
