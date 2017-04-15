package com.cyparty.laihui.db;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.domain.*;
import com.cyparty.laihui.mapper.*;
import com.cyparty.laihui.utilities.Utils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import javax.sql.DataSource;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhu on 2015/12/29.
 */
public class LaiHuiDB {
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplateObject = new JdbcTemplate(dataSource);
    }

    public void procedureUpdateDriverPublishInfo(int now_status, int id, int seats, String order_id) {
        String SQL = "call update_is_must_departure";
        String where = "(" + now_status + "," + id + "," + seats + ",'" + order_id + "')";
        SQL = SQL + where;
        jdbcTemplateObject.execute(SQL);
    }

    public void deleteUserAction(int order_id, String mobile, int now_status) {
        String SQL = "call delete_user_role_action";
        String where = "(" + order_id + ",'" + mobile + "'," + now_status + ")";
        SQL = SQL + where;
        jdbcTemplateObject.execute(SQL);
    }

    public void procedureUpdateUser(String transaction_name, String mobile, int status, String name, String idsn, int id, String token, String ip) {
        String SQL = "call " + transaction_name;
        SQL = SQL + "('" + mobile + "'," + status + ",'" + name + "','" + idsn + "'" + "," + id + ",'" + token + "','" + ip + "')";
        jdbcTemplateObject.execute(SQL);
    }

    public void procedureValidateCarOwner(int now_status, CarOwnerInfo carOwnerInfo) {
        String SQL = "call copy_of_create_car_validate";
        String where = "(" + now_status + "," + carOwnerInfo.getUser_id() + ",'" + carOwnerInfo.getCar_owner_name() + "','" + carOwnerInfo.getIdsn() + "','" + carOwnerInfo.getPic_licence() + "','" + carOwnerInfo.getCar_id() + "','" + carOwnerInfo.getCar_owner() + "','" + carOwnerInfo.getCar_brand() + "','" + carOwnerInfo.getCar_type() + "','" + carOwnerInfo.getCar_color() + "','" + carOwnerInfo.getCar_reg_date() + "','" + carOwnerInfo.getPic_licence2() + "','" + carOwnerInfo.getReason() + "')";
        SQL = SQL + where;
        jdbcTemplateObject.execute(SQL);
    }

    //得到同一手机号2个小时之内发送验证码次数
    public int getSendCodeTimes(String mobile) {
        String sql = "SELECT count(*)total FROM pc_sms_code where mobile=? and create_time>'" + Utils.getCurrentTimeSubOrAdd(-120) + "'";
        //int count=jdbcTemplateObject.queryForInt(sql);
        Map<String, Object> now = jdbcTemplateObject.queryForMap(sql, new Object[]{mobile});
        int total = Integer.parseInt(String.valueOf((long) now.get("total")));
        return total;
    }

    //
    public void createSMS(String mobile, String code) {
        String SQL = "insert into pc_sms_code(mobile,code,create_time) VALUES (?,?,?)";
        jdbcTemplateObject.update(SQL, new Object[]{mobile, code, Utils.getCurrentTime()});
    }

    public void createUserToken(String token, int id) {
        String SQL = "insert into pc_user_token(token,user_id,create_time,update_time) VALUES (?,?,?,?)";
        jdbcTemplateObject.update(SQL, new Object[]{token, id, Utils.getCurrentTime(), Utils.getCurrentTime()});
    }

    public String getUserTokenByID(int id) {
        String SQL = "SELECT  * from pc_user_token  where _id=?";
        Map<String, Object> now = jdbcTemplateObject.queryForMap(SQL, new Object[]{id});
        String token = (String) now.get("token");
        return token;
    }

    public List<Code> getSMS(String where) {
        String SQL = "SELECT * FROM pc_sms_code " + where + " ORDER BY create_time DESC ";
        List<Code> codeList = jdbcTemplateObject.query(SQL, new CodeMapper());
        return codeList;
    }

    //创建用户
    public List<User> getUserList(String where) {
        String SQL = "SELECT * FROM pc_user " + where;
        List<User> userList = jdbcTemplateObject.query(SQL, new UserMapper());
        return userList;
    }

    //得到token对应的id
    public int getIDByToken(String token) {
        String SQL = "SELECT user_id from pc_user_token where token=?";
        List<UserToken> userTokenList = jdbcTemplateObject.query(SQL, new Object[]{token}, new UserIDMapper());
        int id = 0;
        if (userTokenList.size() > 0) {
            id = userTokenList.get(0).getUser_id();
        }
        return id;
    }

    public List<CarOwnerInfo> getCarOwnerInfo(String where) {
        String SQL = "SELECT * FROM pc_car_owner_info a left join pc_user b on a.user_id=b._id " + where;
        List<CarOwnerInfo> carOwnerInfoList = jdbcTemplateObject.query(SQL, new CarOwnerMapper());
        return carOwnerInfoList;
    }

    public List<CarOwnerInfo> getCarOwnerInfoToken(String sql) {
        List<CarOwnerInfo> carOwnerInfoList = jdbcTemplateObject.query(sql, new CarOwnerTokenMapper());
        return carOwnerInfoList;
    }


    public void createManager(Manager manager) {
        String SQL = "insert into pc_manager(m_name,mobile,password,description,create_time,last_login_time,is_enable,m_privilege) VALUES (?,?,?,?,?,?,?,?)";
        jdbcTemplateObject.update(SQL, new Object[]{manager.getName(), manager.getMobile(), manager.getPassword(), manager.getDecription(), Utils.getCurrentTime(), Utils.getCurrentTime(), 1, 1});
    }

    public List<Manager> getManager(String where) {
        String SQL = "SELECT * FROM pc_manager " + where;
        List<Manager> managerList = jdbcTemplateObject.query(SQL, new ManagerMapper());
        return managerList;
    }

    public boolean updateManager(String where) {
        boolean is_success = true;
        String SQL = "update pc_manager " + where;
        int count = jdbcTemplateObject.update(SQL);
        if (count < 1) {
            is_success = false;
        }
        return is_success;
    }


    public boolean updateRoute(String where) {
        boolean is_success = true;
        String SQL = "update pc_route_manage " + where;
        int count = jdbcTemplateObject.update(SQL);
        if (count < 1) {
            is_success = false;
        }
        return is_success;
    }


    public int getTotalCount(String table, String where) {
        String sql = "SELECT count(*)total FROM  " + table + " " + where;
        //int count=jdbcTemplateObject.queryForInt(sql);
        Map<String, Object> now = jdbcTemplateObject.queryForMap(sql);
        int total = Integer.parseInt(String.valueOf((long) now.get("total")));
        return total;
    }

    public int getPCHDepartureCount(String where) {
        String sql = "SELECT count(*)total FROM pch_publish_info " + where;
        //int count=jdbcTemplateObject.queryForInt(sql);
        Map<String, Object> now = jdbcTemplateObject.queryForMap(sql);
        int total = Integer.parseInt(String.valueOf((long) now.get("total")));
        return total;
    }

    public boolean update(String table_name, String where) {
        boolean is_success = true;
        String SQL = "update  " + table_name + where;
        int count = jdbcTemplateObject.update(SQL);
        if (count < 1) {
            is_success = false;
        }
        return is_success;
    }

    public boolean delete(String table_name, String where) {
        boolean is_success = true;
        String SQL = "DELETE  FROM " + table_name + where;
        int count = jdbcTemplateObject.update(SQL);
        if (count < 1) {
            is_success = false;
        }
        return is_success;
    }



   /* //查询所有用户
    public List<WXUser> getWxUser(String where) {
        String SQL = "select * from pc_wx_user " + where;
        List<WXUser> userList = jdbcTemplateObject.query(SQL, new WXUserMapper());
        return userList;
    }*/

    //查询所有APP用户增长情况
    public List<UserCount> getWxUserCount(int status, String source) {
        String SQL = "";
        if (source.equals("all_user")) {

            if (status == 0) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW())  GROUP BY create_date ORDER BY user_create_time";
            } else if (status == 1) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and source=1 GROUP BY create_date ORDER BY user_create_time";
            } else if (status == 2) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and source=0 GROUP BY create_date ORDER BY user_create_time";
            }
        } else if (source.equals("validated_user")) {
            if (status == 0) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and is_validated=1  GROUP BY create_date ORDER BY user_create_time";
            } else if (status == 1) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and is_validated=1 and source=1 GROUP BY create_date ORDER BY user_create_time";
            } else if (status == 2) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and is_validated=1 and source=0 GROUP BY create_date ORDER BY user_create_time";
            }
        } else if (source.equals("car_user")) {
            if (status == 0) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and is_car_owner=1  GROUP BY create_date ORDER BY user_create_time";
            } else if (status == 1) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and is_car_owner=1 and source=1 GROUP BY create_date ORDER BY user_create_time";
            } else if (status == 2) {
                SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and is_car_owner=1 and source=0 GROUP BY create_date ORDER BY user_create_time";
            }
        }
        List<UserCount> userList = jdbcTemplateObject.query(SQL, new UserCountMapper());
        return userList;
    }

    //查询所有APP实名认证用户增长情况
    public List<UserCount> getAllValidatedUserCount(int status) {
        String SQL = "";
        if (status == 0) {
            SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW())   GROUP BY create_date ORDER BY user_create_time";
        } else if (status == 1) {
            SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and source=1 GROUP BY create_date ORDER BY user_create_time";
        } else if (status == 2) {
            SQL = "SELECT DATE(user_create_time) AS create_date, COUNT(_id) as number FROM pc_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) and source=0 GROUP BY create_date ORDER BY user_create_time";
        }
        List<UserCount> userList = jdbcTemplateObject.query(SQL, new UserCountMapper());
        return userList;
    }

    public List<UserCount> getDepartureCount() {
        String SQL = "SELECT DATE(create_time) AS create_date, COUNT(_id) as number FROM pc_driver_publish_info WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) AND is_enable=1 GROUP BY create_date ORDER BY create_time";
        List<UserCount> userList = jdbcTemplateObject.query(SQL, new UserCountMapper());
        return userList;
    }

    public List<UserCount> getPassengerOrdersCount() {
        String SQL = "SELECT DATE(create_time) AS create_date, COUNT(_id) as number FROM pc_orders WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(NOW()) AND is_enable=1 and order_type=0 GROUP BY create_date ORDER BY create_time";
        List<UserCount> userList = jdbcTemplateObject.query(SQL, new UserCountMapper());
        return userList;
    }

    public int getCount(String table, String where) {
        String sql = "SELECT count(*)total FROM  " + table + where;
        Map<String, Object> now = jdbcTemplateObject.queryForMap(sql);
        int total = Integer.parseInt(String.valueOf((long) now.get("total")));
        return total;
    }


    /**
     * APP调整接口
     */

    public List<DepartureInfo> getAppDriverepartureInfo(String where) {
        String SQL = "select * from pc_driver_publish_info a  left join pc_user b on a.mobile=b.user_mobile " + where;
        List<DepartureInfo> appDriverDepartureInfoMapperList = jdbcTemplateObject.query(SQL, new APPDriverDepartureInfoMapper());
        return appDriverDepartureInfoMapperList;
    }


    public int getMaxID(String parameter, String table) {
        String sql = "SELECT Max(" + parameter + ")id FROM  " + table;
        Integer id = jdbcTemplateObject.queryForObject(sql, Integer.class);
        return id.intValue();
    }


    public List<PassengerOrder> getPassengerOrder(String where) {
        String SQL = "SELECT * FROM pc_passenger_orders a   left join pc_user b on a.user_id=b._id " + where;
        List<PassengerOrder> passengerOrders = jdbcTemplateObject.query(SQL, new PassengerOrdersMapper());
        return passengerOrders;
    }

    //创建广告
    public boolean createCarousel(Carousel carousel) {
        boolean is_success = true;
        String SQL = "insert into pc_carousel(pc_image_url,pc_image_link,pc_image_title,pc_image_seq,pc_image_create_time,pc_image_update_time,pc_type) VALUES (?,?,?,?,?,?,?)";
        int count = jdbcTemplateObject.update(SQL, new Object[]{carousel.getImage_url(), carousel.getImage_link(), carousel.getImage_title(), carousel.getSeq(), Utils.getCurrentTime(), Utils.getCurrentTime(), carousel.getType()});
        if (count < 1) {
            is_success = false;
        }

        return is_success;
    }

    public List<Carousel> getCarousel(String where) {
        String SQL = "SELECT * FROM pc_carousel " + where;
        List<Carousel> carouselList = jdbcTemplateObject.query(SQL, new CarouselMapper());
        return carouselList;
    }

    //创建广告统计
    public boolean createSuggestion(int id, String advice, String email) {
        boolean is_success = true;

        String SQL = "insert into pc_user_suggestion(user_id,advice,create_time,contact) VALUES (?,?,?,?)";
        int count = jdbcTemplateObject.update(SQL, new Object[]{id, advice, Utils.getCurrentTime(), email});
        if (count < 1) {
            is_success = false;
        }

        return is_success;
    }


    /**
     * 后台支付管理
     */
    //创建广告统计
    public boolean createOrderPay(PayOrder payOrder) {
        boolean is_success = true;

        String SQL = "insert into pc_pay_driver_orders(user_id,user_name,user_mobile,order_id,total_pay_money,pay_status,all_pay_num,last_updated_time) VALUES (?,?,?,?,?,?,?,?)";
        int count = jdbcTemplateObject.update(SQL, new Object[]{payOrder.getUser_id(), payOrder.getUser_name(), payOrder.getUser_mobile(), payOrder.getOrder_id(), payOrder.getPay_money(), 0, payOrder.getPay_num(), Utils.getCurrentTime()});
        if (count < 1) {
            is_success = false;
        }

        return is_success;
    }

    public List<PayOrder> getOrderPayList(String where) {
        String SQL = "SELECT * FROM (SELECT * FROM cyparty_pc.pc_wx_passenger_orders where pay_num is not null)a inner join pc_user b on a.user_id=b._id " + where;
        List<PayOrder> payOrders = jdbcTemplateObject.query(SQL, new PayOrderMapper());
        return payOrders;
    }

    public List<PayOrder> getDriverOrderPayList(String where) {
        String SQL = "SELECT * FROM pc_pay_driver_orders" + where;
        List<PayOrder> payOrders = jdbcTemplateObject.query(SQL, new TotalPayOrderMapper());
        return payOrders;
    }
    //创建司机支付宝账号

    public boolean createDriverPayAccount(int user_id, String pay_account) {
        boolean is_success = true;
        String SQL = "insert into pc_driver_pay_account(user_id,pay_account,create_time,last_updated_time) VALUES (?,?,?,?)";
        int count = jdbcTemplateObject.update(SQL, new Object[]{user_id, pay_account, Utils.getCurrentTime(), Utils.getCurrentTime()});
        if (count < 1) {
            is_success = false;
        }
        return is_success;
    }

    public List<UserSuggestion> getUserSuggestion(String where) {
        String SQL = "SELECT * FROM pc_user_suggestion a left join pc_user b on a.user_id=b._id " + where;
        List<UserSuggestion> suggestions = jdbcTemplateObject.query(SQL, new UserSuggestionMapper());
        return suggestions;
    }

    //得到所有的省资料
    public List<PlaceCode> getAllProvince() {
        String sql = "SELECT * FROM laihui_pc.pc_place_code where c_parent_code ='0'";
        List<PlaceCode> provinceList = jdbcTemplateObject.query(sql, new PlaceCodeMapper());
        return provinceList;
    }

    //得到所有的市资料
    public List<PlaceCode> getAllCity(int c_parent_code) {
        String sql = "SELECT * FROM laihui_pc.pc_place_code where c_parent_code ='" + c_parent_code + "'";
        List<PlaceCode> provinceList = jdbcTemplateObject.query(sql, new PlaceCodeMapper());
        return provinceList;
    }

    //得到所有已经分配代理的区县资料
    public List<ManagerAreaLocation> getArea(String where) {
        String sql = "SELECT * FROM pc_area_manager_location " + where;
        List<ManagerAreaLocation> provinceList = jdbcTemplateObject.query(sql, new ManagerAreaLocationMapper());
        return provinceList;
    }

    //创建代理商基本信息
    public int createAreaManager(final ManagerAreaLocation manager) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        int autoIncId = 0;

        jdbcTemplateObject.update(new PreparedStatementCreator() {

            public PreparedStatement createPreparedStatement(Connection con)
                    throws SQLException {
                String sql = "insert into pc_area_manager(user_name,user_mobile,user_md5_password,user_create_time,user_last_login_time) VALUES (?,?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setString(1, manager.getUser_name());
                ps.setString(2, manager.getUser_mobile());
                ps.setString(3, manager.getUser_password());
                ps.setString(4, Utils.getCurrentTime());
                ps.setString(5, Utils.getCurrentTime());
                return ps;
            }
        }, keyHolder);

        autoIncId = keyHolder.getKey().intValue();
        return autoIncId;
    }
    //创建代理商代理区域信息

    public boolean createAreaManageLocation(List<ManagerAreaLocation> managerAreaLocationList) {
        boolean is_success = true;
        for (ManagerAreaLocation area : managerAreaLocationList) {
            String SQL = "insert into pc_area_manager_location(user_id,user_manage_area_code,user_manage_area_name,create_time) VALUES (?,?,?,?)";
            int count = jdbcTemplateObject.update(SQL, new Object[]{area.getUser_id(), area.getArea_code(), area.getArea_name(), Utils.getCurrentTime()});
            if (count < 1) {
                is_success = false;
            }
        }
        return is_success;
    }

    //得到代理商信息
    public List<ManagerAreaLocation> getAreaManageLocation(String where) {
        String SQL = "SELECT * FROM pc_area_manager " + where;
        List<ManagerAreaLocation> managerAreaLocationList = jdbcTemplateObject.query(SQL, new ManagerInfoMapper());
        return managerAreaLocationList;
    }

    //查询所有区域代理订单情况
    public List<UserCount> getAreaPassengerOrdersCount(String where) {
        //todo:只统计司机确认的订单
        String SQL = "SELECT DATE(create_time) AS create_date, COUNT(_id) as number FROM pc_passenger_orders WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= create_time  " + where + " GROUP BY create_date ORDER BY create_time;";
        List<UserCount> userList = jdbcTemplateObject.query(SQL, new UserCountMapper());
        return userList;
    }

    //得到支付信息
    public List<PayLog> getPayInfo(String where) {
        String SQL = "SELECT * FROM pay_cash_log " + where;
        List<PayLog> payLogList = jdbcTemplateObject.query(SQL, new RowMapper<PayLog>() {
            @Override
            public PayLog mapRow(ResultSet resultSet, int i) throws SQLException {
                PayLog payLog = new PayLog();
                payLog.set_id(resultSet.getInt("_id"));
                payLog.setCash(resultSet.getDouble("cash"));
                payLog.setCreate_time(Utils.checkTime(resultSet.getString("create_time")));
                payLog.setPay_type(resultSet.getInt("pay_type"));
                payLog.setPay_account(resultSet.getString("pay_account"));
                payLog.setOrder_status(resultSet.getInt("order_status"));

                payLog.setUser_name(resultSet.getString("user_name"));
                payLog.setUser_avatar(Utils.checkNull(resultSet.getString("user_avatar")));
                payLog.setUser_mobile(resultSet.getString("user_mobile"));
                return payLog;
            }
        });
        return payLogList;
    }

    public List<PayLog> getpayDetail(String where) {
        String SQL = "SELECT * FROM pay_cash_log " + where;
        List<PayLog> payLogList = jdbcTemplateObject.query(SQL, new RowMapper<PayLog>() {
            @Override
            public PayLog mapRow(ResultSet resultSet, int i) throws SQLException {
                PayLog payLog = new PayLog();
                payLog.set_id(resultSet.getInt("_id"));
                payLog.setUser_id(resultSet.getInt("user_id"));
                payLog.setDriver_id(resultSet.getInt("driver_id"));
                payLog.setCash(resultSet.getDouble("cash"));
                payLog.setCreate_time(Utils.checkTime(resultSet.getString("create_time")));
                payLog.setPay_type(resultSet.getInt("pay_type"));
                payLog.setPay_account(resultSet.getString("pay_account"));
                payLog.setOrder_status(resultSet.getInt("order_status"));

                payLog.setBoarding_point(resultSet.getString("boarding_point"));
                payLog.setBreakout_point(Utils.checkNull(resultSet.getString("breakout_point")));
                payLog.setBooking_seats(resultSet.getInt("booking_seats"));
                payLog.setTrade_no(resultSet.getString("trade_no"));
                payLog.setOrder_create_time(Utils.checkTime(resultSet.getString("b.create_time")));
                return payLog;
            }
        });
        return payLogList;
    }

    //得到支付信息
    public List<PayBack> getPayBack(String where) {
        String SQL = "SELECT * FROM pc_application_pay_back " + where;
        List<PayBack> payBackList = jdbcTemplateObject.query(SQL, (resultSet, i) -> {
            PayBack payBack = new PayBack();
            payBack.set_id(resultSet.getInt("_id"));
            payBack.setPay_cash(resultSet.getDouble("pay_cash"));
            payBack.setCreate_time(Utils.checkTime(resultSet.getString("create_time")));
            payBack.setPay_type(resultSet.getInt("pay_type"));
            payBack.setPay_account(resultSet.getString("pay_account"));
            payBack.setOrder_id(resultSet.getInt("order_id"));
            payBack.setPay_status(resultSet.getInt("pay_status"));
            payBack.setPay_reason(resultSet.getString("pay_reason"));

            payBack.setUser_name(resultSet.getString("user_name"));
            payBack.setUser_avatar(Utils.checkNull(resultSet.getString("user_avatar")));
            payBack.setUser_mobile(resultSet.getString("user_mobile"));
            return payBack;
        });
        return payBackList;
    }

    public List<PassengerOrder> getPassengerDepartureInfo(String where) {
        String SQL = "SELECT * FROM pc_passenger_publish_info a left join pc_user b on a.user_id=b._id " + where;
        List<PassengerOrder> passengerPublishInfoList = jdbcTemplateObject.query(SQL, new PassengerPublishInfoMapper());
        return passengerPublishInfoList;
    }

    public List<AppOrder> getOrderReview(String where, int type) {
        String SQL = "SELECT * FROM pc_orders " + where;
        List<AppOrder> orders = new ArrayList<>();
        switch (type) {
            case 0: //不关联表
                orders = jdbcTemplateObject.query(SQL, new RowMapper<AppOrder>() {
                    @Override
                    public AppOrder mapRow(ResultSet resultSet, int i) throws SQLException {
                        AppOrder order = new AppOrder();
                        order.set_id(resultSet.getInt("_id"));
                        order.setOrder_id(resultSet.getInt("order_id"));
                        order.setUser_id(resultSet.getInt("user_id"));
                        order.setOrder_status(resultSet.getInt("order_status"));
                        order.setUpdate_time(Utils.checkTime(resultSet.getString("update_time")));
                        order.setCreate_time(Utils.checkTime(resultSet.getString("create_time")));

                        return order;
                    }
                });
                break;
            case 1: //关联user表
                orders = jdbcTemplateObject.query(SQL, new RowMapper<AppOrder>() {
                    @Override
                    public AppOrder mapRow(ResultSet resultSet, int i) throws SQLException {
                        AppOrder order = new AppOrder();

                        order.set_id(resultSet.getInt("_id"));
                        order.setOrder_id(resultSet.getInt("order_id"));
                        order.setUser_id(resultSet.getInt("user_id"));
                        order.setOrder_status(resultSet.getInt("order_status"));
                        order.setUpdate_time(Utils.checkTime(resultSet.getString("update_time")));
                        order.setCreate_time(Utils.checkTime(resultSet.getString("create_time")));
                        String name = Utils.checkNull(resultSet.getString("user_name"));
                        String idsn = Utils.checkNull(resultSet.getString("user_idsn"));

                        if (!name.isEmpty()) {
                            String endName = "";
                            if (!idsn.isEmpty()) {
                                String sexNum = idsn.substring(16, 17);
                                if (!sexNum.isEmpty()) {
                                    if (Integer.parseInt(sexNum) % 2 == 1) {
                                        endName = "先生";
                                    } else {
                                        endName = "女士";
                                    }
                                }
                            }
                            if (name.length() <= 3) {
                                name = name.substring(0, 1) + endName;
                            } else {
                                name = name.substring(0, 2) + endName;
                            }
                        }
                        order.setUser_name(name);
                        order.setUser_mobile(Utils.checkNull(resultSet.getString("user_mobile")));
                        order.setUser_avatar(Utils.checkNull(resultSet.getString("user_avatar")));
                        return order;
                    }
                });
                break;
            case 2: //关联乘客出行表
                orders = jdbcTemplateObject.query(SQL, new RowMapper<AppOrder>() {
                    @Override
                    public AppOrder mapRow(ResultSet resultSet, int i) throws SQLException {
                        AppOrder order = new AppOrder();

                        order.set_id(resultSet.getInt("_id"));
                        order.setOrder_id(resultSet.getInt("order_id"));
                        order.setUser_id(resultSet.getInt("b.user_id"));
                        order.setDriver_id(resultSet.getInt("a.user_id"));
                        order.setOrder_status(resultSet.getInt("order_status"));
                        order.setUpdate_time(Utils.checkTime(resultSet.getString("update_time")));
                        order.setCreate_time(Utils.checkTime(resultSet.getString("create_time")));


                        order.setBoarding_point(resultSet.getString("boarding_point"));
                        order.setBreakout_point(resultSet.getString("breakout_point"));
                        order.setBooking_seats(resultSet.getInt("booking_seats"));
                        order.setPrice(resultSet.getInt("price"));
                        order.setDeparture_time(Utils.checkTime(resultSet.getString("departure_time")));
                        order.setDescription(resultSet.getString("description"));

                        return order;
                    }
                });
                break;
            default:
                break;
        }
        return orders;
    }

    public List<OrderOf76> getOrderOf76(String where) {
        String SQL = "SELECT * FROM pc_76_orders " + where;
        List<OrderOf76> orderList = jdbcTemplateObject.query(SQL, new RowMapper<OrderOf76>() {
            @Override
            public OrderOf76 mapRow(ResultSet resultSet, int i) throws SQLException {
                OrderOf76 order = new OrderOf76();
                order.setId(resultSet.getInt("_id"));
                order.setData(resultSet.getString("goods_data"));
                order.setGoods_price(resultSet.getDouble("goods_price"));
                order.setBuyer_location(resultSet.getString("buyer_location"));
                order.setBuyer_name(resultSet.getString("buyer_name"));
                order.setBuyer_mobile(resultSet.getString("buyer_mobile"));
                order.setBuyer_description(resultSet.getString("buyer_description"));
                order.setPay_number(resultSet.getString("pay_number"));
                order.setCreate_time(Utils.checkTime(resultSet.getString("create_time")));
                order.setDeliver_name(Utils.checkNull(resultSet.getString("deliver_name")));
                order.setDeliver_number(Utils.checkNull(resultSet.getString("deliver_number")));
                return order;
            }
        });
        return orderList;
    }

    //生成最上级的推广人的推广码
    public boolean createPopularize(int popularize_id, int popularize_parent_id, String popularize_parents_id, String popularize_code, int is_enable, int level) {
        boolean is_success = true;
        String SQL = "insert into pc_popularize (popularize_id,popularize_parent_id,popularize_parents_id,popularize_code,create_time,update_time,is_enable,level) VALUES(?,?,?,?,?,?,?,?)";
        int count = jdbcTemplateObject.update(SQL, new Object[]{popularize_id, popularize_parent_id, popularize_parents_id, popularize_code, Utils.getCurrentTime(), Utils.getCurrentTime(), is_enable, level});
        if (count < 1) {
            is_success = false;
        }
        return is_success;
    }

    //查询获取当前推广员的推广码
    public List<Popularize> getPopular(int user_id) {
        String SQL = "select * from pc_popularize where popularize_id =" + user_id;
        List<Popularize> popularizeList = jdbcTemplateObject.query(SQL, new PopularizeMapper());
        return popularizeList;
    }

    //查询车主认证状态
    public List<UserDriverLicenseInfo> getDriverLicense() {
        String SQL = "select * from pc_user_driver_license_info where is_enable=1 order by create_time limit 1 ";
        List<UserDriverLicenseInfo> driverLicenseInfos = jdbcTemplateObject.query(SQL, new UserDriverLicenseInfoMapper());
        return driverLicenseInfos;
    }

    //查询车主行驶证认证状态
    public List<UserTravelCardInfo> getTravelCard() {
        String SQL = "select * from pc_user_travel_card_info where is_enable=1 order by create_time limit 1 ";
        List<UserTravelCardInfo> userTravelCardInfos = jdbcTemplateObject.query(SQL, new UserTravelCardInfoMapper());
        return userTravelCardInfos;
    }

    //根据用户id查询车主驾证认证状态
    public List<UserDriverLicenseInfo> getDriver(int user_id) {
        String SQL = "select * from pc_user_driver_license_info where user_id =" + user_id;
        List<UserDriverLicenseInfo> driverLicenseInfos = jdbcTemplateObject.query(SQL, new UserDriverLicenseInfoMapper());
        return driverLicenseInfos;
    }

    //根据用户id查询车主行驶证认证状态
    public List<UserTravelCardInfo> getTravel(int user_id) {
        String SQL = "select * from pc_user_travel_card_info where user_id =" + user_id;
        List<UserTravelCardInfo> userTravelCardInfos = jdbcTemplateObject.query(SQL, new UserTravelCardInfoMapper());
        return userTravelCardInfos;
    }
    //查询合作商家所有信息
    public List<Business> listBusiness(){
        String SQL="select * from pc_merchant_join ";
        List<Business> businessList = jdbcTemplateObject.query(SQL,new BusinessMapper());
        return businessList;
    }

    //添加pc端车主车单
    public boolean createDeriverCarList(String mobile, String departure_time, String boarding_point, String breakout_point, int init_seats, String remark, int departure_address_code, int departure_city_code, int destination_address_code, int destination_city_code) {
        boolean is_success = true;
        String SQL = "insert into pc_driver_publish_info(user_id,mobile,departure_time,boarding_point,breakout_point,init_seats,remark,departure_address_code,departure_city_code,destination_address_code,destination_city_code,create_time,is_enable,source) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            jdbcTemplateObject.update(SQL, new Object[]{-5, mobile, departure_time, boarding_point, breakout_point, init_seats, remark, departure_address_code, departure_city_code, destination_address_code, departure_city_code, Utils.getCurrentTime(),1,5});
        } catch (Exception e) {
            is_success = false;
        }
        return is_success;

    }

    //添加pc端车主车单
    public boolean createPassengerCarList(String mobile, String departure_time, String boarding_point, String breakout_point, int booking_seats, String remark, int departure_address_code, int departure_city_code, int destination_address_code, int destination_city_code) {
        boolean is_success = true;
        String SQL = "insert into pc_passenger_publish_info(user_id,trade_no,departure_time,boarding_point,breakout_point,booking_seats,remark,departure_address_code,departure_city_code,destination_address_code,destination_city_code,create_time,is_enable,source) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            jdbcTemplateObject.update(SQL, new Object[]{-5, mobile, departure_time, boarding_point, breakout_point, booking_seats, remark, departure_address_code, departure_city_code, destination_address_code, destination_city_code, Utils.getCurrentTime(),1,5});
        } catch (Exception e) {
            is_success = false;
        }
        return is_success;

    }
}

