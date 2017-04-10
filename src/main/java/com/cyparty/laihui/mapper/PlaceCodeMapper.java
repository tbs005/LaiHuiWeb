package com.cyparty.laihui.mapper;


import com.cyparty.laihui.domain.PlaceCode;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by zhu on 2015/12/29.
 */
public class PlaceCodeMapper implements RowMapper<PlaceCode> {

    public PlaceCode mapRow(ResultSet resultSet, int i) throws SQLException {
        PlaceCode province =new PlaceCode();
        province.setCode(resultSet.getInt("c_code"));
        province.setPlace(resultSet.getString("c_name"));

        return province;
    }
}
