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
<link href="/resource/css/sweetalert.css" rel="stylesheet">
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
<script src="/resource/js/md5-min.js"></script>
<script src="/resource/js/sweetalert.min.js" type="text/javascript"></script>

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
    position: relative;
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
    width: 20px;
    position: relative;
    line-height: 24px;
    top: -2px;
  }
  .car_list_down_span{
    margin-left: 10px;
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
    border-bottom-color: #F5AD4E;
    border-bottom-style: solid;
    top: 14px;
    border-left-width: 10px;
    border-right-width: 0px;
    border-top-width: 0px;
    border-bottom-width: 10px;
  }

  .select_checkbox_container {
    position: relative;
    display: inline-block;
    padding: 2px 6px;
    border: 1px solid #fff;
    margin-right: 10px;
    margin-bottom: 10px;
  }

  .select_checkbox_active {
    border: 1px solid #F5AD4E;
  }
  /*//调整央视*/
  .place_container{
    padding: 10px;
    box-shadow: 0px 0px 10px 0px #e8e8e8;
    margin-bottom: 30px;

  }
  .place_top{
    line-height: 38px;
  }
  .place_top span{
    border-left: 2px solid #F5AD4E;
    padding-left: 6px;
  }
  .place_city{
    padding: 5px;
  }
  .place_box_active{
    display: block;
  }
  .province{
    display: none;
  }
  .city{
    display: none;
  }
  .slide_container{
    width: 800px;
    z-index: 9;
    left: 16%;
    max-height: 90%;
    overflow-y: scroll;
  }
  .slide_container .place_container{
    margin: 10px 14px 20px;
    border: 2px dashed #e8e8e8;
    box-shadow: none;
  }
  .add_to_select{
    color: #f5ad4e;
    float: right;
    margin-left: 20px;
    text-align: right;
    line-height: 28px;
    cursor: pointer;
    display: none;
  }
  .add_to_select:hover{
    color: #FF8F0c;
  }
  .circle{
    width: 5px;
    height: 5px;
    background-color: #f5ad4e;
    display: inline-block;
    border-radius: 50%;
    position: relative;
    top: -2px;
    margin: 0 2px;
  }
  /*.input_list_province{*/
    /*margin-right: 5px;*/
  /*}*/
  .input_list_left{
    float: left;
  }
  .input_list_right{
    float: left;
    margin-left: 10px;
    color: #f5ad4e;
  }
  .remove_place{
    color: #e74c3c;
    margin-left: 20px;
    cursor: pointer;
  }
  .remove_place:hover{
    color: #c0392b;
  }
  .input_list{
    line-height: 30px;
    max-height: 120px;
    overflow: hidden;
    overflow-y: auto;
  }

  .submit_select_span{
    background-color: #f5ad4e;
    color: #fff;
    display: block;
    width: 50%;
    text-align: center;
    line-height: 32px;
    height: 32px;
    border-radius: 5px;
    margin: 30px auto;
    float: none;
  }
  @media screen and (max-width: 1204px) {
    .slide_container{
      width: 800px;
      z-index: 9;
      left: 0;
    }
  }
  .car_list_delete{
    position: absolute;
    top: 5px;
    right: 10px;
    cursor: pointer;
    color: #e74c3c;
    display: none;
  }
  .car_list_editor{
    position: absolute;
    top: 5px;
    right: 52px;
    cursor: pointer;
    color: #F5AD4E;
    display: none;
  }
  .car_list:hover>.car_list_delete{
    display: block;
  }
  .car_list:hover>.car_list_editor{
    display: block;
  }
</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    loadUser();
    $('.menu_context_li').removeClass('active_li');
    $('.db_manage_agent').addClass('active_li');
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
      findMessage(province_code);
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
    loadPlace();
  });

  var global_cat_id;
  var check_click_search = 0;

  var menu_type=1;
  var action='show';
  var action_url='/api/area/manager';
  var size = 30;
  var page_array=[15,30,60,120];

  var array_code=[];
  var check_array_code=[];

  var level="";
  var province_code="";
  var check_type="";
  var update_id;
  //ajax获取用户
  //封装传输的信息并提交
  function loadUser(){
    var obj={};
    obj.action=action;
    obj.size=size;
    obj.page=global_page;
    obj.status=menu_type;
    operation.operation_ajax(action_url,obj,sendMessage);
  }
  function sendMessage(){
    $('.car_list').remove();
    count = global_data.count;
    loadPage.checkUserPrivilege(count,insertUserMessage);
  }
  function findMessage(province_code){
    var obj={};
    var search = $('.search_user_input').val();
    var start_time = $('.select_start_time ').val();
    var end_time = $('.select_end_time ').val();
    obj.action=action;
    obj.keyword=search;
    obj.start_time=start_time;
    obj.end_time=end_time;
    obj.size=size;
    obj.page=global_page;
    obj.level=level;
    obj.code=province_code;
    operation.swal_ajax_find(action_url,obj,sendMessage);
  }

  //添加用户数据
  function insertUserMessage(){
    $('.user_manage_container_li').remove();
    for (var i = 0; i < global_data.data.length; i++){
      var create_time = global_data.data[i].create_time;//加入时间
      var idsn=global_data.data[i].idsn;//身份证号
      var mobile=global_data.data[i].mobile;//手机号
      var name=global_data.data[i].name;//名字
      var id=global_data.data[i].id;//id
      var allArea=global_data.data[i].allArea;//id
      var last_logined_time=global_data.data[i].last_logined_time;//最后登录时间
      carListStyle(allArea,name, mobile, create_time,id,last_logined_time);
    }
  }
  //添加车主列表
  function carListStyle(allArea,name, mobile, create_time,id,last_time) {
    $('.not_find_message').before('<li class="car_list" car_id='+id+'>' +
            '<div class="car_list_message" onclick="getId(this)">' +
            '<div class="car_list_down">' +
            '<div class="car_list_down_left">' +
            '<img class="car_list_down_img" src="/resource/images/pc_icon_user.png" alt="姓名">'+
            '<span class="car_list_down_span user_name">' + name + '</span>' +
            '</div>' +
            '<div class="car_list_down_left">' +
            '<img class="car_list_down_img" src="/resource/images/pc_icon_tell.png" alt="手机号">'+
            '<span class="car_list_down_span user_mobile">' + mobile + '</span>' +
            '</div>' +
            '<div class="car_list_down_left">' +
            '<img class="car_list_down_img" src="/resource/images/pc_icon_endRoute.png" alt="管理区域">'+
            '<span class="car_list_down_span">'+allArea+'</span>' +
            '</div>' +
//            '<div class="car_list_down_left">' +
//            '<span style="color:#999">发车总数：'+200+'次</span>'+
//            '</div>' +
            '<div class="car_list_down_left">' +
            '<span style="color:#999">创建时间：'+create_time+'</span>'+
            '</div>' +
            '<div class="car_list_down_left">' +
            '<span style="color:#999">最近登陆时间：'+last_time+'</span>'+
            '</div>' +
            '<div class="clear"></div>' +
            '</div>' +
            '</div>' +
            '<span class="car_list_editor" onclick="changeList(this)">修改</span>' +
            '<span class="car_list_delete" onclick="deleteList(this)">删除</span>' +

            '</li>')
  }
  function changeList(obj){
    check_type="update";
    update_id = $(obj).parent().attr('car_id');
    var user_name = $(obj).parent().find('.user_name').text();
    var user_mobile = $(obj).parent().find('.user_mobile').text();
    $('.input_list_box').remove();
    $('.city').hide();
    $('.place_container_submit').find('.province_select').removeClass('select_checkbox_active');
    $('.place_container_submit').find('.province_select_all').addClass('select_checkbox_active');
    $('.place_container_submit').find('.city_select').removeClass('select_checkbox_active');
    $('.place_container_submit').find('.city_select_all').addClass('select_checkbox_active');
    $('.input_style').val("");
    $('.message_name').val(user_name).attr('disabled','disabled');
    $('.message_tell').val(user_mobile).attr('disabled','disabled');
    $('.message_password').val("******").attr('disabled','disabled');
    click_type=0;
    $('.slide_container').animate({"top":"2%","opacity":"1"},300);
    $('.slide_container_top').find('.slide_container_top_title').text('修改代理商信息');
    $('.submit_select_sure').text('保存修改');
  }
  function deleteList(obj) {
    var user_id = $(obj).parent().attr('car_id');
    swal({
      title: "确定删除?",
      text: "删除后将无法恢复，请谨慎操作！",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      closeOnConfirm: false,
      showLoaderOnConfirm: true
    }, function () {
      setTimeout(function(){
        deleteMessage(user_id)
      }, 2000);

    });
  }
  //获取点击id并跳转
  function getId(obj) {
    var user_id = $(obj).parent().attr("car_id");
    window.location.href = "/db/manage/agent/area/count?id=" + user_id+"&end";
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

  function addManagerStyle(){
    check_type="add";
    array_code=[];
    $('.input_list_box').remove();
    $('.city').hide();
    $('.place_container_submit').find('.province_select').removeClass('select_checkbox_active');
    $('.place_container_submit').find('.province_select_all').addClass('select_checkbox_active');
    $('.place_container_submit').find('.city_select').removeClass('select_checkbox_active');
    $('.place_container_submit').find('.city_select_all').addClass('select_checkbox_active');
    $('.input_style').val("").removeAttr('disabled');
    click_type=0;
    $('.slide_container').animate({"top":"2%","opacity":"1"},300);
    $('.slide_container_top').find('.slide_container_top_title').text('添加代理商');
    $('.submit_select_sure').text('添加');
  }

  function removeManagerStyle(){
    click_type=1;
    $('.slide_container').animate({"top":"-220%","opacity":"0"},300);
  }
  //选择标签
  function addTabStyle(obj) {
    province_code = $(obj).attr('data_id');
    var check_level = $(obj).attr('data_id');
    if(province_code == -11){
      province_code="";

    }else if(province_code == -22){
      province_code =$(obj).closest('.place_container_find').find('.country').find('.select_checkbox_active').attr('data_id');
    }else if(province_code == -33){
      province_code =$(obj).closest('.place_container_find').find('.province').children('.place_city').children('.select_checkbox_active').attr('data_id');
    }else{

    }


//    判断选择条件
    if($(obj).closest('.place_box ').find('.place_top_span').text()=="省份"){

      if ($(obj).hasClass('select_checkbox_active')) {
        $(obj).removeClass('select_checkbox_active')
      } else {
        $(obj).parent().children('.select_checkbox_container').removeClass('select_checkbox_active');
        $(obj).addClass('select_checkbox_active');
      }

      //如果是省份
      if($(obj).closest('.place_container').hasClass('place_container_find')){
        if(check_level == -11){
          level = "";
        }else{
          level = 1;
          loadCityPlace();
        }
        $('.province_select_find').remove();
        findMessage(province_code);
      }else{
        $('.province_select_submit').remove();
        loadSubmitCityPlace();
      }

      if($(obj).children('.select_checkbox').attr('index')==-1){
        $(obj).closest('.place_container').find('.province').hide();
      }else{
        $(obj).closest('.place_container').find('.province').show();
      }
      //市区重置
      $(obj).closest('.place_container').find('.province_select').removeClass('select_checkbox_active');
      $(obj).closest('.place_container').find('.province_select_all').addClass('select_checkbox_active');

      $(obj).closest('.place_container').find('.city').hide();
      $('.add_to_select').hide();
      $(obj).closest('.place_container').find('.city_select').removeClass('select_checkbox_active');
      $(obj).closest('.place_container').find('.city_select_all').addClass('select_checkbox_active');
    }else if($(obj).closest('.place_box ').find('.place_top_span').text()=="市区"){

      if ($(obj).hasClass('select_checkbox_active')) {
        $(obj).removeClass('select_checkbox_active')
      } else {
        $(obj).parent().children('.select_checkbox_container').removeClass('select_checkbox_active');
        $(obj).addClass('select_checkbox_active');
      }

      if($(obj).closest('.place_container').hasClass('place_container_find')){
        if(check_level == -22){
          level = 1;
        }else{
          level = 2;
          loadCountryPlace();
        }

        findMessage(province_code);
      }else{
        $('.city_select_submit').remove();
        loadSubmitCountryPlace();
      }
      if($(obj).children('.select_checkbox').attr('index')==-2){
        $(obj).closest('.place_container').find('.city').hide();
        $('.add_to_select').hide();
      }else{
        $(obj).closest('.place_container').find('.city').show();
        $('.add_to_select').show();
      }

      $(obj).closest('.place_container').find('.city_select').removeClass('select_checkbox_active');
      $(obj).closest('.place_container').find('.city_select_all').addClass('select_checkbox_active');

    }else{



      if($(obj).closest('.place_container').hasClass('place_container_find')){
        if ($(obj).hasClass('select_checkbox_active')) {
          $(obj).removeClass('select_checkbox_active')
        } else {
          $(obj).parent().children('.select_checkbox_container').removeClass('select_checkbox_active');
          $(obj).addClass('select_checkbox_active');
        }
        level = 3;
        findMessage(province_code);
      }else{
        if ($(obj).hasClass('select_checkbox_active')) {
          $(obj).removeClass('select_checkbox_active');
        } else {
          $(obj).addClass('select_checkbox_active');
        }
      }
    }
  }

  //加载全国区域
  function loadPlace(){
    $('.country_select').remove();
    var obj={};
    obj.action='province';
    operation.operation_ajax('/place/code',obj,provincePlaceStyle);
  }

//  添加省份地区样式
  function provincePlaceStyle(){

    for(var i=global_data.data.length-1;i>=0;i--){
      $('.country_select_all').after('<div class="select_checkbox_container country_select country_select_find" onclick="addTabStyle(this)" data_id='+global_data.data[i].code+'>'+
              '<span class="select_checkbox" index="1">'+global_data.data[i].place+'</span>'+
              '<i class="select_popover_arrow"></i>'+
              '</div>')
    }
  }
  //加载全市区域
  function loadCityPlace(){
    var obj={};
    obj.action='city';
    obj.code=province_code;
    operation.operation_ajax('/place/code',obj,cityPlaceStyle);
  }
  //  添加市区地区样式
  function cityPlaceStyle(){

    for(var i=global_data.data.length-1;i>=0;i--){
      $('.province_select_all').after('<div class="select_checkbox_container province_select province_select_find" onclick="addTabStyle(this)" data_id='+global_data.data[i].code+'>'+
              '<span class="select_checkbox" index="1">'+global_data.data[i].place+'</span>'+
              '<i class="select_popover_arrow"></i>'+
              '</div>')
    }

  }
  //加载全县区域
  function loadCountryPlace(){
    $('.city_select_find').remove();
    var obj={};
    obj.action='query_county';
    obj.code=province_code;
    operation.operation_ajax2('/place/code',obj,countryPlaceStyle);
  }
  //  添县区地区样式
  function countryPlaceStyle(){
    if(global_data.data.length==0){
      $('.place_container_submit').children('.city').hide();
      level =3;
    }else{
      for(var i=global_data.data.length-1;i>=0;i--){

        $('.city_select_all_message').after('<div class="select_checkbox_container city_select city_select_find" onclick="addTabStyle(this)" data_id='+global_data.data[i].code+'>'+
                '<span class="select_checkbox" index="1">'+global_data.data[i].place+'</span>'+
                '<i class="select_popover_arrow"></i>'+
                '</div>')
      }

    }
  }



  //加载全国区域
  function loadSubmitPlace(){
    $('.country_select').remove();
    var obj={};
    obj.action='province';
    obj.level='1';
    operation.operation_ajax('/place/code',obj,provincePlaceStyle);
  }



  //加载全市区域
  function loadSubmitCityPlace(){
    var obj={};
    obj.action='city';
    obj.code=province_code;
    operation.operation_ajax('/place/code',obj,citySubmitPlaceStyle);
  }


  //  添加市区地区样式
  function citySubmitPlaceStyle(){
    for(var i=global_data.data.length-1;i>=0;i--){
      $('.province_submit').after('<div class="select_checkbox_container province_select province_select_submit" onclick="addTabStyle(this)" data_id='+global_data.data[i].code+'>'+
              '<span class="select_checkbox" index="1">'+global_data.data[i].place+'</span>'+
              '<i class="select_popover_arrow"></i>'+
              '</div>')
    }

  }


  //加载全县区域
  function loadSubmitCountryPlace(){
    var obj={};
    obj.action='county';
    obj.code=province_code;
    operation.operation_ajax('/place/code',obj,countrySubmitPlaceStyle);
  }

  //  添县区地区样式
  function countrySubmitPlaceStyle(){
    for(var i=global_data.data.length-1;i>=0;i--){
      $('.city_submit').after('<div class="select_checkbox_container city_select city_select_submit" onclick="addTabStyle(this)" data_id='+global_data.data[i].code+'>'+
              '<span class="select_checkbox" index="1">'+global_data.data[i].place+'</span>'+
              '<i class="select_popover_arrow"></i>'+
              '</div>')
    }
  }


//  选择添加管理区域
  function addSelect(obj){
    array_code=[]
    var country_select = $(obj).parent().find('.country').find('.select_checkbox_active').children('span').text();

      for(var i=0;i<$(obj).parent().find('.city').find('.select_checkbox_active').length;i++){
        var array_obj={}
        var city_select_code = $($(obj).parent().find('.city').find('.select_checkbox_active')[i]).attr('data_id');
        var province_select = $($(obj).parent().find('.province').find('.select_checkbox_active')[i]).children('span').text();
        var city_select = $($(obj).parent().find('.city').find('.select_checkbox_active')[i]).children('span').text();
        if(city_select ==""){
          array_obj.area_name = province_select;
        }else{
          array_obj.area_name = city_select;
        }
        array_obj.area_code = city_select_code;
        array_code.push(array_obj);
      }
    addSelectStyle()

  }

  function addSelectStyle(){
    $('.input_list_right').empty();
    for(var j=0;j<array_code.length;j++){
      $('.input_list_right').append('<div class="input_list_box" submit_code = '+array_code[j].area_code+'>'+
              '<span class="input_list_city"> '+array_code[j].area_name+'</span>'+
              '<span class="remove_place" onclick="removeMessage(this)">移除</span>'+
              '</div>');
    }
  }

  //  移除选择区域
  function removeMessage(obj){
    var index= $(obj).parent().index();
    var change_active = $('.city').find('.select_checkbox_active');
    for(var i=0;i<change_active.length;i++){
      if(array_code[index].area_code == $(change_active[i]).attr('data_id')){
        $(change_active[i]).removeClass('select_checkbox_active');
      }
    }
    $(obj).parent().remove();
    array_code.splice(index,1);
    addSelectStyle()
  }
  //  移除选择区域
  function clearMessage(){
    $('.slide_container').animate({"top":"-220%","opacity":"0"},300);
    loadUser();
  }
  function checkInputMessage(){
//    var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
    if($('.message_name').val().trim()==""){
      showErrorTips('用户名不能为空');
    }else if($('.message_tell').val().trim()==""){
      showErrorTips('手机号不能为空');
    }else if($('.message_tell').val().length!=11){
      showErrorTips('手机号格式不正确');
    }else if($('.message_password').val().trim()==""){
      showErrorTips('密码不能为空');
    }else if(array_code.length==0){
      showErrorTips('请选择管理区域');
    }else{
      addMessage()
    }
  }

  function addMessage(){
    var obj={};
    var json = JSON.stringify(array_code);
    if(check_type=="update"){
      obj.id=update_id;
    }
    obj.action=check_type;
    obj.name=$('.message_name').val();
    obj.mobile=$('.message_tell').val();
    obj.md5_password= hex_md5($('.message_password').val());
    obj.area_json=json;
    operation.swal_ajax_manager('/api/area/manager',obj,clearMessage);
  }

//  删除用户
  function deleteMessage(item){
    var obj={};
    obj.action='delete';
    obj.id=item;
    operation.swal_ajax_manager('/api/area/manager',obj,loadUser);
  }
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>代理商管理</span>
        <div class="search_user">
          <input type="text" placeholder="姓名、手机号" class="search_user_input">
          <a href="javascript:;" class="search_user_a">
            <div class="search_ico"></div>
          </a>
        </div>
      </div>
    </div>
    <div class="userManage_container">
      <div class="place_container place_container_find">
        <div class="place_box country">
          <div class="place_top">
            <span class="place_top_span">省份</span>
          </div>
          <div class="place_city">
            <div class="select_checkbox_container country_select_all select_checkbox_active" data_id="-11" onclick="addTabStyle(this)">
              <span class="select_checkbox" index="-1">全国</span>
              <i class="select_popover_arrow"></i>
            </div>

          </div>
        </div>

        <div class="place_box province" date="123">
          <div class="place_top">
            <span class="place_top_span">市区</span>
          </div>
          <div class="place_city" date="456">
            <div class="select_checkbox_container  select_checkbox_active  province_select_all" data_id="-22" onclick="addTabStyle(this)">
              <span class="select_checkbox" index="-2">全部</span>
              <i class="select_popover_arrow"></i>
            </div>
          </div>
        </div>

        <div class="place_box city">
          <div class="place_top">
            <span class="place_top_span">县区</span>
          </div>
          <div class="place_city">
            <div class="select_checkbox_container  select_checkbox_active city_select_all city_select_all_message" data_id="-33" onclick="addTabStyle(this)">
              <span class="select_checkbox" index="-3">全部</span>
              <i class="select_popover_arrow"></i>
            </div>
          </div>
        </div>
      </div>
      <div class="user_list_drop_box">
        <input id="datepicker" name="publish_time" placeholder="选择开始时间" class="select_time select_start_time" onchange="findMessage(province_code)">
      </div>
      <div class="user_list_drop_box">
        <input id="datepicker2" name="publish_time" placeholder="选择结束时间" class="select_time select_end_time" onchange="findMessage(province_code)">
      </div>

      <div class="clear"></div>
      <div class="sub_title_bar">
        <span class="sub_message"></span>
        <span class="add_span" onclick="addManagerStyle()"><span class="add_classify">+</span>新建代理</span>
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
    <%--添加版面--%>
    <div class="slide_container">
      <div class="slide_container_top">
        <span class="slide_container_top_title"></span>
        <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
      </div>
      <div class="slide_container_mid">
        <div class="input_list">
          <img src="/resource/images/pc_icon_user.png" />
          <input type="text" placeholder="姓名" class="input_style message_name" />
        </div>
        <div class="input_list">
          <img src="/resource/images/pc_icon_tell.png" />
          <input type="text" placeholder="手机号" class="input_style message_tell" />
        </div>
        <div class="input_list">
          <img src="/resource/images/pc_icon_password.png" />
          <input type="text" placeholder="密码" class="input_style message_password" />
        </div>
        <div class="input_list ">
          <div class="input_list_left">管理区域：</div>
          <div class="input_list_right">

          </div>
          <div class="clear message_content"></div>
        </div>
        <div class="place_container place_container_submit" >
          <%--省--%>
          <div class="place_box country">
            <div class="place_top">
              <span class="place_top_span">省份</span>
            </div>
            <div class="place_city">
              <div class="country_select_all" style="display: none" data_id="-1" onclick="addTabStyle(this)">
                <span class="select_checkbox" index="-1">全国</span>
                <i class="select_popover_arrow"></i>
              </div>
            </div>
          </div>
          <%--市--%>
          <div class="place_box province">
            <div class="place_top">
              <span class="place_top_span">市区</span>
            </div>
            <div class="place_city">
              <div class="province_submit"  style="display: none" data_id="-2" onclick="addTabStyle(this)">
                <span class="select_checkbox" index="-2">全部</span>
                <i class="select_popover_arrow"></i>
              </div>
            </div>
          </div>
          <%--区--%>
          <div class="place_box city">
            <div class="place_top">
              <span class="place_top_span">县区</span>
            </div>
            <div class="place_city">
              <div class="city_submit" style="display: none"  data_id="-3" onclick="addTabStyle(this)">
                <span class="select_checkbox" index="-3">全部</span>
                <i class="select_popover_arrow"></i>
              </div>
            </div>
          </div>
          <%--添加--%>
          <div class="add_to_select" onclick="addSelect(this)">+添加管理区域</div>
            <div class="clear"></div>
        </div>
        <div class="submit_select">
          <span class="submit_select_span main_color submit_select_sure" onclick="checkInputMessage()">添加</span>
          <div class="clear"></div>
        </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
