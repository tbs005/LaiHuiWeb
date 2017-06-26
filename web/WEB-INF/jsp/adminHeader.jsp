<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 14:06
  describtion:网页头部信息
  To change this template use File | Settings | File Templates.
--%>
<%--<jsp:include flush="true" page="adminHeader.jsp"></jsp:include>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <title>来回拼车后台管理页面</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="/resource/images/pc_logo.ico"/>
  <link href="${pageContext.request.contextPath}/resource/css/pagination.css" rel="stylesheet" type="text/css">
  <script src="http://cdn.staticfile.org/jquery/2.0.0/jquery.min.js" type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/resource/js/jquery.pagination.js"></script>
  <script src="/resource/js/manage.js" type="text/javascript"></script>

  <!--引入wangEditor.css-->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/dist/css/wangEditor.min.css">
  <script type="text/javascript" src="${pageContext.request.contextPath}/resource/dist/js/wangEditor.min.js"></script>

  <link rel="stylesheet" href="/resource/css/bootstrap.min.css">
  <link href="/resource/css/manage_css.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="/resource/css/component.css"/>
  <style type="text/css">
    /*加载动画*/
    .loading_animation {
      margin: 0px auto;
      width: 150px;
      text-align: center;
      padding-top: 100px;
    }

    .loading_animation > div {
      width: 30px;
      height: 30px;
      background-color: #f5ad4e;
      border-radius: 100%;
      display: inline-block;
      -webkit-animation: bouncedelay 1.4s infinite ease-in-out;
      animation: bouncedelay 1.4s infinite ease-in-out;
      /* Prevent first frame from flickering when animation starts */
      -webkit-animation-fill-mode: both;
      animation-fill-mode: both;
    }
    .loading_animation .bounce1 {
      -webkit-animation-delay: -0.32s;
      animation-delay: -0.32s;
    }

    .loading_animation .bounce2 {
      -webkit-animation-delay: -0.16s;
      animation-delay: -0.16s;
    }

    @-webkit-keyframes bouncedelay {
      0%, 80%, 100% { -webkit-transform: scale(0.0) }
      40% { -webkit-transform: scale(1.0) }
    }

    @keyframes bouncedelay {
      0%, 80%, 100% {
        transform: scale(0.0);
        -webkit-transform: scale(0.0);
      } 40% {
          transform: scale(1.0);
          -webkit-transform: scale(1.0);
        }
    }
    .logo_title{
      padding: 14% 0 0;
      text-align: center;
      font-size: 75px;
      width: 200px;
      color: #D8D8D8;
      margin: 0 auto;
    }
    .logo_title_div1{
      float: left;
    }
    .logo_title_div2{
      float: right;
    }
    .fixed_menu{
      position: fixed;
      top: 48%;
      /* left: 10px; */
      background-color: #000;
      opacity: 0.5;
      border-radius: 0px 10px 10px 0px;
      padding: 5px;
      z-index: 100;
      display: none;
    }
    .fixed_menu img{
      width: 50px;
    }
    .footer{
      background: #fff;
      text-align: center;
      padding: 10px 0;
      color: #999;
      position: absolute;
      bottom: 0;
      width: 100%;
      font-size: 12px;
    }
    #large-header-container{
      position: relative;
      height: 100%;
      width: 100%;
    }

  </style>
  <link href="/resource/css/manage_auto.css" rel="stylesheet">
  <script src="/resource/js/loadingTop.js" type="text/javascript"></script>
  <script>
    $(document).ready(function(){
      NProgress.start();
      NProgress.done();
      $('.error_message_tip_yes').click(function(){
        $(this).parent().hide();
      })
    });

    $('.error_message_tip_yes').click(function(){
      $(this).parent().hide();
    });

    var menu=0;
    //加载图片设置
    function lazyImg(){
      $(".lazy").lazyload({
        effect : "fadeIn"
      });
    }
    function showMenu(obj){
      if ($(obj).hasClass('menu_style_active')) {
        $(obj).removeClass('menu_style_active');
        $(obj).children('img').attr('src','/resource/images/pch_icon_menu_style.png');
        $('.ui_left').animate({'left':'-300px'},300);
        $(obj).animate({'left':'0px'},300);

      } else {
        $(obj).addClass('menu_style_active');
        $(obj).children('img').attr('src','/resource/images/pc_icon_white_return.png');

        $('.ui_left').animate({'left':'0px'},300);
        $(obj).animate({'left':'209px'},300);

      }

    }
  </script>

<body>
<div class="header">
  <div class="header_container">
    <a href="/">
      <div class="header_logo">
        <img src="/resource/images/pc_logo.png" alt="来回拼车">
      </div>
      <div class="header_name">
        <span>来回拼车</span>
      </div>
    </a>
    <div class="header_right">
      <div class="header_user">
        <img src="/resource/images/icon_people.png" alt=""/>
        <span>${manager.name}</span>
      </div>
      <div class="header_exit">
        <a href="/db/logout">退出</a>
      </div>
      <div class="clear"></div>
    </div>
    <div class="clear"></div>
  </div>
</div>

<div class="error_message_tip">
  <span class="error_message">服务器异常</span>
  <span class="error_message_tip_yes">确认</span>
</div>

  <span class="error_animate_tips">error_tips</span>

<div class="loading_animation">
  <div class="bounce1"></div>
  <div class="bounce2"></div>
  <div class="bounce3"></div>
</div>
<div class="logo_title">
  <div class="logo_title_div1">来</div>
  <div class="logo_title_div2">回</div>
  <div class="clear"></div>
</div>

<div class="fixed_menu" onclick="showMenu(this)">
  <img src="/resource/images/pch_icon_menu_style.png">
</div>
<style>
  *{margin:0;padding:0;}
  .tishi{width:200px;height:130px;border:1px solid #aaaaaa;overflow: hidden;
    position:fixed;top:100%;right:50px;
    display: none;
    z-index: 10000;
  }
  .tishi_must{width:200px;height:130px;border:1px solid #aaaaaa;overflow: hidden;
    position:fixed;top:100%;right:50px;
    display: none;
    z-index: 10000;
  }
  .tishi_m{padding:5px;background:#63a35c;text-align: center;}
  .caoZuo button{padding:2px 10px;margin:0 10px;background: #AEDEF4;border-radius: 5px;cursor: pointer;}
  .tishi>p:nth-child(2){padding:10px;}
  .xiangQing:hover{background:#00E080;}
  .close_t:hover{background:#DF6A10;}
</style>
<body>
<div class="tishi">
  <p class="tishi_m">消息提醒</p>
  <p>您有<span class="count">2</span>条新的消息</p>
  <div class="caoZuo" style="text-align: center;margin:20px 0">
    <button class="xiangQing" onclick="chakan()">查 看</button>
    <button class="close_t" onclick="close_t1()">取 消</button>
  </div>
</div>
<div class="tishi_must"><%--必达车单提示消息--%>
  <p class="tishi_m">消息提醒</p>
  <p>您有<span class="count_must"></span>条必达车单尚未处理</p>
  <div class="caoZuo" style="text-align: center;margin:20px 0">
    <button class="xiangQing" onclick="chakan_must()">查 看</button>
    <button class="close_t" onclick="close_must()">取 消</button>
  </div>
</div>
<%--<script src="js/jquery-1.11.3.min.js"></script>--%>
<script>
    function open_t(){
        $('.tishi').show();
        $('.tishi').animate({"top":"82%"},1000);

    }

    function close_t1() {
        $('.tishi').hide();
    }

    function chakan() {
        window.location.href="/db/driver/check";
        close_t1();
    }

    function read() {
        var privilege = 0;
        privilege = ${manager.privilege};
        $.ajax({
            type: 'POST',
            url: '/validate/count',
            data: {},
            dataType: 'json',
            success: function (data) {
                if(privilege ==5 &&data.result.count>0){
                    $('.count').html(data.result.count);
                    open_t();
                }else{
                    close_t1();
                }
            }
        });
    }
    read();
    setInterval(function () {
        read();
    },120000);
    /*必达车单操作*/
    function open_must(){
        $('.tishi_must').show();
        $('.tishi_must').animate({"top":"82%"},1000);

    }

    function close_must() {
        $('.tishi_must').hide();
    }

    function chakan_must() {
        window.location.href="/db/must_arrive";
        close_must();
    }

    function read_must() {
        var privilege = 0;
        privilege = ${manager.privilege};
        $.ajax({
            type: 'POST',
            url: '/arrive/unhandle',
            data: {},
            dataType: 'json',
            success: function (data) {
                if(privilege ==5 &&data.result.count>0){
                    $('.count_must').html(data.result.count);
                    open_must();
                }else{
                    close_must();
                }
            }
        });
    }
    read_must();
    setInterval("read_must()",60000);

</script>