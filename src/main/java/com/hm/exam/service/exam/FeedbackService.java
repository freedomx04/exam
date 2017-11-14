package com.hm.exam.service.exam;

import java.util.List;

import com.hm.exam.entity.exam.FeedbackEntity;

public interface FeedbackService {
	
	FeedbackEntity findOne(Long feedbackId);
	
	void save(FeedbackEntity feedback);
	
	void delete(Long feedbackId);
	
	void delete(List<Long> feedbackIdList);
	
	List<FeedbackEntity> list();
	
	List<FeedbackEntity> listByPaperId(Long paperId);

}
