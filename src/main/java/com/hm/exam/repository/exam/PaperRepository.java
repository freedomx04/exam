package com.hm.exam.repository.exam;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.hm.exam.entity.exam.ClassifyEntity;
import com.hm.exam.entity.exam.PaperEntity;

public interface PaperRepository extends PagingAndSortingRepository<PaperEntity, Long> {
	
	Iterable<PaperEntity> findByIdIn(List<Long> paperIdList);
	
	List<PaperEntity> findByOrderByUpdateTimeDesc();
	
	Integer countByClassify(ClassifyEntity classify);
	
	List<PaperEntity> findByClassifyOrderByUpdateTimeDesc(ClassifyEntity classify);

}
