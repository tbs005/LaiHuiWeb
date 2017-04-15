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
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
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

<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>招商加盟</span>
      </div>
    </div>
    <div class="userManage_container">
      <div class="sub_title_bar">
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
      <div class="userManage_container_li_top">
        <span class="userManage_span">姓名</span>
        <span class="userManage_span">电话</span>
        <span class="userManage_span">地址</span>
        <span class="userManage_span">合作方式</span>
        <span class="userManage_span">合作描述</span>
        <span class="userManage_span">创建时间</span>
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
    <script type="text/javascript">

        $.ajax({
            type: 'POST',
            url: '/business',
            data: {},
            dataType:'json',
            success:function(data){
                var cc=data.result.data;
                var aa = ''
                for(i=0;i<cc.length;i++){
                    aa += '<li class="user_manage_container_li"><span class="userManage_span">'+(cc[i].name)+'</span><span class="userManage_span">'+(cc[i].mobile)+'</span><span class="userManage_span">'+(cc[i].address)+'</span><span class="userManage_span">'+(cc[i].way)+'</span><span class="userManage_span">'+(cc[i].description)+'</span><span class="userManage_span">'+(cc[i].create_time)+'</span></li>'
                    $('.userManage_container_ul').html(aa)
                }
            },
            error: function(){
                $('.content_record_p').html("查询失败");
            }
        })
        $(document).ready(function () {
            loadUser();
            $('.menu_context_li').removeClass('active_li');
            $('.db_merchant_join').addClass('active_li');
            pageSet.setPageNumber()
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
            madeLine();
        });
        var global_cat_id;
        var check_click_search = 0;
        var action_url="/business";
        var start_time="";
        var end_time="";
        var count_array=[];
        var count_status=0;
        function loadUser(){
            var obj={};
            obj.size=size;
            obj.page=global_page;
            obj.is_passenger=1;
            obj.source=source;
            operation.operation_ajax(action_url,obj,sendMessage);
        }
        function sendMessage(){
            $('.user_manage_container_li').remove();
            loadPage.checkUserPrivilege(insertUserMessage);
        }
        /*查询数据*/
        function findMessage(){
            var obj={};
            var search = $('.search_user_input').val();
            obj.size=size;
            obj.page=global_page;
            operation.operation_ajax(action_url,obj,sendMessage);
        }
        //添加用户数据
        function insertUserMessage(){
            $('.user_manage_container_li').remove();
            for (var i = 0; i < global_data.data.length; i++){
                var mobile = global_data.data[i].mobile;//手机号
                var name = global_data.data[i].name;//名字
                var address=global_data.data[i].address;//身份证号
                var description=global_data.data[i].description;//描述
                var way=global_data.data[i].way;//加盟方式
                var create_time=global_data.data[i].create_time;//加入时间
                var id=global_data.data[i].id;//id
                addUserDisplay(mobile,name,idsn,address,description,way,create_time,id);
            }
        }
    </script>
    <%--底部--%>
    <jsp:include page="footer.jsp" flush="true"></jsp:include>
