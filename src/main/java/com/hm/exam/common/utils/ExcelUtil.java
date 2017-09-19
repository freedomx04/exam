package com.hm.exam.common.utils;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class ExcelUtil {
	
	static Logger log = LoggerFactory.getLogger(ExcelUtil.class);
	
	private final static String xls = "xls";  
    private final static String xlsx = "xlsx";  
	
	public static void checkFile(MultipartFile file) throws IOException {
		if (null == file) {
			log.error("文件不存在！");
			throw new FileNotFoundException("文件不存在！");
		}
		
		String fileName = file.getOriginalFilename();
		if (!fileName.endsWith(xls) && !fileName.endsWith(xlsx)) {
			log.error(fileName + "不是excel文件");
			throw new IOException(fileName + "不是excel文件");
		}
	}
	
	public static Workbook getWorkBook(MultipartFile file) {
		String fileName = file.getOriginalFilename();
		Workbook workbook = null;
		
		try {
			InputStream is = file.getInputStream();
			if (fileName.endsWith(xls)) {
				workbook = new HSSFWorkbook(is);
			} else if (fileName.endsWith(xlsx)) {
				workbook = new XSSFWorkbook(is);
			}
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
		return workbook;
	}
	
	public static String getCellValue(Cell cell) {
		String cellValue = "";
		if (cell == null) {
			return cellValue;
		}
		
		//把数字当成String来读，避免出现1读成1.0的情况  
		if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
			cell.setCellType(Cell.CELL_TYPE_STRING);
		}
		
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_NUMERIC:
			cellValue = String.valueOf(cell.getNumericCellValue());
			break;
		case Cell.CELL_TYPE_STRING:
			cellValue = String.valueOf(cell.getStringCellValue());
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			cellValue = String.valueOf(cell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_FORMULA:
			cellValue = String.valueOf(cell.getCellFormula());
			break;
		case Cell.CELL_TYPE_BLANK:
			cellValue = null;
			break;
		case Cell.CELL_TYPE_ERROR:
			cellValue = "非法字符";
			break;
		default:
			cellValue = "未知类型";
			break;
		}
		
		return cellValue;
	}

}
