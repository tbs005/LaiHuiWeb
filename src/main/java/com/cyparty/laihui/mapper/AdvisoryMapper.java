package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.Advisory;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 咨询映射类
 * Created by YangGuang on 2017/5/12.
 */
public class AdvisoryMapper implements RowMapper<Advisory> {

    @Override
    public Advisory mapRow(ResultSet resultSet, int i) throws SQLException {
        Advisory advisory = new Advisory();
        advisory.setAdvisory_id(resultSet.getInt("advisory_id"));
        advisory.setTitile(Utils.checkNull(resultSet.getString("title")));
        advisory.setSub_title(Utils.checkNull(resultSet.getString("sub_title")));
        advisory.setContent(Utils.checkNull(resultSet.getString("content")));
        advisory.setCreate_date(Utils.checkNull(resultSet.getString("create_date")));
        advisory.setUpdate_date(Utils.checkNull(resultSet.getString("update_date")));
        return advisory;
    }
}
