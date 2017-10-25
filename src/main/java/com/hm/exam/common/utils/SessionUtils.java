package com.hm.exam.common.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hm.exam.entity.student.StudentEntity;

public class SessionUtils {

	private static final String CUR_STUDENT = "cur_student";

	public static HttpServletRequest getRequest() {
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes();
		return requestAttributes.getRequest();
	}

	public static HttpSession getSession() {
		return getRequest().getSession(true);
	}

	public static StudentEntity getStudent() {
		return (StudentEntity) getSession().getAttribute(CUR_STUDENT);
	}

	public static void setStudent(StudentEntity student) {
		getSession().setAttribute(CUR_STUDENT, student);
	}

	public static void removeStudent() {
		getSession().removeAttribute(CUR_STUDENT);
	}

}
