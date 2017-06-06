package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.Carousel;
import com.cyparty.laihui.domain.Manager;
import com.cyparty.laihui.utilities.ConfigUtils;
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
public class CampainController {
    private boolean is_logined;
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;
    @RequestMapping("/db/campaign/76")
    public String index(Model model,HttpServletRequest request){
        is_logined= Utils.isLogined(request);
        if(is_logined){
            Manager user = (Manager)request.getSession().getAttribute("manager");
            if (ConfigUtils.SUB_ADMIN.equals(user.getMobile())){
                return "redirect:/db/login";
            }
            return "campaign_76";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @ResponseBody
    @RequestMapping(value = "/api/campaign/76", method = RequestMethod.POST)
    public ResponseEntity<String> campaign_76(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        try {
            String action=request.getParameter("action");
            boolean is_success=false;
            int page=0;
            int size=10;

            try {
                page=Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page=0;
            }
            try {
                size=Integer.parseInt(request.getParameter("size"));
            } catch (NumberFormatException e) {
                size=10;
            }
            int id=0;
            switch (action) {
                case "show":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        try {
                            id=Integer.parseInt(request.getParameter("id"));
                        } catch (NumberFormatException e) {
                            id=0;
                        }
                    }else {
                        id=0;
                    }
                    int type;
                    if(request.getParameter("type")!=null&&!request.getParameter("type").isEmpty()){
                        try {
                            type=Integer.parseInt(request.getParameter("type"));
                        } catch (NumberFormatException e) {
                            type=0;
                        }
                    }else {
                        type=0;
                    }
                    String start_time=request.getParameter("start_time");
                    String end_time=request.getParameter("end_time");
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getCampaign76Json(laiHuiDB, page, size, id,type,start_time,end_time), "76烩面订单获取成功");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "update":
                    try {
                        id=Integer.parseInt(request.getParameter("id"));
                    } catch (NumberFormatException e) {
                        id=0;
                    }
                    String deliver_name=request.getParameter("deliver_name");
                    String deliver_number=request.getParameter("deliver_number");
                    if(id>0){
                        String update_sql=" set deliver_name='"+deliver_name+"',deliver_number='"+deliver_number+"',pay_status=2,update_time='"+Utils.getCurrentTime()+"' where _id="+id;
                        laiHuiDB.update("pc_76_orders",update_sql);
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "订单更新成功");
                        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "参数有误");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                case "delete":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    String delete_sql=" where _id="+id;
                    is_success=laiHuiDB.delete("pc_76_orders",delete_sql);
                    if(is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "订单信息删除成功！");
                        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "订单信息删除失败！");
                        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
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
