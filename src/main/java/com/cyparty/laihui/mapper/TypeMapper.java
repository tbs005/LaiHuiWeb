package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.News;
import com.cyparty.laihui.domain.NewsType;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by pangzhenpeng on 2017/6/5.
 */
public class TypeMapper implements RowMapper<NewsType> {
    @Override
    public NewsType mapRow(ResultSet resultSet, int i) throws SQLException {
        NewsType news = new NewsType();
        news.setTypeId(resultSet.getInt("type_id"));
        news.setTypeName(resultSet.getString("type_name"));
        news.setLogo(resultSet.getString("logo"));
        news.setCreateTime(resultSet.getString("create_time"));
        news.setUpdateTime(Utils.checkNull(resultSet.getString("update_time")));
        news.setIsEnable(resultSet.getInt("is_enable"));
        news.setDictionaryName(resultSet.getString("dictionary_name"));
        return news;
    }
}
