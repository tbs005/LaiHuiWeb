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
    body{
        font-size: 14px;
        font-family: Microsoft Yahei;
        padding: 20px;
    }
    .content{
        float: left;
        width: 47%;
        margin: 0 auto;
        line-height:30px;
        padding: 10px;
        margin-top: 20px;
    }
    input{
        background: #fff;
        line-height: 2;
        border-radius: 5px;
        outline: none;
        border: 1px solid rgba(0, 0, 0, 0.43);
    }
    .line1{
        margin-bottom: 10px;
    }
    .travel_license_photo{
        margin:20px auto auto 30px;
    }
    .btn{
        width: 100%;
        /*margin: 0 auto;*/
        text-align: center;
    }
    #btn01{
        display: inline-block;
        margin-right: 30px;
    }
    #btn01,#btn02{
        padding: 5px 10px 5px 10px;
        background: #366ead;
        color: white;
    }
    .describe{
        margin-left: 30px;
    }
    .not_describe{
        color: #bf0000;
    }
    .name{
        padding-left: 30px;
    }
    /*以上是王凡*/
</style>

<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>车主认证审核</span>
            </div>
        </div>
        <div style="overflow: hidden;width: 100%;margin: 0 auto;">
            <div class="content">
                <div class="line1">
                    <span class="name">驾驶员姓名：</span><span class="driver_name"></span>
                </div>
                <div class="line1">
                    <span class="name">驾驶证号：</span><span class="driver_license_number"></span>
                </div>
                <div class="line1">
                    <span class="name">初次领证日期：</span><span class="first_issue_date"></span>
                </div>
                <div class="line1">
                    <span class="name">准驾车型：</span><span class="allow_car_type"></span>
                </div>
                <div class="line1">
                    <span class="name">有效期：</span><span class="effective_date_end"></span>
                </div>
                <div class="line1">
                    <span class="name">架驶证照片：</span>
                    <div class="driver_license_photo">
                        <img src="" alt="" width="80%">
                    </div>
                </div>

            </div>
            <div class="content">
                <div class="line1">
                    <span class="name">车牌号：</span><span class="car_license_number"></span>
                </div>
                <div class="line1">
                    <span class="name">车辆颜色：</span><span class="car_color"></span>
                </div>
                <div class="line1">
                    <span class="name">品牌车型：</span><span class="car_type"></span>
                </div>
                <div class="line1">
                    <span class="name">注册日期：</span><span class="registration_date"></span>
                </div>
                <div class="line1">
                    <span class="name">车辆所有人：</span><span class="vehicle_owner_name"></span>
                </div>
                <div class="line1">
                    <span class="name">行驶证照片：</span>
                    <div class="travel_license_photo">
                        <img src="" alt="" width="80%">
                    </div>
                </div>

            </div>
        </div>
        <div style="width: 100%;text-align: center">
            <form>
                <div class="line1 not_describe">
                    <span class="name">*审核未通过描述:</span><input type="text" class="describe">
                </div>
                <div class="btn">
                    <input type="submit" value="审核通过" id="btn01"><input type="submit" value="审核未通过" id="btn02">
                </div>
            </form>
        </div>
    </div>

    <div class="clear"></div>
</div>
<script src="/resource/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script>

    $.ajax({
        type: 'POST',
        url: '/driver/find',
        dataType:'json',
        success:function(data){
            if(data.result.msg == undefined){
                console.log(data.result)
                $('.driver_name').html(data.result.driver.driver_name)
                $('.driver_license_number').html(data.result.driver.driver_license_number)
                $('.first_issue_date').html(data.result.driver.first_issue_date)
                $('.allow_car_type').html(data.result.driver.allow_car_type)
                $('.effective_date_end').html(data.result.driver.effective_date_end)
                $('.driver_license_photo').children('img').attr("src",data.result.driver.photo_url);
                $('.car_license_number').html(data.result.travel.car_license_number)
                $('.car_color').html(data.result.travel.car_color)
                $('.car_type').html(data.result.travel.car_type)
                $('.registration_date').html(data.result.travel.registration_date)
                $('.vehicle_owner_name').html(data.result.travel.vehicle_owner_name)
                $('.travel_license_photo').children('img').attr("src",data.result.travel.photo_url);
                var oid = data.result.driver.id;
                agree(oid);
                disagree(oid);
            }else{
                alert(data.result.msg)
            }

        },
        error: function(){
            $('.content_record_p').html("查询失败");
        }
    });
    function agree(oid){
        $('#btn01').click(function (){
            var status=3;
            $.ajax({
                type: 'POST',
                url: '/driver/check',
                data:{"id":oid,"is_enable":status},
                dataType:'json',
                success:function(data){
                    alert(data.result.msg)
                },
                error: function(){
                    alert("查询失败")
                }
            });
        })
    }
    function disagree(oid){
        $('#btn02').click(function (){
            var status=2;
            var val=$('.describe').val();
            console.log(val);
            $.ajax({
                type: 'POST',
                url: '/driver/check',
                data:{"id":oid,"is_enable":status,"reason":val},
                dataType:'json',
                success:function(data){
                    alert(data.result.msg)
                },
                error: function(){
                    alert("查询失败")
                }
            });
        })
    }
</script>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>