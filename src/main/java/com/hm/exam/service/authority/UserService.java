package com.hm.exam.service.authority;

import java.util.List;

import com.hm.exam.entity.authority.UserEntity;

public interface UserService {
	
	UserEntity findOne(Long userId);
	
	UserEntity findByUsername(String username);
	
	void save(UserEntity user);
	
	void delete(Long userId);
	
	List<UserEntity> list();

}
