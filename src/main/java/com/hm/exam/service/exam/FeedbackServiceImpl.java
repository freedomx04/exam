package com.hm.exam.service.exam;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.exam.FeedbackEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.repository.exam.FeedbackRepository;

@Service
public class FeedbackServiceImpl implements FeedbackService {
	
	@Autowired
	FeedbackRepository feedbackRepository;

	@Override
	public FeedbackEntity findOne(Long feedbackId) {
		return feedbackRepository.findOne(feedbackId);
	}

	@Override
	public void save(FeedbackEntity feedback) {
		feedbackRepository.save(feedback);
	}
	
	@Override
	public void delete(Long feedbackId) {
		feedbackRepository.delete(feedbackId);
	}

	@Override
	public void delete(List<Long> feedbackIdList) {
		Iterable<FeedbackEntity> it = feedbackRepository.findByIdIn(feedbackIdList);
		feedbackRepository.delete(it);
	}

	@Override
	public List<FeedbackEntity> list() {
		return feedbackRepository.findByOrderByUpdateTime();
	}

	@Override
	public List<FeedbackEntity> listByPaper(PaperEntity paper) {
		return feedbackRepository.findByPaperOrderByUpdateTime(paper);
	}

}
