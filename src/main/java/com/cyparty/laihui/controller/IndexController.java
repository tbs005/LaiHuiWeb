package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import com.cyparty.laihui.utilities.Utils;
import com.cyparty.laihui.utilities.WXUtils;
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

/**
 * Created by zhu on 2016/5/11.
 */
@Controller
public class IndexController {
    private boolean is_logined;
    @Autowired
    LaiHuiDB laiHuiDB;

    @RequestMapping("/")
    public String index(Model model,HttpServletRequest request){

        is_logined= Utils.isLogined(request);

        if(is_logined){
            return "user_list";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    /**
     * 统计接口
     * @param request
     * @return
     */
    @RequestMapping("/db/pcxxh/cumulate")
    public String db_cumulate(Model model, HttpServletRequest request) {
        is_logined=Utils.isLogined(request);
        if(is_logined){
            return "db_cumulate";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }

    @ResponseBody
    @RequestMapping(value = "/api/pcxxh/cumulate", method = RequestMethod.POST)
    public ResponseEntity<String> wx_cumulate(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        try {
            String action=request.getParameter("action");
            switch (action) {
                case "summary":
                    result= WXUtils.httpTest(request, "getusersummary");
                    json = ReturnJsonUtil.returnSuccessJsonString(result, "用户增减数据获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "cumulate":
                    result= WXUtils.httpTest(request,"getusercumulate");
                    json = ReturnJsonUtil.returnSuccessJsonString(result, "累计用户统计信息获取成功");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
    @RequestMapping("/404")
    public String a404Page(){
        return "404";
    }

}
