package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.Manager;
import com.cyparty.laihui.domain.ManagerAreaLocation;
import com.cyparty.laihui.domain.PlaceCode;
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
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhu on 2016/5/11.
 */
@Controller
public class ManagerController {
    private boolean is_logined;
    @Autowired
    LaiHuiDB laiHuiDB;
    @RequestMapping("/db/manage/agent")
    public String validate_car(Model model,HttpServletRequest request){
        is_logined= Utils.isLogined(request);
        if(is_logined){
            return "db_manage_agent";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @RequestMapping("/db/manage/agent/area/count")
    public String area_count(Model model,HttpServletRequest request){
        is_logined= Utils.isLogined(request);
        if(is_logined){
            return "db_manage_area_count";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @RequestMapping("/db/manage/agent/area/info")
    public String area_info(Model model,HttpServletRequest request){
        is_logined= Utils.isLogined(request);
        if(is_logined){
            return "db_manage_area_info";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    @RequestMapping(value = "/place/code", method = RequestMethod.POST)
    public ResponseEntity<String> getPlaceJson(HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        String json = "";
        JSONObject result = new JSONObject();
        String action = request.getParameter("action");
        String code =null;
        switch (action) {
            case "province":
                List<PlaceCode> provinceList = laiHuiDB.getAllProvince();
                json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPlaceJson(provinceList), "请求成功");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            case "city":
                code = request.getParameter("code");
                List<PlaceCode> cityList = laiHuiDB.getAllCity(Integer.parseInt(code));

                json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPlaceJson(cityList), "请求成功");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            case "county":
                code = request.getParameter("code");
                List<PlaceCode> countyList = laiHuiDB.getAllCity(Integer.parseInt(code));
                //todo:查询代理商代理区域
                String where=" where user_manage_area_code like '"+code.substring(0,4)+"%'" ;
                List<ManagerAreaLocation> hasCityList =laiHuiDB.getArea(where);
                //最终显示区域
                List<PlaceCode> lastCityList =new ArrayList<>();
                for(PlaceCode placeCode:countyList){
                    boolean is_existing=false;
                    for(ManagerAreaLocation placeCode1:hasCityList){
                        if(placeCode.getCode()==placeCode1.getArea_code()){
                            is_existing=true;
                            break;
                        }
                    }
                    if(!is_existing){
                        lastCityList.add(placeCode);
                    }
                }
                json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPlaceJson(lastCityList), "请求成功");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            case "query_county":
                code = request.getParameter("code");
                List<PlaceCode> query_countyList = laiHuiDB.getAllCity(Integer.parseInt(code));
                json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getPlaceJson(query_countyList), "请求成功");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        }
        json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
    }
    /**
     * 添加代理商
     *
     * */
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    @RequestMapping(value = "/api/area/manager", method = RequestMethod.POST)
    public ResponseEntity<String> localManager(HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        String json = "";
        JSONObject result = new JSONObject();
        String action = request.getParameter("action");
        String code =null;
        String name =request.getParameter("name");
        String mobile =request.getParameter("mobile");
        String md5_password =request.getParameter("md5_password");
        boolean is_success=false;
        String user_id=null;
        switch (action) {
            case "add":
                ManagerAreaLocation manager=new ManagerAreaLocation();
                manager.setUser_name(name);
                manager.setUser_mobile(mobile);
                manager.setUser_password(md5_password);
                int id=0;
                if(manager.getUser_mobile()!=null&&!manager.getUser_mobile().isEmpty()){
                    //创建区域代理商基本信息
                    String user_where=" where user_mobile like '"+mobile+"'";
                    int count=laiHuiDB.getCount("pc_area_manager",user_where);
                    if(count>0){
                        json = ReturnJsonUtil.returnFailJsonString(result, "手机号已注册");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                    id=laiHuiDB.createAreaManager(manager);
                }
                //创建代理区域信息
                if(id>0){
                    List<ManagerAreaLocation> managerAreaLocationList=new ArrayList<>();
                    String areaJson=request.getParameter("area_json");
                    if(areaJson!=null&&!areaJson.isEmpty()){
                        JSONArray areaArray=JSONArray.parseArray(areaJson);
                        for(int i=0;i<areaArray.size();i++){
                            ManagerAreaLocation managerAreaLocation=new ManagerAreaLocation();
                            JSONObject areaObject=areaArray.getJSONObject(i);
                            int area_code=areaObject.getIntValue("area_code");
                            String  area_name=areaObject.getString("area_name");

                            managerAreaLocation.setArea_name(area_name);
                            managerAreaLocation.setArea_code(area_code);
                            managerAreaLocation.setUser_id(id);

                            managerAreaLocationList.add(managerAreaLocation);
                        }
                        //创建代理区域
                        is_success=laiHuiDB.createAreaManageLocation(managerAreaLocationList);
                        if(is_success){
                            json = ReturnJsonUtil.returnSuccessJsonString(result, "创建成功");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                        json = ReturnJsonUtil.returnFailJsonString(result, "创建失败");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                }else {
                    json = ReturnJsonUtil.returnFailJsonString(result, "创建失败");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                }
            case "show":
                String level=request.getParameter("level");
                String keyword=request.getParameter("keyword");
                String start_time=request.getParameter("start_time");
                String end_time=request.getParameter("end_time");
                int now_user_id=0;
                if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                    now_user_id=Integer.parseInt(request.getParameter("id"));
                }
                int page=getPageOrSize(request,0);
                int size=getPageOrSize(request,1);

                code = request.getParameter("code");
                //直接查询
                json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getManagerInfo(laiHuiDB,keyword,start_time,end_time,page,size,level,code,now_user_id), "请求成功");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            case "delete":
                user_id=request.getParameter("id");
                String delete_sql=" where _id="+user_id;
                is_success=laiHuiDB.delete("pc_area_manager",delete_sql);
                delete_sql=" where user_id="+user_id;
                laiHuiDB.delete("pc_area_manager_location",delete_sql);
                if(is_success){
                    json = ReturnJsonUtil.returnSuccessJsonString(result, "删除成功");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                }
                json = ReturnJsonUtil.returnFailJsonString(result, "删除失败");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
            case "update":
                user_id=request.getParameter("id");
                if(user_id!=null&&!user_id.isEmpty()){
                    id=Integer.parseInt(user_id);
                }else {
                    id=0;
                }
                //删除之前的管辖区域
                delete_sql=" where user_id="+id;
                laiHuiDB.delete("pc_area_manager_location",delete_sql);

                List<ManagerAreaLocation> managerAreaLocationList=new ArrayList<>();
                String areaJson=request.getParameter("area_json");
                if(areaJson!=null&&!areaJson.isEmpty()) {
                    JSONArray areaArray = JSONArray.parseArray(areaJson);
                    for (int i = 0; i < areaArray.size(); i++) {
                        ManagerAreaLocation managerAreaLocation = new ManagerAreaLocation();
                        JSONObject areaObject = areaArray.getJSONObject(i);
                        int area_code = areaObject.getIntValue("area_code");
                        String area_name = areaObject.getString("area_name");

                        managerAreaLocation.setArea_code(area_code);
                        managerAreaLocation.setArea_name(area_name);
                        managerAreaLocation.setUser_id(id);

                        managerAreaLocationList.add(managerAreaLocation);
                    }
                    //创建代理区域
                    is_success = laiHuiDB.createAreaManageLocation(managerAreaLocationList);
                    if (is_success) {
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "修改成功");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "修改失败");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                }
        }
        json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
    }
    @ResponseBody
     @ResponseStatus(value = HttpStatus.OK)
     @RequestMapping(value = "/api/area/passenger/order", method = RequestMethod.POST)
     public ResponseEntity<String> passengerOrderCount(HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        String json = "";
        JSONObject result = new JSONObject();
        String action = request.getParameter("action");
        String code="";
        boolean is_success=false;
        String user_id=request.getParameter("id");
        int id=0;
        if(user_id!=null&&!user_id.isEmpty()){
            id=Integer.parseInt(user_id);
        }
        int page=getPageOrSize(request,0);
        int size=getPageOrSize(request,1);

        String start_time=request.getParameter("start_time");
        String end_time=request.getParameter("end_time");
        if(id>0){
            switch (action) {
                case "count":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getAreaPassengerOrdersCount(laiHuiDB,id), "每日增长订单量数据获取成功！");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                case "area_count":
                    code=request.getParameter("code");
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getAreaCount(laiHuiDB,code), "每日增长订单量数据获取成功！");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
                case "table_count":
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getAreaPassengerOrdersTableCount(laiHuiDB, id, start_time, end_time), "请求成功");
                    return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
            }
        }
        json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
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
