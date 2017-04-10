package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.Code;
import com.cyparty.laihui.domain.ManagerAreaLocation;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by zhu on 2015/12/29.
 */
public class ManagerAreaLocationMapper implements RowMapper<ManagerAreaLocation> {

    public ManagerAreaLocation mapRow(ResultSet resultSet, int i) throws SQLException {
        ManagerAreaLocation manager=new ManagerAreaLocation();

        manager.set_id(resultSet.getInt("_id"));
        manager.setUser_id(resultSet.getInt("user_id"));
        manager.setArea_code(resultSet.getInt("user_manage_area_code"));
        manager.setArea_name(resultSet.getString("user_manage_area_name"));
        manager.setCreate_time(resultSet.getString("create_time").split("\\.")[0]);


        return manager;
    }
}
