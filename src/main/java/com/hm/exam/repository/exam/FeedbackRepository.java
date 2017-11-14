package com.hm.exam.repository.exam;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.exam.FeedbackEntity;

public interface FeedbackRepository extends CrudRepository<FeedbackEntity, Long> {
	
	Iterable<FeedbackEntity> findByIdIn(List<Long> feedbackIdList);
	
	List<FeedbackEntity> findByOrderByUpdateTime();
	
	List<FeedbackEntity> findByPaperIdOrderByUpdateTime(Long paperId);

}
