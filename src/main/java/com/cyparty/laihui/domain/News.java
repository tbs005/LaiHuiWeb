package com.cyparty.laihui.domain;

import com.alibaba.fastjson.JSONObject;

import static com.mysql.jdbc.StringUtils.isNullOrEmpty;

public class News {
    private Integer id;

    private String title;

    private String description;

    private String createTime;

    private String updateTime;

    private String publisher;

    private String content;

    private String image;

    private int isDel;

    private Integer type_id;

    private String type_name;

    private int type;

    private int is_enable;

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Integer getType_id() {
        return type_id;
    }

    public void setType_id(Integer type_id) {
        this.type_id = type_id;
    }

    public String getType_name() {
        return type_name;
    }

    public void setType_name(String type_name) {
        this.type_name = type_name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getIs_enable() {
        return is_enable;
    }

    public void setIs_enable(int is_enable) {
        this.is_enable = is_enable;
    }

    public int getIsDel() {
        return isDel;
    }

    public void setIsDel(int isDel) {
        this.isDel = isDel;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime == null ? null : updateTime.trim();
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher == null ? null : publisher.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public boolean valid(){
        if(isNullOrEmpty(this.getTitle())|| isNullOrEmpty(this.getContent()) || isNullOrEmpty(this.getPublisher())
                || isNullOrEmpty(this.getDescription()) ){
            return false;
        }
        return true;
    }

    public JSONObject ModelToJson(){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",this.getId());
        jsonObject.put("title",this.getTitle());
        jsonObject.put("description",this.getDescription());
        jsonObject.put("publisher",this.getPublisher());
        jsonObject.put("content",this.getContent());
        jsonObject.put("createTime",this.getCreateTime());

        return jsonObject;
    }
}