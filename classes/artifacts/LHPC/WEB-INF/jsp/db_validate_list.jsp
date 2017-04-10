<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 11:09
  describtion:后台管理--【实名认证】车主审核列表
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
  .userManage_container_li_top span{
    width: 140px;
  }

  .userManage_span {
    width: 16%;
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


  /*列表容器*/
  .car_list{
    border: 1px solid #e8e8e8;
    float: left;
    width: 278px;
    cursor: pointer;
    margin-right: 30px;
    margin-bottom: 30px;
  }
  .car_list:hover {
    box-shadow: 2px 2px 10px 2px #e8e8e8;
  }
  .car_list_container_message {
    width: 106%;
    min-height: 400px;
  }
  .car_list_message{
    padding: 10px;
  }
  .car_list_message_tittle {
    font-size: 18px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin-bottom: 8px;
  }
  .car_list_down_left{
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    height: 30px;
    position: relative;
    line-height: 30px;
  }
  .car_list_down_img{
    width: 30px;
    position: relative;
    line-height: 24px;
    top: -2px;
  }
  .car_list_down_span{
    display: inline-block;
    margin-left: 10px;
  }

</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    loadUser();
    $('.menu_context_li').removeClass('active_li');
    $('.db_validate_list').addClass('active_li');
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

  var menu_type=2;
  var action='show_unchecked';
  var action_url='/db/api/validate_list';

  //ajax获取用户
  //封装传输的信息并提交
  function loadUser(){
    var obj={};
    console.log('load');
    obj.action=action;
    obj.size=size;
    obj.page=global_page;
    obj.status=menu_type;
    operation.operation_ajax(action_url,obj,sendMessage);
  }
  function sendMessage(){
    $('.car_list').remove();
    count = global_data.total;
    loadPage.checkUserPrivilege(count,insertUserMessage);
  }
  function findMessage(){
    var obj={};
    console.log('find');
    var passenger_id = $('.passenger_span').attr('cat_id');
    var driver_id = $('.driver_span').attr('cat_id');
    var search = $('.search_user_input').val();
    var start_time = $('.select_start_time ').val();
    var end_time = $('.select_end_time ').val();
    obj.action=action;
    obj.keyword=search;
    obj.start_time=start_time;
    obj.end_time=end_time;
    obj.is_passenger=passenger_id;
    obj.is_car=driver_id;
    obj.size=size;
    obj.page=global_page;
    obj.status=menu_type;
    operation.operation_ajax(action_url,obj,sendMessage);
  }

  //添加用户数据
  function insertUserMessage(){
    $('.user_manage_container_li').remove();
    for (var i = 0; i < global_data.data.length; i++){
      var idsn=global_data.data[i].idsn;//身份证号
      var car_type=global_data.data[i].car_type;//车辆类型
      var name=global_data.data[i].name;//名字
      var validate_date=global_data.data[i].validate_date;//加入时间
      var token=global_data.data[i].token;//url
      var checked_date=global_data.data[i].checked_date;//url
      carListStyle(name, idsn, car_type, validate_date,token,checked_date);
    }
  }
  //添加车主列表
  function carListStyle(name, idsn, car_type, validate_date,token,checked_date) {
    $('.not_find_message').before('<li class="car_list" car_id='+token+'>' +
            '<div class="car_list_message" onclick="getId(this)" >' +
            '<div class="car_list_message_tittle">' +
            '<span class="car_list_message_tittle_span">' + name + '</span>' +
            '<div class="clear"></div>' +
            '</div>' +
            '<div class="car_list_down">' +
            '<div class="car_list_down_left">' +
            '<img class="car_list_down_img" src="/resource/images/pc_icon_IDcard.png" alt="身份证">'+
            '<span class="car_list_down_span">' + idsn + '</span>' +
            '</div>' +
            '<div class="car_list_down_left">' +
            '<img class="car_list_down_img" src="/resource/images/pc_icon_car.png" alt="车辆类型">'+
            '<span class="car_list_down_span">' + car_type + '</span>' +
            '</div>' +
            '<div class="car_list_down_left">' +
            '<span style="color:#999">加入时间：'+validate_date+'</span>'+
            '</div>' +
            '<div class="car_list_down_left">' +
            '<span style="color:#999">审核时间：'+checked_date+'</span>'+
            '</div>' +
            '<div class="clear"></div>' +
            '</div>' +
            '</div>' +
            '</li>')
  }

  //获取点击id并跳转
  function getId(obj) {
    var user_id = $(obj).parent().attr("car_id");
    window.location.href = "/db/validate/info?id=" + user_id;
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
    global_page=0;
    findMessage()
  }
  //点击主菜单
  function clickMenu(obj){
    menu_type = $(obj).attr('menu_type');
    if(menu_type==-1){
      action="show_checked_down"
    }else if(menu_type==2){
      action="show_unchecked"
    }else{
      action="show_checked"
    }
    $(obj).parent().children('.right_menu_li').removeClass('right_menu_li_active');
    $(obj).addClass('right_menu_li_active');
    global_page = 0;
    $('.page_current').text(global_page + 1);
    $('.car_list').remove();
    $('.search_user_input').val('');
    restoreMessage();
  }
  //所有输入还原
  function restoreMessage(){
    $('#datepicker').val('');
    $('#datepicker2').val('');
    $('.search_user_input').val('');
    loadUser();
  }
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>审核列表</span>
        <div class="search_user">
          <input type="text" placeholder="姓名、车型" class="search_user_input">
          <a href="javascript:;" class="search_user_a">
            <div class="search_ico"></div>
          </a>
        </div>
        <div class="right_menu">
          <ul>
            <li class="right_menu_li right_menu_item1 right_menu_li_active" menu_type="2" onclick="clickMenu(this);"><span>未审核信息</span></li>
            <li class="right_menu_li right_menu_item2" menu_type="1" onclick="clickMenu(this);"><span>审核通过列表</span></li>
            <li class="right_menu_li right_menu_item3" menu_type="-1" onclick="clickMenu(this);"><span>审核拒绝列表</span></li>
            <div class="clear"></div>
          </ul>
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
      <%--列表信息--%>
      <div class="car_list_container_message">

        <div class="not_find_message">
          <img src="/resource/images/eat.gif" alt="">
          <span>您所查询的信息被我吃光光了~~</span>
        </div>
        <div class="clear"></div>
      </div>
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
