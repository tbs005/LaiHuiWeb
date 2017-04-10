<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/7/12
  Time: 9:50
  describtion:后台管理--登录界面
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>来回拼车-后台管理页面</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <script src="/resource/js/md5-min.js"></script>
    <script src="/resource/js/jquery-1.11.3.min.js"></script>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            -webkit-box-sizing: border-box;
        }

        body {
            background: #fff;
            -webkit-font-smoothing: antialiased;
            font-family: "\5FAE\8F6F\96C5\9ED1" !important;
            margin: 0 auto !important;
            position: relative;
            color: #333;
        }
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0px 1000px white inset;
        }
        .login_top{
            background-color: #f5ad4e;
            height: 300px;
            width: 100%;
        }
        .login_form{
            width: 400px;
            padding: 20px 40px 40px 40px;
            background-color: #fafafa;
            border-radius: 18px;
            position: relative;
            margin:0 auto;
            z-index: 5;
            top: -170px;
            font-size: 16px;
            border: 1px solid #ccc;
        }
        .login_form_logo{
            width: 200px;
            background-size: 200px;
            margin: 0 auto;
        }
        .login_form_tittle{
            font-size: 20px;
            color: #f5ad4e;
            text-align: center;
            font-weight: bold;
            margin-bottom: 40px;
            margin-top: 15px;
        }
        /*.login_form_logo img{*/
        /*width: 100px;*/
        /*}*/
        .login_input{
            width: 100%;
            height: 44px;
            border: 2px solid #f5ad4e;
            outline: none;
            text-indent: 40px;
            border-radius: 5px;
            font-size: 16px;
        }
        .login_form_user{
            position: relative;
            margin-bottom: 30px;
        }
        .login_form_password{
            position: relative;
            margin-bottom: 40px;
        }
        .icon_left{
            position: absolute;
            top: 12px;
            left: 12px;
            width: 20px;
        }
        .login_submit_btn{
            font-size: 16px;
            color: white;
            background-color: #f5ad4e;
            width: 100%;
            border: none;
            line-height: 38px;
            border-radius: 5px;
            cursor: pointer;
        }
        .login_input:focus{
            border: 2px solid #FF8F0C;
        }
        .login_submit_btn:hover{
            background-color: #FF8F0C;
            color: white;
        }
        .login_user_tips {
            position: absolute;
            top: -26px;
            left: 0;
            color: #ea6523;
            display: none;
        }
        .login_error_tips {
            position: absolute;
            top: -30px;
            left: 0;
            color: #ea6523;
            cursor: pointer;
        }
        .error_tips{
            position: absolute;
            top: -30px;
            left: 0;
            color: #ea6523;
            cursor: pointer;
            display: none;
        }
        .login_other_mode{
            position: relative;
            text-align: center;
            margin-bottom: 20px;
        }
        .other_mode_line{
            top: 13px;
            width: 100%;
            border-top: 1px solid #A9A9A9;
            position: absolute;
        }
        .login_other_mode_span{
            display: inline-block;
            background-color: #fafafa;
            padding: 2px 10px;
            z-index: 1;
            position: relative;
            color: #A9A9A9;
        }
        .icon_style{
            width: 40px;
            border-radius: 50%;
            display: block;
            margin: 10px auto;
        }
        .login_other_mode_a{
            display: inline-block;
        }
        .logo_header {
            width: 100%;
            display: inline-block;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){

            $('.login_input').change(function(){
                $('.login_user_tips').hide();
            });

            $('.error_message_tip_yes').click(function(){
                $(this).parent().hide();
            });

        });
        //ajax验证帐号密码
        var global_returnJson;
        var identity_type=0;
        function displayErrorMsg(errorMsg)
        {
            $('.error_message_tip').fadeIn();
            $('.error_message').text(errorMsg);
        }

        //登陆验证
        function loginCheck() {
            var user = $('.login_input').val();
            var passWord = hex_md5($('.login_input_password').val().trim());
            var login_user_span = $('.login_form_user').children('.login_user_tips');
            var login_pasw_span = $('.login_form_password').children('.login_user_tips');
            console.log(passWord);
            if (user == null || user == "") {
                login_user_span.show().text("").text("用户名不能为空！");
                $('.login_error_tips').hide();
                $('.error_tips').hide();
                return false;
            } else if (passWord == null || passWord == "" || passWord=="d41d8cd98f00b204e9800998ecf8427e") {
                login_pasw_span.show().text("").text("密码不能为空！");
                $('.login_error_tips').hide();
                $('.error_tips').hide();
                return false;
            } else {
                toLogin(user,passWord);
                return true;
            }
        }

        function toLogin(user,passWord){
            $.ajax({
                type: "POST",
                url: "/db/auth/login",
                data: {action:"check",mobile: user, password: passWord},
                dataType: "json",
                success: function (data) {
                    if (data.status == true) {
                        window.location.href="/db/user_list";//验证成功后转向
                    } else {
                        $('.error_tips').show();
                    }
                },
                error: function (data) {
                    displayErrorMsg("网络错误")
                }
            })
        }
    </script>
</head>
<body>
<div class="login_container">
    <div class="login_top"></div>
    <div class="login_form">
        <div class="login_form_logo">
            <img src="/resource/images/pch_share_logo.png" class="logo_header">
        </div>
        <div class="login_form_tittle"><span>后&nbsp;&nbsp;台&nbsp;&nbsp;管&nbsp;&nbsp;理</span></div>
        <form method="post" id="form_login" onsubmit="return false" action="/">

            <div class="login_form_user">
                <span class="error_tips">用户名或密码错误</span>
                <img src="/resource/images/pc_icon_user.png" class="icon_left"/>
                <input type="text" placeholder="请输入用户名" class="login_input login_input_user" name="user_name">
                <span class="login_user_tips"></span>
            </div>
            <div class="login_form_password">
                <img src="/resource/images/pc_icon_password.png" class="icon_left"/>
                <input type="password" placeholder="请输入密码" class="login_input login_input_password" name="password">
                <span class="login_user_tips"></span>
            </div>
            <div class="login_submit">
                <input type="submit" value="登陆" class="btn login_submit_btn" onclick="loginCheck()">
            </div>
        </form>
    </div>
</div>
</body>
</html>