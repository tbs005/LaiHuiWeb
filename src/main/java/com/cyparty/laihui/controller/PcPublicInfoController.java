package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.utilities.JsonUtils;
import com.cyparty.laihui.utilities.SendSMSUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2017/4/14.
 */
@Controller
public class PcPublicInfoController {
    @Autowired
    LaiHuiDB laiHuiDB;

    @ResponseBody
    @RequestMapping(value = "/pc/deriver/date", method = RequestMethod.POST)
    public ResponseEntity<String> deriver(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result = new JSONObject();
        String json = "";
        String mobile = request.getParameter("mobile");
        String departure_time = request.getParameter("departure_time");
        String boarding_point = request.getParameter("boarding_point");
        String breakout_point = request.getParameter("breakout_point");
        int init_seats = Integer.parseInt(request.getParameter("init_seats"));
        String remark = "司机没有限制要求";
        if (request.getParameter("remark") != null && !request.getParameter("remark").isEmpty()) {
            remark = request.getParameter("remark");
        }
        int departure_address_code = 0;
        int departure_city_code = 0;
        int destination_address_code = 0;
        int destination_city_code = 0;
        try {
            JSONObject boardingObject = JSONObject.parseObject(boarding_point);
            departure_address_code = boardingObject.getIntValue("adCode");
            departure_city_code = Integer.parseInt((departure_address_code + "").substring(0, 4) + "00");
            JSONObject breakoutObject = JSONObject.parseObject(breakout_point);
            destination_address_code = breakoutObject.getIntValue("adCode");
            destination_city_code = Integer.parseInt((destination_address_code + "").substring(0, 4) + "00");
        } catch (Exception e) {
            e.printStackTrace();
            json = JsonUtils.returnFailJsonString(result, "发布失败！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }
        boolean is_success = laiHuiDB.createDeriverCarList(mobile, departure_time, boarding_point, breakout_point, init_seats, remark, departure_address_code, departure_city_code, destination_address_code, destination_city_code);
        if (is_success) {
            json = JsonUtils.returnSuccessJsonString(result, "发布成功！");
            SendSMSUtil.sendSMSToPc(mobile);
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        } else {
            json = JsonUtils.returnFailJsonString(result, "发布失败！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }

    }

    @ResponseBody
    @RequestMapping(value = "/pc/pessenger/date", method = RequestMethod.POST)
    public ResponseEntity<String> pessenger(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result = new JSONObject();
        String json = "";
        String mobile = request.getParameter("mobile");
        String departure_time = request.getParameter("departure_time");
        String boarding_point = request.getParameter("boarding_point");
        String breakout_point = request.getParameter("breakout_point");
        int booking_seats = Integer.parseInt(request.getParameter("booking_seats"));
        String remark = "乘客轻装简行";
        if (request.getParameter("remark") != null && !request.getParameter("remark").isEmpty()) {
            remark = request.getParameter("remark");
        }
        int departure_address_code = 0;
        int departure_city_code = 0;
        int destination_address_code = 0;
        int destination_city_code = 0;
        try {
            JSONObject boardingObject = JSONObject.parseObject(boarding_point);
            departure_address_code = boardingObject.getIntValue("adCode");
            departure_city_code = Integer.parseInt((departure_address_code + "").substring(0, 4) + "00");
            JSONObject breakoutObject = JSONObject.parseObject(breakout_point);
            destination_address_code = breakoutObject.getIntValue("adCode");
            destination_city_code = Integer.parseInt((destination_address_code + "").substring(0, 4) + "00");
        } catch (Exception e) {
            e.printStackTrace();
            json = JsonUtils.returnFailJsonString(result, "发布失败！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }
        boolean is_success = laiHuiDB.createPassengerCarList(mobile, departure_time, boarding_point, breakout_point, booking_seats, remark, departure_address_code, departure_city_code, destination_address_code, destination_city_code);
        if (is_success) {
            json = JsonUtils.returnSuccessJsonString(result, "发布成功！");
            SendSMSUtil.sendSMSToPc(mobile);
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        } else {
            json = JsonUtils.returnFailJsonString(result, "发布失败！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }

    }

    /**
     * 给被录入车单信息的人发送一条短信
     */
    @ResponseBody
    @RequestMapping(value = "/pc/sms", method = RequestMethod.POST)
    public static void sms(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        String mobile = request.getParameter("mobile");
        SendSMSUtil.sendSMSToPc(mobile);
    }

}
