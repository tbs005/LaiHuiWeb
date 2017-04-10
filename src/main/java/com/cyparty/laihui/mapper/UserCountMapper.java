package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.UserCount;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by zhu on 2015/12/29.
 */
public class UserCountMapper implements RowMapper<UserCount> {

    public UserCount mapRow(ResultSet resultSet, int i) throws SQLException {
        UserCount count=new UserCount();

        count.setCreate_time(resultSet.getString("create_date"));
        count.setTotal(resultSet.getInt("number"));

        return count;
    }
}
