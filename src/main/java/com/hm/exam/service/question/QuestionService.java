package com.hm.exam.service.question;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.QuestionEntity;

public interface QuestionService {
	
	QuestionEntity findOne(Long questionId);
	
	void save(QuestionEntity question);
	
	void delete(Long questionId);
	
	void delete(List<Long> questionIdList);
	
	List<QuestionEntity> list();
	
	Page<QuestionEntity> list(int page, int size);
	
	Integer countByLibrary(LibraryEntity library);
	
	List<QuestionEntity> listByLibrary(LibraryEntity library);
	
	List<QuestionEntity> listByType(Integer type);
	
	List<QuestionEntity> listByLibraryAndType(LibraryEntity library, Integer type);

}
