<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/3
  Time: 11:09
  describtion:后台管理--【拼车信息会】车主微信自行发布信息列表
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

  .userManage_container_li_top {
    background-color: #f4f5f9;
  }

  .userManage_span {
    width: 18%;
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
    width: 17.6%;

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

  /*添加线路模版*/
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

  .change_find {
    background-color: #1abc9c;
  }

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

    border: 1px solid #e8e8e8;
    margin-bottom: 20px;
  }
  .drive_li_container_top{
    padding: 10px 10px 0 10px;
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

  .driver_detail_option_edit, .driver_detail_option_delete, .driver_detail_option_QQ ,.driver_detail_option_href{
    padding: 2px 8px;
    background-color: #F5AD4E;
    color: #fff;
    border-radius: 5px;
    display: inline-block;
    margin-right: 20px;
    line-height: 24px;
    cursor: pointer;
  }
  .driver_detail_option_href{
    background-color: #3498db;
  }
  .driver_detail_option_href:hover{
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
    line-height: 30px;
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
  .find_discript_span{
    display: inline-block;
  }
  .driving_car_avatar{
    width: 30px;
    height: 30px;
    /*margin-left: 20px;*/
    border-radius: 50%;
    margin-right: 10px;
    position: relative;
    top: -2px;
  }
  /*乘客信息*/
  .passenger_container{
    border-top: 2px dashed #e8e8e8;
    margin-top: 10px;
    padding: 10px 10px;
    background-color: #f3f3f3;
  }
  .passenger_message_box{
    line-height: 30px;
  }

</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
//    loadStartRoute();
    checkId();
    $('.menu_context_li').removeClass('active_li');
    $('.passenger_booking_orders').addClass('active_li');
    // 绑定键盘按下事件
    $(document).keypress(function (e) {
      // 回车键事件
      if (e.which == 13) {
        jQuery('.search_ico').click();
      }
    });
    //  搜索重置page
    $('.search_ico').click(function () {
      global_page = 0;
      findMessage();
    });
    $('.user_list_drop_box').mouseleave(function () {
      $('.user_list_drop_box_ul').hide();
    });
    $('.publish_slide').mouseleave(function () {
      $('.publish_slide ul').hide();
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
//    loadWXUser();
  });

  var global_cat_id;
  var check_click_search = 0;
  var flag = 1;
  var click_type;
  var user_id;
  var action_url = "/api/db/passenger/booking_orders";
  var url = window.location.href;
  var source=1;
  //判断是否是修改信息
  function checkId() {
    if (url.indexOf("=") == -1) {
      loadList();
    } else {
      var departure_city = url.split('departure_city=')[1].split('&destination_city')[0];
      var destination_city = url.split('destination_city=')[1].split('&end')[0];
      departure_city = decodeURI(departure_city);
      destination_city = decodeURI(destination_city);
      updateMessage(departure_city, destination_city);
      $('.publish_start_city').text(departure_city).attr('index', 0);
      $('.publish_end_city').text(destination_city).attr('index', 0);
    }
  }
  //加载微信统计数据
  function loadWXUser(){
    var obj={};
    obj.action='driver_departure_count';
    operation.operation_ajax2("/api/wx_user/cumulate",obj,madeLine);
  }
  //生成统计折线图
  function madeLine(){
    var time_array = [];
    var count=[];
    for(var i=0;i<global_data.data.length;i++){
      time_array.push(global_data.data[i].date);
      count.push(global_data.data[i].count)
    }
    //添加数据折线
    $('#container').highcharts({                   //图表展示容器，与div的id保持一致
      chart: {
        type: 'line'                         //指定图表的类型，默认是折线图（line）
      },
      title: {
        text: '微信车主发布信息数据'      //指定图表标题
      },
      xAxis: {
        categories: time_array   //指定x轴分组
      },
      yAxis: {
        title: {
          text: '单位/条'                  //指定y轴的标题
        }
      },
      series: [{                                 //指定数据列
        name: '微信司机发布信息数',                          //数据列名
        data: count,                      //数据
        color:'#f5ad4e'
      }]
    });
  }

  //封装传输的信息并提交
  function loadList() {
    var obj = {};
    obj.action = 'show';
    obj.size = size;
    obj.page = global_page;
    obj.flag = flag;
    obj.source = source;
    operation.operation_ajax(action_url, obj, sendMessage);
  }
  function sendMessage() {
    $('.drive_li_container').remove();
    count = global_data.total;
    loadPage.checkUserPrivilege(count, insertUserMessage);
  }
  //添加用户数据
  function insertUserMessage() {
    for (var i = 0; i < global_data.data.length; i++) {
      var driving_name = global_data.data[i].driving_name;//车主姓名
      if(driving_name == undefined){
        addUserDisplay("", "", "", "", "","", "", "", "", "", "", "", "","","","","","","");
        $($('.drive_li_container')[i]).hide();
      }else{
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
        var id = global_data.data[i].order.order_id;//id
        var publish_time = global_data.data[i].create_time;//id
        var user_avatar = global_data.data[i].user_data.user_avatar;//微信头像
        var user_name = global_data.data[i].user_data.user_name;//微信昵称
        var boarding_point = global_data.data[i].order.boarding_point;//上车位置
        var breakout_point = global_data.data[i].order.breakout_point;//下车位置
        var order_description = global_data.data[i].order.description;//备注
        var order_create_time = global_data.data[i].order.create_time.substring(0, 16);//备注
        var boarding_point1 = global_data.data[i].boarding_point;//上车地点
        var breakout_point1 = global_data.data[i].breakout_point;//下车地点

        if (departure == "") {
          departure = boarding_point1;
        }
        if (destination == "") {
          destination = breakout_point1;
        }
        if (info_status == 1) {
          info_status = "有空位"
        } else if (info_status == 2) {
          info_status = "已满"
        } else {
          info_status = "已取消"
        }
        if(user_avatar==""){
          user_avatar="/resource/images/icon_people.png";
        }
        var insert_time = start_time.split(":")[0] + ":" + start_time.split(":")[1] + "-" + end_time.substring(11, 16);
        addUserDisplay(driving_name, info_status, insert_time, mobile, departure_city, destination_city,
                description, inits_seats, car_brand, id, publish_time, departure, destination,user_avatar,user_name,boarding_point,breakout_point,order_description,order_create_time);

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
          if(tag_yes_content.indexOf("丶")==-1){
            var array_yes = tag_yes_content.split("、");
          }else{
            var array_yes = tag_yes_content.split("丶");
          }

          for (var j = 0; j < array_yes.length; j++) {
            $($('.publish_yes_tags_container')[i]).append('<span class="publish_yes_tags_context">' + array_yes[j] + '</span>');
          }
        }
        if (tag_no_content == "") {
          $($('.publish_no_tags_box')[i]).hide();

        } else {
          //no标签
          $($('.publish_no_tags_box')[i]).show();
          if(tag_no_content.indexOf("丶")==-1){
            var array_no = tag_no_content.split("、");
          }else{
            var array_no = tag_no_content.split("丶");
          }

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
        if (order_description == "") {
          $($('.passenger_message_remark')[i]).hide();
        }
        if (car_brand == "") {
          $($('.driver_type')[i]).hide();
        }
        if (points == "") {
          $($('.driver_detail_route')[i]).hide();
        }

      }
      }

  }
  //添加用户列表
  function addUserDisplay(driving_name, info_status, insert_time, mobile, departure_city, destination_city,
                          description, inits_seats, car_brand, id, publish_time, departure, destination,user_avatar,user_name,boarding_point,breakout_point,order_description,order_create_time) {
    $(".not_find_message").before('<li class="drive_li_container" index=' + id + ' >' +
            '<div class="drive_li_container_top">' +
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
            '<span>车主备注：</span>' +
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
            '<span>车主电话：</span>' +
            '<span style="color: #999" class="driving_car_mobile">' + mobile + '</span>' +
            '</div>' +
            '<div class="clear"></div>' +
            '<div class="driver_detail_publish">' +
            '<span>发布时间：</span>' +
            '<span style="color: #999" class="driving_car_publish">' + publish_time + '</span>' +
//            '<img src='+user_avatar+' class="driving_car_avatar"></span>' +
//            '<span style="color: #999" class="driving_car_nename">' + user_name + '</span>' +
            '</div>' +
            '<div class="clear"></div>' +
            '</div>' +
            '</div>' +
            '<div class="clear"></div>' +
            '<div class="passenger_container">' +
            '<div class="passenger_container_top">' +
            '<img src='+user_avatar+' class="driving_car_avatar"></span>' +
            '<span style="color: #999" class="driving_car_nename">' + user_name + '</span>' +
            '</div>' +
            '<div class="passenger_message">' +
            '<div class="passenger_message_box">' +
            '<span>上车位置：</span>' +
            '<span style="color: #999" class="driving_car_mobile">' + boarding_point + '</span>' +
            '</div>' +
            '<div class="passenger_message_box">' +
            '<span>下车位置：</span>' +
            '<span style="color: #999" class="driving_car_mobile">' + breakout_point + '</span>' +
            '</div>' +
            '<div class="passenger_message_box passenger_message_remark">' +
            '<span>乘客备注：</span>' +
            '<span style="color: #999" class="driving_car_mobile">' + order_description + '</span>' +
            '</div>' +
            '</div>' +
            '<div class="driver_detail_publish">' +
            '<span>预约时间：</span>' +
            '<span style="color: #999" class="driving_car_publish">' + order_create_time + '</span>' +

            '</div>' +
            '<div class="driver_detail_option">' +
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
            '<div class="clear"></div>' +
            '</div>' +
            '</div>' +
            '</li>'
    )
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
  //查找信息
  function findMessage() {
    var obj = {};
    var search = $('.search_user_input').val();
    var departure_city = $('.publish_start_city').text().trim();
    var destination_city = $('.publish_end_city').text().trim();
    var start_time = $('.select_start_time ').val();
    var end_time = $('.select_end_time ').val();
    var status = $('.publish_status').attr('index');
    flag = $('.select_checkbox_active').children('.select_checkbox').attr('index');
    if (departure_city == "选择出发城市" || departure_city == "全部") {
      departure_city = ""
    }
    if (destination_city == "选择目的城市" || destination_city == "全部") {
      destination_city = ""
    }
    obj.action = 'show';
    obj.source = source;
    obj.keyword = search;
    obj.size = size;
    obj.page = global_page;
    obj.departure_city = departure_city;
    obj.destination_city = destination_city;
    obj.start_time = start_time;
    obj.end_time = end_time;
    obj.status = status;
    operation.operation_ajax(action_url, obj, sendMessage);
  }
  //查找信息
  function updateMessage(item_start, item_end) {
    var obj = {};
    var departure_city = item_start;
    var destination_city = item_end;

    if (departure_city == "选择出发城市") {
      departure_city = ""
    }
    if (destination_city == "选择目的城市") {
      destination_city = ""
    }
    obj.action = 'show';
    obj.source = source;
    obj.size = size;
    obj.page = global_page;
    obj.departure_city = departure_city;
    obj.destination_city = destination_city;
    operation.operation_ajax(action_url, obj, sendMessage);

  }
  //删除信息
  function deleteSingle(item) {
    var obj = {};
    var id = $(item).closest('.drive_li_container').attr('index');
    obj.action = 'delete';
    obj.id = id;
    obj.source = source;
    operation.operation_ajax(action_url, obj, loadList);
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

  //显示下拉
  function showTagsUl(obj) {
    $(obj).children('.publish_slide_ul').toggle();
  }
  function selectTagsLi(obj) {
    global_page = 0;
    $(obj).parent().parent().children('.publish_slide_text').text($(obj).text()).attr('index', $(obj).attr('index'));
    findMessage()
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
        <span>乘客预约信息列表</span>

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
      <div class="clear"></div>
      <div class="sub_title_bar">
        <%--<div class="publish_list_box">--%>
          <%--<div class="publish_list">--%>
            <%--<div class="publish_slide" onclick="showTagsUl(this)">--%>
              <%--<span class="publish_slide_text publish_start_city" index="">选择出发城市</span>--%>
              <%--<ul class="publish_slide_ul publish_start_slide_ul">--%>
                <%--<li class="publish_slide_li publish_slide_li_all" index="" onclick="selectTagsLi(this)">--%>
                  <%--全部--%>
                <%--</li>--%>
              <%--</ul>--%>
              <%--<div class="down1"></div>--%>
            <%--</div>--%>
          <%--</div>--%>
          <%--<img src="/resource/images/pch_icon_to.png" class="publish_icon_to">--%>

          <%--<div class="publish_list">--%>
            <%--<div class="publish_slide" onclick="showTagsUl(this)">--%>
              <%--<span class="publish_slide_text publish_end_city" index="">选择目的城市</span>--%>
              <%--<ul class="publish_slide_ul publish_end_slide_ul">--%>
                <%--<li class="publish_slide_li publish_slide_li_type" index=""--%>
                    <%--onclick="selectTagsLi(this)">--%>
                  <%--全部--%>
                <%--</li>--%>
              <%--</ul>--%>
              <%--<div class="down1"></div>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="user_list_drop_box">--%>
          <%--<input id="datepicker" name="publish_time" placeholder="选择开始时间"--%>
                 <%--class="select_time select_start_time" onchange="global_page = 0;findMessage()">--%>
        <%--</div>--%>
        <%--<div class="user_list_drop_box">--%>
          <%--<input id="datepicker2" name="publish_time" placeholder="选择结束时间" class="select_time select_end_time"--%>
                 <%--onchange="global_page = 0;findMessage()">--%>
        <%--</div>--%>
        <%--<div class="publish_slide" onclick="showTagsUl(this)">--%>
          <%--<span class="publish_slide_text publish_status" index="">选择状态</span>--%>
          <%--<ul class="publish_slide_ul">--%>
            <%--<li class="publish_slide_li publish_slide_li_type" index="" onclick="selectTagsLi(this)">--%>
              <%--全部--%>
            <%--</li>--%>
            <%--<li class="publish_slide_li publish_slide_li_type" index="0" onclick="selectTagsLi(this)">--%>
              <%--已满--%>
            <%--</li>--%>
            <%--<li class="publish_slide_li publish_slide_li_type" index="-1" onclick="selectTagsLi(this)">--%>
              <%--已取消--%>
            <%--</li>--%>
            <%--<li class="publish_slide_li publish_slide_li_type" index="1" onclick="selectTagsLi(this)">--%>
              <%--有空位--%>
            <%--</li>--%>
          <%--</ul>--%>
          <%--<div class="down1"></div>--%>
        <%--</div>--%>
        <div class="clear"></div>
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
          <span class="page_set_number show_page">20</span>
          <span class="page_set_style">条</span>
          <ul class="page_set_ul">

          </ul>
          <div class="down1"></div>
          <div class="clear"></div>
        </div>
        <div class="publish_time_select">
          <div class="select_checkbox_container  select_checkbox_active" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="1">按发布时间排序</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="2">按出行时间排序</span>
            <i class="select_popover_arrow"></i>
          </div>
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
