package com.hm.exam.service.exam;

import java.util.List;

import com.hm.exam.entity.exam.FeedbackEntity;
import com.hm.exam.entity.exam.PaperEntity;

public interface FeedbackService {
	
	FeedbackEntity findOne(Long feedbackId);
	
	void save(FeedbackEntity feedback);
	
	void delete(Long feedbackId);
	
	void delete(List<Long> feedbackIdList);
	
	List<FeedbackEntity> list();
	
	List<FeedbackEntity> listByPaper(PaperEntity paper);

}
