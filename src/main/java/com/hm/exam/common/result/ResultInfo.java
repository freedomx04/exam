package com.hm.exam.common.result;

public class ResultInfo extends Result {
	
	/**
	 * 返回的数据
	 */
	private Object data;
	
	public ResultInfo() {
		// TODO Auto-generated constructor stub
	}
	
	public ResultInfo(int code, String msg, Object data) {
		this.code = code;
		this.msg = msg;
		this.data = data;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
	
}
