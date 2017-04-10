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
</style>
<script type="text/javascript">
    $(document).ready(function () {
        $('.menu_context_li').removeClass('active_li');
        $('.user_suggestion').addClass('active_li');
        loadUser();
        pageSet.setPageNumber();
//        // 绑定键盘按下事件
//        $(document).keypress(function (e) {
//            // 回车键事件
//            if (e.which == 13) {
//                jQuery('.search_ico').click();
//            }
//        });
//        //搜索重置page
//        $('.search_ico').click(function () {
//            global_page = 0;
//            findMessage();
//        });
    });
    var action_ul = '/api/app/user_suggestions';
    var status="";
    function loadUser() {
        var obj = {};
        obj.action = 'show';
        obj.size = size;
        obj.page = global_page;
        operation.operation_ajax(action_ul, obj, userMessage);
    }

    function userMessage() {
        count = global_data.total;
        loadPage.checkUserPrivilege(count, insertUserMessage);
    }
    function insertUserMessage() {
        $('.user_container').remove();
        for (var i = 0; i < global_data.data.length; i++) {
            var user_avatar = global_data.data[i].avatar;
            var user_mobile = global_data.data[i].mobile;
            var user_name = global_data.data[i].name;
            var user_time = global_data.data[i].create_time;
            var user_suggestion = global_data.data[i].content;
            var user_id = global_data.data[i].id;
            if (user_avatar == "") {
                user_avatar = "/resource/images/icon_people.png";
            }
            if(user_name ==""){
                user_name="匿名用户"
            }
            styleMessage(user_id, user_avatar, user_mobile, user_name, user_time, user_suggestion);
            if (i == global_data.data.length - 1) {
                $($('.user_container')[i]).addClass('user_container_last_child');
            }
        }
    }
    //样式布局
    function styleMessage(user_id, user_avatar, user_mobile, user_name, user_time, user_suggestion) {
        $(".not_find_message").before('<li class="user_container" index=' + user_id + '>' +
                '<div class="user_message">' +
                '<img src="' + user_avatar + '" class="user_avatar">' +
                '<span class="user_mobile">' + user_mobile + '</span>' +
                '<span class="user_name">' + user_name + '</span>' +
                '<span class="user_time">' + user_time + '</span>' +
                '</div>' +
                '<div class="user_content">' +
                '<p>' + user_suggestion + '</p>' +
                '</div>' +
                '<span class="delete_message" onclick="showDeleteTip(this)">删除</span>' +
                '<div class="user_list_select_delete_tip all_tip">' +
                '<div class="detailAll_tip_txt">' +
                '<span>确认删除</span>' +
                '</div>' +
                '<span class="detailAll_tip_yes" onclick="deleteSingle(this)">确认</span>' +
                '<span class="detailAll_tip_no" onclick="hideDeleteTips(this)">取消</span>' +
                '<i class="popover_arrow popover_arrow_out"></i>' +
                '<i class="popover_arrow popover_arrow_in"></i>' +
                '</div>' +
                '<div class="clear"></div>' +
                '</li>')
    }
    //查找数据
    function findMessage() {
        var status = $('.select_checkbox_active').children('.select_checkbox').attr('index');
        var obj = {};
        obj.action = 'show';
        obj.size = size;
        obj.page = global_page;
        obj.status=status;
        operation.operation_ajax(action_ul, obj, userMessage);
    }
    //删除信息
    function deleteSingle(item) {
        var obj = {};
        var id = $(item).closest('.user_container').attr('index');
        obj.action = 'delete';
        obj.id = id;
        operation.operation_ajax(action_ul, obj, loadUser);
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
    //选择标签
    function addTabStyle(obj) {
        if ($(obj).hasClass('select_checkbox_active')) {
            return false;
        } else {
            $('.select_checkbox_container').removeClass('select_checkbox_active');
            $(obj).addClass('select_checkbox_active');
        }
        findMessage()
    }
</script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>用户反馈</span>
                <%--<div class="search_user">--%>
                <%--<input type="text" placeholder="姓名、手机号" class="search_user_input">--%>
                <%--<a href="javascript:;" class="search_user_a">--%>
                <%--<div class="search_ico"></div>--%>
                <%--</a>--%>
                <%--</div>--%>
            </div>
        </div>
        <div class="userManage_container">
            <div class="clear"></div>
            <div class="sub_title_bar">
                <span class="sub_message"></span>
                <div class="publish_time_select">
                    <div class="select_checkbox_container  select_checkbox_active" onclick="addTabStyle(this)">
                        <span class="select_checkbox" index="">全部反馈</span>
                        <i class="select_popover_arrow"></i>
                    </div>
                    <div class="select_checkbox_container" onclick="addTabStyle(this)">
                        <span class="select_checkbox" index="1">IOS用户</span>
                        <i class="select_popover_arrow"></i>
                    </div>
                    <div class="select_checkbox_container" onclick="addTabStyle(this)">
                        <span class="select_checkbox" index="0">安卓用户</span>
                        <i class="select_popover_arrow"></i>
                    </div>
                </div>
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
                    <span class="page_set_number show_page">20</span>
                    <span class="page_set_style">条</span>
                    <ul class="page_set_ul">

                    </ul>
                    <div class="down1"></div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </div>
            <ul class="userManage_container_ul">
                <div class="not_find_message">
                    <img src="/resource/images/eat.gif" alt="">
                    <span>您所查询的信息被我吃光光了~~</span>
                </div>
                <div class="clear"></div>
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

                <div class="page_go" onclick="loadPage.checkPageTo();">
                    <span>跳转</span>
                </div>
                <div class="clear"></div>
            </div>
            <div class="page_set" onclick="pageSet.showPageSetDrop(this)" onmouseleave="pageSet.hidePageSet(this)">
                <span class="page_set_style">每页</span>
                <span class="page_set_number show_page">20</span>
                <span class="page_set_style">条</span>
                <ul class="page_set_ul">

                </ul>
                <div class="down1"></div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>