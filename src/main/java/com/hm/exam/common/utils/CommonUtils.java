package com.hm.exam.common.utils;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CommonUtils {

	static Logger log = LoggerFactory.getLogger(CommonUtils.class);

	/**
	 * 字符串数组转换成长整型数组
	 * 
	 * @param str
	 * @return
	 */
	public static List<Long> convent2Long(String str) {
		List<Long> list = new LinkedList<Long>();
		for (String idStr : StringUtils.split(str, ",")) {
			list.add(Long.parseLong(idStr));
		}
		return list;
	}

	public static String[] chars = new String[] { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
			"o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8",
			"9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
			"U", "V", "W", "X", "Y", "Z" };

	public static String getShortUuid() {
		StringBuffer stringBuffer = new StringBuffer();
		String uuid = UUID.randomUUID().toString().replace("-", "");
		for (int i = 0; i < 8; i++) {
			String str = uuid.substring(i * 4, i * 4 + 4);
			int strInteger = Integer.parseInt(str, 16);
			stringBuffer.append(chars[strInteger % 0x3E]);
		}

		return stringBuffer.toString();
	}
	
	public static String getIcon(String filename) {
		String icon = "fa-file";
		String suffix = filename.substring(filename.lastIndexOf(".") + 1);
		switch (suffix) {
		case "doc":case "docx":
			icon = "fa-file-word-o";
			break;
		case "xls":case "xlsx":
			icon = "fa-file-excel-o";
			break;
		case "pdf":
			icon = "fa-file-pdf-o";
			break;
		case "txt":
			icon = "fa-file-text-o";
			break;
		case "ppt":case "pptx":
			icon = "fa-file-powerpoint-o";
			break;
		case "zip":case "rar":case "z":
			icon = "fa-file-zip-o";
			break;
		case "avi":case "mov":case "mp4":case "rmvb":case "rm":case "wma":
			icon = "fa-file-video-o";
			break;
		case "jpg":case "png":case "bmp":case "tiff":case "gif":case "tif":
			icon = "fa-file-image-o";
			break;
		default:
			break;
		}
		
		return icon;
	}

}
