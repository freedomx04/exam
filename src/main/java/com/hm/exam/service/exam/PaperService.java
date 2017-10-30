package com.hm.exam.service.exam;

import java.util.List;

import com.hm.exam.entity.exam.ClassifyEntity;
import com.hm.exam.entity.exam.PaperEntity;

public interface PaperService {
	
	PaperEntity findOne(Long paperId);
	
	void save(PaperEntity paper);
	
	void delete(Long paperId);
	
	List<PaperEntity> list();
	
	Integer countByClassify(ClassifyEntity classify);
	
	List<PaperEntity> listByClassify(ClassifyEntity classify);

}
