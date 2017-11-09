package com.hm.exam.controller.student;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.result.ResultInfo;
import com.hm.exam.common.utils.CiphersUtils;
import com.hm.exam.common.utils.ExcelUtil;
import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.student.GroupService;
import com.hm.exam.service.student.StudentService;

@RestController
public class StudentController {

	static Logger log = LoggerFactory.getLogger(StudentController.class);

	@Autowired
	GroupService groupService;

	@Autowired
	StudentService studentService;

	@RequestMapping(value = "/api/student/create", method = RequestMethod.POST)
	public Result create(Long groupId, String username, String name, String password) {
		try {
			StudentEntity student = studentService.findByUsername(username.trim());
			if (student != null) {
				return new Result(Code.EXISTED.value(), "考生已存在");
			}
			
			Date now = new Date();
			GroupEntity group = groupService.findOne(groupId);
			student = new StudentEntity(group, username, CiphersUtils.getInstance().MD5Password(password), name, now, now);
			studentService.save(student);
			return new Result(Code.SUCCESS.value(), "添加成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/update", method = RequestMethod.POST)
	public Result update(Long studentId, Long groupId, String name) {
		try {
			GroupEntity group = groupService.findOne(groupId);
			StudentEntity student = studentService.findOne(studentId);
			student.setGroup(group);
			student.setName(name);
			student.setUpdateTime(new Date());
			studentService.save(student);
			return new Result(Code.SUCCESS.value(), "编辑成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/password", method = RequestMethod.POST)
	public Result password2(Long studentId, String password) {
		try {
			StudentEntity student = studentService.findOne(studentId);
			student.setPassword(CiphersUtils.getInstance().MD5Password(password));
			studentService.save(student);
			return new Result(Code.SUCCESS.value(), "修改成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/delete")
	public Result delete(Long studentId) {
		try {
			studentService.delete(studentId);
			return new Result(Code.SUCCESS.value(), "删除成功");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/student/batchDelete", method = RequestMethod.POST)
	public Result batchDelete(@RequestParam("studentIdList[]") List<Long> studentIdList) {
		try {
			studentService.delete(studentIdList);
			return new Result(Code.SUCCESS.value(), "删除成功");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/get")
	public Result get(Long studentId) {
		try {
			StudentEntity student = studentService.findOne(studentId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", student);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/list")
	public Result list(Long groupId) {
		try {
			List<StudentEntity> list = new ArrayList<>();
			if (groupId != 0) {
				GroupEntity group = groupService.findOne(groupId);
				list = studentService.listByGroup(group);
			} else {
				list = studentService.list();
			}
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/student/listPaging")
	public Result listPaging(int page, int size) {
		try {
			Page<StudentEntity> studentPage = studentService.list(page, size);
			return new ResultInfo(Code.SUCCESS.value(), "ok", studentPage);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/listByGroup")
	public Result listByGroup(Long groupId) {
		try {
			GroupEntity group = groupService.findOne(groupId);
			List<StudentEntity> list = studentService.listByGroup(group);
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/move", method = RequestMethod.POST)
	public Result move(@RequestParam("studentIdList[]") List<Long> studentIdList, Long groupId) {
		try {
			GroupEntity group = groupService.findOne(groupId);
			for (Long studentId: studentIdList) {
				StudentEntity student = studentService.findOne(studentId);
				student.setGroup(group);
				student.setUpdateTime(new Date());
				studentService.save(student); 
			}
			
			return new Result(Code.SUCCESS.value(), "移动成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping(value = "/api/student/template")
	public ResponseEntity<InputStreamResource> template() {
        try {
            String root = request.getSession().getServletContext().getRealPath("/");
            File file = new File(root + "/resource/student-template.xlsx");
            String fileName = "考生导入模板.xlsx";

            HttpHeaders headers = new HttpHeaders();
            headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
            headers.add("Content-Disposition",
                            String.format("attachment; filename=\"%s\"", new String(fileName.getBytes("UTF-8"), "ISO8859-1")));
            headers.add("Pragma", "no-cache");
            headers.add("Expires", "0");

            return ResponseEntity.ok().headers(headers).contentLength(file.length())
            		.contentType(MediaType.parseMediaType("application/octet-stream"))
            		.body(new InputStreamResource(new FileInputStream(file)));
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
	}
	
	@RequestMapping(value = "/api/student/import")
	public Result import2(MultipartFile file) {
		try {
			// 检查文件
            ExcelUtil.checkFile(file);
            Workbook workbook = ExcelUtil.getWorkBook(file);
            Sheet sheet = workbook.getSheetAt(0);
			
			// 成功导入考生数目标识
            int success = 0;
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            	Row row = sheet.getRow(i);
            	if (row == null) {
            		continue;
            	}
            	
            	String groupName = ExcelUtil.getCellValue(row.getCell(0));
            	if (StringUtils.isEmpty(groupName)) {
            		continue;
            	}
            	GroupEntity group = groupService.findByName(groupName);
            	if (group == null) {
            		Date now = new Date();
            		group = new GroupEntity(groupName, now, now);
            		groupService.save(group);
            	}
            	
            	String username = ExcelUtil.getCellValue(row.getCell(1));
            	StudentEntity student = studentService.findByUsername(username);
            	String password = ExcelUtil.getCellValue(row.getCell(2));
            	String name = ExcelUtil.getCellValue(row.getCell(3));
            			
            	if (student == null) {
            		Date now = new Date();
            		student = new StudentEntity(group, username, CiphersUtils.getInstance().MD5Password(password), name, now, now);
            		studentService.save(student);
            	} else {
            		student.setGroup(group);
            		student.setPassword(CiphersUtils.getInstance().MD5Password(password));
            		student.setName(name);
            		student.setUpdateTime(new Date());
            		studentService.save(student);
            	}
            	success++;
            }
			
			return new Result(Code.SUCCESS.value(), "成功导入" + success + "个考生");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
            return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
