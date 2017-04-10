package com.cyparty.laihui.mapper;


import com.cyparty.laihui.domain.DepartureInfo;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by zhu on 2015/12/29.
 */
public class APPDriverDepartureInfoMapper implements RowMapper<DepartureInfo> {

    public DepartureInfo mapRow(ResultSet resultSet, int i) throws SQLException {
        DepartureInfo departure=new DepartureInfo();

        departure.setR_id(resultSet.getInt("_id"));
        departure.setUser_id(resultSet.getInt("user_id"));
        departure.setStart_time(Utils.checkTime(resultSet.getString("departure_time")));
        departure.setInit_seats(resultSet.getInt("init_seats"));
        departure.setCreate_time(Utils.checkTime(resultSet.getString("create_time")));
        departure.setIs_enable(resultSet.getInt("is_enable"));
        departure.setBoarding_point(resultSet.getString("boarding_point"));
        departure.setBreakout_point(resultSet.getString("breakout_point"));

        departure.setMobile(Utils.checkNull(resultSet.getString("mobile")));
        departure.setUser_name(Utils.checkNull(resultSet.getString("user_name")));
        departure.setUser_avatar(Utils.checkNull(resultSet.getString("user_avatar")));
        return departure;
    }
}
