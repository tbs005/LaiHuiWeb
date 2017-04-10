<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/6/30
  Time: 11:53
  describtion:后台管理--【APP信息管理】出行信息编辑
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

</style>
<script>

  $(document).ready(function () {
    $('.menu_context_li').removeClass('active_li');
    $('.db_passenger_departure').addClass('active_li');
    $('.publish_slide').mouseleave(function () {
      $('.publish_slide ul').hide();
    });
    $('.user_list_drop_box').mouseleave(function () {
      $('.user_list_drop_box_ul').hide();
    });
    checkId();
    loadStartRoute();
    setShowData();
  });
  var array_date = [];
  var send_time;
  var send_time2;
  var start_route;
  var passenger_id;
  var url = window.location.href;
  var save_status;

  var token;
  token = "7f5bfcb450e7425a144f3e20aa1d1a6e";
//  function android_get_token()
//  {
////            String local_token=androidInterface.getToken();
//    return token;
//  }
  //判断是否是修改信息
  function checkId() {
    if (url.indexOf("=") == -1) {
      console.log('不进行修改')
    } else {
      passenger_id = url.substr(url.indexOf("=") + 1);
      console.log('进行修改');
      loadMessage();
    }
  }
  function loadMessage(){

    var obj = {};
    obj.action = 'show';
    obj.id = passenger_id;
    operation.operation_ajax("/api/passenger/departure", obj, insertUserMessage);
  }
  //添加用户数据
  function insertUserMessage() {
    for (var i = 0; i < global_data.data.length; i++) {
      var start_time = global_data.data[i].start_time;//开始时间
      var end_time = global_data.data[i].end_time;//结束时间
      var departure_city = global_data.data[i].departure_city;//出发城市
      var destination_city = global_data.data[i].destination_city;//目的城市
      var departure = global_data.data[i].departure;//出发小城
      var destination = global_data.data[i].destination;//目的小城市
      var description = global_data.data[i].description;//描述信息
      var boarding_point = global_data.data[i].boarding_point;//上车地点
      var breakout_point = global_data.data[i].breakout_point;//下车地点
      var booking_seats = global_data.data[i].booking_seats;//预定座位
      var id = global_data.data[i].id;//id

      $('.publish_start_city').text(departure_city).attr('index','0');
      $('.publish_county1').val(departure);
      $('.publish_end_city').text(destination_city).attr('index','0');
      $('.publish_county2').val(destination);
      $('.boarding_point').val(boarding_point);
      $('.breakout_point').val(breakout_point);
      $('.publish_remark').val(description);

      $('.select_checkbox_container').removeClass('select_checkbox_active');
      for(var j=0;j<$('.select_checkbox_container').length;j++){
        if($($('.select_checkbox_container')[j]).children('.select_checkbox').attr('index') == booking_seats){
          $($('.select_checkbox_container')[j]).addClass('select_checkbox_active');
        }
      }

      var start_date = start_time.split(" ")[0];

      var first_date_time =start_time.substring(11, 13);
      var last_data_time = end_time.substring(11, 13);

      $('.publish_begin_time').text(start_date).attr('index','0');
      $('.publish_start_time').val(first_date_time);
      $('.publish_end_time').val(last_data_time);
    }
  }
  //出发路线
  function loadStartRoute(){
    var obj={};
    obj.action='departure';
    operation.operation_ajax("/db/route",obj,startRouteLi);
  }
  //结束路线
  function loadEndRoute(departure){
    var obj={};
    obj.action='departure';
    obj.departure=departure;
    operation.operation_ajax("/db/route",obj,endRouteLi);
  }
  function startRouteLi(){
    for(var i=0;i<global_data.data.length;i++){
      $('.publish_start_slide_ul').append('<li class="publish_slide_li" index='+i+' onclick="selectStyleTagsLi(this)">'+global_data.data[i].departure+'</li>')
    }
  }
  function endRouteLi(){
    $('.publish_end_slide_ul').empty();
    for(var i=0;i<global_data.data.length;i++){
      $('.publish_end_slide_ul').append('<li class="publish_slide_li" index='+i+' onclick="selectTagsLi(this)">'+global_data.data[i].destination+'</li>')
    }
  }

  //显示下拉
  function showTagsUl(obj) {
    $(obj).children('.publish_slide_ul').toggle();
  }
  function selectTagsLi(obj) {
    $(obj).parent().parent().children('.publish_slide_text').text($(obj).text()).attr('index', $(obj).attr('index'));
  }
  //选择开始出发城市，进行数据交互
  function selectStyleTagsLi(obj) {
    $('.publish_end_city').text("选择目的城市").attr('index',"");
    $(obj).parent().parent().children('.publish_slide_text').text($(obj).text()).attr('index', $(obj).attr('index'));
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
    }else{
      save_status=$(obj).attr('status');
      setSendData();
      addMessage();
    };
  }
  function addMessage(){

    var data_obj={};
    var departure_city=$('.publish_start_city').text();
    var destination_city=$('.publish_end_city').text();
    var init_seats=$('.select_checkbox_active').text().trim().substring(0,1);
    var description=$('.publish_remark').val();
    var departure_county=$('.publish_county1').val();
    var destination=$('.publish_county2').val();
    var boarding_point=$('.boarding_point').val();
    var breakout_point=$('.breakout_point').val();
    if (url.indexOf("=") == -1) {

    } else {
      data_obj.id = passenger_id;
    }
    data_obj.action = 'add';
    data_obj.token = token;
    data_obj.start_time = send_time;
    data_obj.end_time = send_time2;
    data_obj.departure_city = departure_city;
    data_obj.destination_city = destination_city;
    data_obj.booking_seats = init_seats;
    data_obj.description = description;
    data_obj.departure = departure_county;
    data_obj.destination = destination;
    data_obj.boarding_point = boarding_point;
    data_obj.breakout_point = breakout_point;

    operation.operation_ajax('/api/passenger/departure', data_obj, success);
  }
  function success(){

    if(save_status==0){
      showErrorTips("发布成功");
      setTimeout(window.location.href="/db/passenger/departure",1500);
    }else{
      window.location.href="/db/passenger/departure_list";
    }

  }
  //发送时间的数据
  function setSendData(){
    var time;
    var str =$('.publish_begin_time').text().substring(0,2);

    if(str=="今天"){
      time=new Date();
      changeDataStyle(time)
    }else{
      var today=new Date();
      var t=today.getTime()+1000*60*60*24;
      time=new Date(t);
      changeDataStyle(time)
    }

  }
  //显示今天和明天信息
  function setShowData(){

    var str_time1=new Date();
    for(var i=0;i<$('.publish_slide_li_date').length;i++){
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
      obj.date = date2;
      array_date.push(obj);
    }

    for(var j=0;j<array_date.length;j++){
      if(j==0){
        $($('.publish_slide_li_date')[j]).text("今天("+array_date[j].year+"-"+array_date[j].month+"-"+array_date[j].date+")")
      }else{
        $($('.publish_slide_li_date')[j]).text("明天("+array_date[j].year+"-"+array_date[j].month+"-"+array_date[j].date+")")
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
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>出行信息</span>
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
          <span class="publish_tittle_box_span " index="">出发时间</span>

          <div class="publish_list">
            <div class="publish_slide" onclick="showTagsUl(this)">
              <span class="publish_slide_text publish_begin_time" index="" >选择出发时间</span>
              <ul class="publish_slide_ul">
                <li class="publish_slide_li publish_slide_li_date" index="1" onclick="selectTagsLi(this)">
                  今天
                </li>
                <li class="publish_slide_li publish_slide_li_date" index="0" onclick="selectTagsLi(this)">
                  明天
                </li>
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
          <span class="publish_tittle_box_span">上车地点</span>
          <input placeholder="请输上车位置" type="text" class="publish_ueditor_li_input boarding_point">
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span">下车地点</span>
          <input placeholder="请输下车位置" type="text" class="publish_ueditor_li_input breakout_point">
        </div>
        <div class="publish_list_box">
          <span class="publish_tittle_box_span ">预定座位</span>
          <div class="select_checkbox_container select_checkbox_active" style="margin-left: 10px"
               onclick="addTabStyle(this)">
            <span class="select_checkbox" index="1">1个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="2">2个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container" onclick="addTabStyle(this)">
            <span class="select_checkbox" index="3">3个</span>
            <i class="select_popover_arrow"></i>
          </div>
          <div class="select_checkbox_container " onclick="addTabStyle(this)">
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
          <span class="publish_tittle_box_span">备注信息</span>
          <input placeholder="请输入备注信息（可选）" class="publish_ueditor_li_input publish_remark">
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