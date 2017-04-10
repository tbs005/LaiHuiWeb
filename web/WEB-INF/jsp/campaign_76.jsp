<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 11:09
  describtion:后台管理--【资金管理】76人烩面
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<%--瀑布引入--%>
<script src="/resource/js/masonry/masonry.pkgd.min.js" type="text/javascript"></script>
<style>
    .userManage_container {
        width: 902px;
        margin: 30px auto 0;
        min-height: 550px;
    }

    .userManage_container_ul {
        border: 1px solid #e8e8e8;
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

    /*列表容器*/
    .car_list {
        border: 1px solid #e8e8e8;
        float: left;
        width: 270px;
        cursor: pointer;
        margin-right: 30px;
        margin-bottom: 30px;
    }

    .car_list:hover {
        box-shadow: 2px 2px 10px 2px #e8e8e8;
    }

    .car_list_container_message {
        width: 106%;
        min-height: 400px;
    }

    .car_list_message {
        padding: 10px;
    }

    .car_list_message_tittle {
        font-size: 18px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        margin-bottom: 8px;
    }

    .car_list_down_left {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        height: 30px;
        position: relative;
        line-height: 30px;
    }
    .car_list_down_left_detail {
        position: relative;
        line-height: 30px;
        border-top: 2px dashed #e8e8e8;
        border-bottom: 2px dashed #e8e8e8;
    }

    .car_list_down_img {
        width: 24px;
        position: relative;
        line-height: 24px;
        top: -2px;
    }

    .car_list_down_span {
        display: inline-block;
        margin-left: 5px;
    }

    .update_message {
        position: absolute;
        right: 10px;
        top: 0px;
        z-index: 10;
        color: #fff;
        background: #f5ad4e;
        padding: 2px 5px;
        cursor: pointer;
    }

    .update_message:hover {
        background-color: #FF8F0c;
    }

    /*新改动*/
    .money {
        color: #f5ad4e;
    }

    .order_button {
        color: #FFFFFF;
        background: #f5ad4e;
        text-align: center;
        display: block;
        border-radius: 4px;
    }

    .order_button:hover {
        background-color: #FF8F0c;
    }

    .order_span {
        color: #f5ad4e;
        float: right;
    }

    .order_span:hover {
        color: #FF8F0c;
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

    /*下拉模版开始*/
    .slide_container {
        position: fixed;
        top: -220%;
        right: 0;
        left: 0;
        margin: 0 auto;
        opacity: 0;
        width: 340px;
        border: 1px solid #e8e8e8;
        background-color: #fff;
        box-shadow: 2px 2px 6px #e8e8e8;
        z-index: 100;
    }

    .slide_container_top {
        text-align: center;
        margin: 14px 0;
        font-size: 16px;
        /*position: relative;*/
    }

    .input_list {
        padding: 0px 14px;
        position: relative;
    }

    .input_list img {
        position: absolute;
        top: 10px;
        left: 20px;
        width: 20px;
    }

    .input_style {
        text-indent: 32px;
    }

    .submit_select {
        padding: 0 14px;
        margin-bottom: 20px;
    }

    .submit_select_span {
        background-color: #f5ad4e;
        color: #fff;
        float: right;
        display: inline-block;
        width: 140px;
        text-align: center;
        line-height: 32px;
        height: 32px;
        border-radius: 5px;
        cursor: pointer;
    }
    .submit_select_span:hover{
        background-color: #f5ad4e;
    }
    .submit_select_not {
        margin-right: 30px;
    }
    .slide_container_top_remove{
        position: absolute;
        right: 0;
        top: 6px;
        font-size: 24px;
        color: #999;
        width: 40px;
        cursor: pointer;
    }
    .slide_container_top_remove:hover{
        color: #f5ad4e;
    }
    .input_list {
        padding: 0px 14px;
        position: relative;
    }

    .input_list img {
        position: absolute;
        top: 10px;
        left: 20px;
        width: 20px;
    }
    .input_style{
        border: 1px solid #e8e8e8;
        width: 100%;
        height: 40px;
        line-height: 40px;
        border-radius: 6px;
        margin-bottom: 20px;
        font-size: 14px;
        text-indent: 32px;
    }
    /*下拉模版结束*/
</style>
<script type="text/javascript">
    $(document).ready(function () {
        loadUser();
        pageSet.setPageNumber();
        $('.menu_context_li').removeClass('active_li');
        $('.campaign_76').addClass('active_li');
        // 绑定键盘按下事件
        $(document).keypress(function (e) {
            // 回车键事件
            if (e.which == 13) {
                jQuery('.search_ico').click();
            }
        });
//        搜索重置page
        $('.search_ico').click(function () {
            global_page = 0;
            findMessage();
        });
        $('.user_list_drop_box').mouseleave(function () {
            $('.user_list_drop_box_ul').hide();
        });
        $("#datepicker").datetimepicker({
            changeMonth: true,
            changeYear: true
        });
        $("#datepicker2").datetimepicker({
            changeMonth: true,
            changeYear: true
        });
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

        $('#masonry').masonry({
            itemSelector: '.item',
            isAnimated: true
        });
    });
    var menu_type = 0;
    var action = 'show';
    var action_url = '/api/campaign/76';
    var size = 30;
    var page_array = [15, 30, 60, 120];
    var order_id;
    var start_time = "";
    var end_time = "";


    //封装传输的信息并提交
    function loadUser() {
        var obj = {};
        obj.action = action;
        obj.size = size;
        obj.page = global_page;
        operation.operation_ajax(action_url, obj, sendMessage);
    }
    function sendMessage() {
        $('.car_list').remove();
        var count = global_data.total;
        loadPage.checkUserPrivilege(count, insertUserMessage);
    }
    function findMessage() {
        var obj = {};
        var search = $('.search_user_input').val();
        var start_time = $('.select_start_time ').val();
        var end_time = $('.select_end_time ').val();
        menu_type = $('.select_checkbox_active').attr('index');
        obj.action = action;
        obj.keyword = search;
        obj.start_time = start_time;
        obj.end_time = end_time;
        obj.size = size;
        obj.page = global_page;
        obj.type = menu_type;
        operation.operation_ajax(action_url, obj, sendMessage);
    }

    //添加数据
    function insertUserMessage() {
        $('#masonry').masonry('destroy');
        for (var i = 0; i < global_data.slides.length; i++) {
            var buyer_description = global_data.slides[i].buyer_description;
            var buyer_mobile = global_data.slides[i].buyer_mobile;
            var data = global_data.slides[i].data;
            var total_price = global_data.slides[i].total_price;
            var buyer_location = global_data.slides[i].buyer_location;
            var deliver_name = global_data.slides[i].deliver_name;
            var create_time = global_data.slides[i].create_time;
            var buyer_name = global_data.slides[i].buyer_name;
            var id = global_data.slides[i].id;
            var deliver_number = global_data.slides[i].deliver_number;
            var data_obj = JSON.parse(data);
            var data_message="";

            for(var j = 0; j<data_obj.data.length;j++){
                var name = data_obj.data[j].name;
                var price = data_obj.data[j].price;
                var number = data_obj.data[j].number;
                data_message+="</br>&#12288;"+name+": "+number+"&#12288;单价("+price+")";
            }
            carListStyle(deliver_number,id,buyer_description, buyer_mobile, data_message, total_price, buyer_location, deliver_name, create_time,buyer_name);

            if(buyer_description==""){
                $($('.buyer_description')[i]).hide();
            }

            if(menu_type=="1"){
                $($('.order_button_left')[i]).hide();
            }

        }

        $('#masonry').masonry({
            itemSelector: '.item',
            isAnimated: true
        });
    }
    //添加车主列表
    function carListStyle(deliver_number,id,buyer_description, buyer_mobile, data_message, total_price, buyer_location, deliver_name, create_time,buyer_name) {
        $('.not_find_message').before('<li class="item car_list" car_id="'+id+'">' +
            '<div class="car_list_message">' +
            '<div class="car_list_down">' +
            '<div class="car_list_down_left">' +
            '<img class="car_list_down_img" src="/resource/images/pc_icon_user.png" alt="姓名">' +
            '<span class="car_list_down_span">'+buyer_name+'</span>' +
            '</div>' +
            '<div class="car_list_down_left">' +
            '<img class="car_list_down_img" src="/resource/images/pc_icon_tell.png" alt="电话">' +
            '<span class="car_list_down_span">'+buyer_mobile+'</span>' +
            '</div>' +
            '<div class="car_list_down_left money">' +
            '<img class="car_list_down_img" src="/resource/images/pc_cash_money.png" alt="金额">' +
            '<span class="car_list_down_span">总计'+total_price+'元</span>' +
            '</div>' +
            '<div class="car_list_down_left">' +
            '<span style="color:#999">收货地址：'+buyer_location+'</span>' +
            '</div>' +
            '<div class="car_list_down_left">' +
            '<span style="color:#999">创建时间：'+create_time+'</span>' +
            '</div>' +
            '<div class="car_list_down_left_detail">' +
            '<span style="color:#999">订单详情：'+data_message+'</span>' +
            '</div>' +
            '<div class="car_list_down_left buyer_description">' +
            '<span style="color:#999">备注信息：'+buyer_description+'</span>' +
            '</div>' +
            '<div class="car_list_down_left order_button_left" style="margin-top: 10px;">' +
            '<span class="order_button" onclick="addManagerStyle(this)">确认发货</span>' +
            '</div>' +
            '<div class="clear"></div>' +
            '</div>' +
            '</div>' +
            '</li>')
    }

    //选择标签
    function addTabStyle(obj) {
        if ($(obj).hasClass('select_checkbox_active')) {
            return false;
        } else {
            $('.select_checkbox_container').removeClass('select_checkbox_active');
            $(obj).addClass('select_checkbox_active');
        }
        findMessage();
    }

    function checkInputMessage() {
        if ($('.slide_userName').val() == "") {
            showTips("请输入单号")
        } else if ($('.slide_userPassword').val() == "") {
            showTips("请输入物流")
        } else {
            addMessage();
        }
    }
    function addMessage() {
        var obj = {};
        obj.id = order_id;
        obj.action = "update";
        obj.deliver_name = $('.deliver_number').val();
        obj.deliver_number = $('.deliver_name').val();
        operation.operation_ajax(action_url, obj, loadUser);
    }
    //添加下滑
    function addManagerStyle(obj){
        $('.slide_container').animate({"top":"22%","opacity":"1"},300);
        $('.slide_container_top').find('.slide_container_top_title').text("填写发货信息");
        $('.submit_select_sure').text('保存');
        $('.input_style').val('');
        order_id = $(obj).closest('.car_list').attr('car_id');
    }
    function removeManagerStyle() {
        $('.slide_container').animate({"top": "-220%", "opacity": "0"}, 300);
        $('.input_style').val("");
    }
</script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>76人烩面--订单管理</span>
                <div class="search_user">
                    <input type="text" placeholder="姓名、手机号" class="search_user_input">
                    <a href="javascript:;" class="search_user_a">
                        <div class="search_ico"></div>
                    </a>
                </div>
            </div>
        </div>
        <div class="userManage_container">
            <div id="container"></div>
            <div class="user_list_drop_box">
                <input id="datepicker" name="publish_time" placeholder="选择开始时间" class="select_time select_start_time"
                       onchange="findMessage()">
            </div>
            <div class="user_list_drop_box">
                <input id="datepicker2" name="publish_time" placeholder="选择结束时间" class="select_time select_end_time"
                       onchange="findMessage()">
            </div>

            <div class="clear"></div>
            <div class="sub_title_bar">
                <span class="sub_message"></span>
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
                <div class="publish_time_select">
                    <div class="select_checkbox_container  select_checkbox_active" index="0" onclick="addTabStyle(this)">
                        <span class="select_checkbox" >未发货</span>
                        <i class="select_popover_arrow"></i>
                    </div>
                    <div class="select_checkbox_container" index="1" onclick="addTabStyle(this)">
                        <span class="select_checkbox" >已发货</span>
                        <i class="select_popover_arrow"></i>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <%--列表信息--%>
            <div id="masonry">
                <ul class="container-fluid car_list_container_message">

                    <div class="not_find_message">
                        <img src="/resource/images/eat.gif" alt="">
                        <span>您所查询的信息被我吃光光了~~</span>
                    </div>
                    <div class="clear"></div>
                </ul>
            </div>
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
        <%--下滑表单--%>
        <div class="slide_container">
            <div class="slide_container_top">
                <div class="slide_container_top">
                    <span class="slide_container_top_title">添加用户</span>
                    <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
                </div>
            </div>
            <div class="slide_container_mid">
                <div class="input_list">
                    <img src="/resource/images/pc_icon_beihzu.png"/>
                    <input type="text" placeholder="订单号" class="input_style deliver_number"/>
                </div>
                <div class="input_list">
                    <img src="/resource/images/pc_icon_car.png"/>
                    <input type="text" placeholder="物流" class="input_style deliver_name"/>
                </div>
                <div class="submit_select">
                    <span class="submit_select_span main_color submit_select_sure" onclick="checkInputMessage()">添加</span>

                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
