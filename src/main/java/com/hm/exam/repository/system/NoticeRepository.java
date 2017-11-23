package com.hm.exam.repository.system;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.system.NoticeEntity;

public interface NoticeRepository extends CrudRepository<NoticeEntity, Long> {
	
	Iterable<NoticeEntity> findByIdIn(List<Long> noticeIdList);
	
	List<NoticeEntity> findByOrderByUpdateTimeDesc();

}
