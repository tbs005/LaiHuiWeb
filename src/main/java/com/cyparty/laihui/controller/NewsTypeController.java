package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.News;
import com.cyparty.laihui.domain.NewsType;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 新闻类型
 * Created by YangGuang on 2017/6/6.
 */
@Controller
public class NewsTypeController {

    private boolean is_logined;

    @Autowired
    private LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;
    @Autowired
    OssConfigure ossConfigure;

    @RequestMapping("/db/news/type")
    public String db_validate(Model model, HttpServletRequest request) {
        is_logined = Utils.isLogined(request);
        if (is_logined) {
            return "news_type_list";
        } else {
            model.asMap().clear();
            return "redirect:/db/login";
        }

    }

    /**
     * 查询列表
     */
    @ResponseBody
    @RequestMapping(value = "/type/list",method = RequestMethod.POST)
    public ResponseEntity<String> newsList(HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject pageJson = new JSONObject();
        String json = "";
        int page = Integer.parseInt(request.getParameter("page"));
        int size = Integer.parseInt(request.getParameter("size")!=null?  request.getParameter("size"): "10");
        String where = " where b.dictionary_type = 'enable' order by create_time desc limit " + page*size + "," + size;
        List<NewsType> newsList = laiHuiDB.selectNewsTypeByPage(where);
        int count = laiHuiDB.selectNewsTypeCount();
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
    @RequestMapping("/type/toAdd")
    public String toAdd(NewsType news,Model model){
        model.addAttribute("news",news);
        return "news_type_add";
    }

    /**
     *  新增新闻
     */
    @RequestMapping("type/add")
    public String add(NewsType news,HttpServletRequest request){
        String filePath = Utils.fileImgUpload("img", request);
        if (filePath != null && !filePath.trim().equals("")) {
            String image_local = filePath.substring(filePath.indexOf("upload"));
            String arr[] = image_local.split("\\\\");
            String image_oss = arr[arr.length - 1];
            try {
                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                    image_oss = "https://"+ ossConfigure.getAccessUrl() + image_oss;
                    news.setLogo(image_oss);
                }
            } catch (Exception e) {
                image_oss = null;
                news.setLogo(image_oss);
            }
        }
        laiHuiDB.insertNewsType(news);
        return "redirect:/db/news/type";
    }

    /**
     * 跳转编辑页面
     */
    @RequestMapping("/type/toUpdate")
    public String toUpdate(Model model,HttpServletRequest request){
        String where = " where b.dictionary_type = 'enable' and a.type_id = " + request.getParameter("typeId");
        List<NewsType> newsList = laiHuiDB.selectNewsTypeByPage(where);
        model.addAttribute("news",newsList.get(0));
        return "news_type_update";
    }

    /**
     *  编辑新闻
     */
    @RequestMapping("type/update")
    public String update(NewsType news,HttpServletRequest request){
        String filePath = Utils.fileImgUpload("img", request);
        String where = "";
        if (filePath != null && !filePath.trim().equals("")) {
            String image_local = filePath.substring(filePath.indexOf("upload"));
            String arr[] = image_local.split("\\\\");
            String image_oss = arr[arr.length - 1];
            try {
                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                    image_oss = "https://"+ ossConfigure.getAccessUrl() + image_oss;
                    news.setLogo(image_oss);
                }
            } catch (Exception e) {
                image_oss = null;
                news.setLogo(image_oss);
            }
            where = " set type_name = '" + news.getTypeName() + "',logo = '" +
                    news.getLogo() + "',update_time = '" + Utils.getCurrentTime() +
                    "' where type_id = " + news.getTypeId();
        }else {
            where = " set type_name = '" + news.getTypeName() + "',update_time = '" + Utils.getCurrentTime() +
                    "' where type_id = " + news.getTypeId();
        }
        laiHuiDB.update("pc_news_type",where);
        return "redirect:/db/news/type";
    }

    /**
     * 删除新闻
     */
    @RequestMapping("/type/delete")
    public String delete(HttpServletRequest request){
        String where = " where type_id = " + request.getParameter("typeId");
        laiHuiDB.delete("pc_news_type",where);
        return "redirect:/db/news/type";
    }

    /**
     * 启用禁用
     */
    @ResponseBody
    @RequestMapping("/type/enable")
    public  ResponseEntity<String> enable(NewsType newsType){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result = new JSONObject();
        String json = "";
        Map<String,Object> map = new HashMap<>();
        String where = " set is_enable = " + newsType.getIsEnable() + " where type_id = " + newsType.getTypeId();
        map.put("flag",laiHuiDB.update("pc_news_type", where));
        map.put("code",newsType.getIsEnable());
        result.put("result",map);
        json = result.toJSONString();
        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
    }
}
