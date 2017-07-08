package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.ErrorCode;
import com.cyparty.laihui.domain.Manager;
import com.cyparty.laihui.utilities.OssUtil;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import com.cyparty.laihui.utilities.Utils;
import com.sun.org.apache.xerces.internal.util.URI;
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
public class UserController {
    private boolean is_logined=false;
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;
    @RequestMapping("/auth/validate/info")
    public String index(Model model,HttpServletRequest request){

        return "validate_info";
    }

    @RequestMapping("/db/user_list")
    public String validate_car(Model model,HttpServletRequest request){
        String url=request.getHeader("referer");
        is_logined=Utils.isLogined(request);

        if(is_logined){
            Manager manager=(Manager)request.getSession().getAttribute("manager");
            if(manager.getPrivilege()>1){
                return "user_list";
            }else {
                return "redirect:/db/departure_list";
            }

        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @ResponseBody
    @RequestMapping(value = "/user/info", method = RequestMethod.POST)
    public ResponseEntity<String> user( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            String keyword=request.getParameter("keyword");
            String start_time=request.getParameter("start_time");
            String end_time=request.getParameter("end_time");
            String is_validated_passenger=request.getParameter("is_passenger");
            String is_validated_car=request.getParameter("is_car");

            int page=getPageOrSize(request,0);
            int size=getPageOrSize(request,1);
            int id=0;
            String token=null;
            if(request.getParameter("token")!=null){
                token=request.getParameter("token");
            }
            switch (action){
                case "show":
                    if(token!=null){
                        id=laiHuiDB.getIDByToken(token);
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getUserInfo(laiHuiDB, keyword, start_time, end_time, is_validated_passenger, is_validated_car,page,size,id), "用户信息获取成功！");
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
    //todo:用户数据折线图
    @ResponseBody
    @RequestMapping(value = "/user/count", method = RequestMethod.POST)
    public ResponseEntity<String> user_count( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            String status=request.getParameter("status");
            String source=request.getParameter("source");
            switch (action){
                case "show":
                    String data_type="all_user";
                    if(source==null){
                        data_type="all_user";
                    }else {
                        if(source.equals("1")){
                            data_type="validated_user";
                        }if(source.equals("2")){
                            data_type="car_user";
                        }
                    }
                    if(status!=null){
                        if(status.equals("1")){
                            json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getUserCount(laiHuiDB,1,data_type), "iOS用户信息获取成功！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                        if(status.equals("2")){
                            json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getUserCount(laiHuiDB,2,data_type), "Android用户信息获取成功！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getUserCount(laiHuiDB,0,data_type), "用户信息获取成功！");
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
    @RequestMapping("/db/login")
    public String login(HttpServletRequest request){
        String url=request.getHeader("referer");
        if(url!=null&&!url.isEmpty()){

            URI uri ;
            try {
                uri = new URI(url);
                String path=uri.getPath();
                request.getSession().setAttribute("path",path);
                System.out.println("path:"+path);
            } catch (URI.MalformedURIException e) {
                e.printStackTrace();
            }
        }
        return "login";
    }

    @RequestMapping("/db/logout")
    public String logout(Model model,HttpServletRequest request){
        request.getSession().setAttribute("manager",null);
        model.asMap().clear();
        return "redirect:/db/login";
    }
    //
    @RequestMapping("/db/reset_password")
    public String reset_password(Model model,HttpServletRequest request){
        is_logined=Utils.isLogined(request);
        if(is_logined){

            return "reset_password";
        }else {
            return "redirect:/db/login";
        }
    }
    @ResponseBody
    @RequestMapping(value = "db/auth/login", method = RequestMethod.POST)
    public ResponseEntity<String> user_check( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();

        String json="";
        try {
            String action=request.getParameter("action");
            String mobile=request.getParameter("mobile");
            String password=request.getParameter("password");
            switch (action){
                case "check":
                    String where=" where mobile='"+mobile+"' and password='"+password+"'";
                    List<Manager> managerList=laiHuiDB.getManager(where);
                    if(managerList.size()>0){
                        request.getSession().setAttribute("manager",managerList.get(0));
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "登陆成功！");
                        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "登陆失败！");
                        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                    }
                case "reset_password":
                    Manager now_manager=(Manager)request.getSession().getAttribute("manager");
                    if(now_manager!=null){
                        mobile=now_manager.getMobile();
                        String old_md5_password=request.getParameter("old_password");
                        String new_md5_password=request.getParameter("new_password");


                        String now_where=" where mobile='"+mobile+"' and password='"+old_md5_password+"'";
                        List<Manager> now_managerList=laiHuiDB.getManager(now_where);
                        if(now_managerList.size()>0){
                            String update_sql=" set password='"+new_md5_password+"' where _id="+now_manager.getM_id();
                            laiHuiDB.update("pc_manager",update_sql);
                            json = ReturnJsonUtil.returnSuccessJsonString(result, "修改密码成功！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }else {
                            result.put("errcode",ErrorCode.getError_password());
                            json = ReturnJsonUtil.returnFailJsonString(result, "旧密码有误！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                    }else {
                        result.put("errcode",ErrorCode.getLogin_error());
                        json = ReturnJsonUtil.returnFailJsonString(result, "登陆失败！");
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
    /***
     *
     * 用户反馈模块
     *
     */
    @RequestMapping("/db/user_suggestion")
    public String user_suggestion(Model model,HttpServletRequest request){
        is_logined=Utils.isLogined(request);
        if(is_logined){

            return "user_suggestion";
        }else {
            return "redirect:/db/login";
        }
    }

    @ResponseBody
    @RequestMapping(value = "/api/app/user_suggestions", method = RequestMethod.POST)
    public ResponseEntity<String> suggestions( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String action=request.getParameter("action");
            String status=request.getParameter("status");
            int page=getPageOrSize(request,0);
            int size=getPageOrSize(request,1);
            switch (action){
                case "show":
                    if(status!=null){
                        if(status.equals("0")){
                            json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getUserSuggestions(laiHuiDB,page,size, 0), "android用户反馈获取成功！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                        if(status.equals("1")){
                            json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getUserSuggestions(laiHuiDB, page, size, 1), "ios用户反馈获取成功！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getUserSuggestions(laiHuiDB, page, size, 2), "全部用户反馈获取成功！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "delete":
                    String id=request.getParameter("id");
                    String delete_sql=" where _id="+id;
                    boolean is_success=laiHuiDB.delete("pc_user_suggestion",delete_sql);
                    if(is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "删除成功！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "删除失败！");
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

    @ResponseBody
    @RequestMapping(value = "/user/getInfoById", method = RequestMethod.POST)
    public ResponseEntity<String> getUserInfoById( HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json="";
        try {
            String userId = request.getParameter("userId");
            if(userId!=null && !userId.equals("")){
                json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getUserInfoById(laiHuiDB, userId), "用户信息获取成功！");
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
}
