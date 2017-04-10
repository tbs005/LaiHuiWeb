package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
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

import javax.servlet.http.HttpServletRequest;

/**
 * Created by zhu on 2016/5/11.
 */
@Controller
public class PassengerOrdersController {
    private boolean is_logined;
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;

    @RequestMapping("/db/passenger/order_list")
    public String drivingInfo_list(Model model, HttpServletRequest request) {
        is_logined = Utils.isLogined(request);

        if (is_logined) {
            return "driver_departure_list";
        } else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }


    @ResponseBody
    @RequestMapping(value = "/api/passenger/order_list", method = RequestMethod.POST)
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
            if (!request.getParameter("id").isEmpty()) {
                id = Integer.parseInt(request.getParameter("id"));
            }
            is_logined = Utils.isLogined(request);

            String start_time = request.getParameter("start_time");
            String end_time = request.getParameter("end_time");
            String source = request.getParameter("source");
            String keyword = request.getParameter("keyword");

            switch (action) {
                case "delete":
                    if (is_logined) {
                        id = Integer.parseInt(request.getParameter("order_id"));

                        String delete_sql=" set is_enable=0 where _id="+id;
                        is_success=laiHuiDB.update("pc_passenger_orders", delete_sql);
                        if (is_success) {
                            json = ReturnJsonUtil.returnSuccessJsonString(result, "删除成功！");
                        } else {
                            json = ReturnJsonUtil.returnFailJsonString(result, "删除失败！");
                        }
                        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                    }
                case "show":
                    String flag=request.getParameter("flag");
                    int current_flag=0;
                    id=0;
                    if(!flag.isEmpty()&&flag.equals("1")){
                        current_flag=1;
                    }
                    if(!request.getParameter("id").isEmpty()){
                        try {
                            id=Integer.parseInt(request.getParameter("id"));
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                        }
                    }
                    result = ReturnJsonUtil.getMyBookingOrderList(laiHuiDB, page, size, start_time, end_time,current_flag,id);
                    json = ReturnJsonUtil.returnSuccessJsonString(result, "全部订单信息获取成功");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                case "passenger_order_count":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPassengerOrdersCount(laiHuiDB), "订单统计数据获取成功");
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
    /**
     * 乘客发布出行信息
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/db/passenger/departure")
    public String passenger_departure(Model model, HttpServletRequest request) {

        is_logined = Utils.isLogined(request);
        if (is_logined) {
            return "db_passenger_departure";
        } else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @RequestMapping("/db/passenger/departure_list")
    public String passenger_departure_list(Model model, HttpServletRequest request) {
        is_logined = Utils.isLogined(request);
        if (is_logined) {
            return "db_passenger_departure_list";
        } else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
}
