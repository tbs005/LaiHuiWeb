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
<script src="/resource/js/jquery-1.11.3.min.js"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
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
        loadUser();

        $('.menu_body').removeClass('open_menu_body');
        $('.menu_head').removeClass('current');
        $('.menu_body a').removeClass('change_menu');
        $('#extensionManage_head').addClass('current');
        $('#extensionManage_body').addClass('open_menu_body');
        $('#investmentExtension_menu').addClass('change_menu');

        pageSet.setPageNumber()
        // 绑定键盘按下事件
        $(document).keypress(function (e) {
            // 回车键事件
            if (e.which == 13) {
                jQuery('.search_ico').click();
            }
        });
        $('.user_list_drop_box').mouseleave(function () {
            $('.user_list_drop_box_ul').hide();
        });
    });

    var action_url="/business/manage";
    var count_array=[];
    var count_status=0;
    //ajax获取用户
    function updateLine(){
        count_array=[];
        loadUser();
    }
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
        count = global_data.total;
        loadPage.checkUserPrivilege(count,insertUserMessage);
    }
    //删除信息
    function deleteSingle(item){
        var obj={};
        var id = $(item).parent().parent().attr('id');
        obj.action='delete';
        obj.id=id;
        operation.operation_ajax(action_url,obj,loadUser);
    }
    //添加用户数据
    function insertUserMessage(){
        $('.user_manage_container_li').remove();
        for (var i = 0; i < global_data.slides.length; i++){
            var mobile = global_data.slides[i].mobile;//手机号
            var name = global_data.slides[i].name;//名字
            var address=global_data.slides[i].address;//身份证号
            var description=global_data.slides[i].description;//描述
            var way=global_data.slides[i].way;//加盟方式
            var create_time=global_data.slides[i].create_time;//加入时间
            var id=global_data.slides[i].id;//id
            addUserDisplay(name,mobile,address,description,way,create_time,id);
        }
    }
    //添加用户列表
    function addUserDisplay(name,mobile,address,description,way,create_time,id) {
        $(".userManage_container_ul").append('<li class="user_manage_container_li" id='+id+'>'+
            '<span class="userManage_span ">'+name+'</span>' +
            '<span class="userManage_span ">'+mobile+'</span>' +
            '<span class="userManage_span ">'+address+'</span>' +
            '<span id="show-option" title="'+description+'" class="userManage_span">'+description+'</span>' +
            '<span class="userManage_span">'+way+'</span>' +
            '<span class="userManage_span">'+create_time+'</span>' +
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
    //提示框js
    $(function() {
        $("#show-option").tooltip({
            show: {
                effect: "slideDown",
                delay: 250
            },
            position: {
                my: "left top",
                at: "left bottom"
            }

        });
    });
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

    function findMessage(){
        var obj={};
        obj.action='show';
        obj.size=size;
        obj.page=global_page;
        operation.operation_ajax(action_url,obj,sendMessage);
    }
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>招商管理</span>
      </div>
    </div>
    <div class="userManage_container">
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
          <span class="userManage_span">姓名</span>
          <span class="userManage_span">电话</span>
          <span class="userManage_span">地址</span>
          <span class="userManage_span">自我描述</span>
          <span class="userManage_span">合作方式</span>
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
