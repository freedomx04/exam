package com.hm.exam.common.utils;

import java.security.MessageDigest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CiphersUtils {

	static Logger log = LoggerFactory.getLogger(CiphersUtils.class);

	public static CiphersUtils INSTANCE = null;

	public CiphersUtils() {
		// TODO Auto-generated constructor stub
	}

	public static CiphersUtils getInstance() {
		if (INSTANCE == null) {
			synchronized (CiphersUtils.class) {
				if (INSTANCE == null) {
					INSTANCE = new CiphersUtils();
				}
			}
		}
		return INSTANCE;
	}

	public String MD5Password(String pwd) {
		String salt = ConfigUtils.get("customize.salt");
		pwd = pwd + salt;
		MessageDigest md5 = null;
		
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		
		char[] charArray = pwd.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++) {
			byteArray[i] = (byte) charArray[i];
		}
			
		byte[] md5Bytes = md5.digest(byteArray);
		StringBuffer hexValue = new StringBuffer();
		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16) {
				hexValue.append("0");
			}
			hexValue.append(Integer.toHexString(val));
		}
		
		return hexValue.toString();
	}

}
