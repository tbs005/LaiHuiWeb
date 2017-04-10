<%--
  Created by IntelliJ IDEA.
  User: zhu
  Date: 2016/7/25
  Time: 15:06
  describtion:移动端--车主审核页面
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
    <title>车主审核</title>
    <script src="/resource/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="/resource/js/style.js" type="text/javascript"></script>
    <link href="/resource/css/style.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        .check_top {
            background-color: #fff;
            font-size: 2rem;
            text-align: center;
            line-height: 3.2rem;
            margin-bottom: 1.2rem;
        }

        .check_mid {
            font-size: 1.4rem;
            background-color: #fff;
            line-height: 2.4rem;
            margin-bottom: .8rem;
            padding-bottom: 1.2rem;
        }

        .check_mid_pic {
            background-color: #fff;
            font-size: 1.4rem;
            margin-bottom: 7rem;
        }

        .check_car_type {
            border-bottom: 1px solid #e8e8e8;
            line-height: 3.2rem;
            margin-bottom: .8rem;
            padding-left: 1rem;
        }

        .left {
            float: left;
            width: 50%;
            text-align: center;
            margin-bottom: .8rem;
        }

        .check_img {
            width: 70%;
            cursor: pointer;
        }

        .check_mid .check_car_title {
            padding-left: 2rem;
        }

        .check_bottom_pic {
            background-color: #fff;
            text-align: center;
            /*position: fixed;*/
            bottom: 0;
            width: 100%;
            height: 6rem;
            line-height: 6rem;
        }

        .pass_fail {
            background-color: #f5ad4e;
            border: none;
            color: #fff;
            border-radius: 5px;
            width: 10rem;
            line-height: 3.2rem;
            font-size: 1.6rem;
            display: inline-block;
        }

        .pass_success {
            background-color: #f5ad4e;
            border: none;
            color: #fff;
            border-radius: 5px;
            width: 10rem;
            line-height: 3.2rem;
            font-size: 1.6rem;
        }

        .check_bottom_pic_left {
            width: 50%;
            float: left;
            text-align: center;
        }

        .left_icon {
            width: 20px;
            width: 2rem;
            position: relative;
        }

        .check_tips {
            text-align: center;
            margin-top: 3rem;
        }

        .check_tips_span {
            display: block;
            font-size: 3rem;
            margin-top: 2rem;
        }

        .error_tips {
            position: fixed;
            top: -150%;
            width: 100%;
        }

        .error_tips_ul {
            border: 1px solid #e8e8e8;
            width: 20rem;
            margin: 0 auto;
            background-color: #fff;
            padding: 1rem;
            font-size: 1.4rem;
            position: relative;
        }

        .error_tips_title {
            display: inline-block;
            color: #F5AD4E;
            margin-bottom: .8rem;
        }

        .error_tips_li {
            line-height: 3rem;
            color: #52514F;
            cursor: pointer;
        }
        .error_tips_li:hover{
            background-color: #e8e8e8;
        }
        .error_tips_sure {
            float: right;
            padding: .4rem 1.8rem;
            background-color: #F5AD4E;
            color: #fff;
            border-radius: 5px;
            margin-top: .8rem;
            cursor: pointer;
        }

        .error_close {
            position: absolute;
            right: -.8rem;
            top: -.8rem;
            width: 2rem;
            background-color: #999;
            border-radius: 50%;
            color: #fff;
            height: 2rem;
            text-align: center;
            line-height: 2rem;
        }

        .error_tips_message {
            font-size: 1.4rem;
            margin-top: 2rem;
        }

        .error_tips_li {
            padding-right: 2.8rem;
            position: relative;
            padding-left: .4rem;
        }

        .error_tips_li img {
            width: 2rem;
            position: absolute;
            top: .5rem;
            right: .4rem;
        }

        .select_img {
            display: none;
        }


        .error_tips_message_title {
            margin-bottom: .4rem;
            font-size: 1.6rem;
        }
        .check_car_title_span{
            text-align: right;
            display: inline-block;
            width: 9.2rem;
        }
        .check_car_title_left_span{
            display: block;
            margin-bottom: 1rem;
        }
        .cancel{
            cursor: pointer;
        }
    </style>
    <script>
        $(document).ready(function () {
            var browser={
                versions:function(){
                    var u = navigator.userAgent, app = navigator.appVersion;
                    return {//移动终端浏览器版本信息
                        trident: u.indexOf('Trident') > -1, //IE内核
                        presto: u.indexOf('Presto') > -1, //opera内核
                        webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                        gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
                        mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
                        ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                        android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
                        iPhone: u.indexOf('iPhone') > -1 , //是否为iPhone或者QQHD浏览器
                        iPad: u.indexOf('iPad') > -1, //是否iPad
                        webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
                    };
                }(),
                language:(navigator.browserLanguage || navigator.language).toLowerCase()
            }

            if(browser.versions.mobile || browser.versions.ios || browser.versions.android ||
                    browser.versions.iPhone || browser.versions.iPad){
                mobileStyle();

            }else{
                console.log("pc");
                $('html').css('font-size','62.5%');
                $('body').css('background-color','#fff');
            }
            loadMessage();
            $('.error_close').click(function () {
                $('.error_tips').animate({
                    top: "-150%"
                }, 300);
            })
        });
        var global_data;
        var array = {};
        var array_reason = [];
        var status;
        var url = window.location.href;
        var token = url.substr(url.indexOf("=") + 1);

        //控制移动端样式
        function mobileStyle(){
//            token = "7f5bfcb450e7425a144f3e20aa1d1a6e";
            changeFontSize();
            $('.left_icon').css({'top':'.5rem'});
            $('.check_bottom_pic').css({'position':'fixed'})
        }
        function loadMessage() {
            array.action = 'driver';
            array.token = token;
            sendMessage('/auth/info', array, innerMessage);
        }

        function innerMessage() {
            var status = global_data.result.status;
            if (status == 2) {
                var owner = global_data.result.owner;
                var reg_date = global_data.result.reg_date;
                var pic1 = global_data.result.pic1;
                var color = global_data.result.color;
                var idsn = global_data.result.idsn;
                var name = global_data.result.name;
                var type = global_data.result.type;
                var pic2 = global_data.result.pic2;
                var car_id = global_data.result.car_id;
                var brand = global_data.result.brand;
                $('.pc_name').text(name);
                $('.pc_idsn').text(idsn);
                $('.pc_car_id').text(car_id);
                $('.pc_owner').text(owner);
                $('.pc_brand').text(brand);
                $('.pc_type').text(type);
                $('.pc_color').text(color);
                $('.reg_date').text(reg_date);
                $('.pc_1').attr('src', pic1);
                $('.pc_2').attr('src', pic2);
            } else if(status ==1) {
                window.location.href = "/auth/validate/info?id="+token;
            }else{
                window.location.href = "/auth/validate/info?id="+token;
            }

        }
        function showMessage() {
            if (status == 2) {
                $('.check_top').hide();
                $('.check_message').hide();
                $('.error_tips').hide();
                $('.check_tips').show();
            } else {
                $('.check_top').hide();
                $('.check_message').hide();
                $('.error_tips').hide();
                $('.check_tips').show().children('img').attr('src', '/resource/images/pc_icon_error.png');
                $('.check_tips_span').text('已拒绝');
                $('.error_tips_message').show();
                for (var i = 0; i < array_reason.length; i++) {
                    $('.error_tips_message_title').after('<p class="error_tips_message_p">' + array_reason[i] + '</p>')
                }
            }

        }
        function showErrorTips() {
            $('.error_tips').animate({
                top: "30%"
            }, 300);
        }
        function toError() {
            status = -1;
            for (var i = 0; i < $('.active_select').length; i++) {
                array_reason.push($($('.active_select')[i]).children('span').text());
            }
            var reson = JSON.stringify(array_reason);
            passMessage(status, reson);
        }
        function toSuccess() {
            status = 2;
            var reason = "";
            passMessage(status, reason)
        }
        function passMessage(status, reason) {
            array.action = 'check';
            array.token = token;
            array.status = status;
            array.reason = reason;
            sendMessage('/api/auth/validate', array, showMessage);
        }

        function sendMessage(url, data_obj, callback) {
            $.ajax({
                type: "POST",
                url: url,
                data: data_obj,
                dataType: "json",
                beforeSend: loading(),
                success: function (data) {
                    closeLoading();
                    global_data = data;
                    if (global_data.status == true) {
                        console.log("交互成功");
                        callback();
                    } else {
                        validate.showTips("身份证格式不正确");
                    }
                },
                error: function () {
                    console.log("交互失败");
                }
            })
        }

        function select(obj) {
            if ($(obj).hasClass('active_select')) {
                $(obj).removeClass('active_select').children('.select_img').hide();
            } else {
                $(obj).addClass('active_select').children('.select_img').show();
            }

        }
    </script>
</head>
<body>
<div class="hover"></div>
<div class="cancel" onclick="changeImg.cancelBigImg()">x</div>
<div class="image_tips">
    <img src="">
</div>
<div class="check_container">
    <div class="check_top">
        <span>车主审核</span>
    </div>
    <div class="check_message">
        <div class="check_mid">
            <div class="check_car_message">
                <div class="check_car_type">
                    <img src="/resource/images/pc_icon_check_car.png" class="left_icon">
                    <span>车主基本信息</span>
                </div>
                <div class="check_car_title">
                    <span class="check_car_title_span">姓&#12288;&#12288;&#12288;名：</span>
                    <span class="pc_name"></span>
                </div>
                <div class="check_car_title">
                    <span class="check_car_title_span">驾&nbsp;驶&nbsp;证&nbsp;号：</span>
                    <span class="pc_idsn"></span>
                </div>
                <div class="check_car_title">
                    <span class="check_car_title_span">车&nbsp;&nbsp;&nbsp;牌&nbsp;&nbsp;&nbsp;号：</span>
                    <span class="pc_car_id"></span>
                </div>
                <div class="check_car_title">
                    <span class="check_car_title_span">车&nbsp;辆&nbsp;所&nbsp;属：</span>
                    <span class="pc_owner"></span>
                </div>
                <div class="check_car_title">
                    <span class="check_car_title_span">车&nbsp;辆&nbsp;品&nbsp;牌：</span>
                    <span class="pc_brand"></span>
                    <span class="pc_type"></span>
                    <span class="pc_color"></span>
                </div>
                <div class="check_car_title">
                    <span class="check_car_title_span">注&nbsp;册&nbsp;日&nbsp;期：</span>
                    <span class="reg_date">2016-7-1</span>
                </div>

                <div class="clear"></div>
            </div>
        </div>
        <div class="check_mid_pic">
            <div class="check_car_type">
                <img src="/resource/images/pc_icon_check_pic.png" class="left_icon">
                <span>证件图片</span>
            </div>
            <div class="check_car_title left">
                <span class="check_car_title_left_span">驾驶证照片</span>
                <img class="check_img pc_1" src="/resource/images/noimage.gif" onclick="changeImg.showBigImg(this)">
            </div>
            <div class="check_car_title left">
                <span class="check_car_title_left_span">行驶证照片</span>
                <img class="check_img pc_2" src="/resource/images/noimage.gif" onclick="changeImg.showBigImg(this)">
            </div>
            <div class="clear"></div>
        </div>
        <div class="check_bottom_pic">
            <div class="check_bottom_pic_left">
                <%--<input type="button" value="拒绝" class="pass_fail main_color" onclick="showErrorTips()">--%>
                <span class="pass_fail main_color" onclick="showErrorTips()">拒绝</span>
            </div>
            <div class="check_bottom_pic_left">
                <span class="pass_fail main_color" onclick="toSuccess()">通过审核</span>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="error_tips">
        <ul class="error_tips_ul">
            <span class="error_close">X</span>
            <span class="error_tips_title">选择拒绝的理由</span>
            <li class="error_tips_li" onclick="select(this)">
                <span>证件照片与本人信息不符</span>
                <img src="/resource/images/pc_icon_select.png" class="select_img "/>
            </li>
            <li class="error_tips_li" onclick="select(this)">
                <span>驾驶证使用期限已过</span>
                <img src="/resource/images/pc_icon_select.png" class="select_img "/>
            </li>
            <li class="error_tips_li" onclick="select(this)">
                <span>车辆信息不符合要求</span>
                <img src="/resource/images/pc_icon_select.png" class="select_img "/>
            </li>
            <li class="error_tips_li" onclick="select(this)">
                <span>其他</span>
                <img src="/resource/images/pc_icon_select.png" class="select_img "/>
            </li>
            <span class="error_tips_sure main_color" onclick="toError()">确定</span>

            <div class="clear"></div>
        </ul>
    </div>
    <div class="check_tips" style="display: none">
        <img src="/resource/images/pc_icon_success.png">
        <span class="check_tips_span">审核通过</span>

        <div class="error_tips_message" style="display: none">
            <p class="error_tips_message_title">拒绝理由</p>

        </div>
    </div>
</div>
</body>
</html>
