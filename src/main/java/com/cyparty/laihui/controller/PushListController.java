package com.cyparty.laihui.controller;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.User;
import com.cyparty.laihui.utilities.*;
import com.google.gson.Gson;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 推送模块
 */
@Controller
public class PushListController {
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    NotifyPush notifyPush;
    @Autowired
    OssUtil ossUtil;
    @Autowired
    OssConfigure ossConfigure;

    /**
     * 生日推送
     *
     * @param request
     * @param "mobile" 推送手机号
     * @param "type"   推送类型
     * @param "content" 推送内容
     * @return result   返回结果
     */
    @ResponseBody
    @RequestMapping(value = "/brith/push", method = RequestMethod.POST)
    public ResponseEntity<String> HappyBrith(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        Gson gson = new Gson();
        String json = "";
        String time = request.getParameter("time");
        int type = 50;
        String startTime = Utils.getCurrentTime();
        Map birth = new HashMap();
        String content = "";
        Date date = new Date();
        String brithday;
        if (null != time) {
            brithday = time.replace("-", "").substring(4, 8);
        } else {
            brithday = Utils.getBrithDay(date);
        }

        String where = " a INNER JOIN (select CONCAT(right(left(user_idsn,14),4)) as birth ,_id  from pc_user   where  user_idsn is not null and length(user_idsn)>14)as b\n" +
                "on a._id = b._id where b.birth ='";
        List<User> userList = laiHuiDB.getUserList(where + brithday + "' and is_validated=1");
        if (userList.size() > 0) {
            for (User user : userList) {
                content = user.getUser_nick_name() + "你好:\n" +
                        "愿你\n" +
                        "一生努力，一生被爱\n" +
                        "想要的都拥有\n" +
                        "得不到的都释怀\n" +
                        "愿你被世界温柔以待\n" +
                        "来回拼车祝你生日快乐";

                Map<String, String> extrasParam = new HashMap<String, String>();
                extrasParam.put("title","来回拼车");
                extrasParam.put("badge","Increment");
                extrasParam.put("action","com.laihui.pinche.push");
                //把自定义数据添加进去
                extrasParam.put("alert",content);
                extrasParam.put("notify_type",String.valueOf(type));
                extrasParam.put("id",String.valueOf(user.getUser_id()));
                extrasParam.put("badge","1");
                extrasParam.put("sound",type+".caf");
                birth.put("push_time",startTime);
                birth.put("content",content);
                birth.put("type", type);
                birth.put("mobile", user.getUser_mobile());
                birth.put("content", content);
                extrasParam.put("push",gson.toJson(birth));
                //将抢单信息通知给乘客
                JpushClientUtil.getInstance(ConfigUtils.JPUSH_APP_KEY,
                        ConfigUtils.JPUSH_MASTER_SECRET)
                        .sendToRegistrationId(String.valueOf(type), user.getUser_mobile(),
                                content, content, content,
                                extrasParam);
                laiHuiDB.createPush(0, user.getUser_id(), content, 50, 1, "", 2, "生日快乐",null);
            }
            result.put("data", birth);
            json = ReturnJsonUtil.returnSuccessJsonString(result, "生日消息推送成功！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        } else {
            json = ReturnJsonUtil.returnFailJsonString(result, "生日消息推送失败！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }
    }

    /**
     * 统计推送总数
     *
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
        int count = laiHuiDB.getCount("pc_user", " where _id >0");
        int last = laiHuiDB.getUserList(" where _id>0 order by _id desc limit 1").get(0).getUser_id();
        result.put("total", count);
        result.put("last", last);
        json = ReturnJsonUtil.returnSuccessJsonString(result, "统计成功！");
        return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
    }

    /**
     * 推送活动
     *
     * @param request
     * @param "start"   开始推送ID
     * @param "end"     推送截止ID
     * @param "url"     推送活动链接
     * @param "img"     推送图片
     * @param "type"    类型
     * @param "content" 推送内容
     * @return result  返回结果
     */
    @ResponseBody
    @RequestMapping(value = "/activities/push", method = RequestMethod.POST)
    public ResponseEntity<String> ActivitiesPush(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result = new JSONObject();
        JSONArray action = new JSONArray();
        Gson gson = new Gson();
        String json = "";
        String image_url = "";
        String filePath = Utils.fileImgUpload("img", request);
        if (filePath != null && !filePath.trim().equals("")) {
            String image_local = filePath.substring(filePath.indexOf("upload"));
            String arr[] = image_local.split("\\\\");
            String image_oss = arr[arr.length - 1];
            try {
                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                    image_oss = "https://" + ossConfigure.getAccessUrl() + image_oss;
                    image_url = image_oss;
                }
            } catch (Exception e) {
                image_oss = null;
                image_url = image_oss;
            }
        }
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String url = request.getParameter("url");
        String type = request.getParameter("type");
        long start_time = new Date().getTime();
        int last = NotifyPush.getLast(laiHuiDB);
        int start = Integer.parseInt(request.getParameter("start"));
        int end = Integer.parseInt(request.getParameter("end"));
        if (end > last) {
            json = ReturnJsonUtil.returnFailJsonString(result, "不能超过最大id！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
        }
        if (start < 0 || end < 0 || start > end) {
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
        if (StringUtil.isBlank(content) || StringUtil.isBlank(url) || StringUtil.isBlank(type)) {
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
        if (type.equals("") && type == null) {
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
        List<User> users = laiHuiDB.getMobileUsers(" where _id >"+start+"  and _id <= "+end+ " ORDER BY _id ASC");
        if(users.size()>0 ) {
            int a = 1;
            for (User user : users) {
                String mobile = user.getUser_mobile();
                String startTime = Utils.getCurrentTime();
                List<User> userlist = laiHuiDB.getUserList("  where user_mobile ='" + mobile + "'");
                if (userlist.size() > 0) {
                    try {
                        Map activity = new HashMap();
                        Map<String, String> extrasParam = new HashMap<String, String>();
                        extrasParam.put("title","来回拼车");
                        extrasParam.put("badge","Increment");
                        extrasParam.put("action","com.laihui.pinche.push");
                        //把自定义数据添加进去
                        extrasParam.put("alert",content);
                        extrasParam.put("notify_type",String.valueOf(type));
                        extrasParam.put("id",String.valueOf(user.getUser_id()));
                        extrasParam.put("badge","1");
                        extrasParam.put("sound",type+".caf");
                        activity.put("push_time",Utils.getCurrentTime());
                        activity.put("content",content);
                        activity.put("type", type);
                        activity.put("mobile", mobile);
                        activity.put("content", content);
                        activity.put("user_id", userlist.get(0).getUser_id());
                        activity.put("a", a++);
                        action.add(gson.toJson(activity));
                        extrasParam.put("push",gson.toJson(activity));
                        //将抢单信息通知给乘客
                        JpushClientUtil.getInstance(ConfigUtils.JPUSH_APP_KEY,
                                ConfigUtils.JPUSH_MASTER_SECRET)
                                .sendToRegistrationId(String.valueOf(type), mobile,
                                        content, content, content,
                                        extrasParam);
                    } catch (Exception e) {
                        e.printStackTrace();
                        continue;
                    }
                }
            }
            boolean success = laiHuiDB.createPush(0, 0, content, Integer.parseInt(type), 1, url, 1, title, image_url);
            if (success) {
                result.put("data",action);
                json = ReturnJsonUtil.returnSuccessJsonString(result, "精选活动推送成功！");
                return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
            } else {
                json = ReturnJsonUtil.returnFailJsonString(result, "精选活动推送失败！");
                return new ResponseEntity<>(json, responseHeaders, HttpStatus.OK);
            }
        }else {
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误！");
            return new ResponseEntity<>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
}


