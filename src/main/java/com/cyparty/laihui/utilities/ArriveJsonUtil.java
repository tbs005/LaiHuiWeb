package com.cyparty.laihui.utilities;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lunwf on 2017/6/16.
 */
public class ArriveJsonUtil {

    /**
     *
     * @param laiHuiDB
     * @param keyword
     * @param start_time
     * @param end_time
     * @param page
     * @param size
     * @param id
     * @return
     */
    public static JSONObject getArriveList(LaiHuiDB laiHuiDB,String keyword,String start_time,String end_time,int page,int size,String order_status,String is_enable,String id){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String sql ="SELECT t1._id order_id, t1.trade_no trade_no, t1.user_id user_id,t2.user_name username,t2.user_mobile mobile,t2.user_idsn user_idsn,t1.boarding_point,t1.breakout_point,t1.price," +
                "t3.order_status,t1.is_enable,t1.refuse,date_format(t1.departure_time,'%Y-%c-%d %H:%i' ) as departure_time,date_format(t1.create_time,'%Y-%c-%d %H:%i' ) as create_time  " +
                "from pc_passenger_publish_info t1, pc_user t2, pc_orders t3 where t1.user_id=t2._id and t1._id = t3.order_id and t2._id = t3.user_id and is_arrive = 1 ";
        String where ="";
        if(id==null || id.equals("")){
            if(keyword!=null&&!keyword.trim().equals("")){
                where=where+" and (t2.user_name like '%"+keyword+"%' or t2.user_mobile like '%"+keyword+"%') ";
            }
            if(start_time!=null&&!start_time.trim().equals("")){
                where=where+" and t1.departure_time >'"+start_time+"'";
            }
            if(end_time!=null&&!end_time.trim().equals("")){
                where=where+" and t1.departure_time <'"+end_time+"'";
            }
            if(order_status!=null&&!order_status.trim().equals("")){
                where=where+" and t3.order_status ='"+order_status+"'";
            }
            if(is_enable!=null&&!is_enable.trim().equals("")){
                where=where+" and t1.is_enable ='"+is_enable+"'";
            }
        }else {
            where=where+" and t1._id='"+id+"' ";
        }
        int count=laiHuiDB.getMustArriveList(sql+where).size();
        int offset=page*size;
        where=where+" order by t1.departure_time desc "+" limit "+offset+","+size;
        List<MustArrive> list=laiHuiDB.getMustArriveList(sql+where);
        for(int i=0;i<list.size();i++){
            MustArrive obj=list.get(i);
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("orderId",obj.getOrder_id());
            jsonObject.put("traderNo",obj.getTrade_no());
            jsonObject.put("userId",obj.getUser_id());
            jsonObject.put("userName",obj.getUsername());
            jsonObject.put("mobile",obj.getMobile());
            jsonObject.put("sex",obj.getSex());
            JSONObject jsonBoardPoint = JSONObject.parseObject(obj.getBoarding_point());
            String boardProvince = jsonBoardPoint.getString("province");
            String boardCity = jsonBoardPoint.getString("city");
            String boardName = jsonBoardPoint.getString("name");
            String boardLatitude = jsonBoardPoint.getString("latitude");
            String boardLongitude = jsonBoardPoint.getString("longitude");
            //jsonObject.put("boardAdd",boardProvince+boardCity+boardName);
            jsonObject.put("boardAdd",boardCity+boardName);
            jsonObject.put("boardLatitude",boardLatitude);
            jsonObject.put("boardLongitude",boardLongitude);

            JSONObject jsonBreakPoint = JSONObject.parseObject(obj.getBreakout_point());
            String breakProvince = jsonBreakPoint.getString("province");
            String breakCity = jsonBreakPoint.getString("city");
            String breakName = jsonBreakPoint.getString("name");
            String breakLatitude = jsonBreakPoint.getString("latitude");
            String breakLongitude = jsonBreakPoint.getString("longitude");
            //jsonObject.put("breakAdd",breakProvince+breakCity+breakName);
            jsonObject.put("breakAdd",breakCity+breakName);
            jsonObject.put("breakLatitude",breakLatitude);
            jsonObject.put("breakLongitude",breakLongitude);

            jsonObject.put("price",obj.getPrice());
            jsonObject.put("orderStatus",obj.getOrder_status());
            jsonObject.put("isEnable",obj.getIs_enable());
            jsonObject.put("refuse",obj.getRefuse());
            jsonObject.put("departureTime",obj.getDeparture_time());
            jsonObject.put("createTime",obj.getCreate_time());

            dataArray.add(jsonObject);
        }
        result_json.put("count",count);
        result_json.put("data",dataArray);
        return result_json;
    }


    /**
     * 查询近7天 必达单数据
     * @param laiHuiDB
     * @return
     */
    public static JSONObject getArriveLine(LaiHuiDB laiHuiDB) {
        JSONObject return_json = new JSONObject();
        List<UserCount> userCounts=new ArrayList<>();

        userCounts=laiHuiDB.getArriveLine();

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
    public static JSONObject getArriveForMobile(LaiHuiDB laiHuiDB,String traderNo,String userId,int page,int size){
        JSONObject result_json=new JSONObject();
        JSONArray dataArray=new JSONArray();
        String sql ="SELECT t.r_id order_id, t.order_no trade_no, t.driver_phone mobile, " +
                "date_format(t.create_time,'%Y-%c-%d %H:%i') departure_time, t.is_del is_enable, t2._id user_id," +
                "date_format(t2.user_create_time,'%Y-%c-%d %H:%i') create_time, " +
                " '' user_idsn,'' username,'' boarding_point,'' breakout_point,'' price,'' order_status,'' refuse " +
                "from arrive_driver_relation t LEFT JOIN pc_user t2 ON t.driver_phone = t2.user_mobile where t.order_no='"+traderNo+"' and t.passenger_id='"+userId+"' ";

        int count=laiHuiDB.getMustArriveList(sql).size();
        int offset=page*size;
        sql=sql+"  ORDER BY t.create_time "+" limit "+offset+","+size;
        List<MustArrive> list=laiHuiDB.getMustArriveList(sql);
        for(int i=0;i<list.size();i++){
            MustArrive obj=list.get(i);
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("orderId",obj.getOrder_id());
            jsonObject.put("traderNo",obj.getTrade_no());
            jsonObject.put("mobile",obj.getMobile());
            jsonObject.put("pushTime",obj.getDeparture_time());
            String isExist = obj.getUser_id();
            if(isExist==null || isExist.equals("")){
                jsonObject.put("isExist","未注册");
            }else{
                jsonObject.put("isExist","已注册");
            }
            if(obj.getCreate_time()==null||obj.getCreate_time().equals("")) {
                jsonObject.put("creatTime", "未注册");
            }else{
                jsonObject.put("creatTime", obj.getCreate_time());
            }
            dataArray.add(jsonObject);
        }
        result_json.put("count",count);
        result_json.put("data",dataArray);
        return result_json;
    }
}
