package com.hm.exam.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hm.exam.common.PathFormat;
import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.result.ResultInfo;
import com.hm.exam.common.utils.FileUtil;

@RestController
public class CommonController {
	
	static Logger log = LoggerFactory.getLogger(CommonController.class);
	
	@Value("${customize.path.upload}")
    private String uploadPath;
	
	@Value("${customize.path.image}")
    private String imageFormat;
	
	@RequestMapping(value = "/api/uploadImage", method = RequestMethod.POST)
	public Result uploadImage(MultipartFile imageFile) {
		try {
			if (imageFile == null) {
				return null;
			}
			
			String filename = imageFile.getOriginalFilename();
			String suffix = FileUtil.getSuffix(filename);
			
			String tarPath = imageFormat + suffix;
			tarPath = PathFormat.parse(tarPath);
			
			File file = Paths.get(uploadPath, tarPath).toFile();
			FileUtil.sureDirExists(file, true);
			
			BufferedOutputStream bout = new BufferedOutputStream(new FileOutputStream(file));
            bout.write(imageFile.getBytes());
            bout.close();
			
			return new ResultInfo(Code.SUCCESS.value(), "upload", tarPath);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
            return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
