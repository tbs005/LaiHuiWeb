package com.cyparty.laihui.domain;

/**
 * Created by zhu on 2016/10/28.
 */
public class PlaceCode {
    private int code;
    private String place;

    private int c_parent_code;
    private int c_id;
    public int getCode() {
        return code;
    }

    public int getC_parent_code() {
        return c_parent_code;
    }

    public void setC_parent_code(int c_parent_code) {
        this.c_parent_code = c_parent_code;
    }

    public int getC_id() {
        return c_id;
    }

    public void setC_id(int c_id) {
        this.c_id = c_id;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }
}
