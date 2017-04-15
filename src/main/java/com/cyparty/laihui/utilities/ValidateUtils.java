package com.cyparty.laihui.utilities;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.domain.User;
import com.cyparty.laihui.domain.UserDriverLicenseInfo;
import com.cyparty.laihui.domain.UserTravelCardInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


/**
 * Created by Administrator on 2017/4/15 0015.
 */
public class ValidateUtils {

    //获取驾驶证，行驶证信息
    public  static  JSONObject getDriver(UserDriverLicenseInfo driverIfo, UserTravelCardInfo travelInfo){
        JSONObject result = new JSONObject();
        JSONObject driver = new JSONObject();
        JSONObject travel = new JSONObject();
        //驾驶证信息
        driver.put("id",driverIfo.getUser_id());
        driver.put("driver_name",driverIfo.getDriver_name());
        driver.put("driver_license_number",driverIfo.getDriver_license_number());
        driver.put("first_issue_date",driverIfo.getFirst_issue_date());
        driver.put("allow_car_type",driverIfo.getAllow_car_type());
        driver.put("effective_date_end",driverIfo.getEffective_date_end());
        driver.put("photo_url",driverIfo.getDriver_license_photo());
        driver.put("status",driverIfo.getIs_enable());
        //行驶证信息
        travel.put("id",travelInfo.getUser_id());
        travel.put("car_license_number",travelInfo.getCar_license_number());
        travel.put("car_color",travelInfo.getCar_color());
        travel.put("car_type",travelInfo.getCar_type());
        travel.put("registration_date",travelInfo.getRegistration_date());
        travel.put("vehicle_owner_name",travelInfo.getVehicle_owner_name());
        travel.put("photo_url",travelInfo.getTravel_license_photo());
        travel.put("status",travelInfo.getIs_enable());
        result.put("driver",driver);
        result.put("travel",travel);
        return result;
    }
    //推送消息
    public static JSONObject getContent(User user, String content){
        JSONObject driverInfo = new JSONObject();
        driverInfo.put("mobile", user.getUser_mobile());
        driverInfo.put("content", content);
        return driverInfo;
    }
}
