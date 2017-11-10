package com.hm.exam.service.question;

import java.util.List;

import com.hm.exam.entity.question.LibraryEntity;

public interface LibraryService {

	LibraryEntity findOne(Long libraryId);
	
	LibraryEntity findByName(String name);
	
	LibraryEntity save(LibraryEntity library);
	
	void delete(Long libraryId);
	
	void delete(List<Long> libraryIdList);
	
	List<LibraryEntity> list();
	
}
