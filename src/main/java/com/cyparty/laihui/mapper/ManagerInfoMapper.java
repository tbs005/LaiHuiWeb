package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.ManagerAreaLocation;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by zhu on 2015/12/29.
 */
public class ManagerInfoMapper implements RowMapper<ManagerAreaLocation> {

    public ManagerAreaLocation mapRow(ResultSet resultSet, int i) throws SQLException {
        ManagerAreaLocation manager=new ManagerAreaLocation();

        manager.setUser_id(resultSet.getInt("_id"));
        manager.setUser_name(resultSet.getString("user_name"));
        manager.setUser_mobile(resultSet.getString("user_mobile"));
        manager.setUser_create_time(resultSet.getString("user_create_time").split("\\.")[0]);
        manager.setLast_login_time(resultSet.getString("user_last_login_time").split("\\.")[0]);

        return manager;
    }
}
