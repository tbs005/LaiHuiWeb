<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/6/23
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>

<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<style type="text/css">

  .goods_ueditor {
    width: 802px;
    margin: 30px auto;
    min-height: 350px;
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
<script>

  $(document).ready(function () {
    // 菜单切换
    loadStartRoute();
  });


  var ad_id = -1;
  var global_data;
  var url = window.location.href;

  //判断是否是修改信息
  function checkGoodsId() {
    if (url.indexOf("=") == -1) {
      return false;
    } else {
      ad_id = url.substr(url.indexOf("=") + 1);
      loadGoodsEditorMessage();
    }
  }
  function loadGoodsEditorMessage() {
    var obj={};
    obj.action = 'show';
    validate.validate_submit('/api/db/departure', obj, addGoodsMessage);
  }


  function addGoodsMessage() {

    var goods_imageArray;

    //进行图片更换效果
    for(var i=0;i< global_data.result.data[0].imageArray.length;i++){
      goods_imageArray = global_data.result.data[0].imageArray[i].image_link;//封面地址
      var goods_imageId = global_data.result.data[0].imageArray[i].image_id;//封面id
      if (goods_imageArray != "") {
        $($('.img0')[i]).attr('src', goods_imageArray).addClass('add_image').attr('id',goods_imageId);
        $('.author_list_message_ico_box img').show();
        $('.editor_cancel').show();
      }
    }
  }


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
                '</div>')

        setIndex();
      }
    }
  }

  function addAD(status) {
    var array_img=[];
    for(var i=0;i<$('.add_image').length;i++){
      var obj={};
      var fileName = $($('.add_image')[i]).parent().children('.file0').attr('name');
      obj.img = fileName;
      obj.ad_link = $($('.add_image')[i]).parent().parent().find('.ad_link').val();
      obj.ad_weight = $($('.add_image')[i]).parent().parent().find('.ad_weight').val();
      array_img.push(obj);
    }

    var json = JSON.stringify(array_img);

    var dest_name = $('.select_checkbox_active').children('.select_checkbox').text();
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
          if(status==0){
            window.location.href='/db/ad_manage_create'
          }else{
            window.location.href='/db/ad_manage_list'
          }

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
    function checkPublishInput(obj){
      var status = $(obj).attr('status');
      if($('.ad_weight').val()==""){
        showErrorTips("请输入图片权重");
      }else{
        addAD(status);
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

    <div class="goods_ueditor">
      <form method="post" id="upload_form" accept-charset="utf-8" onsubmit="return false" enctype="multipart/form-data" action="/api/goods?action=create">
        <div class="author_list_message_ico_box">
          <div class="place_container">
            <div class="place_top">
              选择目的地
            </div>
            <div class="place_box">


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
        <input type="button" value="保存并继续发布" class="submit_input submit_to_publish" status="0" onclick="checkPublishInput(this)">
        <input type="button" value="保存并返回列表" class="submit_input submit_to_list" status="1" onclick="checkPublishInput(this)">
        <div class="clear"></div>
      </form>
    </div>
  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>