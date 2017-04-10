<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 11:09
  describtion:后台管理--【拼车信息汇】编辑人员信息
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
    margin-bottom: 30px;
  }

  .userManage_container_li_top {
    background-color: #f4f5f9;
  }

  .userManage_span {
    width: 24%;
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
    width: 23.6%;

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

  .detailAll_tip_no {
    margin-left: 14px;
  }




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

  .icon_edit {
    right: 22px;
    left: auto !important;
    cursor: pointer;
    display: none;
  }
</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    loadUser();
    $('.menu_context_li').removeClass('active_li');
    $('.db_editor_cumulate').addClass('active_li');
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

  });

  var global_cat_id;
  var check_click_search = 0;
  var click_type;
  var user_id;
  //ajax获取用户
  //封装传输的信息并提交
  function loadUser() {
      var obj={};
      obj.action='show';
      operation.operation_ajax('/api/db/editor/cumulate',obj,insertUserMessage);
  }
//  //查找信息
//  function findMessage() {
//    var obj = {};
//    var search = $('.search_user_input').val();
//    obj.action = 'show';
//    obj.keyword = search;
//    obj.size = size;
//    obj.page = global_page;
//    operation.operation_ajax('/db/api/validate_manager', obj, sendMessage);
//  }
//  //删除信息
//  function deleteSingle(item) {
//    var obj = {};
//    var id = $(item).parent().parent().attr('user_id');
//    obj.action = 'delete';
//    obj.id = id;
//    operation.operation_ajax('/db/api/validate_manager', obj, loadUser);
//  }
//  function sendMessage() {
//    $('.user_manage_container_li').remove();
//    count = global_data.total;
//    loadPage.checkUserPrivilege(count, insertUserMessage);
//  }
//  //添加审核员
//  function addManage() {
//    var obj = {};
//    var name = $('.manage_username').val();
//    var mobile = $('.manage_user_tell').val();
//    var password = $('.manage_user_password').val();
//    var description = $('.manage_user_remarks').val();
//    obj.action = 'add';
//    obj.name = name;
//    obj.mobile = mobile;
//    obj.password = password;
//    obj.description = description;
//    operation.operation_ajax('/db/api/validate_manager', obj, loadUser);
//    removeManagerStyle();
//  }
//  //修改审核员
//  function updateManage() {
//    var obj = {};
//    var name = $('.manage_username').val();
//    var mobile = $('.manage_user_tell').val();
//    var password = $('.manage_user_password').val();
//    var description = $('.manage_user_remarks').val();
//    if (password == "******") {
//      password = ""
//    }
//    obj.action = 'update';
//    obj.name = name;
//    obj.mobile = mobile;
//    obj.password = password;
//    obj.description = description;
//    obj.id = user_id;
//    operation.operation_ajax('/db/api/validate_manager', obj, loadUser);
//    removeManagerStyle();
//  }
//  function checkInputMessage() {
//    if ($('.manage_username').val() == "") {
//      showErrorTips("请输入审核员姓名")
//    } else if ($('.manage_user_tell').val() == "") {
//      showErrorTips("请输入审核员手机号")
//    } else if ($('.manage_user_password').val() == "") {
//      showErrorTips("请输入审核员密码")
//    } else if ($('.manage_user_remarks').val() == "") {
//      showErrorTips("请输入审核员备注")
//    } else {
//      if (click_type == 1) {
//        addManage()
//      } else {
//        updateManage()
//      }
//
//    }
//  }
  //添加用户数据
  function insertUserMessage() {
    $('.user_manage_container_li').remove();
    for (var i = 0; i < global_data.data.length; i++) {
      var name=global_data.data[i].name;
      var mobile=global_data.data[i].mobile;
      var all_count=global_data.data[i].all_count;
      var day_count=global_data.data[i].day_count;
      addUserDisplay(mobile, name, all_count, day_count);
    }
  }
  //添加用户列表
  function addUserDisplay(mobile, name, all_count, day_count) {
    $(".userManage_container_ul").append('<li class="user_manage_container_li">' +
            '<span class="userManage_span name">' + name + '</span>' +
            '<span class="userManage_span mobile">' + mobile + '</span>' +
            '<span class="userManage_span last_login_time">' + day_count + '</span>' +
            '<span class="userManage_span description">' +  all_count+ '</span>' +
            '</li>')
  }

</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>编辑人员信息统计</span>
        <%--<div class="search_user">--%>
        <%--<input type="text" placeholder="姓名、手机号" class="search_user_input">--%>
        <%--<a href="javascript:;" class="search_user_a">--%>
        <%--<div class="search_ico"></div>--%>
        <%--</a>--%>
        <%--</div>--%>
      </div>
    </div>
    <div class="userManage_container">
      <div class="clear"></div>
      <div class="sub_title_bar">
        <span class="sub_message"></span>
        <%--<span class="add_span" onclick="addManagerStyle()"><span class="add_classify">+</span>添加审核员</span>--%>
        <div class="clear"></div>
      </div>
      <ul class="userManage_container_ul">
        <li class="userManage_container_li_top">
          <span class="userManage_span">姓名</span>
          <span class="userManage_span">手机号</span>
          <span class="userManage_span">今日发布总数</span>
          <span class="userManage_span">累计发布总数</span>
        </li>
      </ul>
    </div>

  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>