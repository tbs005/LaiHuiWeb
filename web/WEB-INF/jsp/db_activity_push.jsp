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
<style>
    .userManage_container {
        width: 902px;
        margin: 30px auto 0;
        min-height: 550px;
    }

    .user_container {
        padding: 8px 20px;
        border-bottom: 1px solid #e8e8e8;
        position: relative;
    }

    .user_container_last_child {
        border-bottom: none;
    }

    .user_avatar {
        border-radius: 50%;
        width: 40px;
        position: relative;
        top: 6px;
    }

    .user_mobile {
        padding-left: 10px;
        font-size: 16px;
    }

    .user_name {
        color: #999;
        padding-left: 8px;
    }

    .user_time {
        display: block;
        float: right;
        color: #999;
    }

    .user_content {
        padding-left: 56px;
        text-indent: 28px;
        color: #777;
    }
    .user_content p{
        margin-bottom: 4px;
    }

    .user_message {
        line-height: 36px;
    }

    .delete_message {
        display: inline-block;
        float: right;
        color: #f5ad4e;
        cursor: pointer;
    }

    .delete_message:hover {
        color: #FF8F0c;
    }

    /*p::before{*/
    /*content: '“';*/
    /*color: #999;*/
    /*font-size: 20px;*/
    /*}*/
    /*p::after{*/
    /*content: '”';*/
    /*color: #999;*/
    /*font-size: 20px;*/
    /*}*/
    .user_container:hover {
        background-color: #fafafa;
    }

    /*user_list_select_delete_tip*/
    .user_list_select_delete_tip {
        position: absolute;
        /* top: 110px; */
        display: none;
        right: -44px;
        width: 170px;
        height: 110px;
        border: 1px solid #e8e8e8;
        z-index: 1;
        background-color: #fff;
        padding-top: 18px;
        text-align: center;
        bottom: -109px;
    }

    .user_list_select_delete_tip .popover_arrow {
        position: absolute;
        left: 55%;
        margin-left: -8px;
        margin-top: -8px;
        display: inline-block;
        width: 0;
        height: 0;
        border-width: 8px;
        border-style: dashed;
        border-color: transparent;
        border-top-width: 0;
        border-bottom-color: #d9dadc;
        border-bottom-style: solid;
    }

    .user_list_select_delete_tip .popover_arrow_in {
        border-bottom-color: #fff;
        top: 1px;
    }

    .user_list_select_delete_tip .popover_arrow_out {
        top: 0;
    }

    .detailAll_tip_no {
        margin-right: 0;
    }

    .detailAll_tip_txt {
        font-size: 16px;
        margin-bottom: 20px;
    }

    .detailAll_tip_yes, .detailAll_tip_no {
        padding: 5px 10px;
        background-color: #f5ad4e;
        color: #fff;
        margin-right: 0px;
        cursor: pointer;
    }

    .detailAll_tip_no {
        margin-left: 14px;
    }

    /*tab标签css样式*/
    .select_checkbox {
        color: #777;
        cursor: pointer;
        position: relative;
        text-align: center
    }

    .select_checkbox_active .select_popover_arrow {
        position: absolute;
        right: 0px;
        display: inline-block;
        width: 0px;
        height: 0;
        border-style: dashed;
        border-color: transparent;
        border-bottom-color: #f5ad4e;
        border-bottom-style: solid;
        top: 19px;
        border-left-width: 10px;
        border-right-width: 0px;
        border-top-width: 0px;
        border-bottom-width: 10px;
    }

    .select_checkbox_container {
        position: relative;
        display: inline-block;
        padding: 2px 6px;
        border: 1px solid #e8e8e8;
        margin-right: 20px;
        margin-bottom: 10px;
    }

    .select_checkbox_active {
        border: 1px solid #f5ad4e;
    }
    .publish_time_select {
        float: left;
        line-height: 25px;
        margin-top: 5px;
        margin-left: 30px;
    }
    /*以下是王凡*/
    .content{
        text-align: center;
        font-size: 20px;
        margin-top: 50px;
    }
    .sms{
        text-align: center;
        font-size: 14px;
        margin-top: 30px;
    }
    .total{
        width: 30%;
        line-height: 2.5;
        font-size: 10px;
        border-radius: 10px;
        outline: none;
        margin-right: 30px;
    }
    .last{
        width: 30%;
        line-height: 2.5;
        font-size: 10px;
        border-radius: 10px;
        outline: none;
        margin-right: 30px;
    }
    .message{
        width: 30%;
        line-height: 2.5;
        font-size: 20px;
        border-radius: 10px;
        outline: none;
        margin-right: 50px;
    }
    .url{
        width: 30%;
        line-height: 2.5;
        font-size: 20px;
        border-radius: 10px;
        outline: none;
        margin-right: 50px;
    }
    .types{
        width: 30%;
        line-height: 2.5;
        font-size: 20px;
        border-radius: 10px;
        outline: none;
        margin-right: 50px;
    }
    .start{
        width: 30%;
        line-height: 2.5;
        font-size: 20px;
        border-radius: 10px;
        outline: none;
        margin-right: 50px;
    }
    .end{
        width: 30%;
        line-height: 2.5;
        font-size: 20px;
        border-radius: 10px;
        outline: none;
        margin-right: 50px;
    }
    #btn{
        width: 50px;
        background: #FF8F0c;
        border: none;
        line-height: 2.5;
        color: white;
        font-size: 20px;
        border-radius: 10px;
        outline: none;
    }
    /*以上是王凡*/


    .editor_mid_box {
        height: 200px;
        width: 45%;
        margin: 5px auto;
        border: 2px dashed #d2d4d5;
        background-color: #f7f9fa;
        position: relative;
        overflow: hidden;
        cursor: pointer;
        text-align: center;
        margin-bottom: 20px;
        display: inline-block;
        max-width: 92%;
    }

    .editor_mid_box_img {
        margin: 66px auto 10px;
        display: block;
        background: transparent url("/resource/images/icon_photo.png") -50px 0 no-repeat;
        width: 50px;
        height: 48px;
        color: rgba(0, 0, 0, 0.58);
        text-shadow: 0 1px 0 #fff;
    }

    .editor_mid_box_txt {
        text-align: center;
        color: #b7bfc5;
    }

    .editor_mid_box .file_prew {
        width: 100%;
        height: 100%;
        position: absolute;
        opacity: 0;
        filter: alpha(opacity=0);
        cursor: pointer;
    }

    .editor_cancel {
        width: 20px;
        height: 20px;
        position: absolute;
        top: 4px;
        right: 0;
        display: none;
        background: transparent url("/resource/images/icon_photo.png") -148px 0 no-repeat;
    }

</style>
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
            <form>
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
                <br> 推送消息：
                <input type="text" class="message"></br>
                <br> 推送链接：
                <input type="text" class="url"></br>
                <br> 推送类型：
                <input type="text" class="types"></br>
                <br> 开始id　：
                <input type="text" class="start"></br>
                <br> 结束id　：
                <input type="text" class="end"></br>
                <br>
                <input type="button" value="推送" id="btn" style="width: 140px;margin-bottom: 100px;">
                </br>
            </form>
        </div>
        <%--分页加载--%>
    </div>
    <div class="clear"></div>
</div>
<script src="/resource/js/jquery-1.11.3.min.js"></script>
<script>
    loadUser();
    function loadUser() {
        var obj = {};
        operation.operation_ajax('/push/last', obj, insertMessage);
    }
    function insertMessage() {
        console.log(global_data);
        var all_count = global_data.total;
        var last =global_data.last;
        $('.total').text(all_count + "条");
        $('.last').text(last );
    }
    $('#btn').click(function (){
        var message=$('.message').val();
        var url = $('.url').val();
        var types = $('.types').val();
        var start=$('.start').val();
        var end=$('.end').val();
        console.log(message);
        $.ajax({
            type: 'POST',
            url: '/activities/push',
            data:{"content":message,"url":url,"type":types,"start":start,"end":end},
            dataType:'json',
            success:function(data){
                console.log(data.result);
                alert(data.message);
                window.location.reload();
            },
            error: function(){
                alert("推送失败")
                window.location.reload();
            }

        });
    })


    //初始加载图片设置
    function loadImageChange(obj) {
        console.log("开始替换图片");
        var objUrl = getObjectURL(obj.files[0]);
        console.log('objUrl'+objUrl);
        if(objUrl!=null){
            var j = $(obj).parent().children('.img0');
            j.addClass("add_image");
            var k = $(obj).parent();
            if (objUrl) {
                $(obj).parent().children('.img0').attr("src", objUrl).attr('id',-1);
            }
            var i = $(obj).parent().children('.img0').attr("src");
            imageStyle(i, j, k);
        }
    }
    function imageStyle(i, j, k) {
        console.log("改变img的框的大小和添加提示图片的显示");
        if (i == undefined || i == "") {
            console.log("回复默认设置");
            k.css({"width": "92%"});
            k.children('.editor_change').css('display', 'block');
            k.children('.editor_cancel').css('display', 'none');
            j.css({"display": "none"});
        } else {
            console.log("改变图片设置");
            k.css({"width": "auto"});
            k.children('.editor_change').css('display', 'none');
            k.children('.editor_cancel').css('display', 'block');
            j.css({"height": "100%", "display": "block"});
        }
    }
    //建立一個可存取到該file的url
    function getObjectURL(file) {
        var url = null;
        if (window.createObjectURL != undefined) { // basic
            url = window.createObjectURL(file);
        } else if (window.URL != undefined) { // mozilla(firefox)
            url = window.URL.createObjectURL(file);
        } else if (window.webkitURL != undefined) { // webkit or chrome
            url = window.webkitURL.createObjectURL(file);
        }
        console.log("获取到的url是" + url);
        return url;
    }

    //点击删除添加图片设置
    function removePicture(obj) {
        var j = $(obj).parent().children('.img0');
        var k = $(obj).parent();
        k.css({"width": "45%"});
        k.children('.editor_change').css('display', 'block');
        k.children('.editor_cancel').css('display', 'none');
        j.css({"display": "none"});
        $(obj).parent().children('.file0').val("");
    }
</script>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>