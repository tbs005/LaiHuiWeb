package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.Business;
import com.cyparty.laihui.domain.Carousel;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/4/13 0013.
 */
@Controller
public class BusinessController {
    @Autowired
    LaiHuiDB laiHuiDB;
    @ResponseBody
    @RequestMapping(value = "/business/manage", method = RequestMethod.POST)
    public ResponseEntity<String> businessManage(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result = new JSONObject();
        String json = "";
        int id = 0;
        try {
            String action=request.getParameter("action");
            boolean is_success=false;
            int page=0;
            int size=1;
            if(request.getParameter("page")!=null&&!request.getParameter("page").trim().equals("")){
                try {
                    page=Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page=0;
                    e.printStackTrace();
                }
            }
            if(request.getParameter("size")!=null&&!request.getParameter("size").trim().equals("")){
                try {
                    size=Integer.parseInt(request.getParameter("size"));
                } catch (NumberFormatException e) {
                    size=1;
                    e.printStackTrace();
                }
            }
            switch (action) {
                case "show":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getBusinessJson(laiHuiDB, page, size, id), "轮播图信息获取成功");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "delete":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    String delete_sql=" where _id="+id;
                    is_success=laiHuiDB.delete("pc_merchant_join",delete_sql);
                    if(is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "招商加盟删除成功！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "招商加盟删除失败！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        }
    }
}
