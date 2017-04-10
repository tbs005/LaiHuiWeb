<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/6/30
  Time: 11:53
  describtion:后台管理--【拼车信息会】车主发布信息编辑
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>

<style type="text/css">

  .publish_ueditor {
    width: 702px;
    margin: 30px auto;
    min-height: 350px;
  }

  .publish_tittle_box_span {
    padding: 0px 10px;
    border-radius: 2px;
    line-height: 38px;
    height: 50px;
  }

  .publish_ueditor_li_input {
    border-radius: 2px;
    padding-left: 6px;
    width: 620px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    line-height: 36px;
    height: 36px;
  }

  .publish_cat_box:hover > .down1 {
    transform: rotate(180deg);
  }

  .publish_list_box {
    margin-bottom: 20px;
    position: relative;
    min-height: 50px;
  }

  .author_list_message_ico_box img {
    width: 100%;
    height: 100%;
    display: none;
  }

  form {
    height: 100%;
  }

  .publish_cat_li:hover > .publish_cat_li_title .icon_top {
    transform: rotate(360deg);
  }

  /*下拉出发城市列表*/
  .publish_slide {
    height: 36px;
    line-height: 34px;
    margin-bottom: 20px;
    font-size: 14px;
    border: 1px solid #e8e8e8;
    width: 140px;
    text-align: center;
    display: inline-block;
    padding-right: 20px;
    position: relative;
    cursor: pointer;
  }

  .publish_slide ul {
    display: none;
    position: absolute;
    background-color: #fff;
    z-index: 1;
    border: 1px solid #e8e8e8;
    width: 140px;
    margin: 0px -1px;
    max-height: 600px;
    overflow: auto;
  }

  .publish_slide_li:hover {
    background-color: #f7f7f7;
  }

  .publish_slide:hover > .down1 {
    transform: rotate(180deg);
  }

  .publish_list {
    display: inline-block;
  }

  .publish_county {
    width: 120px;
  }

  .publish_icon_to {
    width: 52px;
    padding: 0 10px;
  }

  .publish_start_time {
    width: 50px;
    text-align: center;
    padding-left: 0;
  }

  .publish_end_time {
    width: 50px;
    text-align: center;
    padding-left: 0;
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
  /*添加button*/
  .add_button{
    display: inline-block;
    cursor: pointer;
    line-height: 38px;
  }
  .add_button2{
    display: inline-block;
    cursor: pointer;
    line-height: 38px;
  }
  .add_style{
    background-color: #f5ad4e;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    position: relative;
    display: inline-block;
    text-align: center;
    line-height: 16px;
    color: #fff;
  }
  .add_style_text{
    color: #f5ad4e;
  }
  /*添加结束*/
  .slide_container{
    width: 700px;
    left: 128px;
  }
  .slide_container_top{
    padding: 14px 0;
    margin: 0px;
    border-bottom: 1px solid #e8e8e8;
  }
  /*标签左右样式布局*/
  .slide_container_mid{
    padding: 20px;
    max-height: 450px;
    overflow-y: auto;
  }
  .slide_mid_left{
    float: left;
    width: 46%;
    border: 1px solid #e8e8e8;
    padding: 10px;
    border-radius: 5px;
  }
  .slide_mid_right{
    float: right;
    width: 46%;
    border: 1px solid #e8e8e8;
    padding: 10px;
    border-radius: 5px;
  }
  .slide_mid_right>.slide_mid_txt{
    color: #e74c3c;
    border-left: 2px solid #e74c3c;
  }
  .slide_mid_txt{
    line-height: 22px;
    display: inline-block;
    padding-left: 5px;
    border-left: 2px solid #00b38a;
    color: #00b38a;
  }
  .slide_mid_ul{
    margin-top: 8px;
  }
  .slide_mid_li{
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    line-height: 30px;
    padding-left: 30px;
    cursor: pointer;
    position: relative;
  }
  .slide_mid_li:hover{
    color: #f5ad4e;
  }
  .submit_select{
    margin-top: 30px;
  }
  .submit_select_span{
    width: 40%;
    height: 38px;
    line-height: 38px;
  }
  /*复选*/
  .slide_select{
    width: 20px;
    height: 20px;
    position: absolute;
    left: 6px;
    top: 6px;
    background-image: url("/resource/images/pch_icon_unselect.png");
    background-size: 20px;
  }
  .slide_select_active{
    background-image: url("/resource/images/pch_icon_selected.png");
  }
  .publish_yes_tags_box{
    line-height: 38px;
    display: none;
  }
  .publish_no_tags_box{
    line-height: 38px;
    display: none;
  }
  .publish_tags_title{
    color: #00b38a;
  }
  .publish_tags_container{
    display: inline-block;
  }
  .publish_yes_tags_context{
    border: 1px solid #00b38a;
    padding: 2px 8px;
    margin-right: 10px;
  }
  .publish_no_tags_title{
    color:#e74c3c;
  }
  .publish_no_tags_context{
    border: 1px solid #e74c3c;
    padding: 2px 8px;
    margin-right: 10px;
  }
  /*浮选结束*/
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
  .publish_main_route{
    width: 222px;
  }
  /*途径路*/
  .slide_container3 {
    position: fixed;
    width: 400px;
    left: 128px;
    top: -220%;
    right: 0;
    margin: 0 auto;
    opacity: 0;
    border: 1px solid #e8e8e8;
    background-color: #fff;
    box-shadow: 2px 2px 6px #e8e8e8;
    z-index: 100;
  }
  /*途径路*/
  .slide_container2 {
    position: fixed;
    width: 400px;
    left: 128px;
    top: -220%;
    right: 0;
    margin: 0 auto;
    opacity: 0;
    border: 1px solid #e8e8e8;
    background-color: #fff;
    box-shadow: 2px 2px 6px #e8e8e8;
    z-index: 100;
  }
  .input_style{
    width: 80%;
  }
  .remove_route{
    margin-top: -8px;
    width: 20px!important;
    height: 20px;
    position: static!important;
    cursor: pointer;
    margin-left: 18px;
    display: inline-block;
  }
  .add_route{
    color: #F5AD4E;
    padding-left: 14px;
    display: inline-block;
    cursor: pointer;
    margin-top: 20px;
  }
  .copy_route{
    color: #3498db;
    padding-left: 14px;
    display: block;

    margin-top: 30px;
  }
  .copy_route span{
    cursor: pointer;
  }
  .line_container {
    width: 100%;
    position: absolute;
    bottom: -8px;
    overflow: hidden;
  }

  .line_slide {
    border-bottom: 3px solid #F5AD4E;
    position: relative;
    width: 108%;
    margin: 0px auto;
    bottom: 4px;
    display: inline-block;
  }

  .line_circle {
    width: 10px;
    height: 10px;
    border: 1px solid #F5AD4E;
    border-radius: 50%;
    /* display: inline-block; */
    position: absolute;
    left: 0;
    right: 0;
    margin: 0 auto;
    bottom: 4px;
    background-color: #fff;
  }
  .publish_route_box_li{
    position: relative;
    display: inline-block;
    padding:10px 0;
  }
  .publish_route_box_li_span{
    padding:0 10px;
  }
  .line_time{
    width: 30px;
    border-bottom: 2px solid #F5AD4E;
    display: inline-block;
    line-height: 29px;
    top: -4px;
    position: relative;
  }
  .publish_slide_li_time_box{
    width: 60px;
  }
  .publish_slide_li_time_box ul{
    width: 60px;
  }
  .submit_to_publish{
    margin-right: 160px;
  }
  .cony_textarea{
    width: 100%;
    min-height: 200px;
    max-width: 355px;
    /* text-indent: 10px; */
    padding: 10px;
    border: 1px solid #f5ad4e;
    outline: none;
  }

  .input_list_left {
    float: left;
    width: 60px;
  }

  .input_list_right {
    float: left;
  }
  .find_container{
    border: 1px solid #e8e8e8;
    padding: 10px 0;
    border-left: 4px solid #2ecc71;
    margin-bottom: 20px;
  }

</style>
<script>

  $(document).ready(function () {
    $('.menu_context_li').removeClass('active_li');
    $('.db_driver_departure').addClass('active_li');
    $('.publish_slide').mouseleave(function () {
      $('.publish_slide ul').hide();
    });
    $('.user_list_drop_box').mouseleave(function () {
      $('.user_list_drop_box_ul').hide();
    });

    // 绑定键盘按下事件
    $(document).keypress(function (e) {
      // 回车键事件
      if (e.which == 13) {
        jQuery('.search_ico').click();
      }
    });
    //  搜索重置page
    $('.search_ico').click(function () {
      global_page = 0;
      findMessage();
    });
    checkId();
    loadYes();
    loadNo();
    loadStartRoute();
    setShowData();
  });
  var yes_array=[];
  var no_array=[];
  var route_array=[];
  var yes_tags=[];
  var no_tags=[];
  var array_date = [];
  var send_time;
  var send_time2;
  var start_route;
  var driver_id;
  var url = window.location.href;
  var save_status;
  var end_price=[];
  var origin_price;
  //判断是否是修改信息
  function checkId() {
    if (url.indexOf("=") == -1) {
      console.log('不进行修改')
    } else {
      driver_id = url.substr(url.indexOf("=") + 1);
      console.log('进行修改');
      loadMessage();
    }
  }
  function loadMessage(){

    var obj = {};
    obj.action = 'show';
    obj.id = driver_id;
    operation.operation_ajax("/api/db/departure", obj, insertUserMessage);
  }
  //添加用户数据
  function insertUserMessage() {
    for (var i = 0; i < global_data.data.length; i++) {
      var driving_name = global_data.data[i].driving_name;//车主姓名
      var start_time = global_data.data[i].start_time;//开始时间
      var end_time = global_data.data[i].end_time;//结束时间
      var mobile = global_data.data[i].mobile;//手机号
      var departure_city = global_data.data[i].departure_city;//出发城市
      var destination_city = global_data.data[i].destination_city;//目的城市
      var departure = global_data.data[i].departure;//出发小城
      var destination = global_data.data[i].destination;//目的小城市
      var description = global_data.data[i].description;//描述信息
      var tag_yes_content = global_data.data[i].tag_yes_content;//yes标签
      var tag_no_content = global_data.data[i].tag_no_content;//no标签
      var points = global_data.data[i].points;//地点
      var inits_seats = global_data.data[i].inits_seats;//可用座位
      var car_brand = global_data.data[i].car_brand;//车辆品牌
      var id = global_data.data[i].id;//id
      var price = global_data.data[i].price;//id
      var origin_price = global_data.data[i].origin_price;//id

      $('.publish_start_city').text(departure_city).attr('index','0');
      $('.publish_county1').val(departure);
      $('.publish_end_city').text(destination_city).attr('index','0');
      $('.publish_county2').val(destination);
      $('.publish_type').val(car_brand);
      $('.publish_name').val(driving_name);
      $('.publish_tel').val(mobile);
      $('.publish_remark').val(description);
      $('.publish_begin_cost').text(price);
      for(var i = 0; i<3 ;i++){
        $('.publish_begin_cost_ul').append('<li class="publish_slide_li publish_slide_li_cost"  onclick="selectTagsLi(this)">'+(origin_price+i*5)+'</li>');
      }
      $('.select_checkbox_container').removeClass('select_checkbox_active');
      for(var j=0;j<$('.select_checkbox_container').length;j++){
        if($($('.select_checkbox_container')[j]).children('.select_checkbox').attr('index') == inits_seats){
          $($('.select_checkbox_container')[j]).addClass('select_checkbox_active');
        }
      }

      var start_date = start_time.split(" ")[0];

      var first_date_time =start_time.substring(11, 13);
      var last_data_time = end_time.substring(11, 13);

      $('.publish_begin_time').text(start_date).attr('index','0');
      $('.publish_start_time').val(first_date_time);
      $('.publish_end_time').val(last_data_time);
      //添加线路信息
      route_array=points.split("丶");

      inputEditMessage2();
      //yes标签
      yes_array=tag_yes_content.split("丶");

      //no标签
      no_array=tag_no_content.split("丶");
      inputChangeMessage();
  }
  }
  //出发路线
  function loadStartRoute(){
    var obj={};
    obj.action='departure';
    operation.operation_ajax("/db/pch/route",obj,startRouteLi);
  }
  //结束路线
  function loadEndRoute(departure){
    var obj={};
    obj.action='departure';
    obj.departure=departure;
    operation.operation_ajax("/db/pch/route",obj,endRouteLi);
  }
  function startRouteLi(){
    for(var i=0;i<global_data.data.length;i++){
      $('.publish_start_slide_ul').append('<li class="publish_slide_li" index='+i+' onclick="selectStyleTagsLi(this)">'+global_data.data[i].departure+'</li>')
    }
  }
  function endRouteLi(){
    $('.publish_end_slide_ul').empty();
    for(var i=0;i<global_data.data.length;i++){
      $('.publish_end_slide_ul').append('<li class="publish_slide_li" index='+i+' onclick="selectTagsLiPrice(this)">'+global_data.data[i].destination+'</li>');
      end_price.push(global_data.data[i].price);
    }
  }
  //添加YES/NO标签
  function loadYes(){
    load_type=0;
    var obj={};
    obj.action='show';
    obj.type=1;
    operation.operation_ajax2("/api/db/tag",obj,addToYesTags)
  }
  function addToYesTags(){
    for (var i = 0; i < global_data.data.length; i++){
      var content=global_data.data[i].content;
      yes_tags.push(content);
    }
  }
  function loadNo(){
    load_type=1;
    var obj={};
    obj.action='show';
    obj.type=0;
    operation.operation_ajax2("/api/db/tag",obj,addToNoTags)
  }
  function addToNoTags(){
    for (var i = 0; i < global_data.data.length; i++){
      var content=global_data.data[i].content;
      no_tags.push(content);
    }
    addTagsStyle();
  }
  //显示下拉
  function showTagsUl(obj) {
    $(obj).children('.publish_slide_ul').toggle();
  }
  function selectTagsLi(obj) {
    $(obj).parent().parent().children('.publish_slide_text').text($(obj).text()).attr('index', $(obj).attr('index'));

  }
  function selectTagsLiPrice(obj) {
    $(obj).parent().parent().children('.publish_slide_text').text($(obj).text()).attr('index', $(obj).attr('index'));
    origin_price=end_price[$(obj).attr('index')];
    $('.publish_begin_cost').text(origin_price);
    $('.publish_begin_cost_ul').empty();
    for(var i = 0; i<9 ;i++){
      $('.publish_begin_cost_ul').append('<li class="publish_slide_li publish_slide_li_cost"  onclick="selectTagsLi(this)">'+(origin_price+i*5)+'</li>');
    }

  }
  //选择开始出发城市，进行数据交互
  function selectStyleTagsLi(obj) {
    $('.publish_end_city').text("选择目的城市").attr('index',"");
    $(obj).parent().parent().children('.publish_slide_text').text($(obj).text()).attr('index', $(obj).attr('index'));
    $('.publish_begin_cost').text('选择参考价格');
    $('.publish_begin_cost_ul').empty();
    end_price=[];
    loadEndRoute($(obj).text());
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

  //选择标签
  function addSlideStyle(obj) {
    if ($(obj).children('.slide_select').hasClass('slide_select_active')) {
      $(obj).children('.slide_select').removeClass('slide_select_active')
    } else {
      $(obj).children('.slide_select').addClass('slide_select_active')
    }
  }

  //添加下滑
  function addManagerStyle(){
    //判断取消再次显示情况下数据
    for(var i=0;i<$('.success_passed').length;i++){
      var text1=$($('.success_passed')[i]).children('.slide_mid_li_span').text();
      for(var j=0;j<yes_array.length;j++){
        var text2=yes_array[j];
        if(text1==text2){
          $($('.success_passed')[i]).children('.slide_select').addClass('slide_select_active')
        }
      }
    }
    for(var i=0;i<$('.not_passed').length;i++){
      var text1=$($('.not_passed')[i]).children('.slide_mid_li_span').text();
      for(var j=0;j<no_array.length;j++){
        var text2=no_array[j];
        if(text1==text2){
          $($('.not_passed')[i]).children('.slide_select').addClass('slide_select_active')
        }
      }
    }
    $('.slide_container').animate({"top":"22%","opacity":"1"},300);
  }
  //添加下滑
  function addManagerStyle2(){
    //判断取消再次显示情况下数据
    $('.copy_route_container').remove();
    $('.input_list').remove();
    for(var i=0;i<route_array.length;i++){
      addChangeRoute(route_array[i])
    }
    $('.slide_container2').animate({"top":"22%","opacity":"1"},300);
  }
  //添加下滑
  function addManagerStyle3(){

    $('.slide_container3').animate({"top":"22%","opacity":"1"},300);
  }
  //隐藏下滑
  function removeManagerStyle(){
    $('.slide_container').animate({"top":"-220%","opacity":"0"},300);
    $('.slide_container2').animate({"top":"-220%","opacity":"0"},300);
  }
  //隐藏下滑
  function removeManagerStyle2(){
    $('.slide_container2').animate({"top":"-220%","opacity":"0"},300);
  }
  //隐藏下滑
  function removeManagerStyle3(){
    $('.slide_container3').animate({"top":"-220%","opacity":"0"},300);
  }
  //将添加的标签存入数组中
  function inputMessage(){
    no_array=[];
    yes_array=[];
    for(var i=0;i<$('.slide_select_active').length;i++){
      if($($('.slide_select_active')[i]).parent().hasClass('not_passed')){
        no_array.splice(i,1,$($('.slide_select_active')[i]).parent().
                children('.slide_mid_li_span').text());
      }else{
        yes_array.splice(i,1,$($('.slide_select_active')[i]).parent().
                children('.slide_mid_li_span').text());
      }
    }
    getTags();
    removeManagerStyle();
  }
  //将添加的标签存入数组中
  function inputChangeMessage(){
    for(var i=0;i<$('.slide_select_active').length;i++){
      if($($('.slide_select_active')[i]).parent().hasClass('not_passed')){
        no_array.splice(i,1,$($('.slide_select_active')[i]).parent().
                children('.slide_mid_li_span').text());
      }else{
        yes_array.splice(i,1,$($('.slide_select_active')[i]).parent().
                children('.slide_mid_li_span').text());
      }
    }
    getTags();
    removeManagerStyle();
  }
  //将数组中的标签取出
  function getTags(){
    if((yes_array.length==0 && no_array.length==0) ||(yes_array[0]=="" && no_array[0]=="")){
      $('.add_button').css('float','none');
    }else{
      $('.add_button').css('float','right');
    }
    if(yes_array.length>0){
      if(yes_array[0]==""){
        $('.publish_yes_tags_box').hide();
      }else{
        $('.publish_yes_tags_box').show();
        $('.publish_yes_tags_container').empty();
        for(var i=0;i<yes_array.length;i++){
          $('.publish_yes_tags_container').append('<span class="publish_yes_tags_context">'+yes_array[i]+'</span>')
        }
      }

    }else{
      $('.publish_yes_tags_box').hide();
    }

    if(no_array.length>0){
      if(no_array[0]==""){
        $('.publish_no_tags_box').hide();
      }else{
        $('.publish_no_tags_box').show();
        $('.publish_no_tags_container').empty();
        for(var j=0;j<no_array.length;j++){
          $('.publish_no_tags_container').append('<span class="publish_no_tags_context">'+no_array[j]+'</span>')
        }
      }
    }else{
      $('.publish_no_tags_box').hide();

    }

  }
  //将添加的线路存入数组中
  function inputMessage2(){
    route_array=[];
    if($('.copy_route_container').length>0){
      var text = $('.cony_textarea').val();
      text = text.replace(/[\ |\~|\`|\，|――|→|\—|\－|\～|\·|\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\_|\+|\=|\||\\|\[|\]|\{|\}|\;|\:|\"|\'|\,|\<|\.|\>|\/|\?]/g,"、");
      route_array=text.split('、');
      for(var i = 0 ;i<route_array.length;i++)
      {
        if(route_array[i] == "" || typeof(route_array[i]) == "undefined")
        {
          route_array.splice(i,1);
          i= i-1;
        }
      }
    }else{
      for(var i=0;i<$('.route_end').length;i++){
        if($($('.route_end')[i]).val()==""){

        }else{
          route_array.splice(i,1,$($('.route_end')[i]).val());
        }
      }
    }
    getRoute();
    removeManagerStyle();
  }
  //修改使用
  function inputEditMessage2(){
    for(var i=0;i<$('.route_end').length;i++){
      if($($('.route_end')[i]).val()==""){

      }else{
        route_array.splice(i,1,$($('.route_end')[i]).val());
      }
    }
    getRoute();
    removeManagerStyle();
  }
  //将数组中的标签取出
  function getRoute(){
    if(route_array.length>0){
      if(route_array[0]==""){
        route_array=[];
      }else{
        $('.add_button2').css('float','right');
        $('.publish_route_box').empty().show();
        for(var j=0;j<route_array.length;j++){
          $('.publish_route_box').append('<li class="publish_route_box_li">'+
                  '<span class="publish_route_box_li_span">'+route_array[j]+'</span>'+
                  '<div class="line_container">'+
                  '<div class="line_slide"></div>'+
                  '<div class="line_circle"></div>'+
                  '</div>'+
                  '</li>')
        }
      }
    }else{
      if(route_array[0]==undefined){
        $('.publish_route_box').empty();
        $('.add_button2').css('float','none');
      }else{
        $('.publish_route_box').show();
        $('.add_button2').css('float','none');
      }

    }

  }
  //添加路线
  function addChangeRoute(obj){
    $('.add_route').before('<div class="input_list">'+
            '<img src="/resource/images/pc_icon_endRoute.png" />'+
            '<input type="text" placeholder="途径路线" class="input_style route_end route_flag" value='+obj+' />'+
            '<img class="remove_route" src="/resource/images/pch_icon_remove.png" alt="删除" onclick="removeRoute(this)">'+
            '</div>');
//    if($('.route_end').length>1){
//      $('.remove_route').show();
//    }else{
//      $('.remove_route').hide();
//    }
  }
  function addRoute(){
    $('.copy_route_container').remove();
    $('.add_route').before('<div class="input_list">'+
            '<img src="/resource/images/pc_icon_endRoute.png" />'+
            '<input type="text" placeholder="途径路线" class="input_style route_end route_flag" />'+
            '<img class="remove_route" src="/resource/images/pch_icon_remove.png" alt="删除" onclick="removeRoute(this)">'+
            '</div>');
//    if($('.route_end').length>1){
//      $('.remove_route').show();
//    }else{
//      $('.remove_route').hide();
//    }
  }
  function removeRoute(obj){
    $(obj).parent().remove();
    if($('.route_end').length<1){
      route_array=[];
      $('.publish_route_box').empty();
    }
  }
  //设置index
  function setIndex(obj){
    for(var i=0;i<$(obj).length;i++){
      $($(obj)[i]).attr('index',i);
    }
  }
  //检查输入的必选
  function checkPublishInput(obj){

    if($('.publish_start_city').attr('index')==""){
      showErrorTips("请选择出发城市");
    }else if($('.publish_end_city').attr('index')==""){
      showErrorTips("请选择结束城市");
    }else if($('.publish_begin_time').attr('index')==""){
      showErrorTips("请选择出发日期");
    }else if($('.publish_start_time').val()==""){
      showErrorTips("请填写出发时间");
    }else if($('.publish_end_time').val()==""){
      showErrorTips("请填写结束时间");
    }else if($('.publish_tel').val()==""){
      showErrorTips("请填写联系电话");
    }else{
      save_status=$(obj).attr('status');
      setSendData();
      addMessage();
    };
  }
  function addMessage(){
    var route="";
    for(var i=0;i<route_array.length;i++){
      if(i==route_array.length-1){
        route+=route_array[i]
      }else{
        route+=route_array[i]+'丶'
      }
    }
    var tag_yes_content="";
    for(var i=0;i<yes_array.length;i++){
      if(i==yes_array.length-1){
        tag_yes_content+=yes_array[i]
      }else{
        tag_yes_content+=yes_array[i]+'丶'
      }

    }
    var tag_no_content="";
    for(var i=0;i<no_array.length;i++){
      if(i==no_array.length-1){
        tag_no_content+=no_array[i]
      }else{
        tag_no_content+=no_array[i]+'丶'
      }
    }
    var data_obj={};

    var mobile=$('.publish_tel').val();
    var departure_city=$('.publish_start_city').text();
    var destination_city=$('.publish_end_city').text();
    var init_seats=$('.select_checkbox_active').text().trim().substring(0,1);
    var description=$('.publish_remark').val();
    var departure_county=$('.publish_county1').val();
    var destination=$('.publish_county2').val();
    var driving_name=$('.publish_name').val();
    var car_brand=$('.publish_type').val();
    var price = $('.publish_begin_cost').text();
    if (url.indexOf("=") == -1) {

    } else {
      data_obj.id = driver_id;
    }

    mobile =$('.publish_tel').val().toString().trim();
    if(mobile.length>11){
      if(mobile.indexOf("，")==-1){
        mobile.replace("，",",")
      }
    }
    data_obj.action = 'add';
    data_obj.start_time = send_time;
    data_obj.end_time = send_time2;
    data_obj.mobile = mobile;
    data_obj.departure_city = departure_city;
    data_obj.destination_city = destination_city;
    data_obj.init_seats = init_seats;
    data_obj.points = route;
    data_obj.description = description;
    data_obj.departure_county = departure_county;
    data_obj.destination = destination;
    data_obj.tag_yes_content = tag_yes_content;
    data_obj.tag_no_content = tag_no_content;
    data_obj.driving_name = driving_name;
    data_obj.car_brand = car_brand;
    data_obj.price = price;
    data_obj.origin_price = origin_price;
    operation.operation_ajax('/api/db/departure', data_obj, success);
  }
  function success(){

    if(save_status==0){
      showErrorTips("发布成功");
      setTimeout(window.location.href="/db/driver/departure",1500);

    }else{
      window.history.go(-1);
    }

  }
  //发送时间的数据
  function setSendData(){
    var time;
    var str = $('.publish_begin_time').text().substring(0,2);
    var time_str = $('.publish_begin_time').text();

    if(str=="今天"){
      time=new Date();
      changeDataStyle(time)
    }else if(str=="明天"){
      var today=new Date();
      var t=today.getTime()+1000*60*60*24;
      time=new Date(t);
      changeDataStyle(time)
    }else if(str=="后天"){
      var today=new Date();
      var t=today.getTime()+(1000*60*60*24)*2;
      time=new Date(t);
      changeDataStyle(time)
    }else{
      var st2 =$('.publish_start_time').val().trim();
      var st3 =$('.publish_end_time').val().trim();
      var st4 =$('.publish_slide_start_time').text().trim();
      var st5 =$('.publish_slide_end_time').text().trim();
      if(st2.length == 1){
        send_time =time_str+" "+"0"+st2+":"+st4+":00";
      }else{
        send_time =time_str+" "+st2+":"+st4+":00";
      }

      if(st3.length == 1){
        send_time2 =time_str+" "+"0"+st3+":"+st5+":00";
      }else{
        send_time2 =time_str+" "+st3+":"+st5+":00";
      }
    }

  }
  //显示7天内信息
  function setShowData(){

    var str_time1=new Date();
    for(var i=0;i<7;i++){
      var obj={};
      var str_time2=str_time1.getTime()+(1000*60*60*24)*i;
      var time2 = new Date(str_time2);
      var year2  = time2.getFullYear();
      var month2 = time2.getMonth()+1;
      var date2  = time2.getDate();
      obj.year = year2;
      if(month2.toString().length==1){
        obj.month = "0"+month2;
      }else{
        obj.month = parseInt(month2);
      }
      if(date2.toString().length==1){
        obj.date = "0"+date2;
      }else{
        obj.date = parseInt(date2);
      }
      array_date.push(obj);
    }



    for(var j=0;j<array_date.length;j++){
      $('.publish_slide_date').append('<li class="publish_slide_li publish_slide_li_date" index="1"  onclick="selectTagsLi(this)"></li>')
      if(j==0){
        $($('.publish_slide_li_date')[j]).text("今天("+array_date[j].year+"-"+array_date[j].month+"-"+array_date[j].date+")")
      }else if(j==1){
        $($('.publish_slide_li_date')[j]).text("明天("+array_date[j].year+"-"+array_date[j].month+"-"+array_date[j].date+")")
      }else if(j == 2){
        $($('.publish_slide_li_date')[j]).text("后天("+array_date[j].year+"-"+array_date[j].month+"-"+array_date[j].date+")")
      }else{
        $($('.publish_slide_li_date')[j]).text(array_date[j].year+"-"+array_date[j].month+"-"+array_date[j].date)
      }

    }
  }
  //转换日期格式
  function changeDataStyle(time){
    var year  = time.getFullYear();
    var month = time.getMonth()+1;
    var date  = time.getDate();
    if(month.toString().length==1){
      month = "0"+month;
    }else{
      month = parseInt(month);
    }
    var st2 =$('.publish_start_time').val().trim();
    var st3 =$('.publish_end_time').val().trim();
    var st4 =$('.publish_slide_start_time').text().trim();
    var st5 =$('.publish_slide_end_time').text().trim();
    if(st2.length == 1){
      send_time =year+"-"+month+"-"+date+" "+"0"+st2+":"+st4+":00";
    }else{
      send_time =year+"-"+month+"-"+date+" "+st2+":"+st4+":00";
    }

    if(st3.length == 1){
      send_time2 =year+"-"+month+"-"+date+" "+"0"+st3+":"+st5+":00";
    }else{
      send_time2 =year+"-"+month+"-"+date+" "+st3+":"+st5+":00";
    }
  }
  //添加标签列表
  function addTagsStyle(){
    for(var i=0;i<yes_tags.length;i++){
      $('.slide_mid_ul_yes').append('<li class="slide_mid_li success_passed" index="1" onclick="addSlideStyle(this)">'+
              '<span class="slide_mid_li_span">'+yes_tags[i]+'</span>'+
              '<div class="slide_select"></div>'+
              '</li>')
    }
    for(var j=0;j<no_tags.length;j++){
      $('.slide_mid_ul_no').append('<li class="slide_mid_li not_passed" index="1" onclick="addSlideStyle(this)">'+
              '<span class="slide_mid_li_span">'+no_tags[j]+'</span>'+
              '<div class="slide_select"></div>'+
              '</li>')
    }
  }
  //检测是否是数字
  function onlyTowNum(obj)
  {
    var time1=parseInt($('.publish_start_time').val().trim());
    var time2=parseInt($('.publish_end_time').val().trim());
    if(isNaN($(obj).val())){
      $(obj).val("");
      showErrorTips("只允许输入数字");
    }else if($(obj).val().length>2){
      $(obj).val("");
      showErrorTips("输入的时间格式不正确");
    }else if($(obj).val()>24){
      $(obj).val("");
      showErrorTips("输入的时间不能超过24小时");
    }else if(time1!="" && time2!=""){
      if(time1>time2){
        $(obj).val("");
        showErrorTips("输入的最早时间不能超过最晚");
      }
    }else{

    }
  }
  //改变mobile格式
  function changeMobile(obj){
    $(obj).val($(obj).val().replace(/-/g, ''));
  }

  function copyRoute(){
    if($('.copy_route_container').length>0){
      $('.input_list').remove();
    }else{
      $('.input_list').remove();
      $('.add_route').before('<div class="copy_route_container">' +
              '<textarea class="cony_textarea" placeholder="支持路线带各种符号情况下的转换，例如：紫荆山~第八大街-火车站..."></textarea>' +
              '</div>');
    }
  }

  //查找信息
  function findMessage() {
    var obj = {};
    var search = $('.search_user_input').val();
    obj.action = 'show';
    obj.keyword = search;
    obj.size = size;
    obj.page = global_page;
    operation.operation_ajax("/api/db/departure", obj, showRouteMessage);
  }
  function showRouteMessage(){
    addManagerStyle3();
    if(global_data.total == 0){
      $('.slide_container3').find('.departure_city').text('此手机号暂无发布信息').css('text-align','center')
    }else{
      addManagerStyle4();
    }
  }
  //生成文字信息
  function addManagerStyle4() {
    $('.slide_container3_box').empty();

    for(var i=0 ;i<global_data.total;i++){
      addCopyMessageStyle();
      var driver_route_start =global_data.data[i].departure_city;
      var driver_route_end = global_data.data[i].destination_city;
      var driver_time_year = global_data.data[i].start_time.substring(0,16)+" ~ "+global_data.data[i].end_time.substring(11,16);
      var driver_type_seat = global_data.data[i].inits_seats;
      $($('.find_city_span')[i]).text(driver_route_start  + "至" + driver_route_end);
      $($('.find_time_span')[i]).text(driver_time_year);
      $($('.find_seat_span')[i]).text(driver_type_seat);
    }
  }

  //添加文本信息样式
  function addCopyMessageStyle() {
    $('.slide_container3_box').append('<li class="find_container">' +
            '<div class="input_list find_city">' +
            '<div class="input_list_left">' +
            '<span>【找人】</span>' +
            '</div>' +
            '<div class="input_list_right">' +
            '<span class="find_city_span"></span>' +
            '</div>' +
            '<div class="clear"></div>' +
            '</div>' +
            '<div class="input_list find_time">' +
            '<div class="input_list_left">' +
            '<span>【时间】</span>' +
            '</div>' +
            '<div class="input_list_right">' +
            '<span class="find_time_span"></span>' +
            '</div>' +
            '<div class="clear"></div>' +
            '</div>' +
            '<div class="input_list find_seat">' +
            '<div class="input_list_left">' +
            '<span>【空位】</span>' +
            '</div>' +
            '<div class="input_list_right">' +
            '<span class="find_seat_span"></span>' +
            '</div>' +
            '<div class="clear"></div>' +
            '</div>' +
            '</div>' +
            '</li>')
  }
//  .replace(/[\ |\~|\`|\，|\·|\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\_|\+|\=|\||\\|\[|\]|\{|\}|\;|\:|\"|\'|\,|\<|\.|\>|\/|\?]/g,"、")替换所有符号为、
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>发车信息</span>

        <div class="search_user">
          <input type="text" placeholder="输入手机号查询是否存在该车程" class="search_user_input">
          <a href="javascript:;" class="search_user_a">
            <div class="search_ico"></div>
          </a>
        </div>
      </div>

    </div>

    <div class="publish_ueditor">
      <form method="post" id="upload_form" accept-charset="utf-8" onsubmit="return false"
            enctype="multipart/form-data" action="/api/publish?action=create">
        <div class="publish_list_box">
          <span class="publish_tittle_box_span">起止路线</span>
          <div class="publish_list">
            <div class="publish_slide" onclick="showTagsUl(this)">
              <span class="publish_slide_text publish_start_city" index="">选择出发城市</span>
              <ul class="publish_slide_ul publish_start_slide_ul">
              </ul>
              <div class="down1"></div>
            </div>
            <span style="color: #999">●</span>
            <input placeholder="县级（可选）" type="text" class="publish_ueditor_li_input publish_county publish_county1">
          </div>
          <img src="/resource/images/pch_icon_to.png" class="publish_icon_to">
          <div class="publish_list">
            <div class="publish_slide" onclick="showTagsUl(this)">
              <span class="publish_slide_text publish_end_city" index="">选择目的城市</span>
              <ul class="publish_slide_ul publish_end_slide_ul">

              </ul>
              <div class="down1"></div>
            </div>
            <span style="color: #999">●</span>
            <input placeholder="县级（可选）" type="text" class="publish_ueditor_li_input publish_county publish_county2">
          </div>
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span " index="">参考价格</span>

          <div class="publish_list">
            <div class="publish_slide" onclick="showTagsUl(this)">
              <span class="publish_slide_text publish_begin_cost" index="" >选择参考价</span>
              <ul class="publish_slide_ul publish_begin_cost_ul">
              </ul>
              <div class="down1"></div>
            </div>
          </div>
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span" style="float:left ">途径路线</span>
          <ul class="publish_route_box">
          </ul>
          <div class="add_button2" onclick="addManagerStyle2()">
            <span class="add_style">+</span>
            <span class="add_style_text">编辑</span>
          </div>
          <div class="clear"></div>
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span " index="">出发时间</span>

          <div class="publish_list">
            <div class="publish_slide" onclick="showTagsUl(this)">
              <span class="publish_slide_text publish_begin_time" index="" >选择出发时间</span>
              <ul class="publish_slide_ul publish_slide_date">


              </ul>
              <div class="down1"></div>
            </div>
            <span style="color: #999">&#12288;&#12288;&#12288;</span>

            <div class="publish_list">
              <input placeholder="最早" type="text" class="publish_ueditor_li_input publish_start_time" onchange="onlyTowNum(this)">
              <span>：</span>
              <div class="publish_slide publish_slide_li_time_box" onclick="showTagsUl(this)">
                <span class="publish_slide_text publish_status publish_slide_start_time" index="0">00</span>
                <ul class="publish_slide_ul">
                  <li class="publish_slide_li publish_slide_li_time" index="0" onclick="selectTagsLi(this)">
                    00
                  </li>
                  <li class="publish_slide_li publish_slide_li_time" index="1" onclick="selectTagsLi(this)">
                    30
                  </li>
                </ul>
                <div class="down1"></div>
              </div>
            </div>
            <span class="line_time"></span>

            <div class="publish_list">
              <input placeholder="最晚" type="text" class="publish_ueditor_li_input publish_end_time" onchange="onlyTowNum(this)">
              <span>：</span>
              <div class="publish_slide publish_slide_li_time_box" onclick="showTagsUl(this)">
                <span class="publish_slide_text publish_status publish_slide_end_time" index="0">00</span>
                <ul class="publish_slide_ul">
                  <li class="publish_slide_li publish_slide_li_time" index="0" onclick="selectTagsLi(this)">
                    00
                  </li>
                  <li class="publish_slide_li publish_slide_li_time" index="1" onclick="selectTagsLi(this)">
                    30
                  </li>
                </ul>
                <div class="down1"></div>
              </div>
            </div>
          </div>
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span">车辆型号</span>
          <input placeholder="请输车辆型号(例如：大众)" type="text" class="publish_ueditor_li_input publish_type">
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span">可用座位</span>
          <div class="select_checkbox_container" style="margin-left: 10px"
               onclick="addTabStyle(this)">
            <span class="select_checkbox" index="1">1个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container  select_checkbox_active" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="2">2个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="3">3个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="4">4个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="5">5个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="6">6个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="7">7个</span>
            <i class="select_popover_arrow"></i>
          </div>
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span">车主姓名</span>
          <input placeholder="请输车主姓名（可选）" type="text" class="publish_ueditor_li_input publish_name">
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span publish_contact">联系电话</span>
          <input placeholder="请输联系电话，若有多个手机请用逗号隔开（133-3333-3333格式时点击空白处会自动转换）" class="publish_ueditor_li_input publish_tel" onchange="changeMobile(this)">
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span">备注信息</span>
          <input placeholder="请输入备注信息（可选）" class="publish_ueditor_li_input publish_remark">
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span" style="float:left ">备注标签</span>
          <div class="publish_yes_tags_box">
            <span class="publish_tags_title">YES标签：</span>
            <div class="publish_tags_container publish_yes_tags_container">
            </div>
          </div>
          <div class="publish_no_tags_box">
            <span class="publish_no_tags_title">NO标签：</span>
            <div class="publish_tags_container publish_no_tags_container">
            </div>
          </div>
          <div class="add_button" onclick="addManagerStyle()">
            <span class="add_style">+</span>
            <span class="add_style_text">编辑</span>
          </div>
          <div class="clear"></div>
        </div>
        <input type="button" value="保存并继续发布" class="submit_input submit_to_publish" status="0" onclick="checkPublishInput(this)">
        <input type="button" value="保存并返回列表" class="submit_input submit_to_list" status="1" onclick="checkPublishInput(this)">
        <div class="clear"></div>
      </form>
    </div>
    <%--标签选择界面--%>
    <div class="slide_container">
      <div class="slide_container_top">
        <span>选择标签</span>
        <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
      </div>
      <div class="slide_container_mid">
        <div class="slide_mid_left">
          <span class="slide_mid_txt">YES标签</span>
          <ul class="slide_mid_ul slide_mid_ul_yes">
          </ul>
        </div>
        <div class="slide_mid_right">
          <span class="slide_mid_txt">NO标签</span>
          <ul class="slide_mid_ul slide_mid_ul_no">
          </ul>
        </div>
        <div class="clear"></div>
        <div class="submit_select">
          <span class="submit_select_span main_color submit_select_sure" onclick="inputMessage()">保存</span>
          <div class="clear"></div>
        </div>
      </div>
    </div>

    <%--途径路线界面--%>
    <div class="slide_container2">
      <div class="slide_container_top">
        <span>填写主要途径路线</span>
        <span class="slide_container_top_remove" onclick="removeManagerStyle2()">x</span>
      </div>
      <div class="slide_container_mid">
        <div class="route_container">
          <div class="input_list">
            <img src="/resource/images/pc_icon_endRoute.png" />
            <input type="text" placeholder="途径路线" class="input_style route_end" index="1" />
            <img class="remove_route" src="/resource/images/pch_icon_remove.png" alt="删除" onclick="removeRoute(this)">
          </div>
          <div class="add_route" onclick="addRoute()">+手动添加路线</div>
          <div class="copy_route" ><span onclick="copyRoute()">+粘贴复制的路线</span></div>
        </div>

        <div class="clear"></div>
        <div class="submit_select">
          <span class="submit_select_span main_color submit_select_sure" onclick="inputMessage2()">保存</span>
          <div class="clear"></div>
        </div>
      </div>
    </div>

    <%--标签选择界面--%>
    <div class="slide_container3">
      <div class="slide_container_top">
        <span>检测发布信息</span>
        <span class="slide_container_top_remove" onclick="removeManagerStyle3()">x</span>
      </div>
      <div class="slide_container_mid">
        <div class="departure_city slide_container3_box">

        </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>