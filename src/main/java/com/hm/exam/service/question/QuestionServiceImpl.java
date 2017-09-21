package com.hm.exam.service.question;

import java.math.BigInteger;
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
	public Integer countByType(Integer type) {
		return questionRepository.countByType(type);
	}

	@Override
	public List<QuestionEntity> listByLibrary(LibraryEntity library) {
		return questionRepository.findByLibraryOrderByUpdateTimeDesc(library);
	}

	@Override
	public List<QuestionEntity> listByType(Integer type) {
		return questionRepository.findByTypeOrderByUpdateTimeDesc(type);
	}

	@Override
	public List<QuestionEntity> listByLibraryAndType(LibraryEntity library, Integer type) {
		return questionRepository.findByLibraryAndTypeOrderByUpdateTimeDesc(library, type);
	}

	@Override
	public Integer getType(String typeStr) {
		Integer type = 0;
		
		switch (typeStr) {
		case "单选题":		type = 1;	break;
		case "多选题":		type = 2;	break;
		case "判断题":		type = 3;	break;
		default:		type = 0;	break;
		}
		
		return type;
	}

	@Override
	public List<BigInteger> listId() {
		return questionRepository.listId();
	}

	@Override
	public List<BigInteger> listIdByLibraryId(Long libraryId) {
		return questionRepository.listIdByLibraryId(libraryId);
	}

	@Override
	public List<BigInteger> listIdByType(Integer type) {
		return questionRepository.listIdByType(type);
	}

}
