<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/3
  Time: 11:09
  describtion:后台管理--【个人配置】人员基本信息
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<link rel="stylesheet" href="/resource/css/db_activity_push.css" >
<script src="/resource/js/db_activity_push.js" type="text/javascript"></script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>消息推送</span>
            </div>
        </div>
        <div class="content">
            <div class="sms">
                <br>  总数　:<span class = "total">2</span> </br>
                <br>  最大id:<span class = "last"></span> </br>
            </div>
            <form id="pushForm" enctype="multipart/form-data" method="post">
                <div class="editor_mid_box" style="margin-left: -25px;">
                    <input type="file" title="支持jpg、jpeg、gif、png格式，文件小于2M" size="1"
                           onchange="loadImageChange(this)" class="file_prew file0" name="img"
                           accept=".jpg,.png,.gif,.jpeg">
                    <img src="" class="img0" alt="">
                    <div class="editor_cancel" onclick="removePicture(this)"></div>
                    <div class="editor_change">
                        <div class="editor_mid_box_img">
                        </div>
                        <div class="editor_mid_box_txt">
                            <span>上传轮播图片</span>
                        </div>
                    </div>
                </div>
                <br> 推送标题：
                <input type="text" name="title" class="message"></br>
                <br> 推送消息：
                <input type="text" name="content" class="message"></br>
                <br> 推送链接：
                <input type="text" name="url" class="url"></br>
                <br> 推送类型：
                <input type="text" name="type" class="types"></br>
                <br> 开始id　：
                <input type="text" name="start" class="start"></br>
                <br> 结束id　：
                <input type="text" name="end" class="end"></br>
                <br>
                <input type="button" value="推送" onclick="submitForm()" style="width: 140px;margin-bottom: 100px;">
                </br>
            </form>
        </div>
        <%--分页加载--%>
    </div>
    <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>