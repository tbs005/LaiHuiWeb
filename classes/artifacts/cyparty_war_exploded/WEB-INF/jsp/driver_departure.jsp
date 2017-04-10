<%--
  Created by IntelliJ IDEA.
  User: zhu
  Date: 2016/7/25
  Time: 15:06
  describtion:移动端--车主发布出行信息（带诚信必发标志）
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
            background-color: #fff;
            text-align: center;
            line-height: 3.2rem;
            font-size: 1.4rem;
            border-bottom: 1px solid #e8e8e8;
            padding: 0 1rem;
        }

        .publish_mid {
            font-size: 1.4rem;
            background-color: #fff;
            line-height: 2.4rem;
            margin-bottom: .8rem;
            padding: 1rem 1.4rem;
        }

        .publish_top_right {
            float: right;
            font-size: 1.2rem;
            color: #999794;
            line-height: 3.2rem;
        }

        .return_perv {
            float: left;
        }

        .return_perv_img {
            width: 1.4rem;
        }

        .publish_mid_li {
            height: 3.8rem;
            line-height: 3.8rem;
            position: relative;
        }

        .publish_mid_li_img {
            width: 1.4rem;
            position: absolute;
            top: 1.2rem;
            margin-right: .3rem;
        }

        .publish_mid_driver_img {
            width: 1.4rem;
            position: relative;
            top: .3rem;
            margin-right: .3rem;
        }

        .publish_comeback_img {
            position: absolute;
            width: 1.6rem;
            right: 0;
            top: 2.8rem;
            transform: rotate(90deg);
        }

        .publish_message_driver {
            font-size: 1.4rem;
            background-color: #fff;
            line-height: 2.4rem;
            margin-top: .8rem;
            padding: 1rem 1.4rem;
        }

        .publish_mid_driver_li {
            height: 3rem;
            line-height: 3rem;
            position: relative;
        }

        .driver_li_tips {
            line-height: 1.4rem;
            color: #999794;
            position: relative;
            font-size: 1.2rem;
        }

        .driver_li_tips > a {
            text-decoration: underline;
            color: #f5ad4e;
        }

        .driver_li_tips_href {
            position: absolute;
            right: 1rem;
            bottom: 0;
        }

        .to_pay {
            display: none;
            text-align: right;
            line-height: 3rem;
            padding-right: 2rem;
            border-top: 1px solid #e8e8e8;
            background-color: #fff;
            height: 3rem;
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

        .input_style {
            width: 100%;
            height: 2.6rem;
            text-indent: 2rem;
            border: none;
        }

        .publish_route_span {
            display: block;
        }

        .publish_route_box_span {
            line-height: 2rem;
            padding: 0 1rem;
            position: absolute;
            right: 0;
            color: #F5AD4E;
            bottom: 0;
            display: none;
        }

        .publish_route_box_remove {
            position: absolute;
            top: 0.5rem;
            right: -.6rem;
            line-height: 1.5rem;
            width: 1.4rem;
            height: 1.4rem;
            border-radius: 50%;
            font-size: 1.2rem;
            background-color: #F5AD4E;
            text-align: center;
            color: #fff;
            display: none;
        }

        .publish_route_box_input {
            display: inline-block;
            position: relative;
            width: 16rem;
            margin-left: .2rem;
        }

        .publish_route_container {
            position: relative;
            line-height: 2rem;
        }

        .publish_li_route {
            display: block;
            height: auto;
        }

        .publish_route_ul {
            border: 1px solid #e8e8e8;
            position: absolute;
            top: 3.2rem;
            background-color: #fff;
            z-index: 1;
            line-height: 1.6rem;
            font-size: 1.3rem;
            overflow-y: auto;
            max-height: 24rem;
        }

        .publish_route_li {
            padding: .2rem .4rem;
            height: 2.6rem;
            line-height: 1.4rem;
        }

        .input_disabled {
            background-color: #fff;
            border: none;
            width: 100%;
            text-indent: 1.8rem;
            line-height: 3.2rem;
            color: #52514f;
        }

        .line_container {
            width: .8rem;
            height: 2.6rem;
            position: absolute;
            top: -.7rem;
            text-align: center;
        }

        .line_slide {
            border-left: 1px solid #e8e8e8;
            height: 60%;
            position: relative;
            width: 1px;
            margin: 0 auto;
        }

        .line_circle {
            width: .6rem;
            height: .6rem;
            border: 1px solid #00b38a;
            border-radius: 50%;
        }

        .area_county_box {
            display: none;
        }

        .larea_finish {
            color: #f5ad4e;
        }

    </style>
    <script>
        $(document).ready(function () {

            changeFontSize();
            //日期选择器
            var driverDate = new DriverDate();
            driverDate.init({
                'trigger': '#demo_time',//触发选择控件的文本框，同时选择完毕后name属性输出到该位置
                'keys': {id: 'id', name: 'name'},//绑定数据源相关字段 id对应valueTo的value属性输出 name对应trigger的value属性输出
                'type': 1,//数据源类型
                'status': 1,
                'data': timeData//数据源
            });
            //座位选择
            var driverSet = new DriverSet();
            driverSet.init({
                'trigger': '#demo_set',//触发选择控件的文本框，同时选择完毕后name属性输出到该位置
                'keys': {id: 'id', name: 'name'},//绑定数据源相关字段 id对应valueTo的value属性输出 name对应trigger的value属性输出
                'type': 1,//数据源类型
                'status': 1,
                'data': array//数据源
            });
            //地点选择器
            var driverPlace = new DriverPlace();
            driverPlace.init({
                'trigger': '#demo_place',//触发选择控件的文本框，同时选择完毕后name属性输出到该位置
                'keys': {id: 'id', name: 'name'},//绑定数据源相关字段 id对应valueTo的value属性输出 name对应trigger的value属性输出
                'type': 1,//数据源类型
                'data': placeData//数据源
            });
            addTimeStyle();
            getStartPlace();
            hideUl();
        });
        var array = [];
        //加载城市数组
        var city_array = [];
        //选择位置（都有哪几个）数组
        var city_select = [];
        //向后端发送的数组
        var send_array = [];
        //时间数据
        var timeData = [];
        var day = ["今天", "明天"];
        var array_end = [];
        var placeData = [];
        var send_time;
        var send_time2;
        var token="7f5bfcb450e7425a144f3e20aa1d1a6e";

        //添加地点选择
        //获取出发地数据
        function getStartPlace() {
            var data_obj = {};
            data_obj.action = 'departure';
            validate.validate_submit('/db/route', data_obj, carPlace.addCarStart);
        }

        function hideUl(){
            $(document).click(function(e){
                $(".publish_route_ul").empty();
            });
        }
        //添加日期格式
        function addTimeStyle() {
            for (var key in day) {
                var contact = new Object();
                var day_time = [];
                for (var i = 0; i < 24; i++) {
                    var obj = {};
                    obj.name = i + "时——" + (i + 1) + "时";
                    obj.id = 1000 + i;
                    day_time.push(obj);
                }
                contact.child = day_time;
                contact.id = 1;
                contact.name = day[key];
                timeData.push(contact);
            }
        }

        //车辆行程信息2
        var carPlace = (function () {
            //将车辆行程信息据封装进数组
            function addCarStart() {
                var data1 = global_data.result;
                for (var i = 0; i < data1.data.length; i++) {
                    var departure1 = data1.data[i].departure;
                    var contact = new Object();
                    contact.name = departure1;
                    contact.id = 1;
                    $.ajax({
                        type: "POST",
                        url: "/db/route",
                        async:false,
                        data: {"action": "destination", "departure": departure1},
                        dataType: "json",
                        success: function (data) {
                            if (data.status == true) {
                                var array_end = [];
                                for (var j = 0; j < data.result.data.length; j++) {
                                    var obj={};
                                    obj.name =data.result.data[j].destination;
                                    obj.id = 1000 + j;
                                    array_end.push(obj);
                                }
                                contact.child = array_end;
                                placeData.push(contact);
                                console.log(placeData);
                            } else {
                                validate.showTips("格式不正确");
                            }
                        },
                        error: function () {
                            console.log("交互失败");
                        }
                    })

                }
            };

            return {
                addCarStart: addCarStart
            }
        })();


        //改变诚信必发颜色
        function changeMustSelect(obj) {
            if ($(obj).children('.publish_mid_driver_img').attr('src') == '/resource/images/pc_icon_shiyuan.png') {
                $(obj).children('.publish_mid_driver_img').attr('src', '/resource/images/pc_icon_kongyuan.png').removeClass('publish_active');;
                $('.to_pay').hide();
            } else {
                $(obj).children('.publish_mid_driver_img').attr('src', '/resource/images/pc_icon_shiyuan.png').addClass('publish_active');
                $('.to_pay').show();
            }

        }
        //发送ajax获取城市信息
        function sendMessage(key, city) {
            var obj = {};
            obj.key = key;
            obj.city = city;
            var url = "/place_suggestion";
            validate.validate_submit2(url, obj, pushToArray);
        }
        //将信息存入数组
        function pushToArray() {
            city_array = [];
            for (var i = 0; i < global_data.result.length; i++) {
                city_array.push(global_data.result[i]);
            }
            addCitySlide(city_array);
        }

        //移除输入框
        function removeInput(obj) {
            $(obj).parent().parent().remove();
            var city = $(obj).children('.city').text();
            var number = $(obj).parent().children('.input_style').attr('index');
            send_array.splice(number,1);
            isFirstInput();
            setIndex();
        }
        //添加输入
        function addInput() {
            $('.publish_route_box_span').before('<div class="publish_route_container">' +
                    '<div class="publish_route_box_input">' +
                    '<div class="line_container">' +
                    '<div class="line_slide"></div>' +
                    '<div class="line_circle"></div>' +
                    '</div>' +
                    '<input type="text" placeholder="添加行程的主要途径点" index="" class="input_style" oninput="sendKeepDownInput(this)">' +
                    '<span class="publish_route_box_remove" onclick="removeInput(this)">X</span>' +
                    '<ul class="publish_route_ul">' +

                    '</ul>' +
                    '</div>' +
                    '</div>');
            isFirstInput();
            setIndex();
        }
        function setIndex(){
            for(var i=0;i<$('.input_style').length;i++){
                $($('.input_style')[i]).attr('index',i);
            }
        }
        //添加城市下拉列表样式
        function addCitySlide(city_array) {
            $('.publish_route_li').remove();
            for (var i = 0; i < city_array.length; i++) {
                var name = city_array[i].name;
                var city = city_array[i].city;
                var district = city_array[i].district;
                var index = i;
                addCitySlideStyle(name, city, district, index);
            }
        }
        //添加城市下拉列表样式
        function addCitySlideStyle(name, city, district, index) {
            $('.publish_route_ul').append('<li class="publish_route_li" index=' + index + ' onclick="selectCity(this)">' +
                    '<span class="key">'+name+'</span>' +
                    '<span class="city" style="color: #999794">'+city+district+'</span>' +
                    '</li>')
        }
        //选择城市
        function selectCity(obj) {
            //显示用的数据
            var name = $(obj).children('.key').text();
            var city = $(obj).children('.city').text();
            var number = $(obj).parent().parent().children('.input_style').attr('index');
            $(obj).parent().parent().children('input').val(name+" "+city);
            $(obj).parent().hide();
            send_array.splice(number,1,city_array[$(obj).attr('index')]);
        }
        //按键请求城市信息
        function sendKeepDownInput(obj) {
            if($(obj).val() ==""){
                $(obj).parent().children('.publish_route_ul').empty()
            }else{
                $('.publish_route_ul').hide();
                $(obj).parent().children('.publish_route_ul').show();
                var key = $(obj).val().trim();
                var city = "全国";
                sendMessage(key, city);
            }
            isFirstInput();
        }
        //检测输入框是否是第一个
        function isFirstInput() {
            var l_input = $('.publish_route_container').length;
            if (l_input == 1) {
                $('.publish_route_box_remove').hide();
                if ($('.input_style').val() == "") {
                    $('.publish_route_box_span').hide();
                } else {
                    $('.publish_route_box_span').show();
                }
            } else {
                $('.publish_route_box_remove').show();
                $('.publish_route_box_span').show();
            }
        }
        //显示途径和下滑菜单
        function slideCity() {
            $('.publish_li_route').show();
        }
        //检测输入信息是否完整
        function checkDriverMessage(){
            if($('#demo_time').val()==""){
                validate.showTips("出发时间不能为空");
            }else if($('#demo_place').val()==""){
                validate.showTips("起止路线不能为空");
            }else if($('#demo_set').val()==""){
                validate.showTips("可用座位不能为空");
            }else{
                setSendData();
                sendFinalMessage();
            }
        }
        //发送时间的数据
        function setSendData(){
            var time;
            var str =$('#demo_time').val().substring(0,2);
            var st2 =parseInt($('#demo_time').val().substring(3,5));
            if(str=="昨天"){
                var today=new Date();
                var t=today.getTime()-1000*60*60*24;
                time=new Date(t);
                changeDataStyle(time,st2)
            }else if(str=="今天"){
                time=new Date();
                changeDataStyle(time,st2)
            }else{
                var today=new Date();
                var t=today.getTime()+1000*60*60*24;
                time=new Date(t);
                changeDataStyle(time,st2)
            }

        }
        //转换日期格式
        function changeDataStyle(time,st2){
            var year  = time.getFullYear();
            var month = time.getMonth()+1;
            var date  = time.getDate();
            send_time =year+"-"+month+"-"+date+" "+st2+":00"+":00";
            send_time2 =year+"-"+month+"-"+date+" "+(st2+1)+":00"+":00";
        }
        //发送数据到后端
        function sendFinalMessage(){
            var demo_set = $('#demo_set').val().substring(0,1);
            var route = {};
            var is_must_driving=0;
            var a = $('#demo_place').val().split(' ');
            route.result=send_array;
            var json = JSON.stringify(route);
            var data_obj = {};
            if($('.publish_mid_driver_img').hasClass('publish_active')){
                is_must_driving=1;
            }else{
                is_must_driving=0;
            }
            data_obj.action = 'add';
            data_obj.start_time = send_time;
            data_obj.end_time = send_time2;
            data_obj.departure_city = a[0];
            data_obj.destination_city = a[1];
            data_obj.route_json =json ;
            data_obj.init_seats = demo_set;
            data_obj.is_must_driving = is_must_driving;
            data_obj.token = token;
            validate.validate_submit('/api/driver/departure', data_obj, success);
        }

        function success(){
            alert("数据传送成功")
        }

    </script>
</head>
<body>
<div class="publish_container">
    <div class="publish_top">
        <div class="return_perv">
            <img class="return_perv_img" alt="" src="/resource/images/pc_icon_return.png">
        </div>
        <span>发布拼车</span>
        <span class="publish_top_right">计算规则</span>
    </div>
    <div class="publish_message">
        <ul class="publish_mid">
            <li class="publish_mid_li">
                <div class="publish_mid_li_click" onclick="">
                    <img class="publish_mid_li_img" src="/resource/images/pc_icon_kongyuan.png">
                    <input type="text" id="demo_time" placeholder="出行时间" readonly="readonly" class="input_disabled"/>
                </div>
            </li>
            <li class="publish_mid_li publish_start">
                <div class="publish_mid_li_click" index="1" onclick="slideCity()">
                    <img class="publish_mid_li_img" src="/resource/images/pc_icon_kongyuan.png">
                    <input type="text" id="demo_place" placeholder="起止地点" readonly="readonly" class="input_disabled"/>
                </div>
            </li>
            <li class="publish_mid_li">
                <div class="publish_mid_li_click" onclick="">
                    <img class="publish_mid_li_img" src="/resource/images/pc_icon_kongyuan.png">
                    <input type="text" id="demo_set" placeholder="可用座位" readonly="readonly" class="input_disabled"/>
                </div>
            </li>
            <li class="publish_mid_li publish_li_route">
                <span class="publish_route_span">途经点：</span>

                <div class="publish_route_box">
                    <div class="publish_route_container">
                        <div class="publish_route_box_input">
                            <div class="line_container">
                                <div class="line_slide"></div>
                                <div class="line_circle"></div>
                            </div>
                            <input type="text" placeholder="添加行程的主要途径点" class="input_style"
                                   index="0" oninput="sendKeepDownInput(this)">
                            <span class="publish_route_box_remove" onclick="removeInput(this)">X</span>
                            <ul class="publish_route_ul">

                            </ul>
                        </div>
                    </div>
                    <span class="publish_route_box_span" onclick="addInput()">+添加</span>

                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </li>
            <div class="clear"></div>
        </ul>
    </div>
    <div class="publish_message_driver">
        <ul class="publish_mid_driver">
            <li class="publish_mid_driver_li" onclick="changeMustSelect(this)">
                <img class="publish_mid_driver_img" src="/resource/images/pc_icon_kongyuan.png">
                <span>诚信必发</span>
                <span style="color: #999794">&nbsp;&nbsp;￥100</span>
            </li>
            <div class="driver_li_tips">
                <span>诚信保证金是您本次行程的重要保证，缴纳诚信保证金后会携带有诚信必发的标志，行程结束后将全额返还给用户。</span>
                <a href="/" class="driver_li_tips_href">了解更多</a>
            </div>
        </ul>

    </div>
    <a href="/">
        <div class="to_pay">
            <span>去支付</span>
        </div>
    </a>

    <div class="publish_bottom" onclick="checkDriverMessage()">
        <span>确认发布</span>
    </div>
</div>
</body>
</html>
