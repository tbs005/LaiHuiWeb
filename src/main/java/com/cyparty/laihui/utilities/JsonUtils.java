package com.cyparty.laihui.utilities;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * Created by Administrator on 2017/4/14.
 */
public class JsonUtils {
    public static String returnFailJsonString(JSONObject result, String error_message) {
        JSONObject item = new JSONObject();
        item.put("message", error_message);
        item.put("status", false);
        item.put("result", result);
        String jsonString = JSON.toJSONString(item);
        return jsonString;
    }


    public static String returnSuccessJsonString(JSONObject result, String message) {
        JSONObject item = new JSONObject();
        item.put("message", message);
        item.put("status", true);
        item.put("result", result);
        String jsonString = item.toJSONString();
        return jsonString;
    }

}
