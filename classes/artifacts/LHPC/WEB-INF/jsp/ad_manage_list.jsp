<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/10
  Time: 11:09
  describtion:后台管理--【拼车信息会】路线管理列表
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
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
    width: 22%;
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
  .userManage_container_li_top span{
    width: 21.6%;

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
    right: 56px;
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
    left: 48%;
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


  /*添加线路模版*/
  .change_box{
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
  .change_delete{
    background-color: #e74c3c;
  }
  .change_find{
    background-color: #1abc9c;
  }


  /*/!*table*!/*/
  /*li {*/
    /*list-style: none;*/
  /*}*/
  /*.table_ul{*/
    /*/!* display: table-cell; *!/*/
    /*border: 1px solid #e8e8e8;*/
     /*width: 100%;*/
    /*box-sizing: border-box;*/
    /*-webkit-box-sizing: border-box;*/
    /*-moz-box-sizing: border-box;*/
  /*}*/
  /*.table_li_top{*/
    /*line-height: 38px;*/
    /*text-align: center;*/
  /*}*/
  /*.table_li_top_span{*/
    /*display: block;*/
    /*width: 25%;*/
    /*float: left;*/
    /*border-right: 1px solid #e8e8e8;*/
  /*}*/
  /*.table_li{*/
    /*line-height: 38px;*/
    /*border-top: 1px solid #e8e8e8;*/
  /*}*/
  /*.table_li_left{*/
    /*display: table-cell;*/
    /*width: 200px;*/
    /*text-align: center;*/
    /*vertical-align: middle;*/
  /*}*/
  /*.table_li_right{*/
    /*display: table-cell;*/
    /*width: 85%;*/
  /*}*/
  /*.table_right_li_span{*/
    /*display: block;*/
    /*width: 25%;*/
    /*float: left;*/
    /*border-left: 1px solid #e8e8e8;*/
    /*text-indent: 10px;*/
  /*}*/
  /*.table_right_li{*/
    /*border-bottom: 1px solid #e8e8e8;*/
  /*}*/
  /*.clear{*/
    /*clear: both;*/
  /*}*/
  /*/!*end_table*!/*/
</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    loadUser();
    $('.menu_context_li').removeClass('active_li');
    $('.ad_manage_list').addClass('active_li');
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


  });

  var global_cat_id;
  var check_click_search = 0;
  var action_url="/ad/manage";
  var click_type;
  var user_id;
  //ajax获取用户
  //封装传输的信息并提交
  function loadUser(){
    var obj={};
    global_page = 0;
    obj.action='show';
    obj.size=size;
    obj.page=global_page;
    operation.operation_ajax(action_url,obj,sendMessage);
  }
  //查找信息
  function findMessage(){
    var obj={};
    var search = $('.search_user_input').val();
    obj.action='show';
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
  function sendMessage(){
    $('.user_manage_container_li').remove();
    count = global_data.total;
    loadPage.checkUserPrivilege(count,insertUserMessage);
  }

  //添加用户数据
  function insertUserMessage(){
    $('.user_manage_container_li').remove();
    for (var i = 0; i < global_data.data.length; i++){
      var total=global_data.data[i].total;//广告数量
      var create_time=global_data.data[i].create_time.substring(0,16);//创建时间
      var dest_name=global_data.data[i].dest_name;//目的地
      var id=global_data.data[i].id;
      var total_weight=global_data.data[i].total_weight;//权重

      addUserDisplay(total,dest_name,create_time,id,total_weight);
    }
  }
  //添加用户列表
  function addUserDisplay(total,dest_name,create_time,id,total_weight) {
    $(".userManage_container_ul").append('<li class="user_manage_container_li" user_id='+id+' onmouseleave="hideDeleteTip(this)">' +
            '<span class="userManage_span manage_departure">'+dest_name+'</span>' +
            '<span class="userManage_span manage_destination">'+total+'</span>' +
            '<span class="userManage_span manage_driving_length">'+total_weight+'</span>' +
            '<span class="userManage_span manage_cost">'+create_time+'</span>' +
//            '<div class="user_list_checklist_del_active" onclick="showDeleteTip(this)"></div>' +
            '<span class="change_box change_find" onclick="toDetail(this)">查看详情</span>'+
//            '<span class="change_box change_delete" onclick="showDeleteTip(this)">删除</span>'+
//            '<span class="change_box change_edit" onclick="showEditTip(this)">编辑</span>'+
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
  //获取点击id并跳转
  function toDetail(obj) {
    var dest_name=$(obj).parent().children('.manage_departure').text();
    var id=$(obj).parent().attr('user_id');
    window.location.href = "/db/ad_manage_editor?dest_name=" + dest_name+"&id="+id+"&end";
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
        <span>目的地广告配置</span>

      </div>
    </div>
    <div class="userManage_container">
      <div class="clear"></div>
      <div class="sub_title_bar">
        <span class="sub_message"></span>
        <a href="/db/ad_manage_create" class="add_span"><span
                class="add_classify">+</span>新建广告</a>
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
          <span class="userManage_span">目的地</span>
          <span class="userManage_span">广告数量</span>
          <span class="userManage_span">权重</span>
          <span class="userManage_span">创建时间</span>
        </li>
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
  <%--&lt;%&ndash;表格样式&ndash;%&gt;--%>
  <%--<ul class="table_ul">--%>
    <%--<li class="table_li_top">--%>
      <%--<span class="table_li_top_span">名称1</span>--%>
      <%--<span class="table_li_top_span">名称2</span>--%>
      <%--<span class="table_li_top_span">名称3</span>--%>
      <%--<span class="table_li_top_span" style="border:none">名称4</span>--%>
      <%--<div class="clear"></div>--%>
    <%--</li>--%>
    <%--<li class="table_li">--%>
      <%--<div class="table_li_left">--%>
        <%--<span>名称5</span>--%>
      <%--</div>--%>
      <%--<div class="table_li_right">--%>
        <%--<div class="table_right_li">--%>
          <%--<span class="table_right_li_span">名称6</span>--%>
          <%--<span class="table_right_li_span">名称7</span>--%>
          <%--<span class="table_right_li_span">名称8</span>--%>
          <%--<span class="table_right_li_span">名称9</span>--%>
          <%--<div class="clear"></div>--%>
        <%--</div>--%>
        <%--<div class="table_right_li"  style="border: none">--%>
          <%--<span class="table_right_li_span">名称10</span>--%>
          <%--<span class="table_right_li_span">名称11</span>--%>
          <%--<span class="table_right_li_span">名称12</span>--%>
          <%--<span class="table_right_li_span">名称13</span>--%>
          <%--<div class="clear"></div>--%>
        <%--</div>--%>
      <%--</div>--%>
      <%--<div class="clear"></div>--%>
    <%--</li>--%>
    <%--<li class="table_li">--%>
      <%--<div class="table_li_left">--%>
        <%--<span>名称5</span>--%>
      <%--</div>--%>
      <%--<div class="table_li_right">--%>
        <%--<div class="table_right_li">--%>
          <%--<span class="table_right_li_span">名称6</span>--%>
          <%--<span class="table_right_li_span">名称7</span>--%>
          <%--<span class="table_right_li_span">名称8</span>--%>
          <%--<span class="table_right_li_span">名称9</span>--%>
          <%--<div class="clear"></div>--%>
        <%--</div>--%>
        <%--<div class="table_right_li"  style="border: none">--%>
          <%--<span class="table_right_li_span">名称10</span>--%>
          <%--<span class="table_right_li_span">名称11</span>--%>
          <%--<span class="table_right_li_span">名称12</span>--%>
          <%--<span class="table_right_li_span">名称13</span>--%>
          <%--<div class="clear"></div>--%>
        <%--</div>--%>
      <%--</div>--%>
      <%--<div class="clear"></div>--%>
    <%--</li>--%>
    <%--<li class="table_li">--%>
      <%--<div class="table_li_left">--%>
        <%--<span>名称5</span>--%>
      <%--</div>--%>
      <%--<div class="table_li_right">--%>
        <%--<div class="table_right_li"  style="border: none">--%>
          <%--<span class="table_right_li_span">名称10</span>--%>
          <%--<span class="table_right_li_span">名称11</span>--%>
          <%--<span class="table_right_li_span">名称12</span>--%>
          <%--<span class="table_right_li_span">名称13</span>--%>
          <%--<div class="clear"></div>--%>
        <%--</div>--%>
      <%--</div>--%>
      <%--<div class="clear"></div>--%>
    <%--</li>--%>
  <%--</ul>--%>
  <%--&lt;%&ndash;表格结束&ndash;%&gt;--%>
</div>


<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>