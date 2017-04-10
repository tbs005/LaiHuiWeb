package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.ErrorCode;
import com.cyparty.laihui.domain.Manager;
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
import java.util.List;

/**
 * Created by zhu on 2016/5/11.
 */
@Controller
public class PayController {
    private boolean is_logined=false;
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;
    @RequestMapping("/pay/list")
    public String pay_list(HttpServletRequest request,Model model){

        is_logined=Utils.isLogined(request);
        if(is_logined){
            Manager manager=(Manager)request.getSession().getAttribute("manager");
            if(manager.getPrivilege()>1){
                return "pay_list";
            }else {
                return "redirect:/db/departure_list";
            }

        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @RequestMapping("/pay/info")
    public String pay_info(Model model,HttpServletRequest request){

        is_logined=Utils.isLogined(request);

        if(is_logined){
            Manager manager=(Manager)request.getSession().getAttribute("manager");
            if(manager.getPrivilege()>1){
                return "pay_info";
            }else {
                return "redirect:/db/departure_list";
            }
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @RequestMapping("/pay/application")
    public String pay_application(Model model,HttpServletRequest request){
        is_logined=Utils.isLogined(request);
        if(is_logined){
            Manager manager=(Manager)request.getSession().getAttribute("manager");
            if(manager.getPrivilege()>1){
                return "pay_application";
            }else {
                return "redirect:/db/departure_list";
            }
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }

    @RequestMapping("/pay/back")
    public String pay_back(Model model,HttpServletRequest request){
        is_logined=Utils.isLogined(request);
        if(is_logined){
            Manager manager=(Manager)request.getSession().getAttribute("manager");
            if(manager.getPrivilege()>1){
                return "pay_back";
            }else {
                return "redirect:/db/departure_list";
            }
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }

    @ResponseBody
    @RequestMapping(value = "/api/pay/application", method = RequestMethod.POST)
    public ResponseEntity<String> user( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            String keyword=request.getParameter("keyword");
            String type=request.getParameter("type");
            String start_time=request.getParameter("start_time");
            String end_time=request.getParameter("end_time");

            int page=getPageOrSize(request,0);
            int size=getPageOrSize(request,1);
            switch (action){
                case "show":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPayApplication(laiHuiDB, keyword, start_time, end_time, type, page,size), "提现信息获取成功！");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                case "confirm":
                    String id=request.getParameter("id");
                    if(id!=null&&!id.isEmpty()){
                        String update_sql=" set order_status=1,is_complete=1,update_time='"+Utils.getCurrentTime()+"' where _id="+id;
                        laiHuiDB.update("pay_cash_log",update_sql);
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(result, "转账信息确认成功！");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
    @ResponseBody
    @RequestMapping(value = "/api/pay/back", method = RequestMethod.POST)
    public ResponseEntity<String> pay_back( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            String keyword=request.getParameter("keyword");
            String type=request.getParameter("type");
            String start_time=request.getParameter("start_time");
            String end_time=request.getParameter("end_time");

            int page=getPageOrSize(request,0);
            int size=getPageOrSize(request,1);
            switch (action){
                case "show":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPayBackList(laiHuiDB, keyword, start_time, end_time, type, page, size), "退款信息获取成功！");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                case "confirm":
                    String id=request.getParameter("id");//order_id
                    if(id!=null&&!id.isEmpty()){
                        //更新pay_orders表中申请退款状态
                        String update_sql=" set order_status=6,update_time='"+Utils.getCurrentTime()+"' where order_type=0 and order_id="+id;
                        laiHuiDB.update("pc_orders",update_sql);
                        //更新支付记录表中退款状态
                        update_sql=" set is_complete=1 where action_type=0 and order_id="+id;
                        laiHuiDB.update("pay_cash_log",update_sql);
                        //更新退款表中状态
                        update_sql=" set pay_status=1 where  order_id="+id;
                        laiHuiDB.update("pc_application_pay_back",update_sql);
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(result, "转账信息确认成功！");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }
    }
    @ResponseBody
    @RequestMapping(value = "/api/pay", method = RequestMethod.POST)
    public ResponseEntity<String> pay_list( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            String keyword=request.getParameter("keyword");
            String type=request.getParameter("type");
            String start_time=request.getParameter("start_time");
            String end_time=request.getParameter("end_time");

            int page=getPageOrSize(request,0);
            int size=getPageOrSize(request,1);
            switch (action){
                case "show":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPayList(laiHuiDB, keyword, start_time, end_time, type, page,size), "信息获取成功！");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                case "show_info":
                    String id=request.getParameter("id");
                    if(id!=null&&!id.isEmpty()){
                        json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPayInfo(laiHuiDB,id), "订单支付详情获取成功！");
                        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
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
}
