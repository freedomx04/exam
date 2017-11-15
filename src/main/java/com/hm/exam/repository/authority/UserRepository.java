package com.hm.exam.repository.authority;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.authority.RoleEntity;
import com.hm.exam.entity.authority.UserEntity;

public interface UserRepository extends CrudRepository<UserEntity, Long> {
	
	Iterable<UserEntity> findByIdIn(List<Long> userIdList);
	
	UserEntity findByUsername(String username);
	
	List<UserEntity> findByRole(RoleEntity role);

}
