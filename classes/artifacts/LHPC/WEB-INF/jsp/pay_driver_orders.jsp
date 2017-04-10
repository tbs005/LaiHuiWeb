<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/9/26
  Time: 11:09
  describtion:后台管理--【账单管理】车主订单管理
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
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
    width: 15%;
    display: inline-block;
    text-align: center;
    line-height: 40px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    font-size: 14px;
    vertical-align: middle;
  }

  .user_manage_container_li {
    border-top: 1px dashed #e8e8e8;
    cursor:pointer;
    position: relative;
  }
  .user_manage_container_li:hover{
    background-color: #f7f7f7;

  }
  .user_manage_container_li:hover>.user_list_checklist_del_active{
    display:block;
  }
  .sub_title_bar{
    margin-bottom: 10px;
    margin-top: 20px;
  }
  .page_container{
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
  .detailAll_tip_no{
    margin-left: 14px;
  }
  /*.order_id{*/
    /*color: #F5AD4E;*/
    /*text-decoration: underline;*/
  /*}*/
  /*.order_id:hover{*/
    /*color: #FF8F0C;*/
  /*}*/

  /*下拉框*/
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
  .order_count_p{
    line-height: 18px;
    margin-top: 4px;
    margin-bottom: 4px;
    color: #F5AD4E;
    text-decoration: underline;
  }
  .order_count_p:hover{
    color: #FF8F0C;
  }

  p{
    margin: 0;
  }
  .order_count{
    width: 23%;
  }
  .order_count_title{
    width: 21%;
  }
</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    checkId();
    $('.menu_context_li').removeClass('active_li');
    $('.pay_driver_orders').addClass('active_li');
    // 绑定键盘按下事件
    $(document).keypress(function (e) {
      // 回车键事件
      if (e.which == 13) {
        jQuery('.search_ico').click();
      }
    });
    //搜索重置page
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
    $("#datepicker").datetimepicker();
    $("#datepicker2").datetimepicker();
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
  });

  var global_cat_id;
  var check_click_search = 0;
  var action_url="/api/db/pay/orders";
  var url = window.location.href;
  var order_id;
  //判断是否是修改信息
  function checkId() {
    if (url.indexOf("=") == -1) {
      loadUser();
    } else {
      order_id = url.split('order_id=')[1].split('&end')[0];
      $('.search_user_input').val(order_id);
      findMessage();
    }
  }
  //ajax获取用户
  //封装传输的信息并提交
  function loadUser(){
    var obj={};
    obj.action='show_d_orders';
    obj.size=size;
    obj.page=global_page;
    operation.operation_ajax(action_url,obj,sendMessage);
  }
  function sendMessage(){
    $('.user_manage_container_li').remove();
    count = global_data.total;
    loadPage.checkUserPrivilege(count,insertUserMessage);
  }
  function findMessage(){
    var obj={};
    var passenger_id = $('.passenger_span').attr('cat_id');
    var driver_id = $('.driver_span').attr('cat_id');
    var search = $('.search_user_input').val();
    var start_time = $('.select_start_time ').val();
    var end_time = $('.select_end_time ').val();
    var status = $('.publish_status').attr('index');
    obj.action='show_d_orders';
    obj.keyword=search;
    obj.status=status;
    obj.start_time=start_time;
    obj.end_time=end_time;
    obj.is_passenger=passenger_id;
    obj.is_car=driver_id;
    obj.size=size;
    obj.page=global_page;
    operation.operation_ajax(action_url,obj,sendMessage);
  }
  //删除信息
  function deleteSingle(item){
    var obj={};
    var id = $(item).parent().parent().attr('user_id');
    obj.action='delete';
    obj.id=id;
    operation.operation_ajax(action_url,obj,loadUser);
  }
  //添加用户数据
  function insertUserMessage(){
    $('.user_manage_container_li').remove();
    for (var i = 0; i < global_data.data.length; i++){
        var order_id = global_data.data[i].order_id;
        var order_name = global_data.data[i].user_name;
        var order_mobile = global_data.data[i].mobile;
        var order_count_money = global_data.data[i].money;
        var order_status =  global_data.data[i].pay_status;
        var order_tips;
        var order_array = global_data.data[i].pay_num.split("&");
        var order_count = order_array.length;

      if(order_status == -1){
        order_tips = "申请退款";
        $($('.order_tips')[i]).css('color','#e74c3c')
      }else if(order_status == 1){
        order_tips = "已转账";
        $($('.order_tips')[i]).css('color','#2ecc71')
      }else{
        order_tips = "未转账";
        $($('.order_tips')[i]).css('color','#bdc3c7')
      }

      addUserDisplay(order_id,order_name,order_mobile,order_count,order_count_money,order_tips);
      for(var j =0 ;j< order_count;j++){
        $($('.order_count')[i]).append('<p class="order_count_p">'+order_array[j]+'</p>')
      }
      if(order_status == -1){
        $($('.order_tips')[i]).css('color','#e74c3c')
      }else if(order_status == 1){
        $($('.order_tips')[i]).css('color','#2ecc71')
      }else{
        $($('.order_tips')[i]).css('color','#bdc3c7')
      }

    }
  }
  //添加用户列表
  function addUserDisplay(order_id,order_name,order_mobile,order_count,order_count_money,order_tips) {
    $(".userManage_container_ul").append('<li class="user_manage_container_li" onclick="toDetail(this)" index='+order_id+'>' +
            '<span class="userManage_span order_id">'+order_id+'</span>' +
            '<span class="userManage_span ">'+order_name+'</span>' +
            '<span class="userManage_span ">'+order_mobile+'</span>' +
            '<span class="userManage_span order_count"></span>' +
            '<span class="userManage_span">'+order_count_money+'元</span>' +
            '<span class="userManage_span order_tips">'+order_tips+'</span>' +
            '</li>')
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
  //获取点击id并跳转
  function toDetail(obj) {
    var order_id=$(obj).attr('index');
    window.location.href = "/db/pay/d_order/info?order_id=" + order_id+"&end";
  }
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>车主流水管理</span>
        <div class="search_user">
          <input type="text" placeholder="姓名、车单号、流水号、手机号" class="search_user_input">
          <a href="javascript:;" class="search_user_a">
            <div class="search_ico"></div>
          </a>
        </div>
      </div>
    </div>
    <div class="userManage_container">
      <%--<div class="user_list_drop_box">--%>
        <%--<input id="datepicker" name="publish_time" placeholder="选择开始时间" class="select_time select_start_time" onchange="findMessage()">--%>
      <%--</div>--%>
      <%--<div class="user_list_drop_box">--%>
        <%--<input id="datepicker2" name="publish_time" placeholder="选择结束时间" class="select_time select_end_time" onchange="findMessage()">--%>
      <%--</div>--%>
        <div class="publish_slide" onclick="showTagsUl(this)">
          <span class="publish_slide_text publish_status" index="">选择状态</span>
          <ul class="publish_slide_ul">
            <li class="publish_slide_li publish_slide_li_type" index="" onclick="selectTagsLi(this)">
              全部
            </li>
            <li class="publish_slide_li publish_slide_li_type" index="1" onclick="selectTagsLi(this)">
              已转帐
            </li>
            <li class="publish_slide_li publish_slide_li_type" index="0" onclick="selectTagsLi(this)">
              未转账
            </li>
          </ul>
          <div class="down1"></div>
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
          <span class="userManage_span">车单号</span>
          <span class="userManage_span">车主姓名</span>
          <span class="userManage_span">手机号</span>
          <span class="userManage_span order_count_title">收入的流水号</span>
          <span class="userManage_span">总金额</span>
          <span class="userManage_span">支付状态</span>
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
        <div class="page_go" onclick="loadPage.checkPageTo()">
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