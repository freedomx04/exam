package com.hm.exam.repository.exam;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.hm.exam.entity.exam.PaperEntity;

public interface PaperRepository extends PagingAndSortingRepository<PaperEntity, Long> {
	
	List<PaperEntity> findByOrderByUpdateTimeDesc();

}
