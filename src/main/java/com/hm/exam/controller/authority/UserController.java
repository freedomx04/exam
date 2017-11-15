package com.hm.exam.controller.authority;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.result.ResultInfo;
import com.hm.exam.common.utils.CiphersUtils;
import com.hm.exam.common.utils.CurrentUserUtils;
import com.hm.exam.entity.authority.RoleEntity;
import com.hm.exam.entity.authority.UserEntity;
import com.hm.exam.entity.authority.UserEntity.UserStatus;
import com.hm.exam.service.authority.RoleService;
import com.hm.exam.service.authority.UserService;

@RestController
public class UserController {
	
	static Logger log = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	UserService userService;
	
	@Autowired
	RoleService roleService;
	
	@RequestMapping(value = "/api/user/create", method = RequestMethod.POST)
	public Result create(String username, String password, String name, Long roleId) {
		try {
			UserEntity user = userService.findByUsername(username);
			if (user != null) {
				return new Result(Code.EXISTED.value(), "用户名已存在");
			}
			
			Date now = new Date();
			RoleEntity role = roleService.findOne(roleId);
			user = new UserEntity(username, CiphersUtils.getInstance().MD5Password(password), name, role, now, now);
			userService.save(user);
			return new Result(Code.SUCCESS.value(), "添加成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/update", method = RequestMethod.POST)
	public Result update(Long userId, String name, Long roleId) {
		try {
			RoleEntity role = roleService.findOne(roleId);
			UserEntity user = userService.findOne(userId);
			user.setName(name);
			user.setRole(role);
			user.setUpdateTime(new Date());
			userService.save(user);
			return new Result(Code.SUCCESS.value(), "编辑成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/delete")
	public Result delete(Long userId) {
		try {
			userService.delete(userId);
			return new Result(Code.SUCCESS.value(), "删除成功");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "constraint");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/batchDelete", method = RequestMethod.POST)
	public Result batchDelete(@RequestParam("userIdList[]") List<Long> userIdList) {
		try {
			userService.delete(userIdList);
			return new Result(Code.SUCCESS.value(), "删除成功");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/get")
	public Result get(Long userId) {
		try {
			UserEntity user = userService.findOne(userId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", user);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/list")
	public Result list() {
		try {
			List<UserEntity> userList = userService.list();
			return new ResultInfo(Code.SUCCESS.value(), "ok", userList);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/listByRole")
	public Result listByRole(Long roleId) {
		try {
			List<UserEntity> list = new ArrayList<>();
			if (roleId != 0) {
				RoleEntity role = roleService.findOne(roleId);
				list = userService.listByRole(role);
			} else {
				list = userService.list();
			}
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/login", method = RequestMethod.POST)
	public Result login(String username, String password) {
		try {
			UserEntity user = userService.findByUsername(username);
			
			if (user == null) { 
				return new Result(Code.NULL.value(), "用户不存在"); 
			}
			
			if (user.getStatus() == UserStatus.STATUS_NO_VALID) { 
				return new Result(Code.USER_NO_VALID.value(), "该用户已被禁用");
			}
			
			if (!StringUtils.equals(CiphersUtils.getInstance().MD5Password(password), user.getPassword())) {
				return new Result(Code.USER_PWD_ERROR.value(), "密码错误");
			}
			
			CurrentUserUtils.getInstance().serUser(user);
			return new Result(Code.SUCCESS.value(), "login success");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/logout")
	public Result logout() {
		try {
			CurrentUserUtils.getInstance().removeUser();
			return new Result(Code.SUCCESS.value(), "logout success");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/status") 
	public Result status(Long userId, Integer status) {
		try {
			UserEntity user = userService.findOne(userId);
			user.setStatus(status);
			userService.save(user);
			return new Result(Code.SUCCESS.value(), "修改成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/password", method = RequestMethod.POST)
	public Result password(Long userId, String oldPassword, String newPassword) {
		try {
			UserEntity user = userService.findOne(userId);
			if (!StringUtils.equals(CiphersUtils.getInstance().MD5Password(oldPassword), user.getPassword())) {
				return new Result(Code.USER_PWD_ERROR.value(), "原密码错误");
			}

			user.setPassword(CiphersUtils.getInstance().MD5Password(newPassword));
			userService.save(user);
			return new Result(Code.SUCCESS.value(), "修改成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/user/password2", method = RequestMethod.POST)
	public Result password2(Long userId, String password) {
		try {
			UserEntity user = userService.findOne(userId);
			user.setPassword(CiphersUtils.getInstance().MD5Password(password));
			userService.save(user);
			return new Result(Code.SUCCESS.value(), "修改成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
}
