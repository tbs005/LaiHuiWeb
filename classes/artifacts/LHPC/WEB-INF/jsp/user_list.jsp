<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 11:09
  describtion:后台管理--【用户管理】账户管理
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


</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    loadUser();
    $('.menu_context_li').removeClass('active_li');
    $('.user_list').addClass('active_li');
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
  var action_url="/user/info";
  //ajax获取用户
  //封装传输的信息并提交
  function loadUser(){
    var obj={};
    obj.action='show';
    obj.size=size;
    obj.page=global_page;
    operation.operation_ajax(action_url,obj,sendMessage);
  }
  function sendMessage(){
    $('.user_manage_container_li').remove();
    count = global_data.count;
    loadPage.checkUserPrivilege(count,insertUserMessage);
  }
  function findMessage(){
    var obj={};
    var passenger_id = $('.passenger_span').attr('cat_id');
    var driver_id = $('.driver_span').attr('cat_id');
    var search = $('.search_user_input').val();
    var start_time = $('.select_start_time ').val();
    var end_time = $('.select_end_time ').val();
    obj.action='show';
    obj.keyword=search;
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
      var is_validated_passenger = global_data.data[i].is_validated_passenger;//是否认认证乘客信息
      var create_time = global_data.data[i].create_time;//加入时间
      var idsn=global_data.data[i].idsn;//身份证号
      var is_validated_car=global_data.data[i].is_validated_car;//是否通过车主认证
      var mobile=global_data.data[i].mobile;//手机号
      var name=global_data.data[i].name;//名字
      var id=global_data.data[i].id;//id
      var last_logined_time=global_data.data[i].last_logined_time;//最后登录时间
      var last_login_ip=global_data.data[i].last_login_ip;//最后登录时间
      addUserDisplay(is_validated_passenger,create_time,idsn,is_validated_car,mobile,name,id,last_logined_time,last_login_ip);
    }
  }
  //添加用户列表
  function addUserDisplay(is_validated_passenger,create_time,idsn,is_validated_car,mobile,name,id,last_logined_time,last_login_ip) {
    $(".userManage_container_ul").append('<li class="user_manage_container_li" user_id='+id+' is_validated_car='+is_validated_car+' is_validated_passenger='+is_validated_passenger+' onmouseleave="hideDeleteTip(this)">' +
            '<span class="userManage_span ">'+name+'</span>' +
            '<span class="userManage_span ">'+idsn+'</span>' +
            '<span class="userManage_span ">'+mobile+'</span>' +
            '<span class="userManage_span">'+create_time+'</span>' +
            '<span class="userManage_span">'+last_logined_time+'</span>' +
            '<span class="userManage_span">'+last_login_ip+'</span>' +
            '<div class="user_list_checklist_del_active" onclick="showDeleteTip(this)"></div>' +
            '<div class="user_list_select_delete_tip all_tip">'+
            '<div class="detailAll_tip_txt">'+
            '<span>确认删除</span>'+
            '</div>'+
            '<span class="detailAll_tip_yes" onclick="deleteSingle(this)">确认</span>'+
            '<span class="detailAll_tip_no" onclick="hideDeleteTips(this)">取消</span>'+
            '<i class="popover_arrow popover_arrow_out"></i>'+
            '<i class="popover_arrow popover_arrow_in"></i>'+
            '</div>'+
            '</li>')
  }
  //显示下拉
  function showAddToUserDrop(obj) {
    $(obj).children('.user_list_drop_box_ul').toggle();
  }
  //点击下拉列表
  function selectedCatDropList(obj) {
    $('.select_error_message').hide();
    $(obj).parent().parent().children('.user_list_drop_box_span').text($(obj).text()).attr('cat_id', $(obj).attr('cat_id'));
    $(obj).parent().hide();
    global_page=0;
    findMessage();
  }

  //单元删除提示
  function showDeleteTip(obj) {
    $(obj).parent().children('.user_list_select_delete_tip').fadeIn();
  }
  //隐藏删除信息
  function hideDeleteTips(obj){
    $(obj).parent().hide();
  }
  function hideDeleteTip(obj){
    $(obj).children('.user_list_select_delete_tip').hide()
  }

</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>用户管理</span>
        <div class="search_user">
          <input type="text" placeholder="姓名、身份证号、手机号" class="search_user_input">
          <a href="javascript:;" class="search_user_a">
            <div class="search_ico"></div>
          </a>
        </div>
      </div>
    </div>
    <div class="userManage_container">
      <div class="user_list_drop_box" onclick="showAddToUserDrop(this)" >
        <span class="user_list_drop_box_span passenger_span" cat_id="">乘客身份验证条件</span>
        <span class="select_error_message">请选择乘客身份验证验证条件</span>
        <ul class="user_list_drop_box_ul">
          <div class="cat_list_drop_box_li all_id" cat_id="" onclick="selectedCatDropList(this)">全部</div>
          <div class="clear cat_list_box"></div>
          <li class="cat_list_drop_box_li cat_list_style" cat_id=1 onclick="selectedCatDropList(this)">通过乘客身份验证</li>
          <li class="cat_list_drop_box_li cat_list_style" cat_id=0 onclick="selectedCatDropList(this)">未通过乘客身份验证</li>
        </ul>
        <div class="down1"></div>
        <div class="clear"></div>
      </div>
      <div class="user_list_drop_box" onclick="showAddToUserDrop(this)" >
        <span class="user_list_drop_box_span driver_span" cat_id="">车主身份验证条件</span>
        <span class="select_error_message">请选择车主身份验证验证条件</span>
        <ul class="user_list_drop_box_ul">
          <div class="cat_list_drop_box_li all_id" cat_id="" onclick="selectedCatDropList(this)">全部</div>
          <div class="clear cat_list_box"></div>
          <li class="cat_list_drop_box_li cat_list_style" cat_id=1 onclick="selectedCatDropList(this)">通过车主身份验证</li>
          <li class="cat_list_drop_box_li cat_list_style" cat_id=0 onclick="selectedCatDropList(this)">未通过车主身份验证</li>

        </ul>
        <div class="down1"></div>
        <div class="clear"></div>
      </div>
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
      <ul class="userManage_container_ul">
        <li class="userManage_container_li_top">
          <span class="userManage_span">用户名</span>
          <span class="userManage_span">身份证</span>
          <span class="userManage_span">手机号</span>
          <span class="userManage_span">加入时间</span>
          <span class="userManage_span">上次登陆时间</span>
          <span class="userManage_span">上次登陆IP</span>
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
