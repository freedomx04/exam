package com.hm.exam.repository.exam;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.exam.FeedbackEntity;
import com.hm.exam.entity.exam.PaperEntity;

public interface FeedbackRepository extends CrudRepository<FeedbackEntity, Long> {
	
	Iterable<FeedbackEntity> findByIdIn(List<Long> feedbackIdList);
	
	List<FeedbackEntity> findByOrderByUpdateTime();
	
	List<FeedbackEntity> findByPaperOrderByUpdateTime(PaperEntity paper);

}
