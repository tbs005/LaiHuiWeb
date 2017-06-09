package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.News;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by pangzhenpeng on 2017/6/5.
 */
public class NewsTypeMapper implements RowMapper<News> {
    @Override
    public News mapRow(ResultSet resultSet, int i) throws SQLException {
        News news = new News();
        news.setType_id(resultSet.getInt("type_id"));
        news.setType_name(resultSet.getString("type_name"));
        news.setIs_enable(resultSet.getInt("is_enable"));
        return news;
    }
}
