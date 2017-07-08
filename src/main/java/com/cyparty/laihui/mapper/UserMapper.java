package com.cyparty.laihui.mapper;

import com.cyparty.laihui.domain.User;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by zhu on 2015/12/29.
 */
public class UserMapper implements RowMapper<User> {

    public User mapRow(ResultSet resultSet, int i) throws SQLException {
        User user=new User();

        user.setUser_id(resultSet.getInt("_id"));

        user.setUser_mobile(resultSet.getString("user_mobile"));
        user.setUser_name(Utils.checkNull(resultSet.getString("user_name")));
        String idsn= Utils.checkNull(resultSet.getString("user_idsn"));
        String name= Utils.checkNull(resultSet.getString("user_name"));
        String sex="";
        String birthday ="";
        if(!name.isEmpty()) {
            String endName = "";
            if (!idsn.isEmpty()) {
                if(idsn.length()>=18){
                    birthday=idsn.substring(6, 14);
                    String sexNum = idsn.substring(16, 17);
                    if (!sexNum.isEmpty()) {
                        if (Integer.parseInt(sexNum) % 2 == 1) {
                            endName = "先生";
                            sex="男";
                        } else {
                            endName = "女士";
                            sex="女";
                        }
                    }
                }else {
                    System.out.println(idsn+":user_id"+user.getUser_id());
                }
            }
            if (name.length() <= 3) {
                name = name.substring(0, 1) + endName;
            } else {
                name = name.substring(0, 2) + endName;
            }
        }
        user.setUser_nick_name(name);
        if(!idsn.trim().equals("")&&idsn.length()>17){
            idsn=idsn.substring(0,3)+"******"+idsn.substring(14);
        }
        user.setUser_idsn(idsn);
        String create_time=resultSet.getString("user_create_time");
        String last_login=resultSet.getString("user_last_login");
        if(create_time!=null){
            create_time=create_time.split("\\.")[0];
        }
        if(last_login!=null){
            last_login=last_login.split("\\.")[0];
        }

        user.setUser_create_time(create_time);
        user.setUser_last_login(last_login);
        user.setIs_validated(resultSet.getInt("is_validated"));
        user.setIs_car_owner(resultSet.getInt("is_car_owner"));
        user.setReason(Utils.checkNull(resultSet.getString("checked_unpass_reason")));
        user.setUser_last_login_ip(Utils.checkNull(resultSet.getString("user_last_login_ip")));
        user.setAvatar(Utils.checkNull(resultSet.getString("user_avatar")));
        user.setFlag(resultSet.getInt("flag"));

        user.setSource(resultSet.getString("source"));
        user.setSex(sex);
        user.setSignature(resultSet.getString("signature"));
        user.setBirthday(birthday);
        user.setLive_city(resultSet.getString("live_city"));
        user.setHome(resultSet.getString("home"));
        user.setCompany(resultSet.getString("company"));
        user.setDelivery_address(resultSet.getString("delivery_address"));
        return user;
    }
}
