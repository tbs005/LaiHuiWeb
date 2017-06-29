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
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<link href="/resource/css/sweetalert.css" rel="stylesheet">
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<script src="/resource/js/sweetalert.min.js" type="text/javascript"></script>
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
    color: #fff;
    cursor: pointer;
    padding: 4px 10px;
    background-color:#f5ad4e;
    position: relative;
    top: -10px;
  }
  .delete_message2{
    display: inline-block;
    float: right;
    color: #fff;
    cursor: pointer;
    padding: 4px 10px;
    background-color:#D0D0D0;
    position: relative;
    top: -10px;
  }

  .delete_message:hover {
    background-color: #FF8F0c;
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
  .user_list_drop_box {
    position: relative;
    float: left;
    margin-right: 30px;
    margin-bottom: 20px;
  }
  .sweet-alert button.cancel {
    background-color: #F8C28D;
  }
  .sweet-alert button.cancel:hover {
    background-color: #f5ad4e;
  }
  .cash_tips span{
    line-height: 32px;
  }
  .cash_tips{
    width: 250px;
    margin: 0 auto;
    text-align: left;
  }
</style>
<script type="text/javascript">
  $(document).ready(function () {
    $('.menu_body').removeClass('open_menu_body');
    $('.menu_head').removeClass('current');
    $('.menu_body a').removeClass('change_menu');
    $('#fundManage_head').addClass('current');
    $('#fundManage_body').addClass('open_menu_body');
    $('#fundDrawBack_menu').addClass('change_menu');
    loadUser();
    pageSet.setPageNumber();
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
  });
  var action_ul = '/api/pay/back';
  var status="";
  function loadUser() {
    var obj = {};
    obj.action = 'show';
    obj.size = size;
    obj.page = global_page;
    operation.operation_ajax(action_ul, obj, userMessage);
  }

  function userMessage() {
    count = global_data.count;
    loadPage.checkUserPrivilege(count, insertUserMessage);
  }
  function insertUserMessage() {
    $('.user_container').remove();
    for (var i = 0; i < global_data.data.length; i++) {
      var user_avatar = global_data.data[i].avatar;
      var user_mobile = global_data.data[i].mobile;
      var user_name = global_data.data[i].name;
      var user_time = global_data.data[i].create_time;
      var cash = global_data.data[i].cash;
      var user_id = global_data.data[i].id;
      var pay_type = global_data.data[i].pay_type;
      var pay_account = global_data.data[i].pay_account;
      var pay_status = global_data.data[i].pay_status;
      if (user_avatar == "") {
        user_avatar = "/resource/images/icon_people.png";
      }
      if(user_name ==""){
        user_name="匿名用户"
      }
      if(pay_type==0){
        pay_type="支付宝";
      }else{
        pay_type="微信";
      }
      if(pay_status==1){
        styleMessage2(user_id, user_avatar, user_mobile, user_name, user_time,pay_type,pay_account,cash);
      }else{
        styleMessage(user_id, user_avatar, user_mobile, user_name, user_time,pay_type,pay_account,cash);
      }

      if (i == global_data.data.length - 1) {
        $($('.user_container')[i]).addClass('user_container_last_child');
      }
    }
  }
  //样式布局--未处理
  function styleMessage(user_id, user_avatar, user_mobile, user_name, user_time, pay_type,pay_account,cash) {
    $(".not_find_message").before('<li class="user_container" index=' + user_id + '>' +
            '<div class="user_message">' +
            '<img src="' + user_avatar + '" class="user_avatar">' +
            '<span class="user_mobile">' + user_mobile + '</span>' +
            '<span class="user_name">' + user_name + '</span>' +
            '<span class="user_time">' + user_time + '</span>' +
            '</div>' +
            '<div class="user_content">' +
            '<p>退款金额：<span style="color:#f5ad4e">'+cash+' 元</span></p>' +
            '</div>' +
            '<div class="user_content" data_type='+pay_type+' data_account='+pay_account+' data_money='+cash+'>' +
            '<p>退款类型：'+pay_type+'</p>' +
            '<p style="float: left;">退款账户：'+pay_account+'</p>' +
            '<span class="delete_message" onclick="cashList(this)">完成退款</span>' +
            '<div class="clear"></div>' +
            '</div>' +

            '<div class="clear"></div>' +
            '</li>')
  }
  //样式布局--已处理
  function styleMessage2(user_id, user_avatar, user_mobile, user_name, user_time, pay_type,pay_account,cash) {
    $(".not_find_message").before('<li class="user_container" index=' + user_id + '>' +
            '<div class="user_message">' +
            '<img src="' + user_avatar + '" class="user_avatar">' +
            '<span class="user_mobile">' + user_mobile + '</span>' +
            '<span class="user_name">' + user_name + '</span>' +
            '<span class="user_time">' + user_time + '</span>' +
            '</div>' +
            '<div class="user_content">' +
            '<p>退款金额：<span style="color:#f5ad4e">'+cash+' 元</span></p>' +
            '</div>' +
            '<div class="user_content" data_type='+pay_type+' data_account='+pay_account+' data_money='+cash+'>' +
            '<p>退款类型：'+pay_type+'</p>' +
            '<p style="float: left;">退款账户：'+pay_account+'</p>' +
            '<span class="delete_message2">已完成</span>' +
            '<div class="clear"></div>' +
            '</div>' +

            '<div class="clear"></div>' +
            '</li>')
  }
  //查找数据
  function findMessage() {
    var status = $('.select_checkbox_active').children('.select_checkbox').attr('index');
    var obj = {};
    var search = $('.search_user_input').val();
    var start_time = $('.select_start_time ').val();
    var end_time = $('.select_end_time ').val();
    obj.action = 'show';
    obj.size = size;
    obj.page = global_page;
    obj.type=status;
    obj.keyword=search;
    obj.start_time=start_time;
    obj.end_time=end_time;
    operation.operation_ajax(action_ul, obj, userMessage);
  }
  //退款
  function cashSingle(item) {
    var obj = {};
    obj.action = 'confirm';
    obj.id = item;
    operation.operation_ajax(action_ul, obj,successCash );
  }

  function successCash(){
    swal('退款成功','','success');
    loadUser()
  }
  function cashList(obj) {
    var user_id = $(obj).closest('.user_container').attr('index');
    var user_count = $(obj).parent().attr('data_account');
    var user_cash = $(obj).parent().attr('data_money');
    var user_type = $(obj).parent().attr('data_type');
    swal({
      title: "核对退款信息",
      html:true,
      text: '<div class="cash_tips">转账账户：<span><b>'+user_count+'</b></span><br>转账类型：<span><b>'+user_type+'</b></span><br>金&#12288;&#12288;额：<span style="color: #f5ad4e"><b>'+user_cash+' 元</b></span></div>',
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "已支付",
      cancelButtonText: "未支付",
      closeOnConfirm: false,
      showLoaderOnConfirm: true
    }, function () {
      setTimeout(function(){
        cashSingle(user_id);
      }, 2000);
    });
  }
  //选择标签
  function addTabStyle(obj) {
    if ($(obj).hasClass('select_checkbox_active')) {
      return false;
    } else {
      $('.select_checkbox_container').removeClass('select_checkbox_active');
      $(obj).addClass('select_checkbox_active');
    }
    global_page = 0;
    findMessage();
  }
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>用户退款</span>
        <div class="search_user">
          <input type="text" placeholder="姓名、手机号" class="search_user_input">
          <a href="javascript:;" class="search_user_a">
            <div class="search_ico"></div>
          </a>
        </div>
      </div>
    </div>

    <div class="userManage_container">
      <div class="user_list_drop_box">
        <input id="datepicker" name="publish_time" placeholder="选择开始时间" class="select_time select_start_time" onchange="findMessage()">
      </div>
      <div class="user_list_drop_box">
        <input id="datepicker2" name="publish_time" placeholder="选择结束时间" class="select_time select_end_time" onchange="findMessage()">
      </div>
      <div class="clear"></div>
      <div class="sub_title_bar">
        <span class="sub_message"></span>
        <div class="publish_time_select">
          <div class="select_checkbox_container select_checkbox_active" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="">待退款</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="1">已处理</span>
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