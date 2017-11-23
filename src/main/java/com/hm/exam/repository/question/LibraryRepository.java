package com.hm.exam.repository.question;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.question.LibraryEntity;

public interface LibraryRepository extends CrudRepository<LibraryEntity, Long> {
	
	Iterable<LibraryEntity> findByIdIn(List<Long> libraryIdList);

	LibraryEntity findByName(String name);
	
}
