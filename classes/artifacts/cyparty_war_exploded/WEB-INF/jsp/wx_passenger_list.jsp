<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 11:09
  describtion:后台管理--【用户管理】微信乘客列表
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<style>
  .userManage_container {
    width: 902px;
    margin: 30px auto 0;
    min-height: 550px;
  }

  .userManage_container_ul {
    width: 106%;
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

  /*微信列表*/
  .weixin_conyainer{
    padding: 5px;
    border: 1px solid #e8e8e8;
    float: left;
    margin-right: 20px;
    margin-bottom: 30px;
    width: 288px;
    cursor: pointer;
  }
  .weixin_conyainer:hover{
    box-shadow: 2px 2px 10px 2px #e8e8e8;
  }
  .weixin_conyainer_left{
    float: left;
    width: 66px;
    margin-right: 10px;
  }
  .weixin_conyainer_left img{
    width: 100%;
    border-radius: 50%;
    max-height: 66px;
  }
  .weixin_conyainer_right{
    float: left;
    width: 72%;
  }
  .weixin_username{
    font-size: 16px;
    margin-bottom: 6px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
  .weixin_mobile{
    margin-bottom: 4px;
  }
  .mobile_style{
    color: #999;
    margin-left: 8px;
  }
  .count_style{
    color: #2ecc71;
    margin-left: 8px;
  }

</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    loadUser();
    $('.menu_context_li').removeClass('active_li');
    $('.wx_passenger_list').addClass('active_li');
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
    loadWXUser();
  });

  var global_cat_id;
  var check_click_search = 0;
  var action_url="/api/car_owner/cumulate";
  var size=30;
  var array_date=[];
  var page_array=[15,30,60,90,120];
  //ajax获取用户
  //封装传输的信息并提交
  function loadUser(){
    $('.weixin_conyainer').remove();
    var obj={};
    obj.action='show_passenger_list';
    obj.size=size;
    obj.page=global_page;
    operation.operation_ajax2(action_url,obj,sendMessage);
  }
  //加载微信统计数据
  function loadWXUser(){
    var obj={};
    obj.action='passenger_count';
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
        text: '微信乘客新增统计'      //指定图表标题
      },
      xAxis: {
        categories: time_array   //指定x轴分组
      },
      yAxis: {
        title: {
          text: '单位/人'                  //指定y轴的标题
        }
      },
      series: [{                                 //指定数据列
        name: '微信乘客增长数',                          //数据列名
        data: count,                      //数据
        color:'#f5ad4e'
      }]
    });
  }


  function sendMessage(){
    $('.user_manage_container_li').remove();
    var total = global_data.total;
    loadPage.checkUserPrivilege(total,insertUserMessage);
  }
  function findMessage(){
    $('.weixin_conyainer').remove();
    var obj={};
    var search = $('.search_user_input').val();
    obj.action='show_passenger_list';
    obj.keyword=search;
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
      var user_avatar = global_data.data[i].user_avatar;
      var user_id = global_data.data[i].user_id;
      var user_mobile = global_data.data[i].user_mobile;
      var user_name = global_data.data[i].user_name;
      var count = global_data.data[i].count;
      if(user_avatar==""){
        user_avatar="/resource/images/icon_people.png";
      }
      addUserDisplay(user_avatar,user_id,user_mobile,user_name,count);
    }
  }
  //添加用户列表
  function addUserDisplay(user_avatar,user_id,user_mobile,user_name,count) {
    $(".userManage_container_clear").before('<li class="weixin_conyainer" index='+user_id+' onclick="toDetail(this)">'+
            '<div class="weixin_conyainer_left">'+
            '<img src='+user_avatar+'>'+
            '</div>'+
            '<div class="weixin_conyainer_right">'+
            '<div class="weixin_username">'+
            '<span>'+user_name+'</span>'+
            '</div>'+
            '<div class="weixin_mobile">'+
            '<span>手机号</span>'+
            '<span class="mobile_style">'+user_mobile+'</span>'+
            '</div>'+
            '<div class="weixin_count">'+
            '<span>发车总数</span>'+
            '<span class="count_style">'+count+'条</span>'+
            '</div>'+
            '</div>'+
            '<div class="clear"></div>'+
            '</li>')
  }
  function toDetail(obj){
    window.location.href="/db/wx_passenger/departure_info?id="+$(obj).attr('index');
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
        <span>乘客信息列表</span>
        <div class="search_user">
          <input type="text" placeholder="姓名、手机号" class="search_user_input">
          <a href="javascript:;" class="search_user_a">
            <div class="search_ico"></div>
          </a>
        </div>
      </div>
    </div>
    <div class="userManage_container">
      <div id="container">

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
          <span class="page_set_number show_page">30</span>
          <span class="page_set_style">条</span>
          <ul class="page_set_ul">

          </ul>
          <div class="down1"></div>
          <div class="clear"></div>
        </div>
        <div class="clear"></div>
      </div>
      <ul class="userManage_container_ul">
        <%--<li class="userManage_container_li_top">--%>
        <%--<span class="userManage_span">用户名</span>--%>
        <%--<span class="userManage_span">手机号</span>--%>
        <%--</li>--%>

        <div class="clear userManage_container_clear"></div>
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
