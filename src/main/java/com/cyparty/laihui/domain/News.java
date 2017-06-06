package com.cyparty.laihui.domain;

import com.alibaba.fastjson.JSONObject;

import static com.mysql.jdbc.StringUtils.isNullOrEmpty;

public class News {
    private Integer id;

    private String title;

    private String description;

    private String createTime;

    private String deleteTime;

    private String updateTime;

    private String publisher;

    private String content;

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

    public String getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(String deleteTime) {
        this.deleteTime = deleteTime == null ? null : deleteTime.trim();
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