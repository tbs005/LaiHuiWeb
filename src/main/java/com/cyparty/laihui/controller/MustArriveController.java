package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.utilities.ArriveJsonUtil;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
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

/**
 * Created by lunwf on 2017/6/16 .
 */
@Controller
public class MustArriveController {
    private boolean is_logined;

    @Autowired
    LaiHuiDB laiHuiDB;

    @RequestMapping("/db/must_arrive")
    public String must_arrive(Model model, HttpServletRequest request) {
        is_logined = Utils.isLogined(request);

        if (is_logined) {
            return "must_arrive_list";
        } else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }

        @ResponseBody
        @RequestMapping(value = "/arrive/list", method = RequestMethod.POST)
        public ResponseEntity<String> arriveList( HttpServletRequest request){
            HttpHeaders responseHeaders = new HttpHeaders();
            responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
            JSONObject result = new JSONObject();
            String json="";
        try {
            String action=request.getParameter("action");
            String keyword=request.getParameter("keyword");
            String start_time=request.getParameter("start_time");
            String end_time=request.getParameter("end_time");
            String id=request.getParameter("order_id");
            String order_status=request.getParameter("order_status");
            String is_enable=request.getParameter("is_enable");
            String flag = "0";  //车单是否失效   0：全部  1：执行中  2：失效
            int page=getPageOrSize(request,0);
            int size=getPageOrSize(request,1);

            String token=null;
            if(request.getParameter("token")!=null){
                token=request.getParameter("token");
            }
            switch (action){
                case "show":
                    json = ReturnJsonUtil.returnSuccessJsonString(ArriveJsonUtil.getArriveList(laiHuiDB, keyword, start_time, end_time, flag, page, size, order_status, is_enable, id), "必达单数据获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
    public static int getPageOrSize(HttpServletRequest request,int type){
        int result=0;
        if(type==0){
            if(request.getParameter("page")!=null&&!request.getParameter("page").trim().equals("")){
                try {
                    result=Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    result=0;
                }
            }
        }else if(type==1){
            if(request.getParameter("size")!=null&&!request.getParameter("size").trim().equals("")){
                try {
                    result=Integer.parseInt(request.getParameter("size"));
                } catch (NumberFormatException e) {
                    result=10;
                }
            }
        }
        return result;
    }
    //todo:必达单数据折线图
    @ResponseBody
    @RequestMapping(value = "/arrive/line", method = RequestMethod.POST)
    public ResponseEntity<String> user_count( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            switch (action){
                case "show":
                    json = ReturnJsonUtil.returnSuccessJsonString(ArriveJsonUtil.getArriveLine(laiHuiDB), "必达单数据获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);

        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
}
