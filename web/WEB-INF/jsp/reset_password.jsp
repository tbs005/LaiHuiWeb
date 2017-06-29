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
<%--<link rel="stylesheet" type="text/css" href="/resource/css/input-style.css">--%>
<script src="/resource/js/md5-min.js"></script>
<style>
    .userManage_container {
        width: 902px;
        margin: 30px auto 0;
        min-height: 550px;
    }

    .change_container_li {
        position: relative;

    }

    input:focus {
        border: 1px #ccc solid;
    }

    .change_tips {
        float: left;
        width: 20%;
        margin: 20px 0;
        line-height: 40px;
        text-align: right;
        color: #777;
        font-size: 16px;
        display: inline-block;
    }

    .col-3 {
        float: left;
        width: 75%;
        margin: 20px 0 20px 20px;
        position: relative;
    }

    .change_container {
        width: 518px;
        float: left;
        padding: 10px 30px 30px 0;
        margin-right: 40px;
        border: 1px solid #e8e8e8;
        box-shadow: 2px 0px 10px 1px #e8e8e8;
    }

    .change_submit {
        display: inline-block;
        float: right;
        padding: 0px 18%;
        background-color: #f5ad4e;
        color: #fff;
        border-radius: 5px;
        line-height: 32px;
        height: 32px;
        font-size: 16px;
        margin-top: 10px;
        cursor: pointer;
    }

    .change_submit:hover {
        background-color: #FF8F0C;
    }

    .change_title {
        display: block;
        border-bottom: 1px solid #e8e8e8;
        line-height: 30px;
        padding-bottom: 10px;
        font-size: 16px;
        margin-left: 20px;
    }

    /*个人信息*/
    .change_container_left {
        float: left;
        width: 300px;
        margin-right: 40px;
        border: 1px solid #e8e8e8;
        box-shadow: 2px 0px 10px 1px #e8e8e8;
        /* padding: 10px; */
    }

    .change_img {
        float: left;
        width: 80px;
        padding: 5px;
        margin: 10px 0 0 10px;
    }

    .change_img img {
        width: 100%;
        border-radius: 50%;
    }

    .change_user {
        float: left;
        padding-top: 26px;
        padding-left: 10px;
        /* margin-right: 10px; */
    }

    .change_user_name {
        font-size: 16px;
        font-weight: bold;
        display: block;
    }

    .change_user_mobile {
        display: block;
        margin-top: 8px;
        color: #999;
    }

    .change_count {
        margin-top: 6px;
        padding: 10px 0;
    }

    .change_count_left {
        float: left;
        width: 50%;
        text-align: center;
        border-right: 1px solid #e8e8e8;
    }

    .change_count_title {
        display: block;
        line-height: 30px;
    }

    .all_count {
        color: #F5AD4E;
    }

    .today_count {
        color: #2ecc71;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        <c:if test="${manager !=null && manager.privilege==1}">
        loadUser()
        </c:if>
        <%--console.log("${manager.m_id}");--%>

        $('.menu_body').removeClass('open_menu_body');
        $('.menu_head').removeClass('current');
        $('.menu_body a').removeClass('change_menu');
        $('#personalConf_head').addClass('current');
        $('#personalConf_body').addClass('open_menu_body');
        $('#personalInfo_head').addClass('change_menu');

        $(".col-3 input").val("");
        $(".input-effect input").focusout(function () {
            if ($(this).val() != "") {
                $(this).addClass("has-content");
            } else {
                $(this).removeClass("has-content");
            }
        });
    });
//    function loadUser() {
//        var obj = {};
//        obj.action = 'show';
//        operation.operation_ajax('/api/db/editor/cumulate', obj, insertMessage);
//    }

//    function insertMessage() {
//        var name = global_data.data[0].name;
//        var mobile = global_data.data[0].mobile;
//        var all_count = global_data.data[0].all_count;
//        var day_count = global_data.data[0].day_count;
//
//        $('.all_count').text(all_count + "条");
//        $('.today_count').text(day_count + "条");
//        $('.change_user_name').text(name);
//        $('.change_user_mobile').text(mobile);
//    }
        function loadUser() {
            var obj = {};
            obj.m_id ="${manager.m_id}";
            operation.operation_ajax('/single/count', obj, insertMessage);
        }

        function insertMessage() {
            console.log(global_data);
            var all_count = global_data.all_count;
            var day_count = global_data.today_count;
            console.log(global_data.data);
            $('.all_count').text(all_count + "条");
            $('.today_count').text(day_count + "条");
        }
    function success() {
        window.location.href = "/db/login"
    }
    function checkNumber(obj) {
        if ($(obj).val().trim().length < 6) {
            showErrorTips("密码长度不能小于6位")
        } else if ($('.new_password1').val().trim() != "" && $('.new_password2').val().trim() != "") {
            if ($('.new_password1').val() != $('.new_password2').val()) {
                showErrorTips("两次输入密码不一致");
            }
        }
    }

    function submitCheck() {
        if ($('.new_password1').val().trim().length < 6) {
            showErrorTips("密码长度不能小于6位")
        } else if ($('.new_password2').val().trim().length < 6) {
            if ($('.new_password1').val() != $('.new_password2').val()) {
                showErrorTips("密码长度不能小于6位")
            }
        } else if ($('.new_password1').val().trim() != "" && $('.new_password2').val().trim() != "") {
            if ($('.new_password1').val() != $('.new_password2').val()) {
                showErrorTips("两次输入密码不一致");
            } else {
                var old_passWord = hex_md5($('.old_password').val());
                var new_passWord = hex_md5($('.new_password2').val());
                var obj = {};
                obj.action = 'reset_password';
                obj.old_password = old_passWord;
                obj.new_password = new_passWord;
                operation.operation_ajax('/db/auth/login', obj, success);
            }
        }
    }


</script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>个人信息</span>

            </div>
        </div>
        <div class="userManage_container">
            <div class="clear"></div>
            <div class="sub_title_bar">
                <span class="sub_message"></span>

                <div class="clear"></div>
            </div>
            <div class="change_box">
                <c:if test="${manager !=null && manager.privilege==1}">

                    <div class="change_container_left">
                        <div class="change_img">
                            <img src="/resource/images/icon_people.png">
                        </div>
                        <div class="change_user">
                            <span class="change_user_name"></span>
                            <span class="change_user_mobile"></span>
                        </div>
                        <div class="clear">
                        </div>
                        <div class="change_count">
                            <div class="change_count_left">
                                <span class="change_count_title">累计发布总数</span>
                                <span class="all_count"></span>
                            </div>
                            <div class="change_count_left">
                                <span class="change_count_title">今日发布总数</span>
                                <span class="today_count"></span>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </c:if>
                <ul class="change_container">
                    <span class="change_title">修改密码</span>
                    <li class="change_container_li input-effect">
                        <span class="change_tips">旧密码</span>

                        <div class="col-3 input-effect">
                            <input class="effect-19 old_password" type="password" placeholder="">
		            <span class="focus-border">
		            	<i></i>
		            </span>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li class="change_container_li input-effect">
                        <span class="change_tips">新密码</span>

                        <div class="col-3 input-effect">
                            <input class="effect-19 new_password1" type="password" index="1" placeholder="密码长度不小于6位"
                                   onchange="checkNumber(this)">
		            <span class="focus-border">
		            	<i></i>
		            </span>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li class="change_container_li input-effect">
                        <span class="change_tips">确认新密码</span>

                        <div class="col-3 input-effect">
                            <input class="effect-19 new_password2" type="password" index="2" placeholder="密码长度不小于6位"
                                   onchange="checkNumber(this)">
		            <span class="focus-border">
		            	<i></i>
		            </span>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <span class="change_submit" onclick="submitCheck()">保存</span>
                </ul>
                <div class="clear"></div>
            </div>

        </div>
    </div>

    <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>