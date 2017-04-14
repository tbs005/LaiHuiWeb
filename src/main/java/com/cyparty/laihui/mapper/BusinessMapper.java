package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.Business;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Administrator on 2017/4/13.
 */
public class BusinessMapper implements RowMapper<Business> {

    @Override
    public Business mapRow(ResultSet resultSet, int i) throws SQLException {
        Business business = new Business();
        business.set_id(resultSet.getInt("_id"));
        business.setBusiness_name(Utils.checkNull(resultSet.getString("business_name")));
        business.setBusiness_mobile(Utils.checkNull(resultSet.getString("business_mobile")));
        business.setAddress(Utils.checkNull(resultSet.getString("address")));
        business.setCooperation_way(Utils.checkNull(resultSet.getString("cooperation_way")));
        business.setCooperation_description(Utils.checkNull(resultSet.getString("cooperation_description")));
        business.setFlag(resultSet.getInt("flag"));
        business.setCreate_time(Utils.checkNull(resultSet.getString("create_time")));
        return business;
    }
}

