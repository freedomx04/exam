package com.hm.exam.entity.authority;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.hm.exam.entity.BaseEntity;

@Entity
@Table(name = "authority_user")
public class UserEntity extends BaseEntity {
	
	private String username;

}
