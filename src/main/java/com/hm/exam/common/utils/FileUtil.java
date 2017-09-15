package com.hm.exam.common.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Path;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FileUtil {

    static Log log = LogFactory.getLog(FileUtil.class);
    
    public static void writeInfo(File file, String data, boolean append) throws IOException {
        FileWriter fw = null;
        BufferedWriter bw = null;
        
        if (!file.exists()) {
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }
            file.createNewFile();
        }
        try {
            fw = new FileWriter(file, append);
            bw = new BufferedWriter(fw);
            bw.write(data);
            bw.newLine();
            bw.flush();
        } finally {
            bw.close();
            fw.close();
        }
    }
    
    public static void makeDirs(Path path) {
        File file = path.toFile();
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
    }
    
    public static void sureDirExists(File file, boolean parent) throws IOException {
        File dir = parent ? file.getParentFile() : file;
        if (!dir.exists()) {
            if (!dir.mkdirs()) {
                throw new IOException("create folder failed: " + dir);
            }
        }
    }
    
    public static String getSuffix(String filename) {
    	return filename.substring(filename.lastIndexOf("."));
    }
    
}