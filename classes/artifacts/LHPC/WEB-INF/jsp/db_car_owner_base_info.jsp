<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 11:09
  describtion:后台管理--【用户管理】车主自行发布详情页面
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<style>
    .userManage_container {
        width: 902px;
        margin: 30px auto 0;
        min-height: 550px;
    }

    .userManage_container_ul {
        width: 50%;
        box-shadow: 2px 2px 10px 0px #e8e8e8;
        padding: 10px;
        /*border: 1px solid #e8e8e8;*/
    }

    .driver_container_ul {
        width: 101%;
        padding: 10px;
    }

    .userManage_container_li_top {
        background-color: #f4f5f9;
    }

    .userManage_container_li_top span {
        width: 140px;
    }

    .userManage_span {
        width: 16%;
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
        right: 0;
        top: 2px;
        display: none;
    }

    /*user_list_select_delete_tip*/
    .user_list_select_delete_tip {
        position: absolute;
        top: 37px;
        display: none;
        right: -54px;
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

    /*微信列表*/
    .weixin_conyainer {
        padding: 5px;
        float: left;
        width: 90%;
        margin-top: 20px;
        margin-left: 30px;
    }

    .weixin_conyainer_left {
        float: left;
        width: 66px;
        margin-right: 10px;
    }

    .weixin_conyainer_left img {
        width: 100%;
        border-radius: 50%;
        max-height: 66px;
    }

    .weixin_conyainer_right {
        float: left;
        width: 72%;
    }

    .weixin_username {
        font-size: 16px;
        margin-bottom: 16px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .weixin_mobile {
        margin-bottom: 4px;
        display: inline-block;
    }

    .weixin_count {
        display: inline-block;
        margin-left: 20px;
    }

    .mobile_style {
        color: #999;
        margin-left: 8px;
    }

    .count_style {
        color: #2ecc71;
        margin-left: 8px;
    }

    .driver_title {
        border-left: 4px solid #f5ad4e;
        padding-left: 8px;
    }

    .sub_message {
        margin-top: 20px;
    }

    /*列表样式*/
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
    }

    .publish_no_tags_title {
        color: #e74c3c;
    }

    .publish_no_tags_context {
        border: 1px solid #e74c3c;
        padding: 2px 8px;
        margin-right: 10px;
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
        padding: 10px;
        border: 1px solid #e8e8e8;
        margin-bottom: 20px;
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
        margin-left: 20px;
        border-radius: 50%;
        margin-right: 10px;
        position: relative;
        top: -2px;
    }

    /*列表结束*/
</style>
<script type="text/javascript">
    $(document).ready(function () {
        pageSet.setPageNumber();
        loadUser();
        // 绑定键盘按下事件
        $(document).keypress(function (e) {
            // 回车键事件
            if (e.which == 13) {
                jQuery('.search_ico').click();
            }
        });
        //搜索重置page
        $('.search_ico').click(function () {
            global_page = 0;
            findMessage();
        });
        $('.user_list_drop_box').mouseleave(function () {
            $('.user_list_drop_box_ul').hide();
        });
        $("#datepicker").datetimepicker();
        $("#datepicker2").datetimepicker();
        $.datepicker.regional['zh-CN'] = {
            clearText: '清除', clearStatus: '清除已选日期',
            closeText: '关闭', closeStatus: '不改变当前选择',
            prevText: '上月', prevStatus: '显示上月',
            nextText: '下月', nextStatus: '显示下月',
            currentText: '今天', currentStatus: '显示本月',
            monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                '七月', '八月', '九月', '十月', '十一月', '十二月'],
            monthNamesShort: ['一', '二', '三', '四', '五', '六',
                '七', '八', '九', '十', '十一', '十二'],
            monthStatus: '选择月份', yearStatus: '选择年份',
            weekHeader: '周', weekStatus: '年内周次',
            dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
            dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
            dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],
            dayStatus: '设置 DD 为一周起始', dateStatus: '选择 m月 d日, DD',
            dateFormat: 'yy-mm-dd', firstDay: 1,
            initStatus: '请选择日期', isRTL: false
        };
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
    });

    var global_cat_id;
    var check_click_search = 0;
    var action_url = "/api/car_owner/cumulate";
    var page_array=[15,30,60,90,120];
    var url = window.location.href;
    var item_id = url.split("?id=")[1];
    item_id = item_id.split("&")[0];
    var source=1;
    //ajax获取用户
    //封装传输的信息并提交
    function loadUser() {
        var obj = {};
        obj.action = 'show_info';
        obj.size = size;
        obj.page = global_page;
        obj.user_id = item_id;
        operation.operation_ajax(action_url, obj, sendMessage);
    }
    function sendMessage() {
        $('.drive_li_container').remove();
        $('.weixin_conyainer').remove();
        var total = global_data.count;
        loadPage.checkUserPrivilege(total, insertUserMessage);
    }
    function findMessage() {
        var obj = {};
        obj.action = 'show_info';
        obj.user_id = item_id;
        obj.size = size;
        obj.page = global_page;
        operation.operation_ajax(action_url, obj, sendMessage);
    }
    //删除信息
    //删除信息
    function deleteSingle(item) {
        var obj = {};
        var id = $(item).closest('.drive_li_container').attr('index');
        obj.action = 'delete';
        obj.id = id;
        obj.source = source;
        operation.operation_ajax("/api/db/departure", obj, loadUser);
    }
    //添加用户数据
    function insertUserMessage() {
        $('.user_manage_container_li').remove();
        var user_avatar = global_data.user_avatar;
        var user_id = global_data.user_id;
        var user_mobile = global_data.user_mobile;
        var user_name = global_data.user_name;
        var count = global_data.count;
        if(user_avatar==""){
            user_avatar="/resource/images/icon_people.png";
        }
        addUserStyle(user_avatar, user_id, user_mobile, user_name, count);
        insertDriverListMessage();
    }
    //添加用户列表
    function addUserStyle(user_avatar, user_id, user_mobile, user_name, count) {
        $(".userManage_container_clear").before('<li class="weixin_conyainer" index=' + user_id + '>' +
                '<div class="weixin_conyainer_left">' +
                '<img src=' + user_avatar + '>' +
                '</div>' +
                '<div class="weixin_conyainer_right">' +
                '<div class="weixin_username">' +
                '<span>' + user_name + '</span>' +
                '</div>' +
                '<div class="weixin_mobile">' +
                '<span>手机号</span>' +
                '<span class="mobile_style">' + user_mobile + '</span>' +
                '</div>' +
                '<div class="weixin_count">' +
                '<span>发车总数</span>' +
                '<span class="count_style">' + count + '条</span>' +
                '</div>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</li>')
    }
    //显示下拉
    function showAddToUserDrop(obj) {
        $(obj).children('.user_list_drop_box_ul').toggle();
    }
    //点击下拉列表
    function selectedCatDropList(obj) {
        $('.select_error_message').hide();
        $(obj).parent().parent().children('.user_list_drop_box_span').text($(obj).text()).attr('cat_id', $(obj).attr('cat_id'));
        $(obj).parent().hide();
        global_page = 0;
        findMessage();
    }

    //单元删除提示
    function showDeleteTip(obj) {
        $(obj).parent().children('.user_list_select_delete_tip').fadeIn();
    }
    //隐藏删除信息
    function hideDeleteTips(obj) {
        $(obj).parent().hide();
    }
    function hideDeleteTip(obj) {
        $(obj).children('.user_list_select_delete_tip').hide()
    }


    //添加用户数据
    function insertDriverListMessage() {
        for (var i = 0; i < global_data.data.length; i++) {
            var driving_name = global_data.data[i].driving_name;//车主姓名
            var info_status = global_data.data[i].info_status;//状态信息1：有空位；2：已满；-1：已取消
            var start_time = global_data.data[i].start_time;//开始时间
            var end_time = global_data.data[i].end_time;//结束时间
            var mobile = global_data.data[i].mobile;//手机号
            var departure_city = global_data.data[i].departure_city;//出发城市
            var destination_city = global_data.data[i].destination_city;//目的城市
            var departure = global_data.data[i].departure;//出发小城
            var destination = global_data.data[i].destination;//目的小城市
            var description = global_data.data[i].description;//描述信息
            var tag_yes_content = global_data.data[i].tag_yes_content;//yes标签
            var tag_no_content = global_data.data[i].tag_no_content;//no标签
            var points = global_data.data[i].points;//地点
            var inits_seats = global_data.data[i].inits_seats;//可用座位
            var car_brand = global_data.data[i].car_brand;//车辆品牌
            var id = global_data.data[i].id;//id
            var publish_time = global_data.data[i].create_time;//id

            if (info_status == 1) {
                info_status = "有空位"
            } else if (info_status == 2) {
                info_status = "已满"
            } else {
                info_status = "已取消"
            }


            var insert_time = start_time.split(":")[0] + ":" + start_time.split(":")[1] + "-" + end_time.substring(11, 16);
            addUserDisplay(driving_name, info_status, insert_time, mobile, departure_city, destination_city,
                    description, inits_seats, car_brand, id, publish_time, departure, destination);

            var array_points = points.split("丶");
            for (var j = 0; j < array_points.length; j++) {
                $($('.publish_route_box')[i]).append('<li class="publish_route_box_li">' +
                        '<span class="publish_route_box_li_span">' + array_points[j] + '</span>' +
                        '<div class="line_container">' +
                        '<div class="line_slide"></div>' +
                        '<div class="line_circle"></div>' +
                        '</div>' +
                        '</li>')
            }
            if (departure == "") {
                $($('.begin_city')[i]).hide();
            }
            if (destination == "") {
                $($('.end_city')[i]).hide();
            }
            if (tag_yes_content == "") {
                $($('.publish_yes_tags_box')[i]).hide();

            } else {
                //yes标签
                $($('.publish_yes_tags_box')[i]).show();
                var array_yes = tag_yes_content.split("丶");
                for (var j = 0; j < array_yes.length; j++) {
                    $($('.publish_yes_tags_container')[i]).append('<span class="publish_yes_tags_context">' + array_yes[j] + '</span>');
                }
            }
            if (tag_no_content == "") {
                $($('.publish_no_tags_box')[i]).hide();

            } else {
                //no标签
                $($('.publish_no_tags_box')[i]).show();
                var array_no = tag_no_content.split("丶");
                for (var k = 0; k < array_no.length; k++) {
                    $($('.publish_no_tags_container')[i]).append('<span class="publish_no_tags_context">' + array_no[k] + '</span>');
                }
            }

            //进行非空判断

            if (driving_name == "") {
                $($('.driver_detail_driver_set')[i]).hide();
            }
            if (description == "") {
                $($('.driver_detail_remark')[i]).hide();
            }
            if (car_brand == "") {
                $($('.driver_type')[i]).hide();
            }
            if (points == "") {
                $($('.driver_detail_route')[i]).hide();
            }

        }
    }
    //添加用户列表
    function addUserDisplay(driving_name, info_status, insert_time, mobile, departure_city, destination_city,
                            description, inits_seats, car_brand, id, publish_time, departure, destination) {
        $(".not_find_message").before('<li class="drive_li_container" index=' + id + ' >' +
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
                '<div class="inline_block driver_type">' +
                '<img src="/resource/images/pc_icon_car.png" class="driver_type_img">' +
                '<span class="driver_type_span driver_car_type">' + car_brand + '</span>' +
                '</div>' +
                '<div class="inline_block driver_seat">' +
                '<img src="/resource/images/pc_icon_seat.png" class="driver_type_img">' +
                '<span class="driver_type_span driver_type_seat">' + inits_seats + '个座位</span>' +
                '</div>' +
                '<div class="drive_could_use">' +
                '<img src="/resource/images/pc_icon_tags.png" class="driver_use_img">' +
                '<span class="driver_use_span">' + info_status + '</span>' +
                '</div>' +
                '</div>' +
                '<div class="driver_detail_route">' +
                '<span class="publish_tittle_box_span" style="float:left ">途径路线</span>' +
                '<ul class="publish_route_box">' +

                '</ul>' +
                '<div class="clear"></div>' +
                '</div>' +
                '<div class="driver_detail_remark">' +
                '<span>备注信息：</span>' +
                '<span style="color: #999" class="driver_description">' + description + '</span>' +
                '</div>' +
                '<div class="drive_li_tags">' +
                '<div class="publish_yes_tags_box">' +
                '<span class="publish_tags_title">YES标签：</span>' +
                '<div class="publish_tags_container publish_yes_tags_container">' +

                '</div>' +
                '</div>' +
                '<div class="publish_no_tags_box">' +
                '<span class="publish_no_tags_title">N&nbsp;O标签：</span>' +
                '<div class="publish_tags_container publish_no_tags_container">' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="driver_detail_message">' +
                '<div class="driver_detail_driver driver_detail_driver_set">' +
                '<span>车主姓名：</span>' +
                '<span style="color: #999" class="driving_car_name">' + driving_name + '</span>' +
                '</div>' +
                '<div class="driver_detail_driver">' +
                '<span>联系电话：</span>' +
                '<span style="color: #999" class="driving_car_mobile">' + mobile + '</span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '<div class="driver_detail_publish">' +
                '<span>发布时间：</span>' +
                '<span style="color: #999" class="driving_car_publish">' + publish_time + '</span>' +
                '</div>' +
                '<div class="driver_detail_option">' +
                '<span class="driver_detail_option_href" onclick="toHref(this)">车单详情</span>' +
                '<span class="driver_detail_option_QQ" onclick="addManagerStyle(this)">生成文字信息</span>' +
                '<span class="driver_detail_option_edit" onclick="toEdit(this)">编辑</span>' +
                '<span class="driver_detail_option_delete" onclick="showDeleteTip(this)">删除</span>' +
                '<div class="user_list_select_delete_tip all_tip">' +
                '<div class="detailAll_tip_txt">' +
                '<span>确认删除</span>' +
                '</div>' +
                '<span class="detailAll_tip_yes" onclick="deleteSingle(this)">确认</span>' +
                '<span class="detailAll_tip_no" onclick="hideDeleteTips(this)">取消</span>' +
                '<i class="popover_arrow popover_arrow_out"></i>' +
                '<i class="popover_arrow popover_arrow_in"></i>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</li>'
        )
    }

    //跳转前端车单详情
    function toHref(obj){
        var li_index = $(obj).parent().parent().parent().attr('index');
        window.location.href="http://pinchenet.com/laihui/car/detail?id=" + li_index;
    }
    //生成文字信息
    function addManagerStyle(obj) {
        $('#message_container').empty();
        addCopyMessageStyle();
//        $('.find_route').show();
//        $('.find_type').show();
//        $('.find_discript').show();
        click_type = 1;
        var li = $(obj).parent().parent().parent();
        var driver_route_start = li.find('.driver_route_start').text();
        var driver_route_end = li.find('.driver_route_end').text();
        var driver_time_year = li.find('.driver_time_year').text();
        var driver_car_type = li.find('.driver_car_type').text();
        var driver_type_seat = li.find('.driver_type_seat').text();
        var driver_use_span = li.find('.driver_use_span').text();
        var driver_description = li.find('.driver_description').text();
        var driving_car_mobile = "点击下方链接查看详情  ";
        var driving_route = li.find('.publish_route_box_li_span');
        var publish_no_tags_context = li.find('.publish_no_tags_context');
        var publish_yes_tags_context = li.find('.publish_yes_tags_context');
        var driving_car_name = li.find('.driving_car_name').text();
        var driving_id = li.attr('index');
        var driver_begin_city = li.find('.begin_city').text();
        var driver_end_city = li.find('.end_city').text();
        for (var i = 0; i < driving_route.length; i++) {
            $('.find_route_span').append('<span>' + $(driving_route[i]).text() + '</span>' +
                    '<span class="last_route_span">、</span>')
        }
        for (var i = 0; i < publish_yes_tags_context.length; i++) {
            $('.find_discript_span').append($(publish_yes_tags_context[i]).text()+
                    '<span class="last_yes_span">、</span>')
        }
        for (var i = 0; i < publish_no_tags_context.length; i++) {
            $('.find_discript_span').append($(publish_no_tags_context[i]).text() +
                    '<span class="last_no_span">、</span>')
        }

        $($('.last_route_span')[$('.last_route_span').length - 1]).remove();
        if (driver_description == "") {
            if ($('.last_no_span').length == 0) {
                $($('.last_yes_span')[$('.last_yes_span').length - 1]).remove()
            } else {
                $($('.last_no_span')[$('.last_no_span').length - 1]).remove()
            }
        }
        if (driver_begin_city != "") {
            driver_begin_city = "(" + driver_begin_city + ")";
        }
        if (driver_end_city != "") {
            driver_end_city = "(" + driver_end_city + ")";
        }

        $('.slide_container').animate({"top": "22%", "opacity": "1"}, 300);
        $('.find_city_span').text(driver_route_start + driver_begin_city + "至" + driver_route_end + driver_end_city);
        $('.find_time_span').text(driver_time_year);
        $('.find_seat_span').text(driver_type_seat);
        $('.find_type_span').text(driver_car_type);
        $('.find_tell_span').text(driving_car_mobile);
        $('.find_discript_span').append(driver_description);
        $('.find_href_span').text("http://pinchenet.com/laihui/car/detail?id=" + driving_id);

        if ($('.find_route_span').text() == "" || $('.find_route_span').text() == "、") {
            $('.find_route').remove()
        }
        if ($('.find_type_span').text() == "") {
            $('.find_type').remove()
        }
        if ($('.find_discript_span').text() == "") {
            $('.find_discript').remove()
        }
        var str = $('#message_container').text().replace(/\s/g, '').replace(/【/g, "\n【");
        var result= str.split("【时间】")[1].substring(0,10);
        var result1= str.split("【时间】")[1].substring(10);
        var resultAll = str.split("【时间】")[0]+"【时间】"+result +" "+ result1;
        $("#message_copy").zclip({
            path: '/resource/js/ZeroClipboard.swf',
            copy: resultAll,
            afterCopy: function () {
                $("#message_container").css("background-color", 'fafafa');
                showErrorTips("复制成功");
                removeManagerStyle();
            }
        });

    }

    //添加文本信息样式
    function addCopyMessageStyle() {
        $('#message_container').append('<span style="display: inline-block;padding: 6px;">【来回拼车】牵起你生活中的每一次来回</span>'+
                '<div class="input_list find_city">' +
                '<div class="input_list_left">' +
                '<span>【找人】</span>' +
                '</div>' +
                '<div class="input_list_right">' +
                '<span class="find_city_span"></span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '<div class="input_list find_time">' +
                '<div class="input_list_left">' +
                '<span>【时间】</span>' +
                '</div>' +
                '<div class="input_list_right">' +
                '<span class="find_time_span"></span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '<div class="input_list find_route">' +
                '<div class="input_list_left">' +
                '<span>【路线】</span>' +
                '</div>' +
                '<div class="input_list_right">' +
                '<span class="find_route_span"></span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '<div class="input_list find_seat">' +
                '<div class="input_list_left">' +
                '<span>【空位】</span>' +
                '</div>' +
                '<div class="input_list_right">' +
                '<span class="find_seat_span"></span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '<div class="input_list find_type">' +
                '<div class="input_list_left">' +
                '<span>【车型】</span>' +
                '</div>' +
                '<div class="input_list_right">' +
                '<span class="find_type_span"></span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '<div class="input_list find_tell">' +
                '<div class="input_list_left">' +
                '<span>【电话】</span>' +
                '</div>' +
                '<div class="input_list_right">' +
                '<span class="find_tell_span"></span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '<div class="input_list find_discript">' +
                '<div class="input_list_left">' +
                '<span>【备注】</span>' +
                '</div>' +
                '<div class="input_list_right">' +
                '<span class="find_discript_span"></span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>' +
                '<div class="input_list find_href">' +
                '<div class="input_list_left">' +
                '<span>【链接】</span>' +
                '</div>' +
                '<div class="input_list_right">' +
                '<span class="find_href_span"></span>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</div>')
    }

    function removeManagerStyle() {
        $('.slide_container').animate({"top": "-220%", "opacity": "0"}, 300);
    }
    //获取点击id并跳转
    function getId(obj) {
        var user_id = $(obj).parent().attr("car_id");
        window.location.href = "/db/validate/info?id=" + user_id;
    }

    function toEdit(obj) {
        var id = $(obj).closest('.drive_li_container').attr('index');
        window.location.href = "/db/driver/departure?id=" + id;
    }
    //出发路线
    function loadStartRoute() {
        var obj = {};
        obj.action = 'departure';
        obj.user_id = item_id;
        operation.operation_ajax("/db/pch/route", obj, startRouteLi);
    }
    //结束路线
    function loadEndRoute(departure) {
        var obj = {};
        obj.action = 'departure';
        obj.departure = departure;
        obj.user_id = item_id;
        operation.operation_ajax("/db/pch/route", obj, endRouteLi);
    }
    function startRouteLi() {

        for (var i = 0; i < global_data.data.length; i++) {
            $('.publish_start_slide_ul').append('<li class="publish_slide_li publish_start_slide_li" index=' + i + ' onclick="selectStyleTagsLi(this)">' + global_data.data[i].departure + '</li>')
        }
    }
    function endRouteLi() {
        $('.publish_end_slide_li').remove();
        for (var i = 0; i < global_data.data.length; i++) {
            $('.publish_end_slide_ul').append('<li class="publish_slide_li publish_end_slide_li" index=' + i + ' onclick="selectTagsLi(this)">' + global_data.data[i].destination + '</li>')
        }
    }
    //选择开始出发城市，进行数据交互
    function selectStyleTagsLi(obj) {
        global_page = 0;
        $('.publish_end_city').text("选择目的城市").attr('index', "");
        $(obj).parent().parent().children('.publish_slide_text').text($(obj).text()).attr('index', $(obj).attr('index'));
        loadEndRoute($(obj).text());
        findMessage();
    }

    //查找信息
//    function findMessage() {
//        var obj = {};
//        var search = $('.search_user_input').val();
//        var departure_city = $('.publish_start_city').text().trim();
//        var destination_city = $('.publish_end_city').text().trim();
//        var start_time = $('.select_start_time ').val();
//        var end_time = $('.select_end_time ').val();
//        var status = $('.publish_status').attr('index');
//        flag = $('.select_checkbox_active').children('.select_checkbox').attr('index');
//        if (departure_city == "选择出发城市" || departure_city == "全部") {
//            departure_city = ""
//        }
//        if (destination_city == "选择目的城市" || destination_city == "全部") {
//            destination_city = ""
//        }
//        obj.action = 'show';
//        obj.user_id = item_id;
//        obj.keyword = search;
//        obj.size = size;
//        obj.page = global_page;
//        obj.departure_city = departure_city;
//        obj.destination_city = destination_city;
//        obj.start_time = start_time;
//        obj.end_time = end_time;
//        obj.status = status;
//        obj.flag = flag;
//        operation.operation_ajax(action_url, obj, sendMessage);
//    }
    //查找信息
//    function updateMessage(item_start, item_end) {
//        var obj = {};
//        var departure_city = item_start;
//        var destination_city = item_end;
//
//        if (departure_city == "选择出发城市") {
//            departure_city = ""
//        }
//        if (destination_city == "选择目的城市") {
//            destination_city = ""
//        }
//        obj.action = 'show';
//        obj.user_id = item_id;
//        obj.size = size;
//        obj.page = global_page;
//        obj.departure_city = departure_city;
//        obj.destination_city = destination_city;
//        operation.operation_ajax(action_url, obj, sendMessage);
//
//    }


//    //显示下拉
//    function showTagsUl(obj) {
//        $(obj).children('.publish_slide_ul').toggle();
//    }
    function selectTagsLi(obj) {
        global_page = 0;
        $(obj).parent().parent().children('.publish_slide_text').text($(obj).text()).attr('index', $(obj).attr('index'));
        findMessage()
    }
//    //选择标签
//    function addTabStyle(obj) {
//        if ($(obj).hasClass('select_checkbox_active')) {
//            return false;
//        } else {
//            $('.select_checkbox_container').removeClass('select_checkbox_active');
//            $(obj).addClass('select_checkbox_active');
//        }
//        findMessage()
//    }
</script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>用户管理</span>

                <div class="search_user">
                    <input type="text" placeholder="姓名、手机号" class="search_user_input">
                    <a href="javascript:;" class="search_user_a">
                        <div class="search_ico"></div>
                    </a>
                </div>
            </div>
        </div>
        <div class="userManage_container">
            <div class="clear"></div>

            <ul class="userManage_container_ul">
                <div class="driver_title">
                    <span>车主基本信息</span>
                </div>
                <div class="clear userManage_container_clear"></div>
            </ul>
            <span class="sub_message"></span>

            <div class="sub_title_bar">

                <div class="page_box">
                    <div class="page_prev" onclick="loadPage.pagePrev()">
                        <div class="arrow prev_arrow"></div>
                    </div>
                    <div class="page_number">
                        <span class="page_current"></span>
                        <span>/</span>
                        <span class="page_content"></span>
                    </div>
                    <div class="page_next" onclick="loadPage.pageNext()">
                        <div class="arrow next_arrow"></div>
                    </div>
                    <input type="text" class="page_input_number">

                    <div class="page_go" onclick="loadPage.checkPageTo()">
                        <span>跳转</span>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="page_set" onclick="pageSet.showPageSetDrop(this)" onmouseleave="pageSet.hidePageSet(this)">
                    <span class="page_set_style">每页</span>
                    <span class="page_set_number show_page">30</span>
                    <span class="page_set_style">条</span>
                    <ul class="page_set_ul">

                    </ul>
                    <div class="down1"></div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </div>

            <ul class="driver_container_ul">

                <div class="not_find_message">
                    <img src="/resource/images/eat.gif" alt="">
                    <span>车主发布信息被我吃光光了~~</span>
                </div>
                <div class="clear driver_container_clear"></div>
            </ul>
        </div>
        <%--分页加载--%>
        <div class="page_container">
            <div class="page_box">
                <div class="page_prev" onclick="loadPage.pagePrev()">
                    <div class="arrow prev_arrow"></div>
                </div>
                <div class="page_number">
                    <span class="page_current"></span>
                    <span>/</span>
                    <span class="page_content"></span>
                </div>
                <div class="page_next" onclick="loadPage.pageNext()">
                    <div class="arrow next_arrow"></div>
                </div>
                <input type="text" class="page_input_number">

                <div class="page_go" onclick="loadPage.checkPageTo()">
                    <span>跳转</span>
                </div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
        <%--下拉面--%>
        <div class="slide_container">
            <div class="slide_container_top">
                <span>文字信息</span>
                <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
            </div>
            <div class="slide_container_mid" id="message_container">

            </div>
            <div class="submit_select">
                <span class="submit_select_span main_color submit_select_not" id="message_copy">复制并关闭</span>

                <div class="clear"></div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>