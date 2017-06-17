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
        arrive.setUser_id(resultSet.getString("user_id"));
        arrive.setUsername(resultSet.getString("username"));
        arrive.setMobile(resultSet.getString("mobile"));
        arrive.setBoarding_point(resultSet.getString("boarding_point"));
        arrive.setBreakout_point(resultSet.getString("breakout_point"));
        arrive.setPrice(resultSet.getString("price"));
        int orderStatus = resultSet.getInt("order_status");
        if(orderStatus==0){
            arrive.setOrder_status("未被抢单");
        }else{
            arrive.setOrder_status("已被抢单");
        }
        int isEnable = resultSet.getInt("is_enable");
        if(isEnable==0){
            arrive.setIs_enable("不可用");
        }else{
            arrive.setIs_enable("可用");
        }
        arrive.setRefuse(String.valueOf(resultSet.getInt("refuse")));
        arrive.setDeparture_time(resultSet.getString("departure_time"));
        arrive.setCreate_time(resultSet.getString("create_time"));
        return arrive ;
    }
}
