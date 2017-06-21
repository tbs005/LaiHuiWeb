package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.utilities.*;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

    /**
     * 必达单查询
     * @param request
     * @return
     */
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
    /**
     *必达单数据折线图
     *
     */
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

    /**
     * 必达单和推送车主手机号关联
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/arrive/pushMess", method = RequestMethod.POST)
    public ResponseEntity<String> pushMess( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        String errorMobils = "";
        boolean flag=true;
        try {
            String traderNo = request.getParameter("traderNo");
            String userId = request.getParameter("userId");
            String mobiles = request.getParameter("mobiles");
            String name = request.getParameter("name");
            String begin = request.getParameter("begin");
            String end = request.getParameter("end");
            String time = request.getParameter("time");
            if(time!=null && !time.equals("")){
                time=time.trim();
                time = time.substring(0,9);
                String[] timeArr = time.split("-");
                time=timeArr[1]+"月"+timeArr[2]+"日";
            }

            if(mobiles!=null && !mobiles.equals("")){
                String mobileArr[] = mobiles.split(",");
                for(int i=0;i<mobileArr.length;i++){
                    String passergerMobile = mobileArr[i];
                    boolean flag2 =true;//短信推送状态
                    if(passergerMobile==null || passergerMobile.equals("")){
                        flag2=false;
                    }else{
                        if(passergerMobile.length()==11){
                            try{
                                Double.parseDouble(passergerMobile);
                                //推送格式：【来回拼车】#name#正在寻找从#begin#到#end#的顺风车，预计#time#启程，详情请下载 http://dwz.cn/4A6CAt
                                flag2=SendSMSUtil.sendSMS(passergerMobile,37624,"#name#="+name+"&#begin#="+begin+"&#end#="+end+"&#time#="+time);
                            }catch (Exception ex){
                                flag2=false;
                            }
                        }else{
                            flag2=false;
                        }
                        //添加车单和车主短信关联关系
                        if(flag2) {
                            boolean flag3 = laiHuiDB.createArriveForDriver(traderNo, passergerMobile, userId);
                            if (!flag3) {
                                errorMobils += passergerMobile + ",";
                                flag=false;
                            }
                        }else{
                            errorMobils += passergerMobile + ",";
                            flag=false;
                        }
                    }
                }
                String message="";
                if(flag){
                    message="车主短信推送成功！";
                }else{
                    if(errorMobils.length()>0){
                        errorMobils=errorMobils.substring(0,errorMobils.length()-1);
                    }
                    message="部分车主短信推送失败，"+errorMobils;
                }
                json = JsonUtils.returnSuccessJsonString(result, message);
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            }else {
                json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
            }
        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 查询必达单关联的车主手机号
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/arrive/arriveformobile", method = RequestMethod.POST)
    public ResponseEntity<String> arriveForMobile( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String traderNo = request.getParameter("traderNo");
            String userId = request.getParameter("userId");
            int page=getPageOrSize(request,0);
            int size=getPageOrSize(request,1);

            json = ReturnJsonUtil.returnSuccessJsonString(ArriveJsonUtil.getArriveForMobile(laiHuiDB, traderNo,userId, page, size), "必达单数据获取成功！");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);

        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 确认退款 修改必达订单状态
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/arrive/confirmRefund", method = RequestMethod.POST)
    public ResponseEntity<String> confirmRefund( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String orderId = request.getParameter("orderId");
            boolean flag = laiHuiDB.confirmRefund(orderId);
            if(flag){
                json = JsonUtils.returnSuccessJsonString(result, "操作成功！");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            }else {
                json = ReturnJsonUtil.returnFailJsonString(result, "操作失败！");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
            }
        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }


}
