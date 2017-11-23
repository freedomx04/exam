package com.hm.exam.service.system;

import java.util.List;

import com.hm.exam.entity.system.NoticeEntity;

public interface NoticeService {
	
	NoticeEntity findOne(Long noticeId);
	
	void save(NoticeEntity notice);
	
	void delete(Long noticeId);
	
	void delete(List<Long> noticeIdList);
	
	List<NoticeEntity> list();

}
