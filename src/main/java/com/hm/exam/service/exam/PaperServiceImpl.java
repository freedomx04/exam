package com.hm.exam.service.exam;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.repository.exam.PaperRepository;

@Service
public class PaperServiceImpl implements PaperService {
	
	@Autowired
	PaperRepository paperRepository;

	@Override
	public PaperEntity findOne(Long paperId) {
		return paperRepository.findOne(paperId);
	}

	@Override
	public void save(PaperEntity paper) {
		paperRepository.save(paper);
	}

	@Override
	public void delete(Long paperId) {
		paperRepository.delete(paperId);
	}

	@Override
	public List<PaperEntity> list() {
		return paperRepository.findByOrderByUpdateTimeDesc();
	}

}
