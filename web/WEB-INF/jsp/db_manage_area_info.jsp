<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/11/17
  Time: 11:09
  describtion:后台管理--【代理商管理】详细区域管理订单列表
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
    position: relative;
    cursor: pointer;
  }

  .drive_li_container:hover {
    box-shadow: 2px 2px 10px 2px #e8e8e8;;
  }

  .driver_detail_remark {
    line-height: 30px;
  }

  .driver_detail_route {
    padding: 10px 0;
    display: none;
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

  .driver_type {
    margin-left: 20px;
  }

  .driver_seat {
    margin-left: 20px;
  }

  .drive_could_use {
    float: right;
    right: -4px;
    top: -6px;
    width: 80px;
    position: absolute;
  }

  .driver_use_img {
    width: 100%;
  }

  .driver_use_span {
    position: absolute;
    top: 4px;
    right: 8px;
    color: #fff;
    font-size: 12px;
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

  .driver_detail_option_delete, .driver_detail_option_QQ ,.driver_detail_option_href{
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

  .driver_detail_option_delete:hover {
    background-color: #c0392b;
  }

  /*城市下拉框*/

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
  .driver_price {
    margin-left: 20px;
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
  .find_discript_span{
    display: inline-block;
  }
  .driving_car_avatar{
    width: 30px;
    height: 30px;
    margin-left: 20px;
    border-radius: 50%;
    margin-right: 10px;
    position: relative;
    top: -2px;
  }
  .update_message{
    position: absolute;
    right: 10px;
    top: 0px;
    z-index: 10;
    color: #fff;
    background: #f5ad4e;
    padding: 2px 5px;
    cursor: pointer;
  }
  .update_message:hover{
    background-color: #FF8F0c;
  }

</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    loadList();
    loadLineMessage();
    madeLine();
    $('.menu_context_li').removeClass('active_li');
    $('.db_manage_agent').addClass('active_li');
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

//        setInterval(updateLine,5000);
  });

  var user_id;
  var user_code;
  var action_url = "/api/passenger/order_list";
  var url = window.location.href;
  user_id = url.split('id=')[1].split('&end')[0];
  user_code = url.split('code=')[1].split('&id')[0];
  var start_time="";
  var end_time="";
  var count_array=[];
  //ajax获取更新
  function updateLine(){
    count_array=[];
    loadList();
    loadLineMessage();
    madeLine();
  }

  //加载统计数据
  function loadLineMessage(){
    var obj={};
    obj.action='area_count';
    obj.code=user_code;
    obj.id=user_id;
    operation.operation_ajax2('/api/area/passenger/order',obj,madeCountObj);
  }

  function madeCountObj(){
    for(var i=0;i<global_data.area_data.length;i++){
      var count_obj={};
      count_obj.color='#f5ad4e';
      count_obj.name=global_data.area_data[i].name;
      count_obj.data=global_data.area_data[i].data;
      count_array.push(count_obj);
    }
  }

  //生成统计折线图
  function madeLine(){
    var time_array = [];
    for(var i=0;i<global_data.date.length;i++){
      time_array.push(global_data.date[i].date);
    }
    //添加数据折线
    $('#container').highcharts({                   //图表展示容器，与div的id保持一致
      chart: {
        type: 'line'                         //指定图表的类型，默认是折线图（line）
      },
      title: {
        text: '区域管理新增数量统计'      //指定图表标题
      },
      xAxis: {
        categories: time_array   //指定x轴分组
      },
      yAxis: {
        title: {
          text: '单位/条'                  //指定y轴的标题
        }
      },
      tooltip: {
        shared: true,
//        crosshairs: true
      },
      plotOptions: {
        series: {
          cursor: 'pointer',
          events: {
            click: function(event) {
              start_time =event.point.category;
              $('.select_start_time ').val(start_time);
              var end_date = new Date(start_time.replace(/-/g,"/"));
              var t =end_date.getTime()+1000*60*60*24;
              var time=new Date(t);
              changeDataStyle(time);
              findMessage()
            },
          }
        }
      },
      series: count_array
    });
  }
  //转换日期格式
  function changeDataStyle(time){
    var year  = time.getFullYear();
    var month = time.getMonth()+1;
    var date  = time.getDate();
    if(month.toString().length==1){
      month = "0"+month;
    }else{
      month = parseInt(month);
    }
    if(date.toString().length==1){
      date = "0"+date;
    }else{
      date = parseInt(date);
    }
    end_time =year+"-"+month+"-"+date;
    $('.select_end_time ').val(end_time);
  }
  //封装传输的信息并提交
  function loadList() {
    var obj = {};
    obj.action = 'show';
    obj.code=user_code;
    obj.id=user_id;
    obj.size = size;
    obj.page = global_page;
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
      var driving_name = "";//车主姓名
      var order_status = global_data.data[i].order_status; //0:待司机确认，1：司机 已确认，-1司机已拒绝，2，订单已失效
      var create_time = global_data.data[i].create_time;//开始时间
      var mobile = global_data.data[i].user_data.user_mobile;//手机号
      var departure_city = global_data.data[i].boarding_point.city;//出发城市
      var destination_city = global_data.data[i].breakout_point.city;//目的城市
      var departure = global_data.data[i].boarding_point.address+global_data.data[i].boarding_point.name;//出发小城
      var destination = global_data.data[i].breakout_point.address+global_data.data[i].breakout_point.name;//目的小城市
      var booking_seats = global_data.data[i].booking_seats;//预定人数
      var id = global_data.data[i].order_id;//id
      var publish_time = global_data.data[i].create_time;//id
      var user_avatar = global_data.data[i].user_data.user_avatar;//微信头像
      var user_name = global_data.data[i].user_data.user_name;//微信昵称
      var price = "";
      if (departure == "") {
        departure = "";
      }
      if (destination == "") {
        destination = "";
      }
      if (order_status == 1) {
        order_status = "司机已确认"
      } else if (order_status == 2) {
        order_status = "订单已失效"
      } else if (order_status == 0) {
        order_status = "待司机确认"
      } else {
        order_status = "司机已拒绝"
      }
      if(user_avatar==""){
        user_avatar="/resource/images/icon_people.png";
      }
      var insert_time = create_time;
      addUserDisplay(driving_name, order_status, insert_time, mobile, departure_city, destination_city,
              booking_seats, id, publish_time, departure, destination,user_avatar,user_name);

      if (departure == "") {
        $($('.begin_city')[i]).hide();
      }
      if (destination == "") {
        $($('.end_city')[i]).hide();
      }
      //进行非空判断

      if (driving_name == "") {
        $($('.driver_detail_driver_set')[i]).hide();
      }
      if (booking_seats == "") {
        $($('.driver_detail_remark')[i]).hide();
      }
    }
  }
  //添加用户列表
  function addUserDisplay(driving_name, order_status, insert_time, mobile, departure_city, destination_city,
                          booking_seats, id, publish_time, departure, destination,user_avatar,user_name) {
    $(".not_find_message").before('<li class="drive_li_container" index=' + id + ' onclick="toDetail(this)" >' +
            '<div class="drive_li_top">' +
            '<div class="inline_block driver_route">' +
            '<span class="driver_route_span driver_route_start">' + departure_city + '</span>' +
            '<span class="begin_city" style="color:#999794;font-size: 12px;"><i class="circle"></i>' + departure + '</span>' +
            '<span class="driver_route_span" style="color: #F5AD4E;">——</span>' +
            '<span class="driver_route_span driver_route_end">' + destination_city + '</span>' +
            '<span class="end_city" style="color:#999794;font-size: 12px;"><i class="circle"></i>' + destination + '</span>' +
            '</div>' +
            '<div class="drive_could_use">' +
            '<img src="/resource/images/pc_icon_tags.png" class="driver_use_img">' +
            '<span class="driver_use_span">' + order_status + '</span>' +
            '</div>' +
            '</div>' +
            '<div class="driver_detail_remark">' +
            '<span>创建时间：</span>' +
            '<span style="color: #999" class="driver_description">' + insert_time + '</span>' +
            '</div>' +
            '<div class="driver_detail_remark">' +
            '<span>预定座位：</span>' +
            '<span style="color: #999" class="driver_description">' + booking_seats + '</span>' +
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
            '<img src='+user_avatar+' class="driving_car_avatar"></span>' +
            '<span style="color: #999" class="driving_car_nename">' + user_name + '</span>' +
            '</div>' +
            '<div class="driver_detail_option">' +
//                '<span class="driver_detail_option_href" onclick="toHref(this)">分享链接</span>' +
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
  //跳转前端分享链接
  function toHref(obj){
    if (obj && obj.stopPropagation) {//非IE浏览器
      obj.stopPropagation();
    }
    else {//IE浏览器
      window.event.cancelBubble = true;
    }
    var li_index = $(obj).parent().parent().parent().attr('index');
    window.location.href="http://pinchenet.com/laihui/car/detail?id=" + li_index;
  }
  //获取点击id并跳转
  function toDetail(obj) {
    var id=$(obj).attr('index');
    window.location.href = "/laihui/car/detail?driver_id="+"&order_id=" + id+"&end";
  }
  //查找信息
  function findMessage() {
    var obj = {};
    var search = $('.search_user_input').val();
    var start_time = $('.select_start_time ').val();
    var end_time = $('.select_end_time ').val();
    flag = $('.select_checkbox_active').children('.select_checkbox').attr('index');
    obj.action = 'show';
    obj.keyword = search;
    obj.size = size;
    obj.page = global_page;
    obj.start_time = start_time;
    obj.end_time = end_time;
    obj.code=user_code;
    obj.id=user_id;
    operation.operation_ajax(action_url, obj, sendMessage);
  }

  //删除信息
  function deleteSingle(item) {
    if (obj && obj.stopPropagation) {//非IE浏览器
      obj.stopPropagation();
    }
    else {//IE浏览器
      window.event.cancelBubble = true;
    }
    var obj = {};
    var id = $(item).closest('.drive_li_container').attr('index');
    obj.action = 'delete';
    obj.id = id;
    operation.operation_ajax(action_url, obj, loadList);
  }

  //单元删除提示
  function showDeleteTip(obj) {
    if (obj && obj.stopPropagation) {//非IE浏览器
      obj.stopPropagation();
    }
    else {//IE浏览器
      window.event.cancelBubble = true;
    }
    $(obj).parent().children('.user_list_select_delete_tip').fadeIn();
  }
  //隐藏删除信息
  function hideDeleteTips(obj) {
    if (obj && obj.stopPropagation) {//非IE浏览器
      obj.stopPropagation();
    }
    else {//IE浏览器
      window.event.cancelBubble = true;
    }
    $(obj).parent().hide();
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
        <span>区域管理订单列表</span>

        <div class="search_user">
          <input type="text" placeholder="姓名、手机号" class="search_user_input">
          <a href="javascript:;" class="search_user_a">
            <div class="search_ico"></div>
          </a>
        </div>
      </div>
    </div>
    <div class="userManage_container">
      <span class="update_message" onclick="updateLine()">更新数据</span>
      <div id="container"></div>
      <div class="clear"></div>
      <div class="sub_title_bar">

        <div class="user_list_drop_box">
          <input id="datepicker" name="publish_time" placeholder="选择开始时间"
                 class="select_time select_start_time" onchange="global_page = 0;findMessage()">
        </div>
        <div class="user_list_drop_box">
          <input id="datepicker2" name="publish_time" placeholder="选择结束时间" class="select_time select_end_time"
                 onchange="global_page = 0;findMessage()">
        </div>
        <div class="publish_slide" onclick="showTagsUl(this)">
          <span class="publish_slide_text publish_status" index="">选择设备</span>
          <ul class="publish_slide_ul">
            <li class="publish_slide_li publish_slide_li_type" index="" onclick="selectTagsLi(this)">
              全部
            </li>
            <li class="publish_slide_li publish_slide_li_type" index="1" onclick="selectTagsLi(this)">
              IOS
            </li>
            <li class="publish_slide_li publish_slide_li_type" index="0" onclick="selectTagsLi(this)">
              安卓
            </li>
          </ul>
          <div class="down1"></div>
        </div>
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
        <%--<div class="publish_time_select">--%>
        <%--<div class="select_checkbox_container  select_checkbox_active" onclick="addTabStyle(this)">--%>
        <%--<span class="select_checkbox" index="1">按发布时间排序</span>--%>
        <%--<i class="select_popover_arrow"></i>--%>
        <%--</div>--%>
        <%--<div class="select_checkbox_container" onclick="addTabStyle(this)">--%>
        <%--<span class="select_checkbox" index="2">按出行时间排序</span>--%>
        <%--<i class="select_popover_arrow"></i>--%>
        <%--</div>--%>
        <%--</div>--%>
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
      <div class="clear"></div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>