<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/7/25
  Time: 15:06
  describtion:移动端--个人认证
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
  <title>实名认证</title>
  <script src="/resource/js/jquery-1.11.3.min.js" type="text/javascript"></script>
  <script src="/resource/js/style.js" type="text/javascript"></script>
  <link href="/resource/css/style.css" rel="stylesheet" type="text/css">
  <style type="text/css">
    .validate_top_tips{
      text-align: center;
      font-size: 1.4rem;
    }
    .validate_number{
      display: inline-block;
      float: left;
      width: 6%;
    }
    .validate_advice{
      display: inline-block;
      float: left;
      width: 94%;
    }
    .validate_success{
      text-align: center;
      font-size: 1.4rem;
    }
    .validate_success_name{
      font-size: 2.8rem;
      margin: 4rem 0 2rem;
    }
  </style>
  <script>
    $(document).ready(function(){
      changeFontSize();
      $('.validate_ID').val('410222199409230036')
    });
    var global_data;
    var array={};
    var token="7f5bfcb450e7425a144f3e20aa1d1a6e";
    //控制信息跳转
    var toValidateModule = function(){
      $('.validate_ordinary').hide();
      $('.validate_success').show();
      $('.validate_img').attr('src','/resource/images/pc_icon_validate_success.png');
      $('.validate_success_name').text($('.validate_name').val());
      $('.validate_success_ID').text(changeStr($('.validate_ID').val(),4,14));
    }
    //封装传输的信息并提交
    function sendMessage(){
      array.action='passenger';
      array.token=token;
      array.name=$('.validate_name').val();
      array.idsn=$('.validate_ID').val();
      validate.validate_submit('/api/auth/validate',array,toValidateModule);
    }
    //检车输入参数是否完整
    function checkMessage(){
        if($('.validate_name').val()==""){
          validate.showTips("姓名不能为空");
        }else if($('.validate_ID').val()==""){
          validate.showTips("身份证不能为空");
        }else{
          validate.hideTips();
          sendMessage();
        }
    }

    //替换身份信息
    function changeStr(str,start,end){
      //str:原始字符串，start,开始位置,end：结束位  置,changeStr:改变后的字
      var changeStr = "**********";
      return str.substring(0,start-1)+changeStr+str.substring(end,str.length);
    }

  </script>
</head>
<body>
<div class="validate_container">
  <div class="validate_logo" >
    <img src="/resource/images/pc_icon_ID.png" alt="" class="validate_img">
  </div>
  <form  method="post"  action="" onsubmit="return false" class="validate_ordinary">
    <div class="validate_top_tips">
      <p>请提交本人真实的身份信息，否则将无法获得平台提供的安全保障</p>
    </div>
    <div class="validate_data">
      <span class="validate_error_tips">请输入真实的身份证号码</span>
      <input type="text" placeholder="真实的姓名" class="validate_input validate_name" />
      <input type="text" maxlength="18" placeholder="身份证号" class="validate_input validate_ID" onchange="validate.onlyNum(this);"/>
    </div>
    <input type="submit" placeholder="提交审核" class="validate_submit" onclick="checkMessage()"/>
    <div class="validate_bottom_tips">
      <p><span class="validate_number">1.</span><span class="validate_advice">您填写的信息将同时默认为驾驶人信息，请谨慎填写</span></p>
      <div class="clear"></div>
      <p><span class="validate_number">2.</span><span class="validate_advice">如果您无大陆身份证或有其他疑问，请联系客服400-10086-10010</span></p>
      <div class="clear"></div>
    </div>
  </form>

  <div class="validate_success" style="display: none">
      <span class="validate_success_top">恭喜您实名认证成功</span>
      <div class="validate_success_name">
          <span></span>
      </div>
      <span class="validate_success_ID"></span>
  </div>
</div>

</body>
</html>
