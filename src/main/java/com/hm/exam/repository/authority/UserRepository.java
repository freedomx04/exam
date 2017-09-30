package com.hm.exam.repository.authority;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.authority.UserEntity;

public interface UserRepository extends CrudRepository<UserEntity, Long> {
	
	UserEntity findByUsername(String username);

}
