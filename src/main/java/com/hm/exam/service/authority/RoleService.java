package com.hm.exam.service.authority;

import java.util.List;

import com.hm.exam.entity.authority.RoleEntity;

public interface RoleService {

	RoleEntity findOne(Long roleId);

	RoleEntity findByName(String name);

	void save(RoleEntity role);

	void delete(Long roleId);

	void delete(List<Long> roleIdList);

	List<RoleEntity> list();

}
