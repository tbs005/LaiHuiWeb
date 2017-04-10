<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/9/30
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<script src="/resource/js/jquery.zclip.min.js" type="text/javascript"></script>
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<style>
  .userManage_container {
    width: 902px;
    margin: 30px auto 0;
    min-height: 550px;
  }

  #container {
    margin: 10px 0;
    color: #f5ad4e;
    cursor: pointer;
    display: inline-block;
  }

  #container img {
    width: 24px;
    position: relative;
    top: -2px;
  }


  .userManage_container_ul {
    margin-top: 20px;
  }

  /*订单*/
  .pay_top_left{
    float: left;
    width: 50%;
    padding: 0 10px;
  }
  .pay_top_right{
    float: left;
    width: 50%;
    padding: 0 10px;
  }
  .pay_top_type{
    border-left: 4px solid #f5ad4e;
    padding-left: 10px;
    font-size: 16px;
  }
  .pay_top_list{
    line-height: 32px;
    padding-left: 20px;
  }
  .pay_avatar{
    width: 40px;
    height: 40px;
    border: 1px solid #e8e8e8;
    border-radius: 50%;
    padding: 2px;
    background: #fff;
  }
  .pay_avatar_name{
    display: inline-block;
    margin-left: 10px;
    word-spacing: 10px;
    letter-spacing: 10px;
  }

  /*订单列表*/
  .pay_info{
    margin-top: 20px;
    border: 2px dashed #e8e8e8;
    padding: 10px 20px;
  }
  .pay_info_left{
    float: left;
    font-weight: bold;
    font-size: 14px;
    line-height: 32px;
  }
  .pay_info_no{
    font-weight: 100;
  }
  .pay_info_right{
    float: right;
    font-weight: bold;
    line-height: 32px;
  }
  .pay_info_no{
    font-weight: 100;
  }
  .pay_info_title{
    line-height: 32px;
    border-bottom: 1px solid #D2D2D2;
    font-weight: bold;
    /* padding: 0 10px; */
    margin-top: 20px;
  }
  .s1{
    display: inline-block;
    width: 70%;
  }
  .s2{
    display: inline-block;
    width: 10%;
    text-align: right;
  }
  .s3{
    display: inline-block;
    width: 14%;
    text-align: right;
  }
  .pay_info_bottom{
    float: right;
    width: 18%;
    margin-top: 60px;
    font-weight: bold;
    margin-bottom: 14px;
  }
  .pay_info_bottom_style{
    display: inline-block;
    width: 70%;
    text-align: right;
    float: right;
    /* font-weight: bold; */
    padding-right: 10px;
    /* margin-left: 20px; */
    border-bottom: 1px solid #e8e8e8;
  }
  .pay_info_list{
    line-height: 40px;
  }
  .pay_text_car{
    border: 1px solid #e8e8e8;
    padding: 2px 8px;
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
</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    checkId();
    $('.menu_context_li').removeClass('active_li');
    $('.pay_list').addClass('active_li');
    $('#container').click(function () {
      history.go(-1)
    })
  });

  var global_cat_id;
  var url = window.location.href;
  var order_id;
  //判断是否是修改信息
  function checkId() {
    var order_id = url.split('order_id=')[1].split('&end')[0];
    var action_url = "/api/pay";
    $('.right_top_style').children('span').text('流水详情');
    updateMessage(order_id,action_url);
  }

  //查找信息
  function updateMessage(order_id,action_url) {
    var obj = {};
    obj.action = 'show_info';
    obj.id = order_id;
    operation.operation_ajax(action_url, obj, insertUserMessage);
  }

//  添加信息
  function insertUserMessage(){
//      乘客信息
    var p_name = global_data.passengerObject.name;
    var p_mobile = global_data.passengerObject.mobile;
    var p_avatar = global_data.passengerObject.avatar;
    $('.p_name').text(p_name);
    $('.p_mobile').text(p_mobile);
    $('.p_avatar').attr('src',p_avatar);
//    司机信息
    var d_name=global_data.driverObject.name;
    var d_car_no=global_data.driverObject.car_no;
    var d_mobile=global_data.driverObject.mobile;
    var d_car_brand=global_data.driverObject.car_brand;
    var d_car_color=global_data.driverObject.car_color;
    var d_car_type=global_data.driverObject.car_type;
    var d_avatar=global_data.driverObject.avatar;
    $('.d_name').text(d_name);
    $('.d_car_no').text(d_car_no);
    $('.d_mobile').text(d_mobile);
    $('.d_car_brand').text(d_car_brand);
    $('.d_car_color').text("( "+d_car_color+" )");
    $('.d_car_type').text(d_car_type);
    $('.d_avatar').attr('src',d_avatar);

    //订单信息
    var pay_create_time=global_data.recordObject.create_time;
    var pay_trade_no=global_data.recordObject.trade_no;
    var pay_cash=global_data.recordObject.cash;
    var pay_booking_seats=global_data.dataObject.booking_seats;
    var pay_order_create_time=global_data.dataObject.order_create_time;

    var pay_boarding_province=global_data.dataObject.boarding_point.province;
    var pay_boarding_city=global_data.dataObject.boarding_point.city;
    var pay_boarding_address=global_data.dataObject.boarding_point.address;
    var pay_boarding_name=global_data.dataObject.boarding_point.name;

    var pay_breakout_province=global_data.dataObject.breakout_point.province;
    var pay_breakout_city=global_data.dataObject.breakout_point.city;
    var pay_breakout_address=global_data.dataObject.breakout_point.address;
    var pay_breakout_name=global_data.dataObject.breakout_point.name;

    $('.pay_create_time').text(pay_create_time);
    $('.pay_order_create_time').text(pay_order_create_time);
    $('.pay_trade_no').text(pay_trade_no);
    $('.pay_cash').text("￥ "+pay_cash);
    $('.pay_booking_seats').text(pay_booking_seats);
    $('.pay_boarding').text(pay_boarding_province+" "+pay_boarding_city+pay_boarding_address+" "+pay_boarding_name);
    $('.pay_breakout').text(pay_breakout_province+" "+pay_breakout_city+pay_breakout_address+" "+pay_breakout_name);
  }
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>订单详情</span>
      </div>
    </div>
    <div class="userManage_container">
      <div id="container">
        <img src="/resource/images/pc_return_before.png">
        <span>返回上一层</span>
      </div>

      <div class="clear"></div>
      <ul class="userManage_container_ul">
        <div class="pay_top_container">
          <div class="pay_top_left">
            <p class="pay_top_type">乘  客</p>
            <div class="pay_top_list">
              <img src="/resource/images/icon_people.png" class="pay_avatar p_avatar">
              <span class="pay_avatar_name p_name"></span>
            </div>
            <div class="pay_top_list">
              <span class="pay_top_title">联系电话：<span class="pay_text p_mobile"></span></span>
            </div>
          </div>
          <div class="pay_top_right">
            <p class="pay_top_type">司  机</p>
            <div class="pay_top_list">
              <img src="/resource/images/icon_people.png" class="pay_avatar d_avatar">
              <span class="pay_avatar_name d_name"></span>
            </div>
            <div class="pay_top_list">
              <span class="pay_top_title">联系电话：<span class="pay_text d_mobile"></span></span>
            </div>
            <div class="pay_top_list">
              <span class="pay_text pay_text_car d_car_no"></span>
              &nbsp;
              <span class="pay_text d_car_type"></span>
              &nbsp;
              <span class="pay_text d_car_brand"></span>
              <span class="pay_text d_car_color"></span>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        <div class="pay_info">
          <div class="pay_info_left">
            订单号：<span class="pay_info_no pay_trade_no"></span>
          </div>

          <div class="pay_info_right">
            支付时间：<span class="pay_info_no pay_create_time"></span>
          </div>
          <div class="pay_info_right" style="margin-right: 30px">
            车单创建时间：<span class="pay_info_no pay_order_create_time"></span>
          </div>
          <div class="clear"></div>
          <div class="pay_info_title">
            <span class="s1">路线信息</span>
            <span class="s2">订座数量</span>
            <span class="s3">单价</span>
          </div>
          <div class="pay_info_list">
            <span class="s1">
              <span class="pay_boarding"></span>
              <b style="color: #222">  至  </b>
               <span class="pay_breakout"></span>
            </span>
            <span class="s2 pay_booking_seats"></span>
            <span class="s3 pay_cash" ></span>
          </div>
          <div class="pay_info_bottom">
            <span>总计</span>
            <span class="pay_info_bottom_style pay_cash"></span>
          </div>
          <div class="clear"></div>
        </div>
        <div class="clear"></div>
      </ul>
    </div>
  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
