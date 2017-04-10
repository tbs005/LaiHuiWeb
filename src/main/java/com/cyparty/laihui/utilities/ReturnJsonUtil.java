package com.cyparty.laihui.utilities;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Shadow on 2016/5/3.
 */
public class ReturnJsonUtil {
    /**
     * 返回成功信息
     *
     * @param result        需要返回的值
     * @param error_message 提示信息
     * @return
     */
    public static String returnFailJsonString(JSONObject result, String error_message) {
        JSONObject item = new JSONObject();
        item.put("message", error_message);
        item.put("status", false);
        item.put("result", result);
        String jsonString = JSON.toJSONString(item);
        return jsonString;
    }

    /**
     * 返回失败信息
     *
     * @param result  需要返回的值
     * @param message 提示信息
     * @return
     */
    public static String returnSuccessJsonString(JSONObject result, String message) {
        JSONObject item = new JSONObject();
        item.put("message", message);
        item.put("status", true);
        item.put("result", result);
        String jsonString = item.toJSONString();
        return jsonString;
    }

    /**
     * 获取ContentTypeList
     *
     * @param laiHuiDB 数据库连接
     * @return
     */



    public static JSONObject getDriverAllInfo(LaiHuiDB laiHuiDB,int id,int role) {
        JSONObject return_json = new JSONObject();
        String where=" where _id="+id;
        if(role==1){
            where=" where user_id="+id;
            List<CarOwnerInfo> carOwnerInfoList=laiHuiDB.getCarOwnerInfo(where);
            if(carOwnerInfoList.size()>0){
                CarOwnerInfo carOwnerInfo =laiHuiDB.getCarOwnerInfo(where).get(0);
                return_json.put("name",carOwnerInfo.getCar_owner_name());
                return_json.put("car_id",carOwnerInfo.getCar_id());
                return_json.put("brand",carOwnerInfo.getCar_brand());
                return_json.put("color",carOwnerInfo.getCar_color());
                return_json.put("type",carOwnerInfo.getCar_type());
            }
            int count=laiHuiDB.getTotalCount("pc_driver_publish_info",where);
            return_json.put("pc_count",count);
        }else if(role==2){
            User user=laiHuiDB.getUserList(where).get(0);
            if(user.getUser_name()==null&&user.getUser_idsn()==null){
                return_json.put("passenger_status",0);
            }else {
                return_json.put("name",user.getUser_name());
                String idsn=user.getUser_idsn();
                return_json.put("idsn",idsn);
                return_json.put("passenger_status",1);
            }
        }
        return return_json;
    }

    /***
     *
     * @param laiHuiDB
     * @param source
     * @return
     */
    public static JSONObject getUserCount(LaiHuiDB laiHuiDB,int source,String user_data) {
        JSONObject return_json = new JSONObject();
        List<UserCount> userCounts=new ArrayList<>();
        String user_type="";
        if(user_data.equals("all_user")){
            user_type="all_user";
        }else if(user_data.equals("validated_user")){
            user_type="validated_user";
        }else if(user_data.equals("car_user")){
            user_type="car_user";
        }
        if(source==0){
            userCounts=laiHuiDB.getWxUserCount(0,user_type);
        }else if(source==1){
            userCounts=laiHuiDB.getWxUserCount(1,user_type);
        }else if(source==2){
            userCounts=laiHuiDB.getWxUserCount(2,user_type);
        }
        JSONArray jsonArray = new JSONArray();
        String start_date=Utils.getCurrentTimeSubOrAddHour(-24*ConfigUtils.getShow_days()).split(" ")[0];
        String end_date=Utils.getCurrentTime().split(" ")[0];
        Map<String,UserCount> userCountMap=new LinkedHashMap<>();
        for(int i=-6;i<=0;i++){
            UserCount userCount=new UserCount();
            start_date=Utils.getCurrentTimeSubOrAddHour(24*i).split(" ")[0];
            userCount.setCreate_time(start_date);
            userCount.setTotal(0);
            userCountMap.put(start_date,userCount);
        }
        for (String key : userCountMap.keySet()) {
            for(UserCount count:userCounts){
                if(key.equals(count.getCreate_time())){
                    userCountMap.put(key,count);
                    break;
                }
            }

        }
        for (String key : userCountMap.keySet()) {
            UserCount count=userCountMap.get(key);

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("date",count.getCreate_time());
            jsonObject.put("count",count.getTotal());
            jsonArray.add(jsonObject);
        }
        return_json.put("data",jsonArray);
        return_json.put("start_date",start_date);
        return_json.put("end_date",end_date);

        return return_json;
    }
    //司机发车数据统计
    public static JSONObject getDepartureCount(LaiHuiDB laiHuiDB) {
        JSONObject return_json = new JSONObject();
        List<UserCount> userCounts= laiHuiDB.getDepartureCount();

        JSONArray jsonArray = new JSONArray();
        String start_date=Utils.getCurrentTimeSubOrAddHour(-24*ConfigUtils.getShow_days()).split(" ")[0];
        String end_date=Utils.getCurrentTime().split(" ")[0];
        Map<String,UserCount> userCountMap=new LinkedHashMap<>();
        for(int i=-6;i<=0;i++){
            UserCount userCount=new UserCount();
            start_date=Utils.getCurrentTimeSubOrAddHour(24*i).split(" ")[0];
            userCount.setCreate_time(start_date);
            userCount.setTotal(0);
            userCountMap.put(start_date,userCount);
        }
        for (String key : userCountMap.keySet()) {
            for(UserCount count:userCounts){
                if(key.equals(count.getCreate_time())){
                    userCountMap.put(key,count);
                    break;
                }
            }
        }
        for (String key : userCountMap.keySet()) {
            UserCount count=userCountMap.get(key);

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("date",count.getCreate_time());
            jsonObject.put("count",count.getTotal());
            jsonArray.add(jsonObject);
        }
        return_json.put("data",jsonArray);
        return_json.put("start_date",start_date);
        return_json.put("end_date",end_date);

        return return_json;
    }
    /***
     *
     * @param laiHuiDB
     * @param keyword
     * @param start_time
     * @param end_time
     * @param is_validated_passenger
     * @param is_validated_car
     * @param page
     * @param size
     * @param id
     * @return
     */
    public static JSONObject getUserInfo(LaiHuiDB laiHuiDB,String keyword,String start_time,String end_time,String is_validated_passenger,String is_validated_car,int page,int size,int id){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String where ="";
        if(id==0){
            where =" where _id >0";
            if(keyword!=null&&!keyword.trim().equals("")){
                where=where+" and (user_name like '%"+keyword+"%' or user_mobile like '%"+keyword+"%'  or user_idsn like '%"+keyword+"%')";
            }
            if(start_time!=null&&!start_time.trim().equals("")){
                where=where+" and user_create_time >'"+start_time+"'";
            }
            if(end_time!=null&&!end_time.trim().equals("")){
                where=where+" and user_create_time <'"+end_time+"'";
            }
            if(is_validated_passenger!=null&&!is_validated_passenger.trim().equals("")){
                if(is_validated_passenger.equals("0")){
                    where=where+" and is_validated =0";
                }else if(is_validated_passenger.equals("1")){
                    where=where+" and is_validated =1";
                }
            }
            if(is_validated_car!=null&&!is_validated_car.trim().equals("")){
                if(is_validated_car.equals("0")){
                    where=where+" and is_car_owner !=1";
                }else if(is_validated_car.equals("1")){
                    where=where+" and is_car_owner =1";
                }
            }
        }else {
            where=where+" where _id="+id;
        }
        int count=laiHuiDB.getUserList(where).size();
        int offset=page*size;
        where=where+" order by user_create_time DESC "+" limit "+offset+","+size;
        List<User> userList=laiHuiDB.getUserList(where);
        for(int i=0;i<userList.size();i++){
            User user=userList.get(i);
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("id",user.getUser_id());
            jsonObject.put("mobile",user.getUser_mobile());
            jsonObject.put("create_time",user.getUser_create_time());
            jsonObject.put("last_logined_time",user.getUser_last_login());
            jsonObject.put("last_login_ip",user.getUser_last_login_ip());
            jsonObject.put("name",user.getUser_name());
            String idsn=user.getUser_idsn();
            jsonObject.put("idsn",idsn);
            jsonObject.put("is_validated_passenger",user.getIs_validated());
            jsonObject.put("is_validated_car",user.getIs_car_owner());

            dataArray.add(jsonObject);
        }
        result_json.put("count",count);
        result_json.put("data",dataArray);
        return result_json;
    }
    public static JSONObject getManagerJson(LaiHuiDB laiHuiDB,int page,int size){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String where=" where is_enable=1 and m_privilege=1";
        int offset=page*size;
        int count=laiHuiDB.getManager(where).size();
        where=where+" limit "+offset+","+size;
        List<Manager> managerList=laiHuiDB.getManager(where);
        for(Manager manager:managerList){
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("id",manager.getM_id());

            jsonObject.put("name",manager.getName());
            jsonObject.put("mobile",manager.getMobile());
            jsonObject.put("description",manager.getDecription());
            jsonObject.put("last_login_time",manager.getLast_login_time());

            dataArray.add(jsonObject);
        }
        result_json.put("total",count);
        result_json.put("page",page);
        result_json.put("size",size);
        result_json.put("data",dataArray);
        return result_json;
    }
    public static JSONObject getAPPDriverDepartureList(LaiHuiDB appDB, int page, int size,String start_time,String end_time,String keyword,String source,int user_id) {
        JSONObject result_json = new JSONObject();
        JSONArray dataArray = new JSONArray();
        String where = " where is_enable=1 ";

        int count =0;
        if((start_time==null||start_time.isEmpty())&&(end_time==null||end_time.isEmpty())){
            where=where+" and create_time >= '"+Utils.getCurrentTime().split(" ")[0]+" 00:00:00'";
        }else {
            if(start_time!=null&&!start_time.isEmpty()){
                where=where+" and create_time >= '"+start_time+"'";
            }
            if(end_time!=null&&!end_time.isEmpty()){
                where=where+" and create_time <= '"+end_time+"'";
            }
        }
        if(keyword!=null&&!keyword.isEmpty()){
            where=where+" and (mobile like '%"+keyword+"%' or user_mobile like '%"+keyword+"%' )";
        }
        if(source!=null&&!source.isEmpty()){
            //0 :android ;1:ios
            where=where+" and a.source="+source;
        }
        if(user_id!=0){
            where=where+" and user_id="+user_id;
        }
       /* //1.最精确
        where=where+" and departure_address_code="+departure_address_code+" and destination_address_code="+destination_address_code+ " and start_time>='" + Utils.getCurrentTime()+"'"+ " order by start_time ASC ";
        List<DepartureInfo> departureInfoList1 = appDB.getAppDriverepartureInfo(where);
        //2.锁定目的地code
        String city_code=(departure_address_code+"").substring(0,4)+"00";
        where=" where is_enable=1 and departure_city_code ="+city_code+" and departure_address_code!="+departure_address_code+" and destination_address_code="+destination_address_code+ " and start_time>='" + Utils.getCurrentTime()+"'"+ " order by start_time ASC ";
        List<DepartureInfo> departureInfoList2 = appDB.getAppDriverepartureInfo(where);
        //3.锁定出发地code
        String des_city_code=(destination_address_code+"").substring(0,4)+"00";
        where=" where is_enable=1  and departure_address_code="+departure_address_code+" and destination_address_code!="+destination_address_code+ " and destination_city_code = "+des_city_code+ " and start_time>='" + Utils.getCurrentTime()+"'"+ " order by start_time ASC ";
        List<DepartureInfo> departureInfoList3 = appDB.getAppDriverepartureInfo(where);
        //4.两边都使用citycode
        where=" where is_enable=1 and departure_city_code ="+city_code+" and departure_address_code!="+departure_address_code+" and destination_address_code !="+destination_address_code+ " and destination_city_code = "+des_city_code+" and start_time>='" + Utils.getCurrentTime()+"'"+ " order by start_time ASC ";*/
        List<DepartureInfo> departureInfoList  = new ArrayList<>();

        int offset=page*size;
        count = appDB.getCount("pc_driver_publish_info"," a  left join pc_user b on a.mobile=b.user_mobile "+where);
        //按照创建时间倒序排列
        where = where + " order by create_time DESC limit "+offset+","+size;
        departureInfoList = appDB.getAppDriverepartureInfo(where);
        for (DepartureInfo departure : departureInfoList) {
            JSONObject driverObject = new JSONObject();
            JSONObject dataObject = new JSONObject();
            driverObject.put("mobile", departure.getMobile());
          /*  String user_where=" where user_mobile like '%"+departure.getMobile()+"%'";
            List<User> userList=appDB.getUserList(user_where);
            if(userList.size()>0){*/
            where=" where user_id="+departure.getUser_id();
            List<CarOwnerInfo> carOwnerInfoList=appDB.getCarOwnerInfo(where);
            if(carOwnerInfoList.size()>0){
                CarOwnerInfo carOwnerInfo=carOwnerInfoList.get(0);
                driverObject.put("car_no",carOwnerInfo.getCar_id());
                driverObject.put("car_brand",carOwnerInfo.getCar_brand());
                driverObject.put("car_color",carOwnerInfo.getCar_color());
                driverObject.put("car_type",carOwnerInfo.getCar_type());
            }
            driverObject.put("name", departure.getUser_name());
            driverObject.put("avatar", departure.getUser_avatar());
           /* }else {
                driverObject.put("name", departure.getUser_name());
                driverObject.put("avatar", departure.getUser_avatar());
            }*/

            dataObject.put("id", departure.getR_id());
            dataObject.put("start_time", departure.getStart_time());
            dataObject.put("init_seats", departure.getInit_seats());
            dataObject.put("create_time", departure.getCreate_time());
            dataObject.put("boarding_point",JSONObject.parseObject(departure.getBoarding_point()));
            dataObject.put("breakout_point",JSONObject.parseObject(departure.getBreakout_point()));

            dataObject.put("user_data",driverObject);

            dataArray.add(dataObject);
        }
        result_json.put("data", dataArray);
        result_json.put("total", count);
        result_json.put("page", page);
        result_json.put("size", size);
        return result_json;
    }
    public static JSONObject getAPPDriverDepartureInfo(LaiHuiDB appDB, String order_id) {
        JSONObject jsonObject = new JSONObject();
        JSONObject return_json = new JSONObject();
        String where = " where is_enable=1 and a._id= "+order_id;

        List<DepartureInfo> departureInfoList = appDB.getAppDriverepartureInfo(where);
        for (DepartureInfo departure : departureInfoList) {
            JSONObject driverObject=new JSONObject();
            jsonObject.put("id", departure.getR_id());

            where=" where _id="+order_id;
            DepartureInfo departureInfo=departureInfoList.get(0);
            where=" where user_id ="+departureInfo.getUser_id();
            List<CarOwnerInfo> carOwnerInfoList=appDB.getCarOwnerInfo(where);
            if(carOwnerInfoList.size()>0){
                CarOwnerInfo carOwnerInfo =appDB.getCarOwnerInfo(where).get(0);

                driverObject.put("name",departureInfo.getUser_name());
                driverObject.put("avatar",departureInfo.getUser_avatar());
                driverObject.put("car_no",carOwnerInfo.getCar_id());
                driverObject.put("car_brand",carOwnerInfo.getCar_brand());
                driverObject.put("car_color",carOwnerInfo.getCar_color());
                driverObject.put("car_type",carOwnerInfo.getCar_type());
                driverObject.put("mobile", departure.getMobile());
            }

            //统计全部拼车次数
            String where_count=" where user_id ="+departure.getUser_id()+" and is_enable=1";
            int departure_total =appDB.getCount("pc_driver_publish_info",where_count);//发车次数
            where_count=where_count+" and order_status =1";
            int order_total =appDB.getCount("pc_passenger_orders",where_count);//订单次数

            driverObject.put("pc_count",order_total+departure_total);

            jsonObject.put("price",departure.getPrice());

            jsonObject.put("start_time", departure.getStart_time());
            jsonObject.put("boarding_point", JSONObject.parseObject(departure.getBoarding_point()));
            jsonObject.put("breakout_point", JSONObject.parseObject(departure.getBreakout_point()));
            jsonObject.put("init_seats", departure.getInit_seats());
            jsonObject.put("info_status", departure.getStatus());
            jsonObject.put("create_time", departure.getCreate_time());
            jsonObject.put("points", departure.getPoints());
            jsonObject.put("description", departure.getDescription());

            String order_where=" where order_id="+departure.getR_id()+" and is_enable=1 and order_status!=-1 ";
            int booking_count=appDB.getCount("pc_passenger_orders",order_where);
            jsonObject.put("booking_count", booking_count);


            List<PassengerOrder> passengerOrders=appDB.getPassengerOrder(order_where);
            JSONArray orderArray=new JSONArray();
            if(passengerOrders.size()>0){
                for(PassengerOrder passengerOrder:passengerOrders){
                    JSONObject passengerData=new JSONObject();
                    JSONObject orderObject=new JSONObject();
                    orderObject.put("order_id",passengerOrder.get_id());
                    orderObject.put("boarding_point",JSONObject.parseObject(passengerOrder.getBoarding_point()));
                    orderObject.put("breakout_point",JSONObject.parseObject(passengerOrder.getBreakout_point()));
                    orderObject.put("booking_seats",passengerOrder.getSeats());
                    orderObject.put("order_status",passengerOrder.getOrder_status());
                    orderObject.put("create_time",passengerOrder.getCreate_time());
                    orderObject.put("description",passengerOrder.getDescription());
                    passengerData.put("name",passengerOrder.getUser_name());
                    passengerData.put("mobile",passengerOrder.getMobile());
                    passengerData.put("avatar",passengerOrder.getUser_avatar());

                    orderObject.put("user_data",passengerData);
                    orderArray.add(orderObject);
                }
            }
            jsonObject.put("user_data",driverObject);

            return_json.put("driver_data",jsonObject);
            return_json.put("passenger_data",orderArray);
        }
        return return_json;
    }
    public static JSONObject getValidateJson(LaiHuiDB laiHuiDB,String status,int page ,int size,String start_time,String end_time,String keyword){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String where="SELECT * FROM pc_car_owner_info a inner join pc_user_token b on a.user_id=b.user_id where review_status="+status;

        if(status.equals("2")){
            if(start_time!=null&&!start_time.trim().equals("")){
                where=where+" and car_validate_date>'"+start_time+"'";
            }
            if(end_time!=null&&!end_time.trim().equals("")){
                where=where+" and car_validate_date<'"+end_time+"'";
            }
        }else {
            if(start_time!=null&&!start_time.trim().equals("")){
                where=where+" and checked_time>'"+start_time+"'";
            }
            if(end_time!=null&&!end_time.trim().equals("")){
                where=where+" and checked_time<'"+end_time+"'";
            }
        }
        if(keyword!=null&&!keyword.trim().equals("")){
            where=where+" and (car_owner like '%"+keyword+"%' or car_brand like '%"+keyword+"%')";
        }
        if(!status.equals("2")){

            where=where+" order by checked_time DESC ";
        }else {
            where=where+" order by car_validate_date ASC ";
        }
        int count=laiHuiDB.getCarOwnerInfoToken(where).size();
        int offset=page*size;

        where=where+" limit "+offset+","+size;
        List<CarOwnerInfo> carOwnerInfoList =laiHuiDB.getCarOwnerInfoToken(where);
        for(CarOwnerInfo carOwnerInfo:carOwnerInfoList){
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("name",carOwnerInfo.getCar_owner_name());
            jsonObject.put("idsn",carOwnerInfo.getIdsn());
            jsonObject.put("car_type",carOwnerInfo.getCar_brand());
            jsonObject.put("validate_date",carOwnerInfo.getCar_validate_date());
            jsonObject.put("checked_date",carOwnerInfo.getChecked_time());
            jsonObject.put("token",carOwnerInfo.getToken());
            dataArray.add(jsonObject);
        } 
        result_json.put("data",dataArray);
        result_json.put("status",status);
        result_json.put("total",count);
        result_json.put("page",page);
        result_json.put("size",size);
        return result_json;
    }
   /* public static JSONObject getPassengerDepartureInfo(LaiHuiDB laiHuiDB,int page ,int size,String departure_city,String destination_city,String start_time,String end_time,String order_id,int id){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        //+"and start_time>'"+Utils.getCurrentTimeSubOrAdd(-120)+"'"
        String where=" where _id > 0 ";
        if(id!=0){
            where=where+" and user_id ="+id;
        }
        if(order_id!=null&&!order_id.trim().equals("")){
            where=where +" and  _id="+order_id;
        }else {
            if(departure_city!=null&&!departure_city.trim().equals("")){
                where=where+" and departure_city='"+departure_city+"'";
            }
            if(destination_city!=null&&!destination_city.trim().equals("")){
                where=where+" and destination_city='"+destination_city+"'";
            }
            if(start_time!=null&&!start_time.trim().equals("")){
                where=where+" and start_time >='"+start_time+"'";
            }
            if(end_time!=null&&!end_time.trim().equals("")){
                where=where+" and end_time <='"+end_time+"'";
            }else {
                where=where+" and end_time>='"+Utils.getCurrentTime()+"'";
            }
        }
        int count=laiHuiDB.getPassengerDepartureInfo(where).size();
        int offset=page*size;
        where=where+" limit "+offset+","+size;
        List<PassengerPublishInfo> passengerPublishInfoList =laiHuiDB.getPassengerDepartureInfo(where);
        for(PassengerPublishInfo passenger:passengerPublishInfoList){
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("id",passenger.get_id());
            String user_where=" where _id="+passenger.getUser_id();
            String name=laiHuiDB.getUserList(user_where).get(0).getUser_name();
            String token=laiHuiDB.getUserTokenByID(passenger.getUser_id());
            jsonObject.put("name",name);
            jsonObject.put("token",token);
            jsonObject.put("start_time",passenger.getStart_time());
            jsonObject.put("end_time",passenger.getEnd_time());
            jsonObject.put("departure_city",passenger.getDeparture_city());
            jsonObject.put("destination_city",passenger.getDestination_city());
            jsonObject.put("booking_seats",passenger.getBooking_seats());
            jsonObject.put("departure",passenger.getDeparture());
            jsonObject.put("destination",passenger.getDestination());
            jsonObject.put("boarding_point",passenger.getBoarding_point());
            jsonObject.put("breakout_point",passenger.getBreakout_point());
            jsonObject.put("description",passenger.getDescription());
            jsonObject.put("create_time",passenger.getCreate_time());

            dataArray.add(jsonObject);
        }
        result_json.put("data",dataArray);
        result_json.put("total",count);
        result_json.put("page",page);
        result_json.put("size",size);
        return result_json;
    }*/

    //
    public static JSONObject getPayOrderList(LaiHuiDB laiHuiDB,String status,int page,int size,String keyword) {
        JSONObject return_json = new JSONObject();
        JSONArray jsonArray=new JSONArray();
        String where ="";
        if(status!=null){
            where = " where pay_status=" + status;
        }else {
            where=" where pay_status =1 or pay_status=-1 ";
        }
        if(keyword!=null){
            where = where+" order_id ="+keyword;
        }
        int count =laiHuiDB.getCount("pc_wx_passenger_orders",where);
        int offset=page*size;
        where=where+" order by create_time desc limit "+offset+","+size;
        List<PayOrder> payOrderList=laiHuiDB.getOrderPayList(where);

        for(PayOrder pay:payOrderList){
            JSONObject dataObject=new JSONObject();

            dataObject.put("user_id",pay.getUser_id());
            dataObject.put("user_name", pay.getUser_name());
            dataObject.put("mobile", pay.getUser_mobile());
            dataObject.put("money", pay.getPay_money());
            dataObject.put("create_time", pay.getCreate_time());
            dataObject.put("order_id", pay.getOrder_id());
            dataObject.put("pay_num", pay.getPay_num());
            dataObject.put("pay_status", pay.getPay_status());

            jsonArray.add(dataObject);
        }

        return_json.put("data",jsonArray);
        return_json.put("page",page);
        return_json.put("size",size);
        return_json.put("total",count);

        return return_json;
    }

    /***
     * app用户反馈信息
     * 更新
     * @param laiHuiDB
     * @return
     */
    public static JSONObject getUserSuggestions(LaiHuiDB laiHuiDB,int page,int size,int source) {
        JSONObject return_json = new JSONObject();
        JSONArray jsonArray=new JSONArray();
        int offset=page*size;
        String where ="";
        if(source==0){
            //来自android用户反馈
            where=" where a.source = 0 ";
        }else if(source==1){
            //来自ios用户反馈
            where=" where a.source = 1";
        }
        String count_where=" where 1=1 ";
        if(source!=2){
            count_where=count_where+" and source = "+source;
        }
        int count=laiHuiDB.getCount("pc_user_suggestion",count_where);
        where=where+" order by create_time DESC ";
        where =where+" limit "+offset+","+size;
        List<UserSuggestion> suggestionList=laiHuiDB.getUserSuggestion(where);
        for(UserSuggestion suggestion:suggestionList){
          JSONObject dataObject=new JSONObject();
          dataObject.put("name",suggestion.getUser_name());
          dataObject.put("id",suggestion.get_id());
          dataObject.put("avatar",suggestion.getUser_avatar());
          dataObject.put("mobile",suggestion.getUser_mobile());
          dataObject.put("content",suggestion.getContent());
          dataObject.put("create_time",suggestion.getCreate_time());
          dataObject.put("source",suggestion.getSource());

          jsonArray.add(dataObject);
        }

        return_json.put("data",jsonArray);
        return_json.put("total",count);
        return_json.put("page",page);
        return_json.put("size",size);

        return return_json;
    }
    /***
     *
     *乘客订单模块
     */

    public static JSONObject getBookingOrderList(LaiHuiDB appDB, int page, int size,String start_time,String end_time,String keyword,String source,int user_id,String code) {
        JSONObject result_json = new JSONObject();
        JSONArray dataArray = new JSONArray();
        String where = " where is_enable=1 ";
        if(start_time==null&&end_time==null){
            where=where+" and create_time >= '"+Utils.getCurrentTime().split(" ")[0]+" 00:00:00'";
        }else {
            if(start_time!=null&&!start_time.isEmpty()){
                where=where+" and create_time >= '"+start_time+"'";
            }
            if(end_time!=null&&!end_time.isEmpty()){
                where=where+" and create_time <= '"+end_time+"'";
            }
        }
        if(keyword!=null&&!keyword.isEmpty()){
            where=where+" and (user_mobile like '%"+keyword+"%' or user_name like '%"+keyword+"%')";
        }
        if(source!=null&&!source.isEmpty()){
            //0 :android ;1:ios
            where=where+" and a.source="+source;
        }
        if(user_id!=0){
            where=where+" and user_id="+user_id;
        }
        if(code!=null&&!code.isEmpty()){
            where=where+" and destination_address_code="+code;
        }
        int count = appDB.getCount("pc_passenger_orders"," a left join pc_user b on a.user_id=b._id "+where);
        int offset = page * size;

        where = where + " order by create_time DESC limit " + offset + "," + size;
        List<PassengerOrder> passengerOrders = appDB.getPassengerOrder(where);
        for (PassengerOrder passengerOrder : passengerOrders) {
            JSONObject jsonObject = new JSONObject();
            JSONObject passengerData=new JSONObject();

            jsonObject.put("order_id",passengerOrder.get_id());
            jsonObject.put("booking_seats",passengerOrder.getSeats());
            jsonObject.put("boarding_point",JSONObject.parseObject(passengerOrder.getBoarding_point()));
            jsonObject.put("breakout_point",JSONObject.parseObject(passengerOrder.getBreakout_point()));
            jsonObject.put("description",passengerOrder.getDescription());
            jsonObject.put("create_time",passengerOrder.getCreate_time());
            jsonObject.put("order_status",passengerOrder.getOrder_status());

            passengerData.put("user_name",passengerOrder.getUser_name());
            passengerData.put("user_avatar",passengerOrder.getUser_avatar());
            passengerData.put("user_mobile",passengerOrder.getMobile());

            jsonObject.put("user_data",passengerData);
            dataArray.add(jsonObject);
        }
        result_json.put("data", dataArray);
        result_json.put("total", count);
        result_json.put("page", page);
        result_json.put("size", size);
        return result_json;
    }
    public static JSONObject getBookingOrderInfo(LaiHuiDB appDB, String order_id) {
        JSONObject jsonObject = new JSONObject();
        JSONObject return_json = new JSONObject();
        String where = " where is_enable=1 and a._id= "+order_id;

        List<PassengerOrder> passengerOrders = appDB.getPassengerOrder(where);
        if( passengerOrders.size()>0) {
            JSONObject driverObject=new JSONObject();

            PassengerOrder passengerOrder=passengerOrders.get(0);

            where=" where a._id ="+passengerOrder.getDriver_order_id();
            DepartureInfo departure=appDB.getAppDriverepartureInfo(where).get(0);
            where=" where user_id="+departure.getUser_id();
            List<CarOwnerInfo> carOwnerInfoList=appDB.getCarOwnerInfo(where);
            if(carOwnerInfoList.size()>0){
                CarOwnerInfo carOwnerInfo =carOwnerInfoList.get(0);

                driverObject.put("name",departure.getUser_name());
                driverObject.put("avatar",carOwnerInfo.getUser_avatar());
                driverObject.put("mobile", departure.getMobile());
                driverObject.put("car_no",carOwnerInfo.getCar_id());
                driverObject.put("car_brand",carOwnerInfo.getCar_brand());
                driverObject.put("car_color",carOwnerInfo.getCar_color());
                driverObject.put("car_type",carOwnerInfo.getCar_type());
            }

            //统计全部拼车次数
            String where_count=" where user_id ="+departure.getUser_id()+" and is_enable=1";
            int departure_total =appDB.getCount("pc_driver_publish_info",where_count);//发车次数
            where_count=where_count+" and order_status =1";
            int order_total =appDB.getCount("pc_passenger_orders",where_count);//订单次数

            driverObject.put("pc_count",order_total+departure_total);


            jsonObject.put("price",departure.getPrice());


            jsonObject.put("start_time", departure.getStart_time());
            jsonObject.put("boarding_point", JSONObject.parseObject(departure.getBoarding_point()));
            jsonObject.put("breakout_point", JSONObject.parseObject(departure.getBreakout_point()));
            jsonObject.put("init_seats", departure.getInit_seats());
            jsonObject.put("info_status", departure.getStatus());
            jsonObject.put("create_time", departure.getCreate_time());
            jsonObject.put("points", departure.getPoints());
            jsonObject.put("description", departure.getDescription());

            String order_where=" where order_id="+departure.getR_id()+" and is_enable=1 and order_status!=-1 ";
            int booking_count=appDB.getCount("pc_passenger_orders",order_where);
            jsonObject.put("booking_count", booking_count);


            JSONObject orderObject=new JSONObject();
            JSONObject passengerData=new JSONObject();
            JSONArray orderArray=new JSONArray();

            orderObject.put("order_id",passengerOrder.get_id());
            orderObject.put("boarding_point",JSONObject.parseObject(passengerOrder.getBoarding_point()));
            orderObject.put("breakout_point",JSONObject.parseObject(passengerOrder.getBreakout_point()));
            orderObject.put("booking_seats",passengerOrder.getSeats());
            orderObject.put("order_status",passengerOrder.getOrder_status());
            orderObject.put("create_time",passengerOrder.getCreate_time());
            orderObject.put("description",passengerOrder.getDescription());

            passengerData.put("name",passengerOrder.getUser_name());
            passengerData.put("mobile",passengerOrder.getMobile());
            passengerData.put("avatar",passengerOrder.getUser_avatar());

            orderObject.put("user_data",passengerData);
            orderArray.add(orderObject);

            jsonObject.put("user_data",driverObject);
            return_json.put("passenger_data",orderArray);
            return_json.put("driver_data",jsonObject);
        }
        return return_json;
    }

    //司机发车数据统计
    public static JSONObject getPassengerOrdersCount(LaiHuiDB laiHuiDB) {
        JSONObject return_json = new JSONObject();
        List<UserCount> userCounts= laiHuiDB.getPassengerOrdersCount();

        JSONArray jsonArray = new JSONArray();
        String start_date=Utils.getCurrentTimeSubOrAddHour(-24*ConfigUtils.getShow_days()).split(" ")[0];
        String end_date=Utils.getCurrentTime().split(" ")[0];
        Map<String,UserCount> userCountMap=new LinkedHashMap<>();
        for(int i=-6;i<=0;i++){
            UserCount userCount=new UserCount();
            start_date=Utils.getCurrentTimeSubOrAddHour(24*i).split(" ")[0];
            userCount.setCreate_time(start_date);
            userCount.setTotal(0);
            userCountMap.put(start_date,userCount);
        }
        for (String key : userCountMap.keySet()) {
            for(UserCount count:userCounts){
                if(key.equals(count.getCreate_time())){
                    userCountMap.put(key,count);
                    break;
                }
            }
        }
        for (String key : userCountMap.keySet()) {
            UserCount count=userCountMap.get(key);

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("date",count.getCreate_time());
            jsonObject.put("count",count.getTotal());
            jsonArray.add(jsonObject);
        }
        return_json.put("data",jsonArray);
        return_json.put("start_date",start_date);
        return_json.put("end_date",end_date);

        return return_json;
    }
    //得到市资料的json
    public static JSONObject getPlaceJson(List<PlaceCode> cityList)
    {
        JSONObject result=new JSONObject();
        JSONArray resultArray=new JSONArray();

        for(PlaceCode province:cityList){
            JSONObject object=new JSONObject();
            object.put("code", province.getCode());
            object.put("place",province.getPlace());
            resultArray.add(object);
        }
        result.put("data",resultArray);
        return result;
    }
    //得到轮播图json
    public static JSONObject getCarouselJson(LaiHuiDB laiHuiDB,int page,int size,int id,int type){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        //pc_image_create_time DESC,

        String where=" where pc_type="+type+" order by pc_image_seq ASC ";
        int offset=page*size;
        int count=1;
        if(id==0){
            count=laiHuiDB.getCarousel(where).size();
            where=where+" limit "+offset+","+size;
        }else {
            where=" where _id="+id;
        }
        List<Carousel> carouselList=laiHuiDB.getCarousel(where);
        for(Carousel carousel:carouselList){
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("id",carousel.get_id());

            jsonObject.put("image_seq",carousel.getSeq());
            jsonObject.put("image_url",carousel.getImage_url());
            jsonObject.put("image_link",carousel.getImage_link());
            jsonObject.put("image_title",carousel.getImage_title());
            jsonObject.put("create_time",carousel.getCreate_time());
            dataArray.add(jsonObject);
        }
        result_json.put("total",count);
        result_json.put("page",page);
        result_json.put("size",size);
        result_json.put("slides",dataArray);
        return result_json;
    }

    //得到轮播图json
    public static JSONObject getCampaign76Json(LaiHuiDB laiHuiDB,int page,int size,int id,int type,String start_time,String end_time){
        String where=" where _id >0 ";
        if(type!=0){
            where=where+" and pay_status=2";
        }else {
            where=where+" and pay_status=1";
        }
        if(!Utils.checkNull(start_time).isEmpty()){
            where=where+" and create_time >='"+start_time+"'";
        }
        if(!Utils.checkNull(end_time).isEmpty()){
            where=where+" and create_time <='"+start_time+"'";
        }

        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        int offset=page*size;
        int count=1;
        if(id==0){
            count=laiHuiDB.getOrderOf76(where).size();
            where=where+" order by create_time DESC limit "+offset+","+size;
        }else {
            where=" where _id="+id;
        }
        List<OrderOf76> orderList=laiHuiDB.getOrderOf76(where);
        for(OrderOf76 order:orderList){
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("id",order.getId());

            jsonObject.put("data",order.getData());
            jsonObject.put("total_price",order.getGoods_price());
            jsonObject.put("buyer_location",order.getBuyer_location());
            jsonObject.put("buyer_name",order.getBuyer_name());
            jsonObject.put("buyer_mobile",order.getBuyer_mobile());
            jsonObject.put("buyer_description",order.getBuyer_description());
            jsonObject.put("deliver_name",order.getDeliver_name());
            jsonObject.put("deliver_number",order.getDeliver_number());
            jsonObject.put("create_time",order.getCreate_time());
            dataArray.add(jsonObject);
        }
        result_json.put("total",count);
        result_json.put("page",page);
        result_json.put("size",size);
        result_json.put("slides",dataArray);
        return result_json;
    }

    public static JSONObject getManagerInfo(LaiHuiDB laiHuiDB,String keyword,String start_time,String end_time,int page,int size,String level,String code,int id){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String where ="";
        if(id==0){
            where =" where _id >0";
            if(level!=null&&!level.isEmpty()){
                where=" a left join pc_area_manager_location b on a._id=b.user_id ";
                if(level.equals("1")){
                    //根据省分类
                    where=where+" where user_manage_area_code like '"+code.substring(0, 2)+"%'";
                }else if(level.equals("2")){
                    //根据市分类
                    where=where+" where user_manage_area_code like '"+code.substring(0,4)+"%'";
                }else if(level.equals("3")){
                    //根据区分类
                    where=where+" where user_manage_area_code like '"+code+"'";
                }

            }
            if(keyword!=null&&!keyword.trim().equals("")){
                where=where+" and (user_name like '%"+keyword+"%' or user_mobile like '%"+keyword+"%')";
            }
            if(start_time!=null&&!start_time.trim().equals("")){
                where=where+" and user_create_time >='"+start_time+"'";
            }
            if(end_time!=null&&!end_time.trim().equals("")){
                where=where+" and user_create_time <='"+end_time+"'";
            }
        }else {
            where=where+" where _id="+id;
        }
        //laiHuiDB.getAreaManageLocation(where).size()
        if(level!=null&&!level.isEmpty()){
            where= where +" group by user_id ";
        }
        //int count=laiHuiDB.getCount("pc_area_manager",where);
        int count=laiHuiDB.getAreaManageLocation(where).size();
        int offset=page*size;
        where=where+" order by user_create_time DESC "+" limit "+offset+","+size;
        List<ManagerAreaLocation> userList=laiHuiDB.getAreaManageLocation(where);
        for(int i=0;i<userList.size();i++){
            ManagerAreaLocation user=userList.get(i);
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("id",user.getUser_id());
            jsonObject.put("mobile",user.getUser_mobile());
            jsonObject.put("create_time",user.getUser_create_time());
            jsonObject.put("last_logined_time",user.getLast_login_time());
            jsonObject.put("name",user.getUser_name());
            where=" where user_id="+user.getUser_id();
            List<ManagerAreaLocation> areaLocations=laiHuiDB.getArea(where);
            String allArea="";
            for(ManagerAreaLocation area:areaLocations){
                allArea=allArea+"、"+area.getArea_name();
            }
            if(!allArea.isEmpty()){

                allArea=allArea.substring(1);
            }
            jsonObject.put("allArea",allArea);
            dataArray.add(jsonObject);
        }
        result_json.put("count",count);
        result_json.put("data",dataArray);
        return result_json;
    }
    //区域代理订单数据统计
    public static JSONObject getAreaPassengerOrdersCount(LaiHuiDB laiHuiDB,int id) {

        JSONObject return_json = new JSONObject();
        JSONArray dateArray=new JSONArray();
        JSONArray jsonArray = new JSONArray();
        String where=" where user_id="+id;
        List<ManagerAreaLocation> managerAreaLocationList=laiHuiDB.getArea(where);

        String area_code_in=" and is_enable=1 and destination_address_code in (0";
        String end_word="订单日增长量";
        for(ManagerAreaLocation managerAreaLocation:managerAreaLocationList){
            JSONObject dataObject=new JSONObject();
            String name=managerAreaLocation.getArea_name();
            dataObject.put("name",name+end_word);
            area_code_in=area_code_in+","+managerAreaLocation.getArea_code();
            String now_where=" and is_enable=1 and destination_address_code="+managerAreaLocation.getArea_code();
            List<UserCount> userList =laiHuiDB.getAreaPassengerOrdersCount(now_where);
            JSONArray dataArray=ReturnJsonUtil.getCountUtil(userList);

            dataObject.put("data",dataArray);
            jsonArray.add(dataObject);
        }
        //统计全部数据
        area_code_in=area_code_in+")";

        JSONObject dataObject=new JSONObject();
        String name="总计增长"+end_word;
        dataObject.put("name",name);
        List<UserCount> userList =laiHuiDB.getAreaPassengerOrdersCount(area_code_in);
        JSONArray dataArray=ReturnJsonUtil.getCountUtil(userList);

        dataObject.put("data",dataArray);
        jsonArray.add(dataObject);

        String start_date=Utils.getCurrentTimeSubOrAddHour(-24*ConfigUtils.getShow_days()).split(" ")[0];
        String end_date=Utils.getCurrentTime().split(" ")[0];

        for(int i=-6;i<=0;i++){
            JSONObject dateObject=new JSONObject();
            start_date=Utils.getCurrentTimeSubOrAddHour(24*i).split(" ")[0];
            dateObject.put("date",start_date);
            dateArray.add(dateObject);
        }

        return_json.put("date",dateArray);
        return_json.put("area_data",jsonArray);
        return_json.put("start_date",start_date);
        return_json.put("end_date",end_date);

        return return_json;
    }
    //区域代理订单数据统计
    public static JSONObject getAreaCount(LaiHuiDB laiHuiDB,String adcode) {

        JSONObject return_json = new JSONObject();
        JSONArray dateArray=new JSONArray();
        JSONArray jsonArray = new JSONArray();
        String where=" where  user_manage_area_code="+adcode;

        List<ManagerAreaLocation> managerAreaLocationList=laiHuiDB.getArea(where);
        String end_word="订单日增长量";
        for(ManagerAreaLocation managerAreaLocation:managerAreaLocationList){
            JSONObject dataObject=new JSONObject();
            String name=managerAreaLocation.getArea_name();
            dataObject.put("name",name+end_word);

            String now_where=" and is_enable=1 and destination_address_code="+managerAreaLocation.getArea_code();
            List<UserCount> userList =laiHuiDB.getAreaPassengerOrdersCount(now_where);
            JSONArray dataArray=ReturnJsonUtil.getCountUtil(userList);

            dataObject.put("data",dataArray);
            jsonArray.add(dataObject);
        }
        //统计全部数据
        String start_date=Utils.getCurrentTimeSubOrAddHour(-24*ConfigUtils.getShow_days()).split(" ")[0];
        String end_date=Utils.getCurrentTime().split(" ")[0];

        for(int i=-6;i<=0;i++){
            JSONObject dateObject=new JSONObject();
            start_date=Utils.getCurrentTimeSubOrAddHour(24*i).split(" ")[0];
            dateObject.put("date",start_date);
            dateArray.add(dateObject);
        }
        return_json.put("date",dateArray);
        return_json.put("area_data",jsonArray);
        return_json.put("start_date",start_date);
        return_json.put("end_date",end_date);

        return return_json;
    }
    public static JSONArray getCountUtil(List<UserCount> userCounts) {

        JSONArray jsonArray = new JSONArray();
        Map<String,UserCount> userCountMap=new LinkedHashMap<>();
        for(int i=-6;i<=0;i++){
            UserCount userCount=new UserCount();
            String start_date=Utils.getCurrentTimeSubOrAddHour(24*i).split(" ")[0];
            userCount.setCreate_time(start_date);
            userCount.setTotal(0);
            userCountMap.put(start_date,userCount);
        }
        for (String key : userCountMap.keySet()) {
            for(UserCount count:userCounts){
                if(key.equals(count.getCreate_time())){
                    userCountMap.put(key,count);
                    break;
                }
            }
        }
        for (String key : userCountMap.keySet()) {
            UserCount count=userCountMap.get(key);

           /* JSONObject jsonObject = new JSONObject();
            jsonObject.put("date",count.getCreate_time());
            jsonObject.put("count",count.getTotal());*/
            jsonArray.add(count.getTotal());
        }

        return jsonArray;
    }

    //司机发车数据统计
    public static JSONObject getAreaPassengerOrdersTableCount(LaiHuiDB laiHuiDB,int id,String start_time,String end_time) {

        JSONObject return_json = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        String where=" where user_id="+id;
        List<ManagerAreaLocation> managerAreaLocationList=laiHuiDB.getArea(where);
        String sql=" where _id>0";
        if((start_time==null||start_time.isEmpty())&&(end_time==null||end_time.isEmpty())){
            sql=sql+" and create_time >='"+Utils.getCurrentTime().split(" ")[0]+" 00:00:00'";

            return_json.put("start_time",Utils.getCurrentTime().split(" ")[0]+" 00:00:00");
            return_json.put("end_time",Utils.getCurrentTime());
        }else {

            if(start_time!=null&&!start_time.isEmpty()){
                sql=sql+" and create_time >='"+start_time+"'";
                return_json.put("start_time",start_time);
            }else {
                return_json.put("start_time","");
            }
            if(end_time!=null&&!end_time.isEmpty()){
                sql=sql+" and create_time <='"+end_time+"'";
                return_json.put("end_time",end_time);
            }else {
                return_json.put("end_time",Utils.getCurrentTime());
            }
        }

        String area_code_in=sql+" and is_enable=1 and destination_address_code in (0";
        for(ManagerAreaLocation managerAreaLocation:managerAreaLocationList){
            JSONObject dataObject=new JSONObject();
            String name=managerAreaLocation.getArea_name();
            dataObject.put("name",name);
            dataObject.put("code",managerAreaLocation.getArea_code());
            area_code_in=area_code_in+","+managerAreaLocation.getArea_code();
            String now_where=sql+" and is_enable=1 and destination_address_code="+managerAreaLocation.getArea_code();
            //得到统计结果
            int count =laiHuiDB.getCount("pc_passenger_orders",now_where);
            dataObject.put("count",count);
            jsonArray.add(dataObject);
        }
        //统计全部数据
        area_code_in=area_code_in+")";
        JSONObject dataObject=new JSONObject();
        String name="总计增长";
        dataObject.put("name",name);
        int count =laiHuiDB.getCount("pc_passenger_orders", area_code_in);

        dataObject.put("count",count);
        jsonArray.add(dataObject);

        return_json.put("area_data",jsonArray);

        return return_json;
    }

    public static JSONObject getPayApplication(LaiHuiDB laiHuiDB,String keyword,String start_time,String end_time,String type,int page,int size){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String where =" a inner join pc_user b on a.user_id =b._id where action_type=1 ";
        if(start_time!=null&&!start_time.isEmpty()){
            where=where+" and a.create_time>='"+start_time+"'";
        }
        if(end_time!=null&&!end_time.isEmpty()){
            where=where+" and a.create_time<='"+end_time+"'";
        }
        if(type==null||type.trim().equals("")){
            where=where+" and order_status=0 ";
        }else if(type.equals("1")){
            where=where+" and order_status=1 ";
        }
        if(keyword!=null&&!keyword.isEmpty()){
            where=where+" and (user_mobile like '%"+keyword+"%' or user_name like '%"+keyword+"%')";
        }

        int count=laiHuiDB.getCount("pay_cash_log",where);
        int offset=page*size;
        where=where+" order by a.create_time DESC "+" limit "+offset+","+size;
        List<PayLog> payLogList=laiHuiDB.getPayInfo(where);
        for(int i=0;i<payLogList.size();i++){
            PayLog pay=payLogList.get(i);
            JSONObject jsonObject=new JSONObject();

            jsonObject.put("mobile",pay.getUser_mobile());
            jsonObject.put("name",pay.getUser_name());
            jsonObject.put("avatar",pay.getUser_avatar());
            jsonObject.put("create_time",pay.getCreate_time());
            jsonObject.put("id",pay.get_id());
            jsonObject.put("cash",new BigDecimal(pay.getCash()).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
            jsonObject.put("pay_type",pay.getPay_type());
            jsonObject.put("pay_account",pay.getPay_account());
            jsonObject.put("pay_status",pay.getOrder_status());

            dataArray.add(jsonObject);
        }
        result_json.put("count",count);
        result_json.put("data",dataArray);
        return result_json;
    }
    public static JSONObject getPayBackList(LaiHuiDB laiHuiDB,String keyword,String start_time,String end_time,String type,int page,int size){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String where =" a inner join pc_user b on a.user_id =b._id ";
        if(start_time!=null&&!start_time.isEmpty()){
            where=where+" and a.create_time>='"+start_time+"'";
        }
        if(end_time!=null&&!end_time.isEmpty()){
            where=where+" and a.create_time<='"+end_time+"'";
        }
        if(type==null||type.trim().equals("")){
            where=where+" and pay_status=0 ";
        }else if(type.equals("1")){
            where=where+" and pay_status=1 ";
        }
        if(keyword!=null&&!keyword.isEmpty()){
            where=where+" and (user_mobile like '%"+keyword+"%' or user_name like '%"+keyword+"%')";
        }

        int count=laiHuiDB.getCount("pc_application_pay_back",where);
        int offset=page*size;
        where=where+" order by a.create_time DESC "+" limit "+offset+","+size;
        List<PayBack> payBackList=laiHuiDB.getPayBack(where);
        for(int i=0;i<payBackList.size();i++){
            PayBack pay=payBackList.get(i);
            JSONObject jsonObject=new JSONObject();

            jsonObject.put("mobile",pay.getUser_mobile());
            jsonObject.put("name",pay.getUser_name());
            jsonObject.put("avatar",pay.getUser_avatar());
            jsonObject.put("create_time",pay.getCreate_time());
            jsonObject.put("id",pay.getOrder_id());
            jsonObject.put("cash",new BigDecimal(pay.getPay_cash()).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
            jsonObject.put("pay_type",pay.getPay_type());
            jsonObject.put("pay_account",pay.getPay_account());
            jsonObject.put("pay_reason",pay.getPay_reason());
            jsonObject.put("pay_status",pay.getPay_status());

            dataArray.add(jsonObject);
        }
        result_json.put("count",count);
        result_json.put("data",dataArray);
        return result_json;
    }
    public static JSONObject getPayList(LaiHuiDB laiHuiDB,String keyword,String start_time,String end_time,String type,int page,int size){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String where =" a inner join pc_user b on a.user_id =b._id where a._id>0";

        String today_time=Utils.getCurrentTime().split(" ")[0]+" 00:00:00";
        if((start_time==null||start_time.isEmpty())&&(end_time==null||end_time.isEmpty())){
            where=where+" and a.create_time>='"+today_time+"'";
        }
        if(start_time!=null&&!start_time.isEmpty()){
            where=where+" and a.create_time>='"+start_time+"'";
        }
        if(end_time!=null&&!end_time.isEmpty()){
            where=where+" and a.create_time<='"+end_time+"'";
        }
        if(keyword!=null&&!keyword.isEmpty()){
            where=where+" and (user_mobile like '%"+keyword+"%' or user_name like '%"+keyword+"%')";
        }
        String in_where=where+" and action_type=0 and is_complete=1 and order_status=1";
        String out_where=where+" and action_type=1 and order_status=1 ";
        List<PayLog> inPayList=laiHuiDB.getPayInfo(in_where);//选定时间内收入
        List<PayLog> outPayList=laiHuiDB.getPayInfo(out_where);//选定时间内支出
        double in_cash=0;
        for(PayLog payLog:inPayList){
            in_cash=in_cash+payLog.getCash();
        }
        double out_cash=0;
        for(PayLog payLog:outPayList){
            out_cash=out_cash+payLog.getCash();
        }
        int count=0;
        if(type==null||type.isEmpty()){
            where=where+" and action_type=0 and order_status=1";
            count=inPayList.size();
        }else if (type.equals("1")){
            where=where+" and action_type=1 and order_status=1";
            count=outPayList.size();
        }else if (type.equals("-1")){
            where=where+" and action_type=0 and order_status=-1";
            count=outPayList.size();
        }
        int offset=page*size;
        where=where+" order by a.create_time DESC "+" limit "+offset+","+size;
        List<PayLog> payLogList=laiHuiDB.getPayInfo(where);
        for(int i=0;i<payLogList.size();i++){
            PayLog pay=payLogList.get(i);
            JSONObject jsonObject=new JSONObject();

            jsonObject.put("mobile",pay.getUser_mobile());
            jsonObject.put("name",pay.getUser_name());
            jsonObject.put("avatar",pay.getUser_avatar());
            jsonObject.put("create_time",pay.getCreate_time());
            jsonObject.put("id",pay.get_id());
            jsonObject.put("cash",new BigDecimal(pay.getCash()).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
            jsonObject.put("pay_type",pay.getPay_type());
            jsonObject.put("pay_account",pay.getPay_account());
            jsonObject.put("pay_status",pay.getOrder_status());

            dataArray.add(jsonObject);
        }
        result_json.put("in_cash",new BigDecimal(in_cash).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
        result_json.put("out_cash",new BigDecimal(out_cash).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
        result_json.put("count",count);
        result_json.put("page",page);
        result_json.put("size",size);
        result_json.put("data",dataArray);
        return result_json;
    }

    public static JSONObject getPayInfo(LaiHuiDB laiHuiDB,String id){
        JSONObject result_json=new JSONObject();

        String where =" a inner join pc_passenger_publish_info b on a.order_id =b._id where a._id="+id;

        List<PayLog> payLogList=laiHuiDB.getpayDetail(where);
        if(payLogList.size()>0){
            PayLog pay=payLogList.get(0);
            JSONObject recordJson=new JSONObject();

            recordJson.put("create_time",pay.getCreate_time());
            recordJson.put("id",pay.get_id());
            recordJson.put("cash",new BigDecimal(pay.getCash()).setScale(2,BigDecimal.ROUND_HALF_UP).toString());
            recordJson.put("pay_type",pay.getPay_type());
            recordJson.put("pay_status",pay.getOrder_status());
            recordJson.put("trade_no",pay.getTrade_no());

            JSONObject dataObject=new JSONObject();
            dataObject.put("boarding_point",JSONObject.parseObject(pay.getBoarding_point()));
            dataObject.put("breakout_point",JSONObject.parseObject(pay.getBreakout_point()));
            dataObject.put("booking_seats",pay.getBooking_seats());
            dataObject.put("order_create_time",pay.getOrder_create_time());

            String user_where=" where _id="+pay.getUser_id();
            User passenger=laiHuiDB.getUserList(user_where).get(0);

            JSONObject passengerObject=new JSONObject();
            passengerObject.put("mobile",passenger.getUser_mobile());
            passengerObject.put("name",passenger.getUser_name());
            passengerObject.put("avatar",passenger.getAvatar());

            user_where=" where user_id="+pay.getDriver_id();
            CarOwnerInfo carOwnerInfo=laiHuiDB.getCarOwnerInfo(user_where).get(0);
            JSONObject driverObject=new JSONObject();

            driverObject.put("mobile",carOwnerInfo.getUser_mobile());
            driverObject.put("name",carOwnerInfo.getUser_name());
            driverObject.put("avatar",carOwnerInfo.getUser_avatar());

            driverObject.put("car_no",carOwnerInfo.getCar_id());
            driverObject.put("car_brand",carOwnerInfo.getCar_brand());
            driverObject.put("car_color",carOwnerInfo.getCar_color());
            driverObject.put("car_type",carOwnerInfo.getCar_type());


            result_json.put("recordObject",recordJson);
            result_json.put("dataObject",dataObject);
            result_json.put("passengerObject",passengerObject);
            result_json.put("driverObject",driverObject);
        }
        return result_json;
    }
//
    public static JSONObject getMyBookingOrderList(LaiHuiDB appDB, int page, int size,String start_time,String end_time,int flag,int id) {
        JSONObject result_json = new JSONObject();
        JSONArray dataArray = new JSONArray();
        String where = " a right join pc_passenger_publish_info b on a.order_id=b._id where a.is_enable=1 and a.order_type=0 ";
        if(id==0){
            if(start_time.isEmpty()&&end_time.isEmpty()){
                String today_time=Utils.getCurrentTime().split(" ")[0]+" 00:00:00";
                //where=where+" and b.departure_time>='"+today_time+"'";
                where=where+" and a.create_time>='"+today_time+"'";
            }else {
                if(!start_time.isEmpty()){
                    where=where+" and a.create_time>='"+start_time+"'";
                }
                if(!end_time.isEmpty()){
                    where=where+" and a.create_time<='"+end_time+"'";
                }
            }
            if(flag==1){
                //查询历史
                where=where+" and a.order_status>=4 ";
            }else {
                where=where+" and a.order_status<4";
            }
        }else {
            where=where+" and a.order_id="+id;
        }
        int count = appDB.getCount("pc_orders",where);
        int offset = page * size;

        where = where + " order by a.create_time DESC limit " + offset + "," + size;
        List<AppOrder> orderList = appDB.getOrderReview(where, 2);
        for (AppOrder order : orderList) {
            JSONObject jsonObject = new JSONObject();
            JSONObject userObject = new JSONObject();

            jsonObject.put("order_id",order.get_id());
            jsonObject.put("update_time",order.getUpdate_time());
            jsonObject.put("order_status",order.getOrder_status());//order_status<=3

            jsonObject.put("seats",order.getBooking_seats());
            jsonObject.put("boarding_point",JSONObject.parseObject(order.getBoarding_point()));
            jsonObject.put("breakout_point",JSONObject.parseObject(order.getBreakout_point()));
            jsonObject.put("description",order.getDescription());
            jsonObject.put("create_time",order.getCreate_time());
            jsonObject.put("departure_time", order.getDeparture_time());
            jsonObject.put("price", order.getPrice());
            //得到乘客基本信息
            String passenger_where=" where _id="+order.getUser_id();
            User passenger=appDB.getUserList(passenger_where).get(0);
            JSONObject passengerData=new JSONObject();
            passengerData.put("user_mobile",passenger.getUser_mobile());
            passengerData.put("user_avatar",passenger.getAvatar());
            passengerData.put("user_name",passenger.getUser_nick_name());

            //得到司机基本信息
            where=" where order_id="+order.getOrder_id()+" and order_type=2 and order_status!=-1 and is_enable=1";//查询已经抢单且有效的司机抢单记录

            List<AppOrder> driverOrders=appDB.getOrderReview(where,0);
            for(AppOrder order1:driverOrders){
                where=" where user_id="+order1.getUser_id();
                List<CarOwnerInfo> carOwnerInfoList=appDB.getCarOwnerInfo(where);
                if(carOwnerInfoList.size()>0) {
                    CarOwnerInfo carOwnerInfo = carOwnerInfoList.get(0);
                    userObject.put("car_no", carOwnerInfo.getCar_id());
                    userObject.put("grab_id", order1.get_id());
                    userObject.put("car_brand", carOwnerInfo.getCar_brand());
                    userObject.put("car_color", carOwnerInfo.getCar_color());
                    userObject.put("car_type", carOwnerInfo.getCar_type());

                    userObject.put("mobile", carOwnerInfo.getUser_mobile());
                    userObject.put("name", carOwnerInfo.getUser_name());
                    userObject.put("avatar", carOwnerInfo.getUser_avatar());
                }
            }
            jsonObject.put("driver_data",userObject);
            jsonObject.put("passenger_data",passengerData);

            dataArray.add(jsonObject);
        }
        result_json.put("data", dataArray);
        result_json.put("total", count);
        result_json.put("page", page);
        result_json.put("size", size);
        return result_json;
    }

}
