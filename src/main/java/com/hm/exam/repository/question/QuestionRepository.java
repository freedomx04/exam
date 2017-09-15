package com.hm.exam.repository.question;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.QuestionEntity;

public interface QuestionRepository extends PagingAndSortingRepository<QuestionEntity, Long> {
	
	Iterable<QuestionEntity> findByIdIn(List<Long> questionIdList);
	
	Integer countByLibrary(LibraryEntity library);
	
	List<QuestionEntity> findByLibraryOrderByUpdateTimeDesc(LibraryEntity library);
	
	List<QuestionEntity> findByOrderByUpdateTimeDesc();
	
	Page<QuestionEntity> findByOrderByUpdateTimeDesc(Pageable pageable);

}
