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
<link rel="stylesheet" href="/resource/css/user_list.css" type="text/css">
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
<script src="/resource/js/user_list.js" type="text/javascript"></script>
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
      <span class="update_message" onclick="updateLine()">更新数据</span>
      <div id="container"></div>
      <div class="clear"></div>
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
          <span class="userManage_span" style="width:10%;">用户名</span>
          <span class="userManage_span" style="width:15%;">身份证</span>
          <span class="userManage_span" style="width:15%;">手机号</span>
          <span class="userManage_span" style="width:15%;">加入时间</span>
          <span class="userManage_span" style="width:16%;">上次登陆时间</span>
          <span class="userManage_span" style="width:15%;">上次登陆IP</span>
          <span class="userManage_span" style="width:10%;">操作</span>
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
<%--添加新页面--%>
<div class="slide_container" style=" overflow:scroll;border: 1px solid #F5AD4E;">
  <div class="slide_container_top">
    <span class="slide_container_top_title">用户详情</span>
    <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
  </div>
  <div class="slide_container_mid" style="border: 1px dashed #F5AD4E">
    <input type="hidden" id="userId"/><input type="hidden" id="traderNo"/>
    <table style="width:800px;margin-left:auto;">
      <tr style="height: 30px;"><td colspan="3" style="font-weight: bold;color:#F5AD4E;"></td></tr>
      <tr style="height: 30px;">
        <td>姓&emsp;&emsp;&emsp;&emsp;名：<input type="text" id="userName" readonly="true" ></td>
        <td>手&emsp;机&emsp;号：<input type="text" id="userMobile" readonly="true" ></td>
        <td>性&emsp;&emsp;别：<input type="text" id="userSex" readonly="true" ></td>
      </tr>
      <tr style="height: 30px;">
        <td>生&emsp;&emsp;&emsp;&emsp;日：<input type="text" id="birthday" readonly="true" ></td>
        <td>身份证号码：<input type="text" id="userIdsn" readonly="true" ></td>
        <td></td>
      </tr>
      <tr style="height: 30px;">
        <td>实名&emsp;&emsp;认证：<input type="text" id="isValidated" readonly="true" ></td>
        <td>是否&emsp;车主：<input type="text" id="isValidatedCar" readonly="true" ></td>
        <td>用户来源：<input type="text" id="userSource" readonly="true" ></td>
      </tr>
      <tr style="height: 30px;">
        <td colspan="2">个性&emsp;&emsp;签名：<input type="text" id="signature" readonly="true" style="width:428px;"></td>
        <td></td>
      </tr>
      <tr style="height: 30px;">
        <td colspan="2">公&emsp;&emsp;&emsp;&emsp;司：<input type="text" id="userCompany" readonly="true" style="width:428px;"></td>
        <td></td>
      </tr>
      <tr style="height: 30px;">
        <td>常驻&emsp;&emsp;地址：<input type="text" id="liveCity" readonly="true" ></td>
        <td>家&emsp;&emsp;&emsp;乡：<input type="text" id="userHome" readonly="true" ></td>
        <td></td>
      </tr>
      <tr style="height: 30px;">
        <td colspan="2">送货&emsp;&emsp;地址：<input type="text" id="deliveryAddress" readonly="true" style="width:428px;"></td>
        <td></td>
      </tr>
      <tr style="height: 30px;">
        <td>最近登录日期：<input type="text" id="lastLoginedTime" readonly="true" ></td>
        <td>最近登录IP：<input type="text" id="lastLoginIP" readonly="true" ></td>
        <td>创建日期：<input type="text" id="createTime" readonly="true" ></td>
      </tr>
      <tr style="height: 30px;"><td colspan="3" style="font-weight: bold;color:#F5AD4E;"></td></tr>
    </table>
  </div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
