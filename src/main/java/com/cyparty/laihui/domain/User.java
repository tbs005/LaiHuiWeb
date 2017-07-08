package com.cyparty.laihui.domain;

/**
 * Created by zhu on 2016/3/4.
 */
public class User {
    private int user_id=0;
    private int is_validated=0;
    private int is_car_owner=0;
    private String user_mobile;
    private String user_create_time;
    private String user_last_login;
    private String user_last_login_ip;
    private String user_name;
    private String user_nick_name;
    private String user_idsn;
    private String reason;
    private String avatar;
    private String source;
    private String sex;
    private String signature;
    private String birthday;
    private String live_city;
    private String home;
    private String company;
    private String delivery_address;
    private int flag;

    public String getUser_nick_name() {
        return user_nick_name;
    }

    public void setUser_nick_name(String user_nick_name) {
        this.user_nick_name = user_nick_name;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getUser_last_login_ip() {
        return user_last_login_ip;
    }

    public void setUser_last_login_ip(String user_last_login_ip) {
        this.user_last_login_ip = user_last_login_ip;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getIs_validated() {
        return is_validated;
    }

    public void setIs_validated(int is_validated) {
        this.is_validated = is_validated;
    }

    public int getIs_car_owner() {
        return is_car_owner;
    }

    public void setIs_car_owner(int is_car_owner) {
        this.is_car_owner = is_car_owner;
    }

    public String getUser_mobile() {
        return user_mobile;
    }

    public void setUser_mobile(String user_mobile) {
        this.user_mobile = user_mobile;
    }

    public String getUser_create_time() {
        return user_create_time;
    }

    public void setUser_create_time(String user_create_time) {
        this.user_create_time = user_create_time;
    }

    public String getUser_last_login() {
        return user_last_login;
    }

    public void setUser_last_login(String user_last_login) {
        this.user_last_login = user_last_login;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_idsn() {
        return user_idsn;
    }

    public void setUser_idsn(String user_idsn) {
        this.user_idsn = user_idsn;
    }

    public int getFlag() {return flag;}

    public void setFlag(int flag) {this.flag = flag;}

    public String getSource() {
        return source;
    }

    public String getSex() {
        return sex;
    }

    public String getSignature() {
        return signature;
    }

    public String getBirthday() {
        return birthday;
    }

    public String getLive_city() {
        return live_city;
    }

    public String getHome() {
        return home;
    }

    public String getCompany() {
        return company;
    }

    public String getDelivery_address() {
        return delivery_address;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public void setLive_city(String live_city) {
        this.live_city = live_city;
    }

    public void setHome(String home) {
        this.home = home;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public void setDelivery_address(String delivery_address) {
        this.delivery_address = delivery_address;
    }
}
