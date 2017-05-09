package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.User;
import com.cyparty.laihui.utilities.*;
import org.jsoup.helper.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.util.Date;
import java.util.List;

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
        int  m_id = Integer.parseInt(request.getParameter("m_id"));
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
        boolean is_success = laiHuiDB.createDeriverCarList(mobile, departure_time, boarding_point, breakout_point, init_seats, remark, departure_address_code, departure_city_code, destination_address_code, destination_city_code,m_id);
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
        int  m_id = Integer.parseInt(request.getParameter("m_id"));
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
        boolean is_success = laiHuiDB.createPassengerCarList(mobile, departure_time, boarding_point, breakout_point, booking_seats, remark, departure_address_code, departure_city_code, destination_address_code, destination_city_code, m_id);
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
    /**
     * 五一活动给每个用户都发送一条活动消息
    */
    @ResponseBody
    @RequestMapping(value = "/activity/sms", method = RequestMethod.POST)
    public ResponseEntity<String>ActivitySms(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result =new JSONObject();
        String json ="";
        int start = 50000;
        int end = 50678;
        long start_time = new Date().getTime();
        List<User> userList = laiHuiDB.getMobileUsers(" where _id >"+start+"  and _id <= "+end+ " ORDER BY _id ASC");
        String mobile ="";
        JSONObject activity = new JSONObject();
        JSONArray action = new JSONArray();
        if(userList.size()>0){
            int a =1;
            for(User user : userList){
                mobile = user.getUser_mobile();
                if(null != mobile && mobile.length()==11){
                    SendSMSUtil.sendSMS(mobile,33130,"");
                }else{
                    continue;
                }
                activity.put("mobile",mobile);
                List<User> users =laiHuiDB.getUserList("  where user_mobile ='"+mobile+"'");
                if(users.size()>0){
                    activity.put("id",users.get(0).getUser_id());
                    activity.put("a",a++);
                    action.add(activity);
                }
            }
            long end_time = new Date().getTime();
            long time =end_time-start_time;
            System.out.println(time);
            result.put("data",action);
            System.out.println(result.toJSONString());
            json = ReturnJsonUtil.returnSuccessJsonString(result, "活动消息推送成功！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }else{
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
    /**
     * 统计今天录入车单的情况，统计到今天为止车单录入的情况
     */
    @ResponseBody
    @RequestMapping(value = "/single/count", method = RequestMethod.POST)
    public ResponseEntity<String>SingleCount(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result =new JSONObject();
        String json ="";
        String  id = request.getParameter("m_id");
        if(StringUtil.isBlank(id) && "null".equals(id)){
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
        int m_id = Integer.parseInt(id);
        int all_count = 0;
        int today_count = 0;
        int d_allCount = 0;
        int p_allCount = 0;
        int d_todayCount = 0;
        int p_todayCount = 0;
        d_allCount = laiHuiDB.getTotalCount("pc_driver_publish_info"," where m_id="+m_id);
        d_todayCount = laiHuiDB.getTotalCount("pc_driver_publish_info"," where m_id="+m_id+" and to_days(create_time) = to_days(now())");
        p_allCount = laiHuiDB.getTotalCount("pc_passenger_publish_info"," where m_id="+m_id);
        p_todayCount = laiHuiDB.getTotalCount("pc_passenger_publish_info"," where m_id="+m_id+" and to_days(create_time) = to_days(now())");
        all_count = d_allCount + p_allCount;
        today_count = d_todayCount + p_todayCount;
        result.put("all_count",all_count);
        result.put("today_count",today_count);
        json = ReturnJsonUtil.returnSuccessJsonString(result, "统计成功！");
        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
    }

    /**
     * 五一活动给每个用户都发送一条活动消息
     */
    @ResponseBody
    @RequestMapping(value = "/sms/push", method = RequestMethod.POST)
    public ResponseEntity<String>PushSms(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result =new JSONObject();
        String json ="";
//        int start = 50000;
//        int end = 50678;
        int last = NotifyPush.getLast(laiHuiDB);
        int start = Integer.parseInt(request.getParameter("start"));
        int end = Integer.parseInt(request.getParameter("end"));
        int tpl_id = Integer.parseInt(request.getParameter("tpl_id"));
        if(end>last){
            json = ReturnJsonUtil.returnFailJsonString(result, "不能超过最大id！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }
        if(start<0 || end<0 || start>end  || tpl_id<0){
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
        long start_time = new Date().getTime();
        List<User> userList = laiHuiDB.getMobileUsers(" where _id >"+start+"  and _id <= "+end+ " ORDER BY _id ASC");
        String mobile ="";
        JSONObject activity = new JSONObject();
        JSONArray action = new JSONArray();
        if(userList.size()>0){
            int a =1;
            for(User user : userList){
                mobile = user.getUser_mobile();
                if(null != mobile && mobile.length()==11){
                    SendSMSUtil.sendSMS(mobile,tpl_id,"");
                }else{
                    continue;
                }
                activity.put("mobile",mobile);
                List<User> users =laiHuiDB.getUserList("  where user_mobile ='"+mobile+"'");
                if(users.size()>0){
                    activity.put("id",users.get(0).getUser_id());
                    activity.put("a",a++);
                    action.add(activity);
                }
            }
            long end_time = new Date().getTime();
            long time =end_time-start_time;
            System.out.println(time);
            result.put("data",action);
            System.out.println(result.toJSONString());
            json = ReturnJsonUtil.returnSuccessJsonString(result, "活动消息推送成功！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }else{
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
}
