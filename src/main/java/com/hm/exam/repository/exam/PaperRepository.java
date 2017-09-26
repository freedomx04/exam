package com.hm.exam.repository.exam;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.hm.exam.entity.exam.PaperEntity;

public interface PaperRepository extends PagingAndSortingRepository<PaperEntity, Long> {

}
