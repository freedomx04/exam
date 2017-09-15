package com.hm.exam.common.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hm.exam.entity.authority.UserEntity;

public class CurrentUserUtils {

	private final String CUR_USER = "cur_user";
	public static CurrentUserUtils INSTANCE = null;

	private CurrentUserUtils() {
		// TODO Auto-generated constructor stub
	}

	public static CurrentUserUtils getInstance() {
		if (INSTANCE == null) {
			synchronized (CurrentUserUtils.class) {
				if (INSTANCE == null) {
					INSTANCE = new CurrentUserUtils();
				}
			}
		}
		return INSTANCE;
	}

	private HttpServletRequest getRequest() {
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes();
		return requestAttributes.getRequest();
	}

	private HttpSession getSession() {
		return getRequest().getSession(true);
	}

	public UserEntity getUser() {
		return (UserEntity) getSession().getAttribute(CUR_USER);
	}

	public void serUser(UserEntity user) {
		getSession().setAttribute(CUR_USER, user);
	}

	public void removeUser() {
		getSession().removeAttribute(CUR_USER);
	}
	
}
