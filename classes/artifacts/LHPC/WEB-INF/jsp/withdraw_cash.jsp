<%--
  Created by IntelliJ IDEA.
  User: zhu
  Date: 2016/10/13
  Time: 9:30
  describtion:移动管理--【提现】app左侧提现界面
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>提现</title>
    <script src="/resource/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="/resource/js/style.js" type="text/javascript"></script>
    <link href="/resource/css/style.css" rel="stylesheet" type="text/css">

    <style type="text/css">
        /*返回上一层*/
        .publish_top {
            background-color: #F5AD4E;
            text-align: center;
            line-height: 4.2rem;
            font-size: 1.4rem;
            padding: 0 1rem;
            color: #fff;
        }

        .publish_top_right {
            float: right;
            /* font-size: 1.4rem; */
            color: #999794;
            /* line-height: 3.2rem; */
            width: 1.8rem;
            position: relative;
            top: 1rem;
        }

        .return_perv {
            float: left;
        }

        .return_perv_img {
            width: 1.4rem;
            /* line-height: 9.8rem; */
            display: inline-block;
            top: 0.2rem;
            position: relative;
        }

        /*end*/
        .cash_pay_message {
            background-color: #fff;
            margin-bottom: 1rem;
        }

        .cash_error_img {
            float: left;
            width: 4rem;
        }

        .cash_tips_box {
            float: left;
            padding-left: 1rem;
        }

        .cash_tips_text {
            font-size: 2rem;
            /* padding-bottom: .4rem; */
            /* padding-left: 1rem; */
            display: inline-block;
            /* background: #F5AD4E; */
            color: #f5ad4e;
            /* padding: .4rem 1rem; */
            border-radius: 5px;
            /* text-decoration: underline; */
            margin-bottom: 0.5rem;
        }

        .cash_bottom_tips {
            font-size: 1.2rem;
            color: #999;
        }

        .cash_error_box {
            padding: 2rem 1rem;
        }

        /*支付宝信息*/
        .cash_message_top {
            background: #f5ad4e;
            padding: 1.2rem 1rem;
        }

        .cash_all_count {
            color: #fff;
            float: left;
            width: 44%;
            padding-left: 5%;
            font-size: 2rem;
        }

        .cash_all_count_title {
            color: #F5F2F2;
            margin-bottom: .8rem;
            font-size: 1.4rem;
        }

        .cash_pay_self_message {
            padding: .8rem 2rem;
        }

        .cash_pay_logo {
            float: left;
            width: 3rem;
            position: relative;
            top: .4rem;
        }

        .cash_self_message {
            float: left;
            padding: 1rem
        }

        .cash_self_message img {
            width: 1.5rem;
            position: relative;
            top: .1rem;
            left: .2rem;
        }

        .departure_li_status {
            position: absolute;
            top: 1.2rem;
            right: 1.5rem;
            /* background-color: #f5ad4e; */
            padding: .2rem .4rem;
            color: #f5ad4e;
            border-radius: 3px;
        }

        .circle {
            width: 6px;
            height: 6px;
            background-color: #999794;
            display: inline-block;
            border-radius: 50%;
            position: relative;
            top: -.15rem;
            margin: 0 .2rem;
        }

        .circle_more {
            width: 6px;
            height: 6px;
            background-color: #b3b3b3;
            display: inline-block;
            border-radius: 50%;
            position: relative;
            top: -.15rem;
            margin: 0 .2rem;
        }

        .circle_hide_top_left {
            width: 2rem;
            height: 2rem;
            background-color: #F2EFEB;
            display: inline-block;
            border-radius: 50%;
            margin: 0 .2rem;
            position: absolute;
            top: -1rem;
            left: -2em;
        }

        .begin_city, .end_city {
            font-size: 1.2rem;
        }

        .departure_li_city {
            font-size: 1.4rem;
            line-height: 3rem;
            position: relative;
            padding-right: 5.4rem;
        }

        .cash_departure_li {
            position: relative;
            margin-bottom: 1.5rem;
            padding: .8rem 1rem;
            border-left: 4px solid #f5ad4e;
            /* border-top: 1px solid #e8e8e8; */
            /* border-bottom: 1px solid #e8e8e8; */
            background: #fff;
        }
        .loading{
             width: 3rem;
         }

        .cash_departure_style {
            line-height: 3rem;
        }

        .cash_style_left {
            float: left;
            margin-right: 2rem;
        }

        .cash_style_left img {
            width: 1.4rem;
            position: relative;
            top: .2rem;
        }

        .cash_style_left_money {
            color: #f5ad4e;
        }

        .cash_style_left_time {
            color: #888;
        }

        .cash_departure_li_bottom {
            line-height: 3rem;
        }

        .cash_departure_img_box {
            display: inline-block;
        }

        /*.cash_departure_img_box img{*/
        /*width: 2rem;*/
        /*border-radius: 50%;*/
        /*border: 1px solid #fff;*/
        /*position: relative;*/
        /*top: .7rem;*/
        /*margin: 0 0.2rem;*/
        /*}*/
        .cash_detail {
            float: right;
            color: #E2E2E2;
            line-height: 1rem;
            margin-top: .2rem;
        }

        /*.cash_departure_container{*/
        /*background-color: #fff;*/
        /*padding: .8rem 0;*/
        /*}*/
        .finish_cash {
            border-left: 4px solid #2ecc71;
        }

        .finish_cash .departure_li_status {
            color: #999;

        }

        .cash_departure_container_title {
            padding-left: .4rem;
            line-height: 3rem;
            color: #777;
        }

        .cash_order_li {
            line-height: 2.4rem;
            position: relative;
            border-top: 1px dashed #e8e8e8;
            padding: .4rem 0
        }

        .cash_order_li_city {
            color: #999794;
        }

        .cash_order_li_money {
            float: right;
        }

        .cash_order_li_span {
            color: #52514f;
            display: inline-block;
            max-width: 77%;
            padding-left: .5rem;
        }

        .cash_order_li_title {
            float: left;
        }

        /*.last_li .circle_hide_bottom_left{*/
        /*display: none;*/
        /*}*/
        .done {
            display: none;
        }

        .image_up {
            width: 1.6rem;
            position: relative;
            top: .4rem;
            margin-right: .4rem;
        }
        /*账户填写*/
        .booking_span {
            display: inline-block;
            background-color: #f5ad4e;
            color: #fff;
            border-radius: 5px;
            padding: 0 2rem;
            cursor: pointer;
        }

        .booking_span:hover {
            background-color: #FF8F0c;
        }

        .close_booking {
            position: absolute;
            right: 1rem;
            top: 0;
            font-size: 24px;
            color: #999;
            cursor: pointer;
            -webkit-tap-highlight-color:transparent;
        }
        .close_booking:hover{
            background-color: #fff;
        }

        .booking_top {
            text-align: center;
            margin-top: 1.2rem;
            margin-bottom: 1.6rem;
            position: relative;
        }

        .booking_container {
            margin: 1rem 0;
            position: relative;
            overflow: hidden;
        }

        .input_style {
            border: none;
            padding: 0 .6rem;
            border-bottom: 1px solid #f5ad4e;
            width: 100%;
            font-size: 1.5rem;
            line-height: 3.2rem;
        }

        .booking_bottom {
            text-align: center;
            color: #fff;
            background-color: #f5ad4e;
            border-radius: 5px;
            line-height: 3.2rem;
            cursor: pointer;
        }

        .booking_bottom:hover {
            background-color: #FF8F0c;
        }

        .booking_li {
            margin-bottom: .8rem;
            position: relative;
        }

        .booking_box {
            font-size: 1.5rem;
        }

        .booking_error {
            position: absolute;
            top: 4.4rem;
            font-size: 1.3rem;
            color: #e74c3c;
            left: 2rem;
        }
        .change_pay_message{
            float: right;
            padding: 1rem .8rem;
            color: #f5ad4e;
        }
        .not_message{
            color: #888;
            text-align: center;
            margin-top: 5rem;
            font-size: 2rem;
            display: none;
        }
    </style>
    <script>
        $(document).ready(function () {
            changeFontSize();

            android_get_token();
            $('.cash_error_box').click(function(){
                showFloatStyle2();
                $('.float_container2').empty().append('<div class="booking_box">' +
                        '<div class="close_booking" onclick="removeFloatMessage()">x</div>' +
                        '<p class="booking_top">填写转账账户，方便平台给您提现</p>' +
                        '<span class="booking_error"></span>' +
                        '<div class="booking_container">' +
                        '<div class="booking_li">' +
                        '<input placeholder="请输入转账账户" type="text" index="0" class="input_style pay_user" oninput="sendKeepDownInput(this)">' +
                        '</div>' +
                        '</div>' +
                        '<div class="booking_bottom" onclick="checkInput()">确认</div>' +
                        '</div>');
            })
        });
        var action_url = "/app/api/pay/orders";
        var change = 0;
        var token= "";

        function android_get_token()
        {

            try
            {
                var local_token=androidInterface.getToken();
                token = local_token;
                loadUser();
                loadCash();
            }
            catch(err)
            {
                console.log(err)
                $('.cash_success_box').hide();
                $('.cash_error_box').show();
                $('.not_message').show();
            }

        }
        //封装传输的信息并提交
        function loadUser() {
            $('.cash_success_box').show();
            $('.cash_error_box').hide();
            var obj = {};
            obj.action = 'check_account';
            obj.token=token;
            validate.validate_submit3(action_url, obj, insertMessage);
        }

        //载入提现订单信息
        function loadCash() {
            var obj = {};
            obj.action = 'show_my_pay_orders';
            obj.token=token;
            validate.validate_submit3(action_url, obj, insertOrderList);
        }
        //展示错误信息
        function sendKeepDownInput(){
            $('.booking_error').hide();
        }
        function insertMessage() {
            var has_account = global_data.result.has_account;
            if(has_account==true){
                var total_pay = global_data.result.total_pay;
                var pay_account = global_data.result.pay_account;
                var already_pay = global_data.result.already_pay;
                $('.all_count').text(total_pay);
                $('.ready_count').text(already_pay);
                $('.cash_user').text(pay_account);
            }else{
                $('.cash_success_box').hide();
                $('.cash_error_box').show();
            }


        }
        //载入订单列表
        function insertOrderList() {
            if(global_data.result.data.length == 0){
                $('.not_message').show();
            }else{
                for (var i = 0; i < global_data.result.data.length; i++) {
                    var status = global_data.result.data[i].total_pay_object.pay_status;
                    var departure_city = global_data.result.data[i].departure_city;
                    var destination_city = global_data.result.data[i].destination_city;
                    var id = global_data.result.data[i].id;
                    var price = global_data.result.data[i].price;
                    var start_time = global_data.result.data[i].start_time;
                    var end_time = global_data.result.data[i].end_time;
                    var order_length  = global_data.result.data[i].orderArray.length;
                    var total_pay  = global_data.result.data[i].total_pay_object.total_pay;
                    var insert_time = start_time.substring(0, 10);
                    var time_change = insert_time.split('-');
                    insert_time = time_change[1] + '月' + time_change[2] + '日';
                    var begin_start_time = start_time.substring(11, 16);
                    var begin_end_time = end_time.substring(11, 16);
                    insertOrderListStyle(id,total_pay,status,departure_city,destination_city,price,order_length,insert_time,begin_start_time,begin_end_time);

                    for(var j= 0;j<order_length;j++){
                        var boarding_point  = global_data.result.data[i].orderArray[j].boarding_point;
                        var breakout_point  = global_data.result.data[i].orderArray[j].breakout_point;
                        var order_price  = global_data.result.data[i].orderArray[j].price;
                        var user_mobile  = global_data.result.data[i].orderArray[j].user_mobile;
                        var order_id  = global_data.result.data[i].orderArray[j].order_id;
                        insertOrderListStyle2(i,boarding_point,breakout_point,order_price,user_mobile,order_id);
                    }

                }
            }
        }
        //载入订单列表样式
        function insertOrderListStyle(id,total_pay,status,departure_city,destination_city,price,order_length,insert_time,begin_start_time,begin_end_time) {
           var style_class;
            if (status == 0) {
                style_class = "";
                status="待提现：";
            } else {
                style_class = "finish_cash";
                status="已完成";
            }
            $('.cash_departure_ul').append('<li class="cash_departure_li '+style_class+'" id='+id+'>' +
                    '<div class="cash_departure_li_top">' +
                    '<span class="departure_li_status">' + status + total_pay+'元</span>' +
                    '<div class="departure_li_city">' +
                    '<span>' + departure_city + ' </span>' +
                    '<span>——</span>' +
                    '<span>'+destination_city+'</span>' +
                    '</div>' +
                    '</div>' +
                    '<div class="cash_departure_style">' +
                    '<div class="cash_style_left">' +
                    '<img src="/resource/images/pc_cash_money.png">' +
                    '<span>  60元</span>' +
                    '</div>' +
                    '<div class="cash_style_left">' +
                    '<img src="/resource/images/pc_icon_thin_time.png">' +
                    '<span class="departure_time_mouth">  ' + insert_time + ' </span>' +
                    '<span style="color: #999794"> ' + begin_start_time + '-' + begin_end_time + '</span>' +
                    '</div>' +
                    '<div class="clear"></div>' +
                    '</div>' +
                    '<div class="cash_departure_li_bottom">' +
                    '<span>订单个数：</span>' +
                    '<div class="cash_departure_img_box">'+order_length+'个' +
                    '</div>' +
                    '<div class="cash_detail" onclick="showOrderList(this)">' +
                    '<img src="/resource/images/pc_icon_cash_more.png">' +
                    '</div>' +
                    '</div>' +

                    '<ul class="cash_order done">' +

                    '</ul>' +
                    '</li>')
        }

        function insertOrderListStyle2(i,boarding_point,breakout_point,order_price,user_mobile,order_id){
            $($('.cash_order')[i]).append('<li class="cash_order_li" order_id='+order_id+'>' +
            '<i class="circle_hide_top_left"></i>' +
            '<div class="cash_order_li_city">' +
            '<span class="cash_order_li_title">上车地点</span>' +
            '<span class="cash_order_li_span">'+boarding_point+'</span>' +
            '<div class="clear"></div>' +
            '</div>' +
            '<div class="cash_order_li_city">' +
            '<span class="cash_order_li_title">下车地点</span>' +
            '<span class="cash_order_li_span">'+breakout_point+'</span>' +
            '<div class="clear"></div>' +
            '</div>' +
            '<div class="cash_order_li_city">' +
            '<span class="cash_order_li_title">联系方式</span>' +
            '<span class="cash_order_li_span">'+user_mobile+'</span>' +
            '<div class="cash_order_li_money" style="color: #f5ad4e;">支付金额  ' +
            '<span>'+order_price+'元</span>' +
            '</div>' +
            '<div class="clear"></div>' +
            '</div>' +
            '</li>')
        }

        //展示订单列表
        function showOrderList(obj) {
            $(obj).parent().parent().children('.cash_order').toggle();
            if($(obj).children('img').attr('src')=='/resource/images/pc_icon_cash_more.png'){
                $(obj).children('img').addClass('image_up').prop('src','/resource/images/pc_icon_cash_up.png');
            }else{
                $(obj).children('img').removeClass('image_up').prop('src','/resource/images/pc_icon_cash_more.png');
            }
        }

        function checkInput(){
            if($('.pay_user').val()==""){
                $('.booking_error').show().text('帐号不能为空')
            }else{
                var obj = {};

                if(change == 1){
                    obj.action = 'update_account';
                }else{
                    obj.action = 'add_account';

                }
                obj.account = $('.pay_user').val();
                obj.token=token;
                validate.validate_submit_app(action_url, obj, loadUser);
                removeFloatMessage();
            }
        }
        //修改帐号信息
        function changePayMessage(){
            change=1;
            showFloatStyle2();
            $('.float_container2').empty().append('<div class="booking_box">' +
                    '<div class="close_booking" onclick="removeFloatMessage()">x</div>' +
                    '<p class="booking_top">填写修改转账账户的帐号</p>' +
                    '<span class="booking_error"></span>' +
                    '<div class="booking_container">' +
                    '<div class="booking_li">' +
                    '<input placeholder="请输入转账账户" type="text" index="0" class="input_style pay_user" oninput="sendKeepDownInput(this)">' +
                    '</div>' +
                    '</div>' +
                    '<div class="booking_bottom" onclick="checkInput()">确认</div>' +
                    '</div>');
        }
    </script>
</head>
<body>
<div class="hover_all"></div>
<div class="loading_box">
    <img class="loading" src="/resource/images/loading.gif" alt="请等待">
</div>
<div class="hover"></div>
<div class="float_container">
</div>
<div class="float_container2">
</div>
<div class="cash_container">
    <div class="cash_pay_message">
        <div class="cash_error_box" style="display: none">
            <img src="/resource/images/pc_icon_tan.png" class="cash_error_img">

            <div class="cash_tips_box">
                <div class="cash_tips_text">
                    <span>请完善账户信息</span>
                </div>
                <div class="cash_bottom_tips">完善账户信息方便进行提现转账操作</div>
            </div>
            <div class="clear"></div>

        </div>
        <div class="cash_success_box" style="display: block">
            <div class="cash_message_box">
                <div class="cash_message_top">
                    <div class="cash_all_count">
                        <div class="cash_all_count_title">总金额(元)</div>
                        <span class="all_count">0</span>
                    </div>
                    <div class="cash_all_count">
                        <div class="cash_all_count_title">已提现金额(元)</div>
                        <span class="ready_count">0</span>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="cash_pay_self_message">
                    <img src="/resource/images/pc_pay_style.png" class="cash_pay_logo">

                    <div class="cash_self_message">
                        <span style="color: #777">账户信息：</span>
                        <span class="cash_user"></span>
                        <img src="/resource/images/pc_icon_cash_user.png">

                    </div>
                    <div class="change_pay_message" onclick="changePayMessage()">修改</div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="cash_departure_container">
        <div class="cash_departure_container_title">提现记录</div>
        <ul class="cash_departure_ul">
            <div class="not_message">
                暂无订单数据
            </div>
        </ul>
    </div>
</div>
</body>
</html>

