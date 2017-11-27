package com.hm.exam.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hm.exam.entity.system.NoticeEntity;
import com.hm.exam.repository.system.NoticeRepository;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeRepository noticeRepository;
	
	@Override
	public NoticeEntity findOne(Long noticeId) {
		return noticeRepository.findOne(noticeId);
	}
	
	@Override
	public NoticeEntity findLastest() {
		List<NoticeEntity> list = noticeRepository.findByOrderByUpdateTimeDesc();
		if (list.size() > 0) {
			return list.get(0);
		}
		return null;
	}
	

	@Override
	public void save(NoticeEntity notice) {
		noticeRepository.save(notice);
	}

	@Override
	public void delete(Long noticeId) {
		noticeRepository.delete(noticeId);
	}

	@Override
	public void delete(List<Long> noticeIdList) {
		Iterable<NoticeEntity> it = noticeRepository.findByIdIn(noticeIdList);
		noticeRepository.delete(it);
	}

	@Override
	public List<NoticeEntity> list() {
		return noticeRepository.findByOrderByUpdateTimeDesc();
	}

}
