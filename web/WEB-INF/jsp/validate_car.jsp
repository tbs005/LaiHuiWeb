<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/7/25
  Time: 15:07
  describtion:移动端--车主认证界面
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
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>车主认证</title>
    <script src="/resource/js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="/resource/js/style.js" type="text/javascript"></script>
    <link href="/resource/css/style.css" rel="stylesheet" type="text/css">

    <script src="/resource/js/LCalendar.js" type="text/javascript"></script>
    <link href="/resource/css/LCalendar.css" rel="stylesheet" type="text/css">

    <style type="text/css">
        .validate_img {
            width: 400%;
            max-width: none;
        }

        .validate_input {
            border: none;
            width: 100%;
            height: 3.4rem;
            line-height: 3.4rem;
            text-indent: 1rem;
            border-radius: 0;
            margin-bottom: 1rem;
            font-size: 1.4rem;
            border-bottom: 2px solid #f5ad4e;
            background-color: #f2efeb;
            color: #52514f;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .lcalendar_finish {
            color: #f5ad4e;
        }

        .larea_finish {
            color: #f5ad4e;
        }

        .validate_data_box {
            overflow: hidden;
            font-size: 1.4rem;
            position: relative;
        }

        .validate_car_owner {
            position: relative;
        }

        .validate_submit {
            width: 92%;
            position: fixed;
            bottom: 0;
            z-index: 1
        }

        .validate_data_img_box {
            margin: 4rem auto 0.2rem;
            display: block;
            width: 5rem;
            color: rgba(0, 0, 0, 0.58);
            text-shadow: 0 1px 0 #fff;
        }

        .validate_data_img_text {
            text-align: center;
            color: #999794;
            font-size: 1.4rem;
        }

        .submit_container {
            width: 100%;
            background: #fff;
            border-top: 1px solid #e8e8e8;
            position: fixed;
            bottom: 0rem;
            height: 5rem;

        }

        .validate_bottom_tips {
            text-align: center;
        }


        .reload_img {
            position: fixed;
            bottom: 8rem;
            width: 70%;
            background-color: #f5ad4e;
            color: #fff;
            line-height: 3.8rem;
            padding: 4px;
            margin-left: 15%;
            font-size: 1.4rem;
            border-radius: 5px;
            text-align: center;
            display: none;
        }



        .validate_logo {
            font-size: 1.4rem;
            line-height: 2.4rem;
        }

        .change_style {
            width: 41%;
        }

        .validate_return_submit {
            left: 2rem;
            background-color: #fff;
            width: 41%;
            text-align: center;
            color: #52514f;
            display: none;
        }

        .validate_next_submit {
            right: 2rem;
            width: 41%;
        }

        .area_county_box {
            display: none;
        }

        .validate_car_no {
            width: 4.5rem;
            position: absolute;
            top: 2rem;
            line-height: 2.4rem;
            height: 2.4rem;
            border: 1px solid #79abff;
            border-radius: 5px;
            color: #79abff;
        }

        .validate_car_no:focus {
            border: 1px solid #79abff;
        }

        .right_slip_body {
            min-height: 667px;
            background-color: #fff;
            z-index: 10;
            position: absolute;
            width: 100%;
            top: -6rem;
            right: -500%;
        }

        .right_slip_top {
            background-color: #f0f0f0;
            height: 2.2rem;
            line-height: 2.2rem;
            padding-left: 2rem;
            border-top: 1px solid #e8e8e8;
            border-bottom: 1px solid #e8e8e8;
            margin: -1px;
        }

        .right_slip_container {
            padding-left: 2rem;
            margin: 1.5rem 0;
        }

        .right_slip_container_span {
            padding-left: 2rem;
            margin: 0;
        }

        .right_slip_img {
            float: left;
            width: 6rem;
        }

        .right_slip_img img {
            width: 3.2rem;
            margin: 0 auto;
            display: inherit;
        }

        .right_slip_img p {
            text-align: center;
        }

        .right_slip_span {
            display: block;
            line-height: 3rem;
            font-size: 1.4rem;
            border-top: 1px solid #e8e8e8;
        }

        .right_slip_ul {
            margin-right: 2rem;
        }

        .right_flag {
            z-index: 12;
            font-size: 1.2rem;
            position: fixed;
            right: 0;
            top: 8%;
            width: 2rem;
            padding-left: 1rem;
            text-align: center;
        }

        .right_flag_box a {
            line-height: 2.2rem;
            padding: .3rem .8rem;
        }

        .right_slip2 {
            position: fixed;
            top: 0;
            right: -500%;
            width: 68%;
            background: #f0f0f0;
            z-index: 12;
            height: 100%;
            box-shadow: 1px 0px 10px 0px #BFBFBF;
            overflow: auto;
        }

        .right_slip2_container, .right_slip3_container {
            background: #fff;
            padding-left: 1.8rem;
        }

        .right_slip3 {
            position: fixed;
            top: 0;
            right: -400%;
            width: 34%;
            background: #f0f0f0;
            z-index: 13;
            height: 100%;
            box-shadow: 1px 0 10px 0 #BFBFBF;
        }

        .right_color_box {
            width: 1.6rem;
            height: 1.6rem;
            display: inline-block;
            background-color: #fff;
            border: 1px solid #e8e8e8;
            border-radius: 50%;
            top: .4rem;
            position: relative;
            margin-right: .8rem;
            margin-left: .2rem;
        }

        .validate_car_register::-webkit-input-placeholder {
            color: #f5ad4e;
        }

        .validate_car_register:-moz-placeholder {
            color: #f5ad4e;
        }

        .cancel_input {
            position: absolute;
            right: .6rem;
            top: 2.8rem;
            background-color: #c1c1c1;
            color: #fff;
            border-radius: 50%;
            width: 1.6rem;
            height: 1.6rem;
            text-align: center;
            line-height: 1.6rem;
            display: none;
        }
    </style>
    <link href="/resource/css/h5_auto.css" rel="stylesheet" type="text/css">
    <script>
        $(document).ready(function () {
            changeFontSize();
            madeAToZ();
            $('.validate_ID').val('410222199409230036');
            $('.image_tips').click(function () {
                if ($('.validate_car_owner2').css('display') == "none") {
                    $('.file0').click();
                } else {
                    $('.file1').click();
                }
            });

            //时间选择器
            var calendar = new LCalendar();
            calendar.init({
                'trigger': '#demo1',//标签id
                'type': 'date',//date 调出日期选择 datetime 调出日期时间选择 time 调出时间选择 ym 调出年月选择
                'minDate': '1949-10-1'//最小日期 注意：该值会覆盖标签内定义的日期范围
//        'maxDate':'2036-3-18'//最大日期 注意：该值会覆盖标签内定义的日期范围
            });

            //车牌选择器
            var area = new LArea();
            area.init({
                'trigger': '#demo2',//触发选择控件的文本框，同时选择完毕后name属性输出到该位置
//                'valueTo': '#value1',//选择完毕后id属性输出到该位置
                'keys': {id: 'id', name: 'name'},//绑定数据源相关字段 id对应valueTo的value属性输出 name对应trigger的value属性输出
                'type': 1,//数据源类型
                'data': LAreaData//数据源
            });

        });
        var global_data;
        var data_obj = {};

        var url = window.location.href;
        var token="";
        if(url.split("token=").length>=2){
            token=url.split("token=")[1];
        }else{
            token="7f5bfcb450e7425a144f3e20aa1d1a6e";
        }
        function android_get_token()
        {
//            String local_token=androidInterface.getToken();
            return token;
        }
        var car_type_id;
        var car_cate_id;
        var car_color_id;
        var car_type_name;
        var car_cate_name;
        var car_color_name;
        //存26英文字母
        var str = [];
        //存车牌名称ID信息
        var car_type = [];
        // 存现有字母名称
        var car_letter = [];
        //存取省份车牌信息
        var LAreaData = [];

        //热门车辆
        var hot_car = [{
                "name": "大众",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/dazhong.png",
                "id": "57"
            }, {
                "name": "现代",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/xdai.png",
                "id": "167"
            }, {
                "name": "丰田",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/fengtian.png",
                "id": "66"
            },{
                "name": "福特",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/fute.png",
                "id": "69"
            }, {
                "name": "别克",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/bieke.png",
                "id": "52"
            }, {
                "name": "本田",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/bentian.png",
                "id": "49"
            }, {
                "name": "起亚",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/qiya.png",
                "id": "137"
            }, {
                "name": "奥迪",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/ad.png",
                "id": "36"
            }, {
                "name": "日产",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/richan.png",
                "id": "139"
            }, {
                "name": "长安",
                "logo": "http://static.diditaxi.com.cn/pinche/logo/changan.png",
                "id": "178"
            }];
        //生成26英文字母
        function madeAToZ() {
            for (var i = 65; i < 91; i++) {
                str.push(String.fromCharCode(i));
            }
        }
        //检测车主身份信息
        var validateLicense = (function () {
            var validate_ajax = function (url, data_obj, callback) {
                $.ajax({
                    type: "POST",
                    url: url,
                    data: data_obj,
                    dataType: "json",
                    beforeSend:loading(),
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
            };

            var validateFormData = function (url, data_obj, callback) {
                $.ajax({
                    type: "POST",
                    url: url,
                    data: data_obj,
                    processData: false,
                    contentType: false,
                    dataType: "json",
                    beforeSend:loading(),
                    success: function (data) {
                        closeLoading();
                        global_data = data;
                        if (global_data.status == true) {
                            callback();
                            alert("交互成功");
                        } else {
                            validate.showTips("身份证格式不正确");
                        }
                    },
                    error: function () {
                        console.log("交互失败");
                    }
                })
            };

            function showTips(message) {
                $('.validate_error_tips').show().text(message);
            };

            function hideTips() {
                $('.validate_error_tips').hide().text("");
            };

            //控制输入的只能是数字
            function onlyNum(obj) {
                if (isNaN($(obj).val())) {
                    $(obj).val("");
                    validate.showTips("请输入合法的身份证号");
                } else {
                    validate.hideTips();
                    $(obj).parent().children('.cancel_input').show();
                }
            }

            return {
                validate_ajax: validate_ajax,
                showTips: showTips,
                hideTips: hideTips,
                onlyNum: onlyNum,
                validateFormData: validateFormData
            }

        })();

        //车辆信息展示类
        var carData = (function () {

            //将车辆车牌数据封装进数组
            function addCarBrand(){
                var data = global_data.result;
                for (var key in data) {
                    var contact = new Object();
                    var array2 = [];
                    for (var i = 0; i < str.length; i++) {
                        var obj = {};
                        obj.name = str[i];
                        obj.id = 1000+i;
                        array2.push(obj);
                    }
                    contact.child = array2;
                    contact.id = 1;
                    contact.name = data[key];
                    LAreaData.push(contact);
                }
            };

            //将车辆类型数据存入数组
            function addCarType() {
                var data = global_data.result;
                for (var i in data) {
                    car_letter.push(i);
                }
                for (var key in data) {
                    var contact = new Object();
                    contact.car_type = data[key];
                    car_type.push(contact);
                }
                showCarTypeList(car_letter);
            };

            //将车辆类型下的分类存入数组
            function addCarCate() {
                var data = global_data.result;
                // 存现有车辆类型下品牌
                var car_cate = [];
                for (var i = 0; i < data.data.length; i++) {
                    var contact = new Object();
                    contact.car_name = data.data[i].brand_type_name;
                    contact.car_id = data.data[i].brand_type_id;
                    car_cate.push(contact);
                }

                showCarCateList(car_cate);
            };

            //将车辆类型下的颜色存入数组
            function addCarcolor() {
                var data = global_data.result;
                var car_color = [];
                for (var i = 0; i < data.data.length; i++) {
                    var contact = new Object();
                    contact.car_name = data.data[i].name;
                    contact.car_id = data.data[i].id;
                    contact.car_value = data.data[i].value;
                    car_color.push(contact);
                }
                showCarCateColor(car_color);
            };
            return {
                addCarBrand: addCarBrand,
                addCarType: addCarType,
                addCarCate: addCarCate,
                addCarColor: addCarcolor
            }
        })();

        function callBack() {
            if ($('.validate_car_owner2').css('display') == "none") {
                changeNextSkip();
                return false;
            } else {
                return true;
            }
        }

        //进行第二步操作
        function changeNextSkip() {
            if (LAreaData.length == 0) {
                loadLicenseNumber();
            }
            $('.validate_end_submit').val("提交审核");
            $('.validate_car_owner1').hide();
            $('.validate_car_owner2').show();
            validate.hideTips();
            $('.validate_logo_span_top').text("第2步填写你的【行驶证】");
            $('.validate_return_submit').show();
            $($('.validate_submit')[1]).addClass('validate_next_submit');
            $('.validate_img').css('margin-left', '-100%');
            $('.image_tips img').attr('src', '/resource/images/pc_icon_license_ID.png');
            $('.validate_bottom_tips').empty().append('<p>可填写本人或他人的行驶证资料，<br>但请保证出行时车辆信息一致 </p>')
        }

        //返回第一步操作
        function returnFirstSkip(obj) {
            $('.validate_car_owner2').hide();
            $('.validate_car_owner1').show();
            $('.validate_end_submit').val("下一步");
            validate.hideTips();
            $('.validate_logo_span_top').text("第1步填写你的【驾驶证】");
            $(obj).hide();
            $($('.validate_submit')[1]).removeClass('validate_next_submit');
            $('.validate_img').css('margin-left', '0');
            $('.validate_bottom_tips').empty().append('<p>为保障出行安全，请务必填写本人的驾驶证资料，<br>驾驶证号同时会作为实名信息进行验证 </p>')
        }

        //获取车牌数据
        function loadLicenseNumber() {
            data_obj.action = 'getlicencehead';
            validateLicense.validate_ajax('/pc/cartype', data_obj, carData.addCarBrand);
        }
        //获取车辆品牌数据
        function getDataOfCarType() {
            data_obj.action = 'getcarbrand';
            validateLicense.validate_ajax('/pc/cartype', data_obj, carData.addCarType);
        }
        //获取车辆品牌下分类信息
        function getDataOfCarCate(brand_id) {
            data_obj.action = 'getcartype';
            data_obj.brand_id = brand_id;
            validateLicense.validate_ajax('/pc/cartype', data_obj, carData.addCarCate);
        }
        //获取车辆颜色信息
        function getDataOfCarColor() {

            data_obj.action = 'getcolor';
            validateLicense.validate_ajax('/pc/cartype', data_obj, carData.addCarColor);
        }


        //加载车辆类型展示效果
        function showCarTypeList(car_letter) {
            var type_name;
            var type_id;
            var type_str;

            for (var i = 0; i < car_type.length; i++) {
                type_str = car_letter[i];
                addMessageToCarTypeList(type_str);
                for (var j = 0; j < car_type[i].car_type.length; j++) {
                    type_name = car_type[i].car_type[j].name;
                    type_id = car_type[i].car_type[j].id;
                    $($('.right_slip_container_span')[i]).append('<span class="right_slip_span" car_cate_id=' + type_id + ' onclick="showRightSlip2(this)">' + type_name + '</span>');
                }
            }

            addAToZ(car_letter);

        }
        //加载车辆类型展示效果信息
        function addMessageToCarTypeList(item_type) {
            $('.car_type_list').before('<li class="right_slip_li">' +
                    '<div class="right_slip_top">' +
                    '<a name=' + item_type + '>' + item_type + '</a>' +
                    '</div>' +
                    '<div class="right_slip_container_span">' +
                    '<div class="clear"></div>' +
                    '</div>' +
                    '</li>')
        }
        //加载车辆类型下车辆名称展示效果
        function showCarCateList(car_cate) {
            var type_name;
            var type_id;
            for (var i = 0; i < car_cate.length; i++) {
                type_name = car_cate[i].car_name;
                type_id = car_cate[i].car_id;
                addMessageToCarCateList(type_name, type_id)
            }
        }
        //加载车辆类型下车辆名称展示效果信息
        function addMessageToCarCateList(item_name, item_id) {
            $('.right_slip2_container').append('<span class="right_slip_span" car_type_id=' + item_id + ' onclick="showRightSlip3(this)">' + item_name + '</span>')
        }
        //加载车辆类型颜色
        function showCarCateColor(car_color) {
            var type_name;
            var type_id;
            var type_color;

            for (var i = 0; i < car_color.length; i++) {
                type_name = car_color[i].car_name;
                type_id = car_color[i].car_id;
                type_color = car_color[i].car_value;
                addMessageToCarCateColor(type_name, type_id, type_color)
            }
        }
        //加载车辆类型颜色果信息
        function addMessageToCarCateColor(item_name, item_id, item_color) {
            $('.right_slip3_container').append('<div class="right_color_container" onclick="saveLicense(this)" car_color_id=' + item_id + ' >' +
                    '<span class="right_slip_span">' +
                    '<span class="right_color_box" style="background-color: ' + item_color + '"></span>' +
                    '<span class="right_color_name">' + item_name + '</span>' +
                    '</span>' +
                    '</div>')
        }
        function showHotCar(){
            var hot_name;
            var hot_id;
            var hot_url;
            $('.hot_top').empty();
            for(var i=0;i<hot_car.length;i++){
                hot_name=hot_car[i].name;
                hot_id=hot_car[i].id;
                hot_url=hot_car[i].logo;
                hotCar(hot_name,hot_id,hot_url);
            }
        }
        //加载热门车辆信息
        function hotCar(item_name,item_id,item_url){
            $('.hot_top').append('<div class="right_slip_img" car_cate_id='+item_id+' onclick="showRightSlip2(this)">'+
                    '<img src="'+item_url+'"/>'+
                    '<p>'+item_name+'</p>'+
                    '</div>')
        }
        //检车输入参数是否完整
        function checkMessage() {
            if ($('.validate_car_owner2').css('display') == "none") {
                if ($('.validate_name').val() == "") {
                    validate.showTips("姓名不能为空");
                } else if ($('.validate_ID').val() == "") {
                    validate.showTips("身份证不能为空");
                } else if ($('.validate_car_owner1').find('.img0').attr('src') == "") {
                    validate.showTips("驾驶证件照片不能为空");
                } else {
                    sendStpe1Message();
                }
            } else {
                if ($('.validate_car_number').val() == "") {
                    validate.showTips("车牌号不能为空");
                } else if ($('.validate_car_belong').val() == "") {
                    validate.showTips("车辆所属者不能为空");
                } else if ($('.validate_car_message').val() == "") {
                    validate.showTips("车辆品牌不能为空");
                } else if ($('.validate_car_register').val() == "") {
                    validate.showTips("行驶证上的注册日期不能为空");
                } else if ($('.validate_car_owner2').find('.img0').attr('src') == "") {
                    validate.showTips("行驶证件照片不能为空");
                } else {
                    sendStpe2Message();
                }
            }

        }
        //传输第一步数据
        function sendStpe1Message() {
            data_obj.action = 'car_owner';
            data_obj.token = token;
            data_obj.step = 1;
            data_obj.idsn = $('.validate_ID').val();
            validateLicense.validate_ajax('/api/auth/validate', data_obj, callBack);
        }
        //传输所有数据
        function sendStpe2Message() {
            var data = new FormData($('#upload_form')[0]);
            data.append('action', 'car_owner');
            data.append('token', token);
            data.append('car_id', $('.validate_car_no').val() + $('.validate_car_number').val());
            data.append('step', 2);
            data.append('type', car_type_name);
            data.append('brand', car_cate_name);
            data.append('color', car_color_name);
            validateLicense.validateFormData('/api/auth/validate', data, callBack);
        }

        //初始加载图片设置
        function loadImageChange(obj) {
            console.log("开始替换图片");
            var objUrl = getObjectURL(obj.files[0]);
            var j = $(obj).parent().children('.img0');
            j.addClass("add_image");
            var k = $(obj).parent();
            if (objUrl) {
                $(obj).parent().children('.img0').attr("src", objUrl);
            }
            var i = $(obj).parent().children('.img0').attr("src");
            imageStyle(i, j, k);
        }
        function imageStyle(i, j, k) {
            console.log("改变img的框的大小和添加提示图片的显示");
            if (i == undefined || i == "") {
                console.log("回复默认设置");
                k.css({"width": "240px"});
                j.css({"display": "none"});
            } else {
                console.log("改变图片设置");
                k.children('.validate_data_img_change').hide();
                $('.hover').hide();
                $('.image_tips').hide();
                $('.cancel').hide();
                k.css({"width": "auto"});
//                j.css({"width": 100%,"display": "block"});
                j.css({"height": "100%","display": "block"});
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
        function showHover(obj) {
            if ($(obj).children('.img0').hasClass('add_image')) {
                $('.hover').show();
                $('.image_tips').show().css({'top': '10rem'}).children('img').attr('src', $(obj).children('.img0').attr('src'));
                $('.reload_img').show();
                $('.cancel').show();
            } else {

                $('.hover').show();
                $('.image_tips').show();
                $('.cancel').show();
            }
        }
        //添加英文侧边栏
        function addAToZ(car_letter) {
            for (var i = 0; i < car_letter.length; i++) {
                var code = car_letter[i];
                $('.right_flag').append('<div class="right_flag_box"><a href="#' + code + '">' + code + '</a></div>')
            }

        }

        //展示右边滑动窗口
        function showRightSlip() {
            getDataOfCarType();
            showHotCar();
            $('.right_slip_body').show().animate({right: '0'}, 300, function () {
                $('.right_flag').show()
            });
            $('.validate_car_message').val("").attr('cate', "").attr('type', "").attr('color', "")
        }
        function showRightSlip2(obj) {
            if($('.right_slip3').css('display') == "block"){
                $('.right_slip3').animate({right: '-400%'}, 500);
            }
            $('.right_slip_img').css('color', '#52514f');
            $('.right_slip_container_span').children('span').css('color', '#52514f');
            car_cate_name = $(obj).text();
            $(obj).css('color', '#f5ad4e');
            $('.right_slip2').show().animate({right: '0'}, 300);
            car_cate_id = $(obj).attr('car_cate_id');
            $('.right_slip2_container').empty();
            getDataOfCarCate(car_cate_id);
        }
        function showRightSlip3(obj) {
            $('.right_slip3_container').empty();
            getDataOfCarColor();
            $(obj).parent().children('span').css('color', '#52514f');
            $(obj).css('color', '#f5ad4e');
            $('.right_slip3').show().animate({right: '0'}, 300);
            car_type_name = $(obj).text();
            car_type_id = $(obj).attr('car_type_id');
        }


        //保存车辆信息
        function saveLicense(obj) {
            car_color_name = $(obj).find('.right_color_name').text();
            car_color_id = $(obj).attr('car_color_id');
            $('.right_slip_body').hide().animate({right: '-400%'}, 300, function () {
                $('.right_flag').hide()
            });
            $('.right_slip2').hide().animate({right: '-400%'}, 300);
            $('.right_slip3').hide().animate({right: '-400%'}, 300);
            $('.validate_car_message').val(car_cate_name + "   " + car_type_name + "   " + car_color_name).attr('cate', car_cate_id).attr('type', car_type_id).attr('color', car_color_id)
        }


        //清楚输入信息
        function cancelInput(obj) {
            $(obj).parent().children('input').val("");
            $(obj).hide();
        }
        function cancelInputDemo(obj) {
            $(obj).parent().children('.validate_car_number').val("");
        }
        function checkInput(obj) {
            if ($(obj).val == "") {
                $(obj).parent().children('.cancel_input').hide();
            } else {
                $(obj).parent().children('.cancel_input').show();
            }
        }
    </script>
</head>
<body>
<div class="hover"></div>
<div class="loading_box">
    <img class="loading" src="/resource/images/loading.gif" alt="请等待" style="width: 4rem">
</div>
<div class="cancel" onclick="changeImg.cancelBigImg()">x</div>
<div class="image_tips">
    <img src="/resource/images/pc_icon_drivercard.png">
    <span class="reload_img">重新上传</span>
</div>
<div class="validate_container">
    <div class="validate_logo">
        <img src="/resource/images/pc_icon_licence.png" alt="" class="validate_img">
        <span class="validate_logo_span_top">第1步填写你的【驾驶证】</span><br>
        <span class="validate_logo_span_bottom">认证后可获得官方车主认证身份</span>
    </div>
    <form method="post" id="upload_form" accept-charset="utf-8" onsubmit="return false" enctype="multipart/form-data"
          class="validate_car_owner">
        <div class="validate_car_owner1">
            <div class="validate_data">
                <span class="validate_error_tips">请输入真实的身份证号码</span>

                <div class="validate_data_box">
                    <span>真实姓名</span>
                    <input type="text" placeholder="姓名" name="name" class="validate_input validate_name"
                           onchange="checkInput(this)"/>

                    <div class="cancel_input" onclick="cancelInput(this)">X</div>
                </div>
                <div class="validate_data_box">
                    <span>驾驶证号</span>
                    <input type="text" maxlength="18" name="idsn" placeholder="与身份证号一致的18位证件号"
                           class="validate_input validate_ID"
                           onchange="validateLicense.onlyNum(this);"/>

                    <div class="cancel_input" onclick="cancelInput(this)">X</div>
                </div>
                <div class="validate_data_img_container" onclick="showHover(this)">
                    <input type="file" size="1" onchange="loadImageChange(this)" class="file_prew file0"
                           name="pic_licence"
                           accept=".jpg,.png,.gif,.jpeg" capture="camera">
                    <img src="" class="img0">

                    <div class="validate_data_img_change">
                        <%--<div class="validate_data_img_box">--%>
                        <%--</div>--%><img src="/resource/images/pc_icon_camera.png" class="validate_data_img_box">
                        <div class="validate_data_img_text">
                            <span>上传驾驶证照片</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="validate_bottom_tips">
                <p>为保障出行安全，请务必填写本人的驾驶证资料，<br>
                    驾驶证号同时会作为实名信息进行验证 </p>
            </div>
        </div>
        <div class="validate_car_owner2" style="display: none">
            <div class="validate_data">
                <span class="validate_error_tips">请输入真实的身份证号码</span>

                <div class="validate_data_box">
                    <span>车牌号码</span>
                    <input type="text" placeholder="车牌号码" class="validate_input validate_car_number"
                           style="text-indent: 5rem"
                           maxlength="10" onchange="checkInput(this)">
                    <input type="text" id="demo2" placeholder="" class="validate_input validate_car_no" readonly=""
                           value="豫 A"/>

                    <div class="cancel_input" onclick="cancelInputDemo(this)">X</div>
                </div>
                <div class="validate_data_box">
                    <span>车辆所属人</span>
                    <input type="text" placeholder="填写车辆所有人名字" name="car_owner"
                           class="validate_input validate_car_belong" onchange="checkInput(this)"/>

                    <div class="cancel_input" onclick="cancelInput(this)">X</div>
                </div>
                <div class="validate_data_box">
                    <span>车辆品牌</span>
                    <input type="text" placeholder="车辆品牌信息" readonly="" class="validate_input validate_car_message"
                           onclick="showRightSlip()"/>

                    <div class="cancel_input" onclick="cancelInput(this)">X</div>
                </div>
                <div class="validate_data_box">
                    <span>行驶证上的注册日期</span>
                    <input type="text" readonly="" id="demo1" name="reg_date" data-lcalendar="2000-01-01,2030-01-29"
                           placeholder="参照行驶证上的注册信息" class="validate_input validate_car_register"
                           onchange="checkInput(this)"/>

                    <div class="cancel_input" onclick="cancelInput(this)">X</div>
                </div>
                <div class="validate_data_img_container" onclick="showHover(this)">
                    <input type="file" size="1" onchange="loadImageChange(this)" class="file_prew file1"
                           name="pic_licence2"
                           accept=".jpg,.png,.gif,.jpeg" capture="camera">
                    <img src="" class="img0">

                    <div class="validate_data_img_change">
                        <img src="/resource/images/pc_icon_camera.png" class="validate_data_img_box">
                        <div class="validate_data_img_text">
                            <span>上传行驶证照片</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="validate_bottom_tips">
                <p>为保障出行安全，请务必填写本人的驾驶证资料，<br>
                    驾驶证号同时会作为实名信息进行验证 </p>
            </div>
        </div>
        <input type="button" value="上一步" class="validate_submit validate_return_submit"
               onclick="returnFirstSkip(this)"/>
        <input type="submit" value="下一步" class="validate_submit validate_end_submit" onclick="checkMessage()"/>
    </form>


</div>
<div class="submit_container"></div>
<div class="right_slip_body" style="display: none">
    <ul class="right_slip_ul">
        <li class="right_slip_li hot_List">
            <div class="right_slip_top">
                <span>热门车辆品牌</span>
            </div>
            <div class="right_slip_container">
                <div class="hot_top"></div>

                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </li>
        <div class="clear car_type_list"></div>
    </ul>
    <ul class="right_flag" style="display: none">

    </ul>
    <ul class="right_slip2" style="display: none">
        <div class="right_slip2_container">

        </div>

    </ul>
    <ul class="right_slip3" style="display: none">
        <div class="right_slip3_container">

        </div>

    </ul>
</div>
</body>

</html>
