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
    display: none;
  }

  .userManage_container_ul {
    border: 1px solid #e8e8e8;
    margin-top: 20px;
    margin-bottom: 20px;
  }

  .userManage_container_li_top {
    background-color: #f4f5f9;
  }

  .userManage_span {
    width: 20%;
    display: inline-block;
    text-align: center;
    line-height: 40px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    font-size: 14px;
    vertical-align: middle;
  }

  .user_manage_container_li {
    border-top: 1px dashed #e8e8e8;
    cursor:pointer;
    position: relative;
    padding: 10px 0;
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
    width: 19.6%;

  }

  .select_error_message {
    color: #f5ad4e;
    position: absolute;
    left: 30px;
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
  .ad_pic_url{
    width: 90%;
  }
  .sub_message{
    margin-right: 60px;
  }


  /*广告添加编辑*/

  .goods_ueditor {
    width: 802px;
    margin: 30px auto;
    min-height: 350px;
    display: none;
  }



  .author_list_message_ico_box {
    margin-right: 20px;
    width: 101%;
    margin-bottom: 30px;
  }

  .author_list_message_ico_box img {
    /*width: 100%;*/
    height: 100%;
    display: none;
    margin: 0 auto;
    /*margin: 10px 0 0 10px;*/
  }

  .editor_mid_box {
    height: 200px;
    width: 100%;
    margin: 5px;
    border: 2px dashed #d2d4d5;
    background-color: #f7f9fa;
    position: relative;
    overflow: hidden;
    cursor: pointer;
    text-align: center;
    margin-bottom: 20px;
  }

  .editor_mid_box_img {
    margin: 66px auto 10px;
    display: block;
    background: transparent url("/resource/images/icon_photo.png") -50px 0 no-repeat;
    width: 50px;
    height: 48px;
    color: rgba(0, 0, 0, 0.58);
    text-shadow: 0 1px 0 #fff;
  }

  .editor_mid_box_txt {
    text-align: center;
    color: #b7bfc5;
  }

  .editor_mid_box .file_prew {
    width: 100%;
    height: 100%;
    position: absolute;
    opacity: 0;
    filter: alpha(opacity=0);
    cursor: pointer;
  }

  form {
    height: 100%;
  }

  .editor_cancel {
    width: 20px;
    height: 20px;
    position: absolute;
    top: 4px;
    right: 0;
    display: none;
    background: transparent url("/resource/images/icon_photo.png") -148px 0 no-repeat;
  }



  .goods_source_li_input_box span{
    position: absolute;
    top: 10px;
    right: -20px;
    font-size: 16px;
  }
  .submit_input{
    background-color: #f5ad4e;
    border: none;
    color: #fff;
    border-radius: 5px;
    width: 270px;
    line-height: 38px;
    font-size: 16px;
    margin: 0 auto;
    display: inherit;
    float: left;
  }
  .submit_input:hover{
    background-color: #FF8F0C;
  }
  .submit_to_publish{
    margin-right: 160px;
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
    top: 15px;
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
  /*标签结束*/
  .place_container{
    border: 1px solid #e8e8e8;
    padding: 10px;
    margin-bottom: 30px;
  }
  .place_top{
    border-left: 4px #f5ad4e solid;
    padding-left: 8px;
    margin-bottom: 20px
  }
  .place_box{
    padding:0 10px;
  }
  .place_message_container{
    width: 30%;
    float: left;
    margin-right: 20px;
  }
  .place_url{
    position: relative;
  }
  .place_url .place_img{
    display: block;
    position: absolute;
    width: 20px;
    height: 20px;
    top: 10px;
    left: 10px;
  }

</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    checkId();
    $('.menu_context_li').removeClass('active_li');
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

  var global_id;
  var check_click_search = 0;
  var action_url="/ad/manage";
  var click_type;
  var dest_name;
  var global_ad_total;
  var global_ad_weight=0;
  var url = window.location.href;
  var is_change=0;

  var del_img=[];

  //判断是否是修改信息
  function checkId() {
    if (url.indexOf("=") == -1) {
      $('.goods_ueditor').show();
      loadStartRoute();
    } else {
      console.log('开始更新');
      dest_name = url.split('dest_name=')[1].split('&id')[0];
      global_id = url.split('id=')[1].split('&end')[0];
      dest_name = decodeURI(dest_name);
      $('.userManage_container').show();
      $('.right_top_style').children('span').text(dest_name+'广告详情');
      $('.editor_city').text(dest_name);
      $('.place_top').text('目的地');
      loadMessage();
    }
  }
  //ajax获取用户
  //封装传输的信息并提交
  function loadMessage(){
    var obj={};
    global_page = 0;
    obj.action='show';
    obj.dest_name=dest_name;
//    obj.id=global_id;
    operation.operation_ajax(action_url,obj,insertUserMessage);
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


  //添加用户数据
  function insertUserMessage(){
    $('.user_manage_container_li').remove();
    global_ad_total=global_data.total;
    for (var i = 0; i < global_data.data.length; i++){
      var ad_link=global_data.data[i].ad_link;//链接
      var ad_create_time=global_data.data[i].ad_create_time.substring(0,16);//创建时间
      var dest_name=global_data.data[i].dest_name;//目的地
      var id=global_data.data[i].ad_id;
      var ad_weight=global_data.data[i].ad_weight;//权重
      var ad_pic_url=global_data.data[i].ad_pic_url;//图片

      addUserDisplay(ad_link,ad_create_time,dest_name,id,ad_weight,ad_pic_url,(i+1));
      global_ad_weight+=ad_weight;

    }

    $('.sub_message_place').text(dest_name);
    $('.sub_message_total').text(global_ad_total);
    $('.sub_message_weight').text(global_ad_weight);
  }
  //添加用户列表
  function addUserDisplay(ad_link,ad_create_time,dest_name,id,ad_weight,ad_pic_url,i) {
    $(".userManage_container_ul").append('<li class="user_manage_container_li" user_id='+id+' onmouseleave="hideDeleteTip(this)">' +
            '<span class="userManage_span manage_departure">'+i+'</span>' +
            '<span class="userManage_span manage_departure">' +
            '<img src='+ad_pic_url+' class="ad_pic_url">' +
            '</span>' +
            '<span class="userManage_span manage_destination">'+ad_link+'</span>' +
            '<span class="userManage_span manage_driving_length">'+ad_weight+'</span>' +
            '<span class="userManage_span manage_cost">'+ad_create_time+'</span>' +
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
    var departure_city=$(obj).parent().children('.manage_departure').text();
    var destination=$(obj).parent().children('.manage_destination').text();
    window.location.href = "/db/departure_list?departure_city=" + departure_city+"&destination_city="+destination+"&end";
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
//  控制广告添加编辑部分
  //初始加载图片设置
  function loadImageChange(obj) {
    console.log("开始替换图片");
    var objUrl = getObjectURL(obj.files[0]);
    console.log('objUrl'+objUrl);
    if(objUrl!=null){
      var j = $(obj).parent().children('.img0');
      j.addClass("add_image");
      var k = $(obj).parent();
      if (objUrl) {
        $(obj).parent().children('.img0').attr("src", objUrl).attr('id',-1);
      }
      var i = $(obj).parent().children('.img0').attr("src");
      imageStyle(i, j, k);
    }
  }
  function imageStyle(i, j, k) {
    console.log("改变img的框的大小和添加提示图片的显示");
    if (i == undefined || i == "") {
      console.log("回复默认设置");
      k.css({"width": "240px"});
      k.children('.editor_change').css('display', 'block');
      k.children('.editor_cancel').css('display', 'none');
      j.css({"display": "none"});
    } else {
      console.log("改变图片设置");
      k.css({"width": "auto"});
      k.children('.editor_change').css('display', 'none');
      k.children('.editor_cancel').css('display', 'block');
      j.css({"height": "100%", "display": "block"});
      checkImageNumber();
    }
  }
  //建立一個可存取到該file的url
  function getObjectURL(file) {
    var url = null;
    if (window.createObjectURL != undefined) { // basic
      url = window.createObjectURL(file);
    } else if (window.URL != undefined) { // mozilla(firefox)
      url = window.URL.createObjectURL(file);
    } else if (window.webkitURL != undefined) { // webkit or chrome
      url = window.webkitURL.createObjectURL(file);
    }
    console.log("获取到的url是" + url);
    return url;
  }
  //点击删除添加图片设置
  function removePicture(obj) {
    var delete_id = $(obj).parent().children('.add_image').attr('index');
    var weight = $(obj).parent().children('.add_image').attr('ad_weight');
    if(delete_id == undefined){

    }else{
      var delete_img={};
      delete_img.id = delete_id;
      delete_img.weight = weight;
      del_img.push(delete_img)
    }
    if($('.editor_mid_box').length>1){
      console.log('start');
      if($('.add_image').length==10){
        $('.editor_box_flag').before('<div class="place_message_container">' +
                '<div class="editor_mid_box">'+
                '<input type="file" title="支持jpg、jpeg、gif、png格式，文件小于2M" size="1" onchange="loadImageChange(this)" class="file_prew file0" name="img" accept=".jpg,.png,.gif,.jpeg">'+
                '<img src="" class="img0">'+
                '<div class="editor_cancel" onclick="removePicture(this)"></div>'+
                '<div class="editor_change">'+
                '<div class="editor_mid_box_img">'+
                '</div>'+
                '<div class="editor_mid_box_txt">'+
                '<span>上传宣传图片</span>'+
                '</div>'+
                '</div>'+
                '</div>' +
                '<div class="place_url">' +
                '<img src="/resource/images/pc_icon_url.png" class="place_img">'+
                '<input placeholder="请输图片链接" type="text" class="input_style ad_link">'+
                '</div>' +
                '<div class="place_url">' +
                '<img src="/resource/images/pc_icon_star.png" class="place_img">'+
                '<input placeholder="请输图片权重(只能为整数)" type="text" class="input_style ad_weight" >'+
                '</div>' +
                '</div>');
      }
      $(obj).parent().parent().remove();
    }else{
      var j = $(obj).parent().children('.img0');
      var k = $(obj).parent();
      k.css({"width": "100%px"});
      k.children('.editor_change').css('display', 'block');
      k.children('.editor_cancel').css('display', 'none');
      j.css({"display": "none"});
      $(obj).parent().children('.file0').val("");
    }
    setIndex();
  }
  function getFileName(file_name) {
    var pos = file_name.lastIndexOf("\\");
    return file_name.substring(pos + 1);

  }
  //判断是否满足图片要求
  function checkImageNumber(){
    if($('.editor_mid_box').length>=10){
      showErrorTips('最多上传十张宣传图片')
    }else{
      console.log('开始添加图片块状样式');
      if($('.add_image').length==$('.editor_mid_box').length-1){
        return;
      }else{
        $('.editor_box_flag').before('<div class="place_message_container">' +
                '<div class="editor_mid_box">'+
                '<input type="file" title="支持jpg、jpeg、gif、png格式，文件小于2M" size="1" onchange="loadImageChange(this)" class="file_prew file0" name="images" accept=".jpg,.png,.gif,.jpeg">'+
                '<img src="" class="img0">'+
                '<div class="editor_cancel" onclick="removePicture(this)"></div>'+
                '<div class="editor_change">'+
                '<div class="editor_mid_box_img">'+
                '</div>'+
                '<div class="editor_mid_box_txt">'+
                '<span>上传宣传图片</span>'+
                '</div>'+
                '</div>'+
                '</div>' +
                '<div class="place_url">' +
                '<img src="/resource/images/pc_icon_url.png" class="place_img">'+
                '<input placeholder="请输图片链接" type="text" class="input_style ad_link">'+
                '</div>' +
                '<div class="place_url">' +
                '<img src="/resource/images/pc_icon_star.png" class="place_img">'+
                '<input placeholder="请输图片权重(只能为整数)" type="text" class="input_style ad_weight">'+
                '</div>' +
                '</div>');

        setIndex();
      }
    }
  }

  function addAD() {
    var dest_name = $('.select_checkbox_active').children('.select_checkbox').text();
    if(del_img!=""){
      delAD(dest_name);
    }
    var array_img=[];
    for(var i=0;i<$('.add_image').length;i++){
      var obj={};
      var fileName = $($('.add_image')[i]).parent().children('.file0').attr('name');
      obj.img = fileName;
      obj.ad_link = $($('.add_image')[i]).parent().parent().find('.ad_link').val();
      obj.ad_weight = $($('.add_image')[i]).parent().parent().find('.ad_weight').val();

      if (url.indexOf("=") == -1) {
      } else {
        obj.ad_id = $($('.add_image')[i]).attr('index');
      }
      array_img.push(obj);
    }
    var json = JSON.stringify(array_img);
    var data = new FormData($('#upload_form')[0]);
    data.append("action", "add");
    data.append("dest_name", dest_name);
    data.append("imgs", json);
    $.ajax({
      type: "post",
      url: "/ad/manage",
      data: data,
      processData: false,
      contentType: false,
      beforeSend: loading,//执行ajax前执行loading函数.直到success
      success: function (data) {
        showErrorTips(data.message);
        if (data.status == true) {
          closeLoading();
          location.reload();
        }
      }
    })
  }


  function delAD(dest_name) {
    var json_del = JSON.stringify(del_img);
    alert(json_del);
    var data = new FormData($('#upload_form')[0]);
    data.append("action", "delete");
    data.append("delete", json_del);
    data.append("dest_name", dest_name);
    $.ajax({
      type: "post",
      url: "/ad/manage",
      data: data,
      processData: false,
      contentType: false,
      beforeSend: loading,//执行ajax前执行loading函数.直到success
      success: function (data) {
        showErrorTips(data.message);
        if (data.status == true) {
          closeLoading();
          location.reload();
        }
      }
    })
  }
  //出发路线
  function loadStartRoute() {
    var obj = {};
    obj.action = 'destination_all';
    operation.operation_ajax("/db/pch/route", obj, startRouteLi);
  }
  function startRouteLi() {
    $('.place_box').empty();
    for (var i = 0; i < global_data.data.length; i++) {
      $('.place_box').append('<div class="select_checkbox_container" onclick="addTabStyle(this)">'+
              '<span class="select_checkbox" index='+ i +'>' + global_data.data[i].departure + '</span>'+
              '<i class="select_popover_arrow"></i>'+
              '</div>')
    }

    $($('.select_checkbox_container')[0]).addClass('select_checkbox_active')

  }

  //检查输入的必选
  function checkPublishInput(){
    var check =0;
    for(var i=0;i<$('.add_image').length;i++){
      if($($('.ad_weight')[i]).val()==""){
        check = 1;
        showErrorTips("请输入图片权重");
      }else{
        check = 0;
      }
    }
    if(check==0){
      addAD();
    }

  }
  //设置index
  function setIndex(){
    for(var i=0;i<$('.file0').length;i++){
      $($('.file0')[i]).attr('name','images'+i);
    }
  }
  //选择标签
  function addTabStyle(obj) {
    if ($(obj).hasClass('select_checkbox_active')) {
      return false;
    } else {
      $('.select_checkbox_container').removeClass('select_checkbox_active');
      $(obj).addClass('select_checkbox_active');
    }
  }
//  改变为编辑状态
  function changeEditor(){
    $('.userManage_container').hide();
    $('.goods_ueditor').fadeIn();
    addEditorMessage();
    is_change=1;
  }
  function removeEditor(){
    if (url.indexOf("=") == -1) {
      window.location.href='/db/ad_manage_list';
    } else {
      location.reload();
    }
  }

  //添加修改信息
  function addEditorMessage(){
    if(is_change==0){
      for (var i = 0; i < global_data.data.length; i++){
        var ad_weight=global_data.data[i].ad_weight;//权重
        var ad_link=global_data.data[i].ad_link;//权重
        var ad_pic_url=global_data.data[i].ad_pic_url;//图片
        var ad_id=global_data.data[i].ad_id;//图片
        $('.editor_box_flag').before('<div class="place_message_container">' +
                '<div class="editor_mid_box">'+
                '<input type="file" title="支持jpg、jpeg、gif、png格式，文件小于2M" size="1" onchange="loadImageChange(this)" class="file_prew file0" name="images" accept=".jpg,.png,.gif,.jpeg">'+
                '<img src="" class="img0">'+
                '<div class="editor_cancel" onclick="removePicture(this)"></div>'+
                '<div class="editor_change">'+
                '<div class="editor_mid_box_img">'+
                '</div>'+
                '<div class="editor_mid_box_txt">'+
                '<span>上传宣传图片</span>'+
                '</div>'+
                '</div>'+
                '</div>' +
                '<div class="place_url">' +
                '<img src="/resource/images/pc_icon_url.png" class="place_img">'+
                '<input placeholder="请输图片链接" type="text" class="input_style ad_link">'+
                '</div>' +
                '<div class="place_url">' +
                '<img src="/resource/images/pc_icon_star.png" class="place_img">'+
                '<input placeholder="请输图片权重(只能为整数)" type="text" class="input_style ad_weight">'+
                '</div>' +
                '</div>');
        $($('.ad_link')[i]).val(ad_link);
        $($('.ad_weight')[i]).val(ad_weight);
        $($('.img0')[i]).attr('src', ad_pic_url).addClass('add_image');
        $($('.add_image')[i]).show().attr('index',ad_id).attr('ad_weight',ad_weight);
        $($('.editor_cancel')[i]).show();
        setIndex();
      }
    }

  }

</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>宣传图片设置</span>
      </div>
    </div>
    <div class="userManage_container">
      <div class="sub_message">目的地：<span style="color: #27ae60" class="sub_message_place"></span></div>
      <div class="sub_message">总数：<span style="color: #27ae60" class="sub_message_total"></span></div>
      <div class="sub_message">总权重：<span style="color: #27ae60" class="sub_message_weight"></span></div>
      <span class="add_span" onclick="changeEditor()"><span
              class="add_classify">+</span>编辑信息</span>
      <div class="clear"></div>
      <ul class="userManage_container_ul">
        <li class="userManage_container_li_top">
          <span class="userManage_span">序号</span>
          <span class="userManage_span">图片</span>
          <span class="userManage_span">链接</span>
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
    <%--广告添加编辑--%>
    <div class="goods_ueditor">
      <form method="post" id="upload_form" accept-charset="utf-8" onsubmit="return false" enctype="multipart/form-data" action="/api/goods?action=create">
        <div class="author_list_message_ico_box">
          <div class="place_container">
            <div class="place_top">
              选择目的地
            </div>
            <div class="place_box">
              <div class="select_checkbox_container select_checkbox_active" onclick="addTabStyle(this)">
                <span class="select_checkbox editor_city">郑州</span>
                <i class="select_popover_arrow"></i>
              </div>
            </div>
          </div>
          <div class="place_message_container">
            <div class="editor_mid_box">
              <input type="file" title="支持jpg、jpeg、gif、png格式，文件小于2M" size="1"
                     onchange="loadImageChange(this)" class="file_prew file0" name="images0"
                     accept=".jpg,.png,.gif,.jpeg">
              <img src="" class="img0" alt="">
              <div class="editor_cancel" onclick="removePicture(this)"></div>
              <div class="editor_change">
                <div class="editor_mid_box_img">
                </div>
                <div class="editor_mid_box_txt">
                  <span>上传展示图片</span>
                </div>
              </div>
            </div>
            <div class="place_url">
              <img src="/resource/images/pc_icon_url.png" class="place_img">
              <input placeholder="请输图片链接" type="text" class="input_style ad_link">
            </div>
            <div class="place_url">
              <img src="/resource/images/pc_icon_star.png" class="place_img">
              <input placeholder="请输图片权重(只能为整数)" type="text" class="input_style ad_weight">
            </div>
          </div>
          <div class="clear editor_box_flag"></div>
        </div>
        <input type="button" value="取消编辑" class="submit_input submit_to_publish" status="0" onclick="removeEditor(this)">
        <input type="button" value="保存" class="submit_input submit_to_list" status="1" onclick="checkPublishInput(this)">
        <div class="clear"></div>
      </form>
    </div>
  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
