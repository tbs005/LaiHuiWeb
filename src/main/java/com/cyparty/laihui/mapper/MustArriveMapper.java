package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.MustArrive;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by lunwf on 2017/6/16.
 */
public class MustArriveMapper implements RowMapper<MustArrive> {
    public MustArrive mapRow(ResultSet resultSet, int i) throws SQLException {
        MustArrive arrive =new MustArrive();
        arrive.setOrder_id(resultSet.getString("order_id"));
        arrive.setTrade_no(resultSet.getString("trade_no"));
        arrive.setUser_id(resultSet.getString("user_id"));
        arrive.setUsername(resultSet.getString("username"));
        String isdn = resultSet.getString("user_idsn");
        arrive.setIsdn(isdn);
        arrive.setMobile(resultSet.getString("mobile"));
        arrive.setBoarding_point(resultSet.getString("boarding_point"));
        arrive.setBreakout_point(resultSet.getString("breakout_point"));
        arrive.setPrice(resultSet.getString("price"));
        int orderStatus = resultSet.getInt("order_status");
        if(orderStatus==100){
            arrive.setOrder_status("司机已抢单");
        }else if(orderStatus==200){
            arrive.setOrder_status("车单已支付");
        }else if(orderStatus==300){
            arrive.setOrder_status("同意抢单");
        }else if(orderStatus==5){
            arrive.setOrder_status("车单结束");
        }else if(orderStatus==-1){
            arrive.setOrder_status("申请退款");
        }else if(orderStatus==6){
            arrive.setOrder_status("退款成功");
        }
        int isEnable = resultSet.getInt("is_enable");
        if(isEnable==0){
            arrive.setIs_enable("不可用");
        }else{
            arrive.setIs_enable("可用");
        }
        if(isdn!=null && !isdn.equals("")&&isdn.length()==18) {
            int sexType = Integer.parseInt(isdn.substring(16,17));
            if (sexType % 2 == 1) {
                arrive.setSex("先生");
            } else {
                arrive.setSex("女士");
            }
        }
        arrive.setRefuse(String.valueOf(resultSet.getInt("refuse")));
        arrive.setDeparture_time(resultSet.getString("departure_time"));
        arrive.setCreate_time(resultSet.getString("create_time"));
        return arrive ;
    }
}
