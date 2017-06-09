package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.News;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by pangzhenpeng on 2017/6/5.
 */
public class NewsMapper implements RowMapper<News> {
    @Override
    public News mapRow(ResultSet resultSet, int i) throws SQLException {
        News news = new News();
        news.setId(resultSet.getInt("_id"));
        news.setTitle(resultSet.getString("title"));
        news.setDescription(resultSet.getString("description"));
        news.setContent(resultSet.getString("content"));
        news.setCreateTime(resultSet.getString("create_time"));
        news.setUpdateTime(resultSet.getString("update_time"));
        news.setPublisher(resultSet.getString("publisher"));
        news.setIsDel(resultSet.getInt("isDel"));
        news.setType_id(resultSet.getInt("type_id"));
        news.setType(resultSet.getInt("type"));
        news.setType_name(resultSet.getString("type_name"));
        news.setIs_enable(resultSet.getInt("is_enable"));
        news.setImage(resultSet.getString("image"));
        return news;
    }
}
