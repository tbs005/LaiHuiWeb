<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/9/30
  Time: 11:09
  describtion:后台管理--【拼车信息会】车主流水详情信息
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<script src="/resource/js/jquery.zclip.min.js" type="text/javascript"></script>
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<style>
    .userManage_container {
        width: 902px;
        margin: 30px auto 0;
        min-height: 550px;
    }

    .userManage_container_li_top {
        background-color: #f4f5f9;
    }

    .userManage_span {
        width: 18%;
        display: inline-block;
        text-align: center;
        height: 40px;
        line-height: 40px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        font-size: 14px;
    }

    .user_manage_container_li {
        border-top: 1px dashed #e8e8e8;
        cursor: pointer;
        position: relative;
    }

    .user_manage_container_li:hover {
        background-color: #f7f7f7;

    }

    .user_manage_container_li:hover > .user_list_checklist_del_active {
        display: block;
    }

    .sub_title_bar {
        margin-bottom: 10px;
        margin-top: 20px;
    }

    .page_container {
        padding: 15px 92px;
    }

    /*下拉列表*/
    .user_list_drop_box {
        position: relative;
        float: left;
        margin-right: 30px;
    }

    .user_list_drop_box:hover > .down1 {
        transform: rotate(180deg);
    }

    .user_list_drop_box_ul {
        display: none;
        position: absolute;
        top: 31px;
        border: 1px solid #e8e8e8;
        text-align: center;
        z-index: 1;
        background-color: #fff;
    }

    .user_list_drop_box_span {
        line-height: 30px;
        padding: 0 30px 0 10px;
        text-align: center;
        border: 1px solid #e8e8e8;
        display: inline-block;
        cursor: pointer;
        width: 182px;
    }

    .userManage_container_li_top span {
        width: 17.6%;

    }

    .cat_list_drop_box_li {
        width: 180px;
        line-height: 32px;
        cursor: pointer;
        position: relative;
    }

    .cat_list_drop_box_li:hover {
        background-color: #f4f5f9;
    }

    .select_error_message {
        color: #f5ad4e;
        position: absolute;
        left: 30px;
        display: none;
    }

    .user_list_checklist_del_active {
        background: url("/resource/images/icon_style.png") 0 -3732px no-repeat;
        width: 16px;
        height: 16px;
        vertical-align: middle;

        margin: 10px 10px;
        position: absolute;
        right: 16px;
        top: 2px;
        display: none;
    }

    /*user_list_select_delete_tip*/
    .user_list_select_delete_tip {
        position: absolute;
        top: 37px;
        display: none;
        right: -42px;
        width: 170px;
        height: 110px;
        border: 1px solid #e8e8e8;
        z-index: 1;
        background-color: #fff;
        padding-top: 18px;
        text-align: center;
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

    /*添加线路模版*/
    .change_box {
        display: inline-block;
        overflow: hidden;
        color: #fff;
        border-radius: 5px;
        background-color: #f5ad4e;
        padding: 4px 8px;
        position: relative;
        float: right;
        margin-top: 8px;
        margin-right: 26px;
    }

    .change_delete {
        background-color: #e74c3c;
    }

    .change_find {
        background-color: #1abc9c;
    }

    /*路线样式布局*/
    .line_container {
        width: 100%;
        position: absolute;
        bottom: -15px;
        overflow: hidden;
    }

    .line_slide {
        border-bottom: 3px solid #F5AD4E;
        position: relative;
        width: 108%;
        margin: 0px auto;
        bottom: 4px;
        display: inline-block;
    }

    .line_circle {
        width: 10px;
        height: 10px;
        border: 1px solid #F5AD4E;
        border-radius: 50%;
        position: absolute;
        left: 0;
        right: 0;
        margin: 0 auto;
        bottom: 10px;
        background-color: #fff;
    }

    .publish_route_box_li {
        position: relative;
        display: inline-block;
        line-height: 30px;
    }

    .publish_route_box_li_span {
        padding: 0 10px;
    }

    .publish_yes_tags_box {
        line-height: 38px;
        display: none;
    }

    .publish_no_tags_box {
        line-height: 38px;
        display: none;
    }

    .publish_tags_title {
        color: #00b38a;
    }

    .publish_tags_container {
        display: inline-block;
    }

    .publish_yes_tags_context {
        border: 1px solid #00b38a;
        padding: 2px 8px;
        margin-right: 10px;
        display: inline-block;
        line-height: 22px;
    }

    .publish_no_tags_title {
        color: #e74c3c;
    }

    .publish_no_tags_context {
        border: 1px solid #e74c3c;
        padding: 2px 8px;
        margin-right: 10px;
        display: inline-block;
        line-height: 22px;
    }

    .inline_block {
        display: inline-block;
    }

    .drive_li_top {
        height: 34px;
        line-height: 30px;
    }

    .publish_route_box {
        float: left;
        top: -14px;
        position: relative;
        margin-left: 10px;
        width: 800px;
    }

    .drive_li_container {

        border: 1px solid #e8e8e8;
        margin-bottom: 20px;
    }

    .drive_li_container_top {
        padding: 10px 10px 0 10px;
    }

    .drive_li_container:hover {
        box-shadow: 2px 2px 10px 2px #e8e8e8;;
    }

    .driver_detail_remark {
        line-height: 30px;
    }

    .driver_detail_route {
        padding: 10px 0;
    }

    .driver_time_img {
        width: 16px;
        position: relative;
        top: -2px;
        margin-right: 4px;
    }

    .driver_type_img {
        width: 20px;
        position: relative;
        top: -2px;
        margin-right: 4px;
    }

    .driver_route {
        font-size: 16px;
    }

    .driver_time {
        color: #999;
        margin-left: 20px;
    }

    .driver_type {
        margin-left: 20px;
    }

    .driver_seat {
        margin-left: 20px;
    }

    .drive_could_use {
        float: right;
        right: -14px;
        top: -15px;
        width: 80px;
        position: relative;
    }

    .driver_use_img {
        width: 100%;
    }

    .driver_use_span {
        position: absolute;
        top: 2px;
        right: 16px;
        color: #fff;
    }

    .driver_detail_message {
        line-height: 30px;
    }

    .driver_detail_driver {
        display: inline-block;
        margin-right: 20px;
    }

    .driver_detail_driver {
        display: inline-block;
    }

    .driver_detail_option {
        float: right;
        position: relative;
    }

    .driver_detail_option_edit, .driver_detail_option_delete, .driver_detail_option_QQ, .driver_detail_option_href {
        padding: 2px 8px;
        background-color: #F5AD4E;
        color: #fff;
        border-radius: 5px;
        display: inline-block;
        margin-right: 20px;
        line-height: 24px;
        cursor: pointer;
    }

    .driver_detail_option_href {
        background-color: #3498db;
    }

    .driver_detail_option_href:hover {
        background-color: #2980b9;
    }

    .driver_detail_option_QQ {
        background-color: #2ecc71;
    }

    .driver_detail_option_QQ:hover {
        background-color: #27ae60;
    }

    .driver_detail_option_delete {
        background-color: #e74c3c;
    }

    .driver_detail_option_edit:hover {
        background-color: #FF8F0C;
    }

    .driver_detail_option_delete:hover {
        background-color: #c0392b;
    }

    /*城市下拉框*/
    .publish_list_box {
        float: left;
        margin-right: 30px;
    }

    .publish_slide {
        height: 32px;
        line-height: 32px;
        margin-bottom: 20px;
        font-size: 14px;
        border: 1px solid #e8e8e8;
        width: 140px;
        text-align: center;
        display: inline-block;
        padding-right: 20px;
        position: relative;
        cursor: pointer;
    }

    .publish_slide ul {
        display: none;
        position: absolute;
        background-color: #fff;
        z-index: 1;
        border: 1px solid #e8e8e8;
        width: 140px;
        margin: -2px -1px;
        max-height: 600px;
        overflow: auto;
    }

    .publish_slide_li:hover {
        background-color: #f7f7f7;
    }

    .publish_slide:hover > .down1 {
        transform: rotate(180deg);
    }

    .publish_list {
        display: inline-block;
    }

    .publish_county {
        width: 120px;
    }

    .publish_icon_to {
        width: 18px;
        position: relative;
        top: -4px;
    }

    .slide_container {
        width: 600px;
    }

    .input_list_left {
        float: left;
        width: 60px;
    }

    .input_list_right {
        float: left;
        width: 500px;
    }

    .input_list {
        padding: 6px;
    }

    .submit_select {
        margin-top: 20px;
    }

    .slide_container_mid {
        max-height: 600px;
        overflow: auto;
    }

    .find_route_span {
        display: inline-block;
    }

    .find_route_span span {
        display: inline-block;
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
        float: right;
        line-height: 25px;
        margin-top: 5px
    }

    .driver_detail_publish {
        float: left;
        line-height: 30px;
    }

    .circle {
        width: 4px;
        height: 4px;
        background-color: #999794;
        display: inline-block;
        border-radius: 50%;
        position: relative;
        top: -.15rem;
        margin: 0 .2rem;
    }

    .find_discript_span {
        display: inline-block;
    }

    .driving_car_avatar {
        width: 30px;
        height: 30px;
        /*margin-left: 20px;*/
        border-radius: 50%;
        margin-right: 10px;
        position: relative;
        top: -2px;
    }

    /*乘客信息*/
    .passenger_container {
        border-top: 2px dashed #e8e8e8;
        margin-top: 10px;
        padding: 10px 10px;
        background-color: #f3f3f3;
    }

    .passenger_message_box {
        line-height: 30px;
    }
    .driver_breakout_point{
        margin-left: 30px;
    }
    .driver_price{
        margin-left: 20px;
    }
    .not_manage{
        text-align: center;
        font-size: 16px;
        margin-top: 10px;
        color: #f5ad4e;
    }
    .passenger_container_li{
        padding: 10px;
        margin-bottom: 10px;
        border-bottom: 1px solid #e8e8e8;
    }
    .passenger_container_li:hover{
        border-bottom: 1px solid #f5ad4e;
    }
    .no_border{
        border:none;
        margin-bottom: 0px;
    }
    #container{
        margin: 10px 0;
        color: #f5ad4e;
        cursor: pointer;
        display: inline-block;
    }
    #container img{
        width: 24px;
        position: relative;
        top: -2px;
    }
    .driver_money{
        font-size: 16px;
        float: right;
        margin-right: 30px;
    }
    .pay_for{
        float: right;
        background-color: #f5ad4e;
        color: #fff;
        padding: 8px 20px;
        cursor: pointer;
    }
    .pay_for:hover{
        background-color: #FF8F0c;
    }
    .userManage_container_ul{
        margin-top: 20px;
    }
    .slide_container{
        width: 700px;
        left: 128px;
    }
    .slide_container_top{
        padding: 14px 0;
        margin: 0px;
        border-bottom: 1px solid #e8e8e8;
    }
    .slide_container{
        width: 380px;
    }
    .slide_container_top{
      border-bottom: none ;
    }
    .submit_select_span{
        width: 100%;
        line-height: 50px;
        height: 50px;
        font-size: 16px;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        pageSet.setPageNumber();
        checkId();
        $('.menu_context_li').removeClass('active_li');
        $('.user_list_drop_box').mouseleave(function () {
            $('.user_list_drop_box_ul').hide();
        });
        $('.publish_slide').mouseleave(function () {
            $('.publish_slide ul').hide();
        });
        $('#container').click(function(){
            history.go(-1)
        })
    });

    var global_cat_id;
    var check_click_search = 0;
    var flag = 1;
    var click_type;
    var user_id;
    var action_url = "/app/api/db/departure";
    var url = window.location.href;
    var source = 1;
    var order_id;
    var pay_status;
    //判断是否是修改信息
    function checkId() {
        order_id = url.split('order_id=')[1].split('&end')[0];
        updateMessage(order_id);
    }


    //添加用户数据
    function insertUserMessage() {
        var driving_name = global_data.wx_nickname;//车主姓名
        var driving_id = global_data.id;//车主姓名
        var is_must_departure = global_data.is_must_departure;//车主姓名
        var price = global_data.price;
        var start_time = global_data.start_time;//开始时间
        var end_time = global_data.end_time;//结束时间
        var mobile = global_data.mobile;//手机号
        var departure_city = global_data.departure_city;//出发城市
        var destination_city = global_data.destination_city;//目的城市
        pay_status= global_data.total_pay_object.pay_status;
        if( global_data.points.length ==0){
            var departure = "";//出发小城
            var destination ="";//目的小城市
        }else{
            var departure = global_data.points[0].name + "(" + global_data.points[0].district + ")";//出发小城
            var destination = global_data.points[1].name + "(" + global_data.points[1].district + ")";//目的小城市
        }

        var description = global_data.description;//描述信息
        var inits_seats = global_data.inits_seats;//可用座位
        var publish_time = global_data.create_time;//id
        var total_pay = global_data.total_pay_object.total_pay;//微信头像

        if (is_must_departure != 0) {
            is_must_departure = "诚信必发"
        }
//        if (departure == "") {
//            departure = boarding_point;
//        }
//        if (destination == "") {
//            destination = breakout_point;
//        }
//        if (driver_avatar == "") {
//            driver_avatar = "/resource/images/icon_people.png";
//        }
        var insert_time = start_time.split(":")[0] + ":" + start_time.split(":")[1] + "-" + end_time.substring(11, 16);
        addUserDisplay(driving_id, driving_name, is_must_departure, price, insert_time, mobile, departure_city, destination_city, departure,
                destination, description, inits_seats, publish_time,total_pay);
        if (is_must_departure == 0) {
            $('.drive_could_use').hide();
        }
        if(global_data.orderArray.length ==0){
            $('.passenger_container').append('<p class="not_manage">无乘客流水信息</p>');
        }else{
            for (var i = 0; i < global_data.orderArray.length; i++) {
                var id = global_data.orderArray[i].order_id;//id
                var user_name = global_data.orderArray[i].user_name;//id
                var user_avatar = global_data.orderArray[i].user_avatar;//id
                var boarding_point = global_data.orderArray[i].boarding_point;//上车位置
                var breakout_point = global_data.orderArray[i].breakout_point;//下车位置
                var order_create_time = global_data.orderArray[i].create_time.substring(0, 16);//备注
                var user_mobile = global_data.orderArray[i].user_mobile;//手机号
                var pay_num = global_data.orderArray[i].pay_num;//流水号
                var price = global_data.orderArray[i].price;
                if (user_avatar == "") {
                    user_avatar = "/resource/images/icon_people.png";
                }
                addPassengerDisplay(id, user_name, user_avatar, boarding_point, breakout_point, order_create_time,
                        user_mobile, pay_num,price)
            }


        }



        if (departure == "") {
            $('.begin_city').hide();
        }
        if (destination == "") {
            $('.end_city').hide();
        }
        $($('.passenger_container_li')[$('.passenger_container_li').length-1]).addClass('no_border');

        //进行非空判断

        if (driving_name == "") {
            $('.driver_detail_driver_set').hide();
        }
        if (description == "") {
            $('.driver_detail_remark').hide();
        }
        if(pay_status == 1 ){
            $('.pay_for').css("background-color", "#e8e8e8").text("已转帐");
        }
    }
    //添加车主列表
    function addUserDisplay(driving_id, driving_name, is_must_departure, price, insert_time, mobile, departure_city, destination_city, departure,
                            destination, description, inits_seats, publish_time,total_pay) {
        $(".not_find_message").before('<li class="drive_li_container" index=' + driving_id + ' >' +
                '<div class="drive_li_container_top">' +
                '<div class="drive_li_top">' +
                '<div class="inline_block driver_route">' +
                '<span class="driver_route_span driver_route_start">' + departure_city + '</span>' +
                '<span class="begin_city" style="color:#999794;font-size: 12px;"><i class="circle"></i>' + departure + '</span>' +
                '<span class="driver_route_span" style="color: #F5AD4E;">——</span>' +
                '<span class="driver_route_span driver_route_end">' + destination_city + '</span>' +
                '<span class="end_city" style="color:#999794;font-size: 12px;"><i class="circle"></i>' + destination + '</span>' +
                '</div>' +
                '<div class="inline_block driver_time">' +
                '<img src="/resource/images/pc_icon_time.png" class="driver_time_img">' +
                '<span class="driver_time_span driver_time_year">' + insert_time + '</span>' +
                '</div>' +

                '<div class="inline_block driver_seat">' +
                '<img src="/resource/images/pc_icon_seat.png" class="driver_type_img">' +
                '<span class="driver_type_span driver_type_seat">' + inits_seats + '个座位</span>' +
                '</div>' +
                '<div class="inline_block driver_price">' +
                '<img src="/resource/images/pc_icon_money.png" class="driver_type_img">' +
                '<span class="driver_type_span driver_type_price">' + price + '元</span>' +
                '</div>' +
                '<div class="drive_could_use">' +
                '<img src="/resource/images/pc_icon_tags.png" class="driver_use_img">' +
                '<span class="driver_use_span">' + is_must_departure + '</span>' +
                '</div>' +
                '</div>' +
                '<div class="driver_detail_remark">' +
                '<span>车主备注：</span>' +
                '<span style="color: #999" class="driver_description">' + description + '</span>' +
                '</div>' +

                '<div class="driver_detail_message">' +
                '<div class="driver_detail_driver driver_detail_driver_set">' +
                '<span>车主姓名：</span>' +
                '<span style="color: #999" class="driving_car_name">' + driving_name + '</span>' +
                '</div>' +
                '<div class="driver_detail_driver">' +
                '<span>车主电话：</span>' +
                '<span style="color: #999" class="driving_car_mobile">' + mobile + '</span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '<div class="driver_detail_publish">' +
                '<span>发布时间：</span>' +
                '<span style="color: #999" class="driving_car_publish">' + publish_time + '</span>' +
                '</div>' +
                '<div class="driver_detail_publish driver_money ">' +
                '<span>收入金额：</span>' +
                '<span style="color: #f5ad4e" class="driving_car_money">' + total_pay + '元</span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '</div>' +
                '<div class="clear"></div>' +
                '<div class="passenger_container">' +
                '</div>' +
//                '<div class="count_container">' +
//                '<div class="count_top">' +
//                '</div>' +
//                '</div>' +
                '</li>'
        )
    }
    //添加乘客列表
    function addPassengerDisplay(id, user_name, user_avatar, boarding_point, breakout_point, order_create_time,
                                 user_mobile, pay_num,price) {
        $(".passenger_container").append('<li class="passenger_container_li" index=' + id + '>' +
                '<div class="passenger_container_top">' +
                '<img src=' + user_avatar + ' class="driving_car_avatar"></span>' +
                '<span style="color: #999" class="driving_car_nename">' + user_name + '</span>' +
                '</div>' +
                '<div class="passenger_message">' +
                '<div class="driver_detail_publish">' +
                '<span>上车位置：</span>' +
                '<span style="color: #999" class="driving_car_mobile">' + boarding_point + '</span>' +
                '</div>' +
                '<div class="driver_detail_publish driver_breakout_point">' +
                '<span>下车位置：</span>' +
                '<span style="color: #999" class="driving_car_mobile">' + breakout_point + '</span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '<div class="passenger_message_box">' +
                '<span>预约时间：</span>' +
                '<span style="color: #999" class="driving_car_publish">' + order_create_time + '</span>' +
                '</div>' +
                '<div class="passenger_message_box">' +
                '<span>联系方式：</span>' +
                '<span style="color: #999" class="driving_car_mobile">' + user_mobile + '</span>' +
                '</div>' +
                '<div class="driver_detail_publish">' +
                '<span>支付流水：</span>' +
                '<span style="color: #999" class="driving_car_mobile">' + pay_num + '</span>' +
                '</div>' +
                '<div class="driver_detail_publish driver_breakout_point ">' +
                '<span>支付金额：</span>' +
                '<span style="color: #f5ad4e" class="driving_car_money">' + price + '元</span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '</li>'
        )
    }
    function removeManagerStyle() {
        $('.slide_container').animate({"top": "-220%", "opacity": "0"}, 300);
    }

    //查找信息
    function updateMessage(order_id) {
        var obj = {};
        obj.action = 'show_info';
        obj.order_id = order_id;
        operation.operation_ajax(action_url, obj, insertUserMessage);
    }
    //添加下滑
    function addManagerStyle(){
        //判断取消再次显示情况下数据
        if(pay_status == 1 ){
            $('.pay_for').css("background-color", "#e8e8e8");
        }else{
            $('.slide_container').animate({"top":"42%","opacity":"1"},300);
        }


    }
    //确认已经转账
    function checkMessage(){

        var obj = {};
        obj.action = 'withdraw_cash_complete';
        obj.order_id = order_id;
        operation.operation_ajax('/api/db/pay/orders', obj, window.location.href="/db/pay/d_orders");
    }
</script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>车单流水详情</span>
            </div>
        </div>
        <div class="userManage_container">
            <div id="container">
                <img src="/resource/images/pc_return_before.png">
                <span>返回上一层</span>
            </div>
            <div class="pay_for" onclick="addManagerStyle()">
                转账确认
            </div>
            <div class="clear"></div>
            <ul class="userManage_container_ul">

                <div class="not_find_message">
                    <img src="/resource/images/eat.gif" alt="">
                    <span>您所查询的信息被我吃光光了~~</span>
                </div>
                <div class="clear"></div>
            </ul>
        </div>
        <%--添加版面--%>
        <div class="slide_container">
            <div class="slide_container_top">
                <div class="slide_container_top">

                    <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
                </div>
            </div>
            <div class="slide_container_mid">
                <div class="submit_select">
                    <span class="submit_select_span main_color submit_select_sure" onclick="checkMessage()">确认已给车主转账</span>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
