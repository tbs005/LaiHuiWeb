package com.cyparty.laihui.domain;

/**
 * 咨询实体类
 * Created by YangGuang on 2017/5/12.
 */
public class Advisory {

    private Integer advisory_id;//咨询id
    private String titile;//咨询标题
    private String sub_title;//副标题
    private String content;//内容
    private String create_date;//创建时间
    private String update_date;//修改时间

    public Integer getAdvisory_id() {
        return advisory_id;
    }

    public void setAdvisory_id(Integer advisory_id) {
        this.advisory_id = advisory_id;
    }

    public String getTitile() {
        return titile;
    }

    public void setTitile(String titile) {
        this.titile = titile;
    }

    public String getSub_title() {
        return sub_title;
    }

    public void setSub_title(String sub_title) {
        this.sub_title = sub_title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(String update_date) {
        this.update_date = update_date;
    }
}
