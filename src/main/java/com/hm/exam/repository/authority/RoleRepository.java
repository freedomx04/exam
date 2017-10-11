package com.hm.exam.repository.authority;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.exam.entity.authority.RoleEntity;

public interface RoleRepository extends CrudRepository<RoleEntity, Long> {
	
	Iterable<RoleEntity> findByIdIn(List<Long> roleIdList);
	
	RoleEntity findByName(String name);

}
