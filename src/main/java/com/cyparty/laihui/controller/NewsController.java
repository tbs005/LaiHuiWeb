package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.News;
import com.cyparty.laihui.utilities.OssConfigure;
import com.cyparty.laihui.utilities.OssUtil;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 新闻管理
 * Created by YangGuang on 2017/6/6.
 */
@Controller
public class NewsController {

    private boolean is_logined;

    @Autowired
    private LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;
    @Autowired
    OssConfigure ossConfigure;

    @RequestMapping("/db/news/manage")
    public String db_validate(Model model, HttpServletRequest request) {
        is_logined = Utils.isLogined(request);
        if (is_logined) {
            return "news_manage_list";
        } else {
            model.asMap().clear();
            return "redirect:/db/login";
        }

    }

    /**
     * 查询列表
     */
    @ResponseBody
    @RequestMapping(value = "/news/list",method = RequestMethod.POST)
    public ResponseEntity<String> newsList(HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject pageJson = new JSONObject();
        String json = "";
        int page = Integer.parseInt(request.getParameter("page"));
        int size = Integer.parseInt(request.getParameter("size")!=null?  request.getParameter("size"): "10");
        String where = " where a.isDel = 1 and b.is_enable = 1 order by a.create_time desc limit " + page*size + "," + size;
        List<News> newsList = laiHuiDB.selectNewsByPage(where);
        String count_where = " where a.isDel = 1 and b.is_enable = 1";
        int count = laiHuiDB.selectNewsCount(count_where);
        if (newsList.size() > 0){
            pageJson.put("result",newsList);
            pageJson.put("page",page);
            pageJson.put("size",size);
            pageJson.put("totalCount",count);
            json = pageJson.toJSONString();
        }
        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
    }

    /**
     * 跳转新增页面
     */
    @RequestMapping("/news/toAdd")
    public String toAdd(News news,Model model){
        String where = " where is_enable = 1";
        List<News> typeList = laiHuiDB.selectNewsTypeList(where);
        model.addAttribute("news",news);
        model.addAttribute("typeList",typeList);
        return "news_manage_add";
    }

    /**
     *  新增新闻
     */
    @RequestMapping("news/add")
    public String add(News news,HttpServletRequest request){
        String filePath = Utils.fileImgUpload("img", request);
        if (filePath != null && !filePath.trim().equals("")) {
            String image_local = filePath.substring(filePath.indexOf("upload"));
            String arr[] = image_local.split("\\\\");
            String image_oss = arr[arr.length - 1];
            try {
                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                    image_oss = "https://"+ ossConfigure.getAccessUrl() + image_oss;
                    news.setImage(image_oss);
                }
            } catch (Exception e) {
                image_oss = null;
                news.setImage(image_oss);
            }
        }
        laiHuiDB.insertNews(news);
        return "redirect:/db/news/manage";
    }

    /**
     * 跳转编辑页面
     */
    @RequestMapping("/news/toUpdate")
    public String toUpdate(Model model,HttpServletRequest request){
        String where = " where is_enable = 1";
        List<News> typeList = laiHuiDB.selectNewsTypeList(where);
        String where1 = " where a._id = " + request.getParameter("id");
        List<News> newsList = laiHuiDB.selectNewsByPage(where1);
        model.addAttribute("news",newsList.get(0));
        model.addAttribute("typeList",typeList);
        return "news_manage_update";
    }

    /**
     *  编辑新闻
     */
    @RequestMapping("news/update")
    public String update(News news,HttpServletRequest request){
        String filePath = Utils.fileImgUpload("img", request);
        String where = "";
        if (filePath != null && !filePath.trim().equals("")) {
            String image_local = filePath.substring(filePath.indexOf("upload"));
            String arr[] = image_local.split("\\\\");
            String image_oss = arr[arr.length - 1];
            try {
                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                    image_oss = "https://"+ ossConfigure.getAccessUrl() + image_oss;
                    news.setImage(image_oss);
                }
            } catch (Exception e) {
                image_oss = null;
                news.setImage(image_oss);
            }
            where = " set title = '" + news.getTitle() + "',description = '" + news.getDescription() + "',image = '" +
                    news.getImage() + "',content = '" + news.getContent() + "',update_time = '" + Utils.getCurrentTime() +
                    "',type = "+news.getType()+" where _id = " + news.getId();
        }else {
            where = " set title = '" + news.getTitle() + "',description = '" + news.getDescription() +
                    "',content = '" + news.getContent() + "',update_time = '" + Utils.getCurrentTime() +
                    "',type = "+news.getType()+" where _id = " + news.getId();
        }
        laiHuiDB.update("pc_news",where);
        return "redirect:/db/news/manage";
    }

    /**
     * 删除新闻
     */
    @RequestMapping("/news/delete")
    public String delete(HttpServletRequest request){
        String where = " set isDel = 0 where _id = " + request.getParameter("id");
        laiHuiDB.update("pc_news",where);
        return "redirect:/db/news/manage";
    }

    /**
     * 富文本上传图片
     */
    @ResponseBody
    @RequestMapping("/news/upload")
    public String uploadPhoto(HttpServletRequest request){
        String filePath = Utils.fileImgUpload("myFileName", request);
        String image_oss = "";
        if (filePath != null && !filePath.trim().equals("")) {
            String image_local = filePath.substring(filePath.indexOf("upload"));
            String arr[] = image_local.split("\\\\");
            image_oss = arr[arr.length - 1];
            try {
                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                    image_oss = "https://"+ ossConfigure.getAccessUrl() + image_oss;
                }
            } catch (Exception e) {
                image_oss = null;
            }
        }
        return image_oss;
    }
}
