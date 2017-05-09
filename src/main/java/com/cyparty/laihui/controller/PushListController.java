package com.cyparty.laihui.controller;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.User;
import com.cyparty.laihui.utilities.NotifyPush;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import com.cyparty.laihui.utilities.Utils;
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
import java.util.Date;
import java.util.List;

/**
 * 消息模块
 */
@Controller
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
    /**
     * 推送活动
     * @param request
     * @param "mobile"
     * @param "url"
     * @param "type"
     * @param  "content"
     * @return result
     */
    @ResponseBody
    @RequestMapping(value = "/activity/push", method = RequestMethod.POST)
    public ResponseEntity<String> activity(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        String mobile = "";
        JSONObject activity = new JSONObject();
        JSONArray action = new JSONArray();
        String content = request.getParameter("content");

        int type =100 ;
        long start_time = new Date().getTime();
        int start =50000 ;
        int end = 50817;
        String url ="http://t.cn/RXYKmJN";
        List<User> users = laiHuiDB.getMobileUsers(" where _id >"+start+"  and _id <= "+end+ " ORDER BY _id ASC");
//        List<User> users = laiHuiDB.getMobileUsers(" where _id =30735");
        if(users.size()>0 ){
            int a =1;
            for(User user : users){
                mobile = user.getUser_mobile();
                content = "五一送大礼，3M滤水壶、小米手环、55度水杯，总有一款你喜欢，快来领取吧！http://t.cn/RXYKmJN";
                String startTime = Utils.getCurrentTime();
                activity.put("type",type);
                activity.put("mobile",user.getUser_mobile());
                activity.put("content",content);
                activity.put("link_url",url);
                List<User> userlist =laiHuiDB.getUserList("  where user_mobile ='"+mobile+"'");
                if(userlist.size()>0){
                    try{
                        notifyPush.pinCheNotifiy("100", mobile, content, userlist.get(0).getUser_id(), activity, startTime);
                    }catch (Exception e){
                        e.printStackTrace();
                        continue;
                    }
                    activity.put("user_id",userlist.get(0).getUser_id());
                    activity.put("a",a++);
                    action.add(activity);
                }
            }
            result.put("data",action);
            long end_time = new Date().getTime();
            long time =end_time-start_time;
            System.out.print(time);
            System.out.println(result.toJSONString());
            json = ReturnJsonUtil.returnSuccessJsonString(result, "活动消息推送成功！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }else{
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 统计推送总数
     * @param request
     * @return result
     */
    @ResponseBody
    @RequestMapping(value = "/push/last", method = RequestMethod.POST)
    public ResponseEntity<String> PushCount(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        int count = laiHuiDB.getCount("pc_user"," where _id >0");
        int last = laiHuiDB.getUserList(" where _id>0 order by _id desc limit 1").get(0).getUser_id();
        result.put("total",count);
        result.put("last",last);
        json = ReturnJsonUtil.returnSuccessJsonString(result, "统计成功！");
        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
    }
    /**
     * 推送活动
     * @param request
     * @param "start"
     * @param "end"
     * @param "url"
     * @param "type"
     * @param  "content"
     * @return result
     */
    @ResponseBody
    @RequestMapping(value = "/activities/push", method = RequestMethod.POST)
    public ResponseEntity<String> ActivitiesPush(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        String mobile = "";
        JSONObject activity = new JSONObject();
        JSONArray action = new JSONArray();
        String content = request.getParameter("content");
        String url = request.getParameter("url");
        String type = request.getParameter("type");
        long start_time = new Date().getTime();
        int last = NotifyPush.getLast(laiHuiDB);
        int start = Integer.parseInt(request.getParameter("start"));
        int end = Integer.parseInt(request.getParameter("end"));
        if(end>last){
            json = ReturnJsonUtil.returnFailJsonString(result, "不能超过最大id！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }
        if(start<0 || end<0 || start>end ){
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
        if(StringUtil.isBlank(content)||StringUtil.isBlank(url)||StringUtil.isBlank(type)){
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
        if(!type.equals("100")){
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
        List<User> users = laiHuiDB.getMobileUsers(" where _id >"+start+"  and _id <= "+end+ " ORDER BY _id ASC");
        if(users.size()>0 ){
            int a =1;
            for(User user : users){
                mobile = user.getUser_mobile();
//                content = "五一送大礼，3M滤水壶、小米手环、55度水杯，总有一款你喜欢，快来领取吧！http://t.cn/RXYKmJN";
                String startTime = Utils.getCurrentTime();
                activity.put("type",type);
                activity.put("mobile",user.getUser_mobile());
                activity.put("content",content);
                activity.put("link_url",url);
                List<User> userlist =laiHuiDB.getUserList("  where user_mobile ='"+mobile+"'");
                if(userlist.size()>0){
                    try{
                        notifyPush.pinCheNotifiy(type, mobile, content, userlist.get(0).getUser_id(), activity, startTime);
                    }catch (Exception e){
                        e.printStackTrace();
                        continue;
                    }
                    activity.put("user_id",userlist.get(0).getUser_id());
                    activity.put("a",a++);
                    action.add(activity);
                }
            }
            result.put("data",action);
            long end_time = new Date().getTime();
            long time =end_time-start_time;
            System.out.print(time);
            System.out.println(result.toJSONString());

            json = ReturnJsonUtil.returnSuccessJsonString(result, "活动消息推送成功！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }else{
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
}

