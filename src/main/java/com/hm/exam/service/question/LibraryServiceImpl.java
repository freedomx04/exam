package com.hm.exam.service.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.repository.question.LibraryRepository;

@Service
public class LibraryServiceImpl implements LibraryService {

	@Autowired
	LibraryRepository libraryRepository;
	
	@Override
	public LibraryEntity findOne(Long libraryId) {
		return libraryRepository.findOne(libraryId);
	}
	
	@Override
	public LibraryEntity findByName(String name) {
		return libraryRepository.findByName(name);
	}

	@Override
	public void save(LibraryEntity library) {
		libraryRepository.save(library);
	}

	@Override
	public void delete(Long libraryId) {
		libraryRepository.delete(libraryId);
	}

	@Override
	public void delete(List<Long> libraryIdList) {
		Iterable<LibraryEntity> it = libraryRepository.findByIdIn(libraryIdList);
		libraryRepository.delete(it);
	}

	@Override
	public List<LibraryEntity> list() {
		return (List<LibraryEntity>) libraryRepository.findAll();
	}

}
