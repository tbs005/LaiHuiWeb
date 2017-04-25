package com.cyparty.laihui.controller;


import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.User;
import com.cyparty.laihui.utilities.NotifyPush;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 消息模块
 */
@Controller
@ResponseBody
@RequestMapping(value = "/api/app", method = RequestMethod.POST)
public class PushListController {
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    NotifyPush notifyPush;


    /**
     * 生日推送
     * @param request
     * @param "mobile"
     * @param "url"
     * @param "type"
     * @param  "content"
     * @return result
     */
    @ResponseBody
    @RequestMapping(value = "/brith/push", method = RequestMethod.POST)
    public ResponseEntity<String> HappyBrith(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        String time = request.getParameter("time");
        int type = 50;
        String startTime = Utils.getCurrentTime();
        JSONObject birth = new JSONObject();
        String content = "";
        Date date = new Date();
        String brithday;
        if(null != time){
            brithday = time.replace("-","").substring(4,8);
        }else{
            brithday = Utils.getBrithDay(date);
        }

        String where = " a INNER JOIN (select CONCAT(right(left(user_idsn,14),4)) as birth ,_id  from pc_user   where  user_idsn is not null and length(user_idsn)>14)as b\n" +
                "on a._id = b._id where b.birth ='";
        List<User> userList = laiHuiDB.getUserList(where+brithday+"' and is_validated=1");
        if(userList.size()>0){
            for (User user : userList) {
                content =user.getUser_nick_name()+"你好:\n" +
                        "愿你\n" +
                        "一生努力，一生被爱\n" +
                        "想要的都拥有\n" +
                        "得不到的都释怀\n" +
                        "愿你被世界温柔以待\n" +
                        "来回拼车祝你生日快乐";
                birth.put("type",type);
                birth.put("mobile",user.getUser_mobile());
                birth.put("content",content);
                notifyPush.pinCheNotifiy(String.valueOf(type), user.getUser_mobile(), content, user.getUser_id(), birth, startTime);
                laiHuiDB.createPush(0,user.getUser_id(),content,50,1,"",2,"生日快乐");
            }
            result.put("data",birth);
            json = ReturnJsonUtil.returnSuccessJsonString(result, "生日消息推送成功！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }else {
            json = ReturnJsonUtil.returnFailJsonString(result, "生日消息推送失败！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }
    }
}
