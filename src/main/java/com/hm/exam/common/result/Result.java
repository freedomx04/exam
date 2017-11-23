package com.hm.exam.common.result;

public class Result {
	
	/**
	 * 返回的状态码
	 */
	protected int code;
	
	/**
	 * 返回的信息
	 */
	protected String msg;
	
	public Result() {
		// TODO Auto-generated constructor stub
	}
	
	public Result(int code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
