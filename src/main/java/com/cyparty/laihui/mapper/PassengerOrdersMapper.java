package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.PassengerOrder;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by zhu on 2015/12/29.
 */
public class PassengerOrdersMapper implements RowMapper<PassengerOrder> {

    public PassengerOrder mapRow(ResultSet resultSet, int i) throws SQLException {
        PassengerOrder order=new PassengerOrder();

        order.set_id(resultSet.getInt("_id"));
        order.setDriver_order_id(resultSet.getInt("order_id"));
        order.setSeats(resultSet.getInt("booking_seats"));
        order.setBoarding_point(Utils.checkNull(resultSet.getString("boarding_point")));
        order.setBreakout_point(Utils.checkNull(resultSet.getString("breakout_point")));
        order.setDescription(Utils.checkNull(resultSet.getString("description")));
        order.setOrder_status(resultSet.getInt("order_status"));
        order.setCreate_time(resultSet.getString("create_time").split("\\.")[0]);

        order.setUser_id(resultSet.getInt("user_id"));
        order.setMobile(resultSet.getString("user_mobile"));
        order.setUser_name(Utils.checkNull(resultSet.getString("user_name")));
        order.setUser_avatar(Utils.checkNull(resultSet.getString("user_avatar")));
        return order;
    }
}
