package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.Business;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/4/13 0013.
 */
@Controller
public class BusinessController {
    @Autowired
    LaiHuiDB laiHuiDB;
    @ResponseBody
    @RequestMapping(value = "/business", method = RequestMethod.POST)
    public ResponseEntity<String> business(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        String json = "";
        JSONObject bus = new JSONObject();
        JSONArray result = new JSONArray();
        List<Business> businessList = laiHuiDB.listBusiness();
        if(businessList.size()>0){
            for(Business business : businessList){
                JSONObject object = new JSONObject();
                object.put("mobile",business.getBusiness_mobile());
                object.put("name",business.getBusiness_name());
                object.put("address",business.getAddress());
                object.put("description",business.getCooperation_description());
                object.put("way",business.getCooperation_way());
                object.put("flag",business.getFlag());
                object.put("create_time",business.getCreate_time());
                object.put("id",business.get_id());
                result.add(object);
            }
            bus.put("data",result);
            json = ReturnJsonUtil.returnSuccessJsonString(bus, "数据查询成功！");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        }
        json = ReturnJsonUtil.returnFailJsonString(bus, "数据查询失败！");
        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
    }

}
