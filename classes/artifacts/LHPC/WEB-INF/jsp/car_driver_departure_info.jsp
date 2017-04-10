<%--
  Created by IntelliJ IDEA.
  User: zhu
  Date: 2016/7/25
  Time: 15:06
  describtion:运维移动端--车主发布信息详情页面（已作废）
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
    <title>拼车信息</title>
    <script src="/resource/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="/resource/js/style.js" type="text/javascript"></script>
    <link href="/resource/css/style.css" rel="stylesheet" type="text/css">
    <script src="/resource/js/LCalendar.js" type="text/javascript"></script>
    <link href="/resource/css/LCalendar.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        .publish_top {
            background-color: #F5AD4E;
            text-align: center;
            line-height: 4.2rem;
            font-size: 1.4rem;
            border-bottom: 1px solid #e8e8e8;
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

        .publish_message_driver {
            font-size: 1.4rem;
            background-color: #fff;
            line-height: 2.4rem;
            padding: 1rem 1.4rem;
        }

        .publish_message {
            font-size: 1.4rem;
            background-color: #fff;
            line-height: 2.4rem;
            margin: .8rem 0;
            padding: 1rem 0 1rem 1.4rem;
        }

        .publish_bottom {
            position: fixed;
            height: 4rem;
            line-height: 4rem;
            background-color: #f5ad4e;
            color: #fff;
            bottom: 0;
            width: 100%;
            text-align: center;
        }

        .publish_message_driver_title {
            font-size: 1.4rem;
        }

        .publish_message_driver_title img {
            width: 1.4rem;
            position: relative;
            top: .3rem;
        }

        .publish_message_driver_time_img {
            width: 1.4rem;
            position: relative;
            top: .3rem;
        }

        .publish_message_driver_time {
            color: #555;
        }

        .publish_seat {
            float: right;
            color: #F5AD4E;
        }

        .publish_message_li_left {
            float: left;
            color: #999;
            margin-right: 1rem;
        }

        .publish_message_li_right {
            float: left;
            max-width: 84%;
        }

        .publish_message_li {
            border-bottom: 1px solid #e8e8e8;
            padding: .8rem 0;
            position: relative;
        }

        .li_last {
            border: none;
        }

        .mobile {
            width: 2rem;
            float: right;
            position: absolute;
            top: 1rem;
            right: 2rem;
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

        /*路线布局结束*/

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
        .item_yes_tips{
            color: #00b38a;
        }
        .item_no_tips{
            color: #e74c3c;
        }
        .call_driver{
            color: #fff;
        }
    </style>
    <script>
        $(document).ready(function () {
            changeFontSize();
            checkId()
        });

        //更新信息
        function updateMessage(item_id) {
            var obj = {};
            obj.action = 'show';
            obj.id = item_id;
            validate.validate_submit('/api/db/departure', obj, insertMessage);
        }
        //添加用户数据
        function insertMessage() {
            if(global_data.result.total == 0){
                window.location.href="/404"
            }else{
                for (var i = 0; i < global_data.result.data.length; i++) {
                    var driving_name = global_data.result.data[i].driving_name;//车主姓名
                    var info_status = global_data.result.data[i].info_status;//状态信息1：有空位；2：已满；-1：已取消
                    var start_time = global_data.result.data[i].start_time;//开始时间
                    var end_time = global_data.result.data[i].end_time;//结束时间
                    var mobile = global_data.result.data[i].mobile;//手机号
                    var departure_city = global_data.result.data[i].departure_city;//出发城市
                    var destination_city = global_data.result.data[i].destination_city;//目的城市
                    var departure = global_data.result.data[i].departure;//出发小城
                    var destination = global_data.result.data[i].destination;//目的小城市
                    var description = global_data.result.data[i].description;//描述信息
                    var tag_yes_content = global_data.result.data[i].tag_yes_content;//yes标签
                    var tag_no_content = global_data.result.data[i].tag_no_content;//no标签
                    var points = global_data.result.data[i].points;//地点
                    var inits_seats = global_data.result.data[i].inits_seats;//可用座位
                    var car_brand = global_data.result.data[i].car_brand;//车辆品牌
                    var id = global_data.result.data[i].id;//id
                    var create_time = global_data.result.data[i].create_time;//id
                    if (info_status == 1) {
                        info_status = "有空位"
                    } else if (info_status == 2) {
                        info_status = "已满"
                    } else {
                        info_status = "已取消"
                    }
                    //开始时间设置
                    var insert_time = start_time.substring(0, 10);
                    var time_change = insert_time.split('-');
                    insert_time = time_change[1] + '月' + time_change[2] + '日';
                    //发布时间设置
                    var begin_create_time = create_time.substring(11, 16);
                    create_time = create_time.substring(0, 10);
                    var time_create = create_time.split('-');
                    create_time = time_create[1] + '月' + time_create[2] + '日';

                    //开始结束时间
                    var begin_start_time = start_time.substring(11, 16);
                    var begin_end_time = end_time.substring(11, 16);

                    $('.departure_city').text(departure_city);
                    $('.destination_city').text(destination_city);
                    $('.item_mobile').text(mobile);
                    $('.item_tips').text(description);
                    $('.item_mouth').text(insert_time);
                    $('.item_start_end_times').text(begin_start_time+"-"+begin_end_time);
                    $('.item_seat_status').text(info_status);
                    $('.item_seat').text(inits_seats+"个");
                    $('.item_yes_tips').text(tag_yes_content);
                    $('.item_no_tips').text(tag_no_content);
                    $('.item_name').text(driving_name);
                    $('.item_points').text(points);
                    $('.item_type').text(car_brand);
                    $('.call_driver').attr('href','tel:'+mobile);

                    if(driving_name==""){
                        $('.item_name_li').hide()
                    }
                    if(points==""){
                        $('.item_points_li').hide()
                    }
                    if(description==""){
                        $('.item_tips').hide()
                    }
                    if(tag_yes_content==""){
                        $('.item_yes_tips').hide()
                    }
                    if(tag_no_content==""){
                        $('.item_no_tips').hide()
                    }
                    if(car_brand==""){
                        $('.item_type_li').hide()
                    }


                    if (car_brand == "") {
                        $($('.departure_li_car_type')[i]).remove();
                    }


                    if (departure == "") {
                        $('.start_city_type').remove();
                    }else{
                        $('.begin_city').text(departure);
                    }
                    if (destination == "") {
                        $('.end_city_type').remove();
                    }else{
                        $('.end_city').text(destination);
                    }

                }
            }

        }
    </script>
</head>
<body>
<div class="publish_container">
    <div class="publish_top">
        <div class="return_perv">
            <img class="return_perv_img" alt="" src="/resource/images/pc_icon_white_return.png"
                 onclick="window.history.go(-1)">
        </div>
        <span>发布拼车</span>
        <img class="publish_top_right" alt="" src="/resource/images/pc_icon_white_share.png">

    </div>
    <div class="publish_message_driver">
        <div class="publish_message_driver_title">
            <img src="/resource/images/pc_icon_stratRoute.png">
            <span class="departure_city"></span>
            <span class="start_city_type">
            <i class="circle"></i>
            <span class="begin_city" style="color:#999794"></span>
            </span>
            <span>——</span>
            <span class="destination_city"> </span>
            <span class="end_city_type">
            <i class="circle"></i>
            <span class="end_city"  style="color:#999794"></span>
            </span>
        </div>
        <div class="publish_message_driver_time">
            <img src="/resource/images/pc_icon_thin_time.png" class="publish_message_driver_time_img">
            <span class="item_mouth"></span>
            <span class="item_start_end_times"></span>

            <div class="publish_seat">
                <span class="item_seat_status"></span>
            </div>
        </div>
    </div>
    <div class="publish_message">
        <ul>
            <li class="publish_message_li item_name_li">
                <div class="publish_message_li_left">
                    <span>车主姓名</span>
                </div>
                <div class="publish_message_li_right">
                    <span class="item_name"></span>
                </div>
                <div class="clear"></div>
            </li>
            <li class="publish_message_li">
                <div class="publish_message_li_left">
                    <span>电话</span>
                </div>
                <div class="publish_message_li_right">
                    <span class="item_mobile"></span>
                    <a href="tel:13764567708" class="call_driver">
                        <img src="/resource/images/pc_icon_mobile.png" class="mobile">
                    </a>

                </div>
                <div class="clear"></div>
            </li>
            <li class="publish_message_li item_points_li">
                <div class="publish_message_li_left">
                    <span>途径</span>
                </div>
                <div class="publish_message_li_right publish_message_li_route">
                    <span class="item_points"></span>
                </div>
                <div class="clear"></div>
            </li>

            <li class="publish_message_li item_type_li">
                <div class="publish_message_li_left">
                    <span>车型</span>
                </div>
                <div class="publish_message_li_right">
                    <span class="item_type"></span>
                </div>
                <div class="clear"></div>
            </li>
            <li class="publish_message_li ">
                <div class="publish_message_li_left">
                    <span>可用座位</span>
                </div>
                <div class="publish_message_li_right">
                    <span class="item_seat"></span>
                </div>
                <div class="clear"></div>
            </li>
            <li class="publish_message_li li_last item_tips_li">
                <div class="publish_message_li_left">
                    <span>备注</span>
                </div>
                <div class="publish_message_li_right">
                    <span class="item_tips"></span>
                    <br>
                    <span class="item_yes_tips"></span>
                    <br>
                    <span class="item_no_tips"></span>
                </div>
                <div class="clear"></div>
            </li>
        </ul>
    </div>
    <a href="" class="call_driver">
    <div class="publish_bottom">
            联系车主
    </div>
    </a>
</div>
</body>
</html>
