package com.cyparty.laihui.domain;

/**
 * Created by lunwf on 2017/6/16.
 */
public class MustArrive {
    private String order_id;
    private String trade_no;
    private String user_id;     //乘客ID
    private String username;    //乘客姓名
    private String sex;    //乘客性别
    private String isdn;    //乘客身份证
    private String mobile;      //乘客手机号
    private String boarding_point;  //起点信息
    private String breakout_point;  //终点信息
    private String price;            //价格
    private String order_status;    //是否已经被抢单 0：否；1：是
    private String is_enable;       //订单是否可用  0：不可用  1：可用
    private String refuse;           //乘客拒绝推荐订单次数
    private String departure_time;  //乘客出发时间
    private String create_time;      //订单创建时间


    public void setTrade_no(String trade_no) {
        this.trade_no = trade_no;
    }

    public String getTrade_no() {

        return trade_no;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public void setIsdn(String isdn) {
        this.isdn = isdn;
    }

    public String getSex() {
        return sex;
    }

    public String getIsdn() {
        return isdn;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public String getUsername() {
        return username;
    }

    public String getMobile() {
        return mobile;
    }

    public String getBoarding_point() {
        return boarding_point;
    }

    public String getBreakout_point() {
        return breakout_point;
    }

    public String getPrice() {
        return price;
    }

    public String getOrder_status() {
        return order_status;
    }

    public String getIs_enable() {
        return is_enable;
    }

    public String getRefuse() {
        return refuse;
    }

    public String getDeparture_time() {
        return departure_time;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public void setBoarding_point(String boarding_point) {
        this.boarding_point = boarding_point;
    }

    public void setBreakout_point(String breakout_point) {
        this.breakout_point = breakout_point;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public void setOrder_status(String order_status) {
        this.order_status = order_status;
    }

    public void setIs_enable(String is_enable) {
        this.is_enable = is_enable;
    }

    public void setRefuse(String refuse) {
        this.refuse = refuse;
    }

    public void setDeparture_time(String departure_time) {
        this.departure_time = departure_time;
    }

    public void setCreate_time(String create_time) {
        this.create_time = create_time;
    }
}
