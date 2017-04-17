package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.Popularize;
import com.cyparty.laihui.domain.User;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import com.cyparty.laihui.utilities.SerialNumberUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/3/29 0029.
 */
@Controller
public class PopularizeController {
    @Autowired
    LaiHuiDB laiHuiDB;
    /**
     * 添加代理商
     *
     * */
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    @RequestMapping(value = "/api/popularize", method = RequestMethod.POST)
    public ResponseEntity<String> Popularize(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        String json = "";
        JSONObject result = new JSONObject();
        String mobile = request.getParameter("mobile");
        if(null != mobile && mobile.length() ==11){
            List<User> userList = laiHuiDB.getUserList(" where  user_mobile =" +mobile);
            if(userList.size()>0){
                User user = userList.get(0);
                int user_id = user.getUser_id();
                //手机号重复则不再生成推广码
                List<Popularize> popularizeList = laiHuiDB.getPopular(user_id);
                if(popularizeList.size() ==0 ){
                    String popularize_code = SerialNumberUtil.toSerialNumber(user_id);
                    boolean is_true =  false;
                    is_true = laiHuiDB.createPopularize(user_id, 0, null, popularize_code, 1, 0);
                    if(is_true){
                        result.put("msg","推广人推广码生成成功");
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "推广人推广码生成成功");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else{
                        result.put("msg","推广人推广码生成失败");
                        json = ReturnJsonUtil.returnFailJsonString(result, "推广人推广码生成失败");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                }else{
                    result.put("msg","推广人推广码已存在");
                    json = ReturnJsonUtil.returnFailJsonString(result, "推广人推广码已存在");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                }
            }else{
                json = ReturnJsonUtil.returnFailJsonString(result, "参数错误");
                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
            }
        }else{
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }

}
