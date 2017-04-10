package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.*;
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
import java.util.List;

/**
 * Created by zhu on 2016/5/11.
 */
@Controller
public class ValidateController {
    private boolean is_logined;
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;
    @RequestMapping("/auth/validate_idcard")
    public String index(Model model,HttpServletRequest request){

        return "validate";
    }
    @RequestMapping("/auth/validate_car")
    public String validate_car(Model model,HttpServletRequest request){

        return "validate_car";
    }
    @RequestMapping("/auth/check_car")
    public String check_car(Model model,HttpServletRequest request){

        return "check_car";
    }


    /**
     * 后台实名认证模块
     *
     */
    @RequestMapping("/db/validate/manager")
     public String db_validate(Model model,HttpServletRequest request){
        is_logined=Utils.isLogined(request);

        if(is_logined){
            return "db_validate_manager";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }

    }
    @ResponseBody
    @RequestMapping(value = "/db/api/validate_manager", method = RequestMethod.POST)
    public ResponseEntity<String> validate_manager( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            boolean is_success=true;
            int page=0;
            int size=10;
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
                    size=10;
                    e.printStackTrace();
                }
            }
            String where ="";
            switch (action){
                case "add":
                    Manager manager=new Manager();
                    String name=request.getParameter("name");
                    String mobile=request.getParameter("mobile");
                    String password=request.getParameter("password");
                    String md5_password=Utils.encode("MD5",password);
                    String description=request.getParameter("description");

                    manager.setName(name);
                    manager.setMobile(mobile);
                    manager.setPassword(md5_password);
                    manager.setDecription(description);
                    where =" where mobile='"+mobile+"'";
                    List<Manager> managerList=laiHuiDB.getManager(where);
                    if(managerList.size()>0){
                        json = ReturnJsonUtil.returnFailJsonString(result, "管理员创建失败,该用户已存在！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        laiHuiDB.createManager(manager);
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(result, "管理员创建成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "show":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getManagerJson(laiHuiDB,page,size), "管理员数据获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "delete":
                    int id=Integer.parseInt(request.getParameter("id"));
                    where=" set is_enable=0 where _id="+id;
                    is_success=laiHuiDB.updateManager(where);
                    if(is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "删除成功！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "删除失败！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
//    车主认证链接页面
    @RequestMapping("/db/validate/driver_list")
    public String db_driver_list(Model model,HttpServletRequest request){
        is_logined=Utils.isLogined(request);
        if(is_logined){
            return "db_validate_driver_list";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
//    乘客认证链接页面
    @RequestMapping("/db/validate/passenger_list")
    public String db_validate_list(Model model,HttpServletRequest request){
        is_logined=Utils.isLogined(request);
        if(is_logined){
            return "db_validate_passenger_list";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @ResponseBody
    @RequestMapping(value = "/db/api/validate_list", method = RequestMethod.POST)
    public ResponseEntity<String> validate_list( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            boolean is_success=true;
            String status=request.getParameter("status");

            int page=0;
            int size=10;
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
                    size=10;
                    e.printStackTrace();
                }
            }
            String start_time=request.getParameter("start_time");
            String end_time=request.getParameter("end_time");
            String keyword=request.getParameter("keyword");
            switch (action){
                //2
              /*  case "show_unchecked":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getValidateJson(laiHuiDB,status,page,size,start_time,end_time,keyword), "待审核数据获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);*/
                case "show_driver_checked":
                    //1
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getValidateJson(laiHuiDB, status,page,size,start_time,end_time,keyword), "通过审核数据获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
               /* case "show_checked_down":
                    //-1
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getValidateJson(laiHuiDB, status,page,size,start_time,end_time,keyword), "审核拒绝数据获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);*/
               /* case "show_passenger_checked":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getValidateJson(laiHuiDB, status,page,size,start_time,end_time,keyword), "通过审核数据获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);*/
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
    @RequestMapping("/db/validate/info")
    public String db_validate_info(Model model,HttpServletRequest request){
        is_logined=Utils.isLogined(request);
        if(is_logined){
            return "db_validate_info";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
}
