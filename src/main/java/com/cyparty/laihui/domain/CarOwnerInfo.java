package com.cyparty.laihui.domain;

/**
 * Created by zhu on 2016/7/25.
 */
public class CarOwnerInfo {
    private int user_id,_id;
    private String car_owner_name,idsn,pic_licence,pic_licence2,car_id,car_owner,car_brand,car_type,car_color,car_reg_date,car_validate_date,reason;
    private String token;
    private String checked_time;
    private String user_avatar;
    private String user_mobile;
    private String user_name;

    public String getUser_mobile() {
        return user_mobile;
    }

    public void setUser_mobile(String user_mobile) {
        this.user_mobile = user_mobile;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_avatar() {
        return user_avatar;
    }

    public void setUser_avatar(String user_avatar) {
        this.user_avatar = user_avatar;
    }

    public String getChecked_time() {
        return checked_time;
    }

    public void setChecked_time(String checked_time) {
        this.checked_time = checked_time;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int get_id() {
        return _id;
    }

    public void set_id(int _id) {
        this._id = _id;
    }

    public String getCar_owner_name() {
        return car_owner_name;
    }

    public void setCar_owner_name(String car_owner_name) {
        this.car_owner_name = car_owner_name;
    }

    public String getIdsn() {
        return idsn;
    }

    public void setIdsn(String idsn) {
        this.idsn = idsn;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getPic_licence() {
        return pic_licence;
    }

    public void setPic_licence(String pic_licence) {
        this.pic_licence = pic_licence;
    }

    public String getPic_licence2() {
        return pic_licence2;
    }

    public void setPic_licence2(String pic_licence2) {
        this.pic_licence2 = pic_licence2;
    }

    public String getCar_id() {
        return car_id;
    }

    public void setCar_id(String car_id) {
        this.car_id = car_id;
    }

    public String getCar_owner() {
        return car_owner;
    }

    public void setCar_owner(String car_owner) {
        this.car_owner = car_owner;
    }

    public String getCar_brand() {
        return car_brand;
    }

    public void setCar_brand(String car_brand) {
        this.car_brand = car_brand;
    }

    public String getCar_type() {
        return car_type;
    }

    public void setCar_type(String car_type) {
        this.car_type = car_type;
    }

    public String getCar_color() {
        return car_color;
    }

    public void setCar_color(String car_color) {
        this.car_color = car_color;
    }

    public String getCar_reg_date() {
        return car_reg_date;
    }

    public void setCar_reg_date(String car_reg_date) {
        this.car_reg_date = car_reg_date;
    }

    public String getCar_validate_date() {
        return car_validate_date;
    }

    public void setCar_validate_date(String car_validate_date) {
        this.car_validate_date = car_validate_date;
    }
}
