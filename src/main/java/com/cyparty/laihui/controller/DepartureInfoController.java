package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.*;
import com.cyparty.laihui.utilities.OssUtil;
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
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

/**
 * Created by zhu on 2016/5/11.
 */
@Controller
public class DepartureInfoController {
    private boolean is_logined;
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;

    @RequestMapping("/db/departure_list")
    public String drivingInfo_list(Model model, HttpServletRequest request) {
        is_logined = Utils.isLogined(request);

        if (is_logined) {
            return "driver_departure_list";
        } else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }

    @RequestMapping("/laihui/car/list")
    public String car_departure(Model model, HttpServletRequest request) {
        is_logined=Utils.isLogined(request);
        if(is_logined){

            return "car_driver_departure_list";
        }else {
            return "redirect:/db/login";
        }
    }

    @RequestMapping("/laihui/car/detail")
    public String car_departure_info(Model model, HttpServletRequest request) {
        is_logined=Utils.isLogined(request);
        if(is_logined){

            return "car_driver_departure_info";
        }else {
            return "redirect:/db/login";
        }
    }

    @RequestMapping("/db/car/departure")
    public String db_departure(Model model, HttpServletRequest request) {
        is_logined=Utils.isLogined(request);
        if(is_logined){
            return "db_car_departure";
        }else {
            return "redirect:/db/login";
        }
    }
    @ResponseBody
    @RequestMapping(value = "/api/driver/departure", method = RequestMethod.POST)
    public ResponseEntity<String> departure(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        try {
            String action = request.getParameter("action");
            int page = 0;
            int size = 10;
            if (request.getParameter("page") != null && !request.getParameter("page").trim().equals("")) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 0;
                    e.printStackTrace();
                }
            }
            if (request.getParameter("size") != null && !request.getParameter("size").trim().equals("")) {
                try {
                    size = Integer.parseInt(request.getParameter("size"));
                } catch (NumberFormatException e) {
                    size = 10;
                    e.printStackTrace();
                }
            }
            int id = 0;
            String where = "";
            boolean is_success = true;
            String start_time = request.getParameter("start_time");
            String end_time = request.getParameter("end_time");
            String keyword = request.getParameter("keyword");
            if (request.getParameter("id") != null) {
                id = Integer.parseInt(request.getParameter("id"));
            }
            is_logined = Utils.isLogined(request);
            String source = request.getParameter("source");

            switch (action) {
                case "delete":
                    if (is_logined) {
                        id = Integer.parseInt(request.getParameter("order_id"));

                        String delete_sql=" set is_enable=0 where _id="+id;
                        is_success=laiHuiDB.update("pc_driver_publish_info", delete_sql);
                        if (is_success) {
                            json = ReturnJsonUtil.returnSuccessJsonString(result, "删除成功！");
                        } else {
                            json = ReturnJsonUtil.returnFailJsonString(result, "删除失败！");
                        }
                        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                    }
                case "show":
                    result = ReturnJsonUtil.getAPPDriverDepartureList(laiHuiDB, page, size,start_time,end_time,keyword,source,0);
                    json = ReturnJsonUtil.returnSuccessJsonString(result, "全部出车信息获取成功");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
               /* case "show_info":
                    String order_id = request.getParameter("order_id");
                    result = ReturnJsonUtil.getAPPDriverDepartureInfo(laiHuiDB, order_id);

                    json = ReturnJsonUtil.returnSuccessJsonString(result, "出车信息详情获取成功");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);*/
                case "driver_departure_count":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getDepartureCount(laiHuiDB), "出车统计数据获取成功");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
}
