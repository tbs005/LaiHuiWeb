package com.cyparty.laihui.controller;

import com.cyparty.laihui.db.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/14.
 */
@Controller
@RequestMapping(value = "/ueditor")
public class UediorController {
    @Autowired
    private FileService fileService;

    /**
     * 文件上传Action
     * @return UEDITOR 需要的json格式数据
     */
    @RequestMapping(value = "/upload.do")
    @ResponseBody
    public Map<String,Object> upload(HttpServletRequest request, @RequestParam("upfile") MultipartFile myfile){
        Map<String,Object> result = new HashMap<String, Object>();
        String fileName = "";
        // 原始文件名   UEDITOR创建页面元素时的alt和title属性
        String originalFileName = "";
        String filePath = "";

        try {
            // 取得文件的原始文件名称
            fileName = myfile.getOriginalFilename();
            originalFileName = fileName;

            if(!fileName.isEmpty()){
                filePath = fileService.uploadFile(request,myfile,"ueditorUpload");
                int index = filePath.lastIndexOf("/");
                fileName = filePath.substring(index,filePath.length());
            } else {
                throw new IOException("文件名为空!");
            }
            result.put("state", "SUCCESS");// UEDITOR的规则:不为SUCCESS则显示state的内容
            result.put("url",filePath);
            result.put("title", originalFileName);
            result.put("original", originalFileName);
        }catch (Exception e) {
            System.out.println(e.getMessage());
            result.put("state", "文件上传失败!");
            result.put("url","");
            result.put("title", "");
            result.put("original", "");
            System.out.println("文件 "+fileName+" 上传失败!");
        }
        return result;
    }
}
