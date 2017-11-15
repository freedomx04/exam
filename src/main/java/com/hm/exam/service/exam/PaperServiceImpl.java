package com.hm.exam.service.exam;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.exam.ClassifyEntity;
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
	public void delete(List<Long> paperIdList) {
		Iterable<PaperEntity> it = paperRepository.findByIdIn(paperIdList);
		paperRepository.delete(it);
	}

	@Override
	public List<PaperEntity> list() {
		return paperRepository.findByOrderByUpdateTimeDesc();
	}

	@Override
	public Integer countByClassify(ClassifyEntity classify) {
		return paperRepository.countByClassify(classify);
	}

	@Override
	public List<PaperEntity> listByClassify(ClassifyEntity classify) {
		return paperRepository.findByClassifyOrderByUpdateTimeDesc(classify);
	}

}
