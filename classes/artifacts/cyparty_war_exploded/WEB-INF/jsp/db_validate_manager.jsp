<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 11:09
  describtion:后台管理--【实名认证】配置审核员
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
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

    .userManage_span {
        width: 21%;
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
        width: 20.6%;

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
        left: 48%;
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

    .icon_edit {
        right: 22px;
        left: auto !important;
        cursor: pointer;
        display: none;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        pageSet.setPageNumber();
        loadUser();
        $('.menu_context_li').removeClass('active_li');
        $('.db_validate_manager').addClass('active_li');
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

    });

    var global_cat_id;
    var check_click_search = 0;
    var click_type;
    var user_id;
    //ajax获取用户
    //封装传输的信息并提交
    function loadUser() {
        var obj = {};
        global_page = 0;
        obj.action = 'show';
        obj.size = size;
        obj.page = global_page;
        operation.operation_ajax('/db/api/validate_manager', obj, sendMessage);
    }
    //查找信息
    function findMessage() {
        var obj = {};
        var search = $('.search_user_input').val();
        obj.action = 'show';
        obj.keyword = search;
        obj.size = size;
        obj.page = global_page;
        operation.operation_ajax('/db/api/validate_manager', obj, sendMessage);
    }
    //删除信息
    function deleteSingle(item) {
        var obj = {};
        var id = $(item).parent().parent().attr('user_id');
        obj.action = 'delete';
        obj.id = id;
        operation.operation_ajax('/db/api/validate_manager', obj, loadUser);
    }
    function sendMessage() {
        $('.user_manage_container_li').remove();
        count = global_data.total;
        loadPage.checkUserPrivilege(count, insertUserMessage);
    }
    //添加审核员
    function addManage() {
        var obj = {};
        var name = $('.manage_username').val();
        var mobile = $('.manage_user_tell').val();
        var password = $('.manage_user_password').val();
        var description = $('.manage_user_remarks').val();
        obj.action = 'add';
        obj.name = name;
        obj.mobile = mobile;
        obj.password = password;
        obj.description = description;
        operation.operation_ajax('/db/api/validate_manager', obj, loadUser);
        removeManagerStyle();
    }
    //修改审核员
    function updateManage() {
        var obj = {};
        var name = $('.manage_username').val();
        var mobile = $('.manage_user_tell').val();
        var password = $('.manage_user_password').val();
        var description = $('.manage_user_remarks').val();
        if (password == "******") {
            password = ""
        }
        obj.action = 'update';
        obj.name = name;
        obj.mobile = mobile;
        obj.password = password;
        obj.description = description;
        obj.id = user_id;
        operation.operation_ajax('/db/api/validate_manager', obj, loadUser);
        removeManagerStyle();
    }
    function checkInputMessage() {
        if ($('.manage_username').val() == "") {
            showErrorTips("请输入审核员姓名")
        } else if ($('.manage_user_tell').val() == "") {
            showErrorTips("请输入审核员手机号")
        } else if ($('.manage_user_password').val() == "") {
            showErrorTips("请输入审核员密码")
        } else if ($('.manage_user_remarks').val() == "") {
            showErrorTips("请输入审核员备注")
        } else {
            if (click_type == 1) {
                addManage()
            } else {
                updateManage()
            }

        }
    }
    //添加用户数据
    function insertUserMessage() {
        $('.user_manage_container_li').remove();
        for (var i = 0; i < global_data.data.length; i++) {
            var mobile = global_data.data[i].mobile;//手机号
            var name = global_data.data[i].name;//名字
            var id = global_data.data[i].id;//id
            var last_login_time = global_data.data[i].last_login_time;//最后登录时间
            var description = global_data.data[i].description;//描述
            addUserDisplay(mobile, name, id, last_login_time, description);
        }
    }
    //添加用户列表
    function addUserDisplay(mobile, name, id, last_login_time, description) {
        $(".userManage_container_ul").append('<li class="user_manage_container_li" user_id=' + id + '>' +
                '<span class="userManage_span name">' + name + '</span>' +
                '<span class="userManage_span mobile">' + mobile + '</span>' +
                '<span class="userManage_span last_login_time">' + last_login_time + '</span>' +
                '<span class="userManage_span description">' + description + '</span>' +
//            '<div class="user_list_checklist_del_active" onclick="showDeleteTip(this)"></div>' +
                '<span class="change_box change_delete" onclick="showDeleteTip(this)">删除</span>' +
                '<span class="change_box change_edit" onclick="showEditTip(this)">编辑</span>' +
                '<div class="user_list_select_delete_tip all_tip">' +
                '<div class="detailAll_tip_txt">' +
                '<span>确认删除</span>' +
                '</div>' +
                '<span class="detailAll_tip_yes" onclick="deleteSingle(this)">确认</span>' +
                '<span class="detailAll_tip_no" onclick="hideDeleteTips(this)">取消</span>' +
                '<i class="popover_arrow popover_arrow_out"></i>' +
                '<i class="popover_arrow popover_arrow_in"></i>' +
                '</div>' +
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
        $('.user_list_drop_box_ul').hide();
        $('.user_list_container_message li').remove();
        global_page = 0;
        findMessage()
    }
    //添加审核员
    function addManagerStyle() {
//        event.preventDefault();
        click_type = 1;
        $('.manage_username').val('');
        $('.manage_user_tell').val('');
        $('.manage_user_password').val('');
        $('.manage_user_remarks').val('');
        $('.slide_container').animate({"top": "22%", "opacity": "1"}, 300);
        $('.slide_container_top').children('span').text('添加审核员账户');
        $('.submit_select_sure').text('添加');
        $('.icon_edit').hide();
    }
    //编辑审核员
    function showEditTip(obj) {
        click_type = 2;
        user_id = $(obj).parent().attr('user_id');
        $('.manage_username').val($(obj).parent().children('.name').text());
        $('.manage_user_tell').val($(obj).parent().children('.mobile').text());
        $('.manage_user_password').val('******').attr('readonly', 'readonly');
        $('.manage_user_remarks').val($(obj).parent().children('.description').text());
        $('.slide_container').animate({"top": "22%", "opacity": "1"}, 300);
        $('.slide_container_top').children('span').text('编辑审核员账户');
        $('.submit_select_sure').text('保存');
        $('.icon_edit').show();
    }
    function removeManagerStyle() {
        $('.slide_container').animate({"top": "-220%", "opacity": "0"}, 300);
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
        $(obj).children('.user_list_select_delete_tip').hide();
    }
    function changeReadonly(obj) {
        $('.manage_user_password').val('').removeAttr('readonly');
    }
</script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>审核员配置</span>

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
                <span class="add_span" onclick="addManagerStyle()"><span class="add_classify">+</span>添加审核员</span>

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
                <li class="userManage_container_li_top">
                    <span class="userManage_span">姓名</span>
                    <span class="userManage_span">手机号</span>
                    <span class="userManage_span">上次登陆时间</span>
                    <span class="userManage_span">备注</span>
                </li>
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
            <div class="clear"></div>
        </div>
        <%--审核员添加版面--%>
        <div class="slide_container">
            <div class="slide_container_top">
                <span>添加审核员账户</span>
            </div>
            <div class="slide_container_mid">
                <div class="input_list">
                    <img src="/resource/images/pc_icon_user.png"/>
                    <input type="text" placeholder="审核员姓名" class="input_style manage_username"/>
                </div>
                <div class="input_list">
                    <img src="/resource/images/pc_icon_tell.png"/>
                    <input type="text" placeholder="审核员手机号" class="input_style manage_user_tell"/>
                </div>
                <div class="input_list">
                    <img src="/resource/images/pc_icon_password.png"/>
                    <input type="text" placeholder="审核员密码" class="input_style manage_user_password"/>
                    <img src="/resource/images/pc_icon_edit.png" class="icon_edit" onclick="changeReadonly(this)"/>
                </div>
                <div class="input_list">
                    <img src="/resource/images/pc_icon_beihzu.png"/>
                    <input type="text" placeholder="审核员备注信息" class="input_style manage_user_remarks"/>
                </div>
                <div class="submit_select">
                    <span class="submit_select_span main_color submit_select_sure"
                          onclick="checkInputMessage()">添加</span>
                    <span class="submit_select_span main_color submit_select_not"
                          onclick="removeManagerStyle()">取消</span>

                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>