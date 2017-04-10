<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/10
  Time: 11:09
  describtion:后台管理--【拼车信息会】标签管理
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


  .container_li_box:hover{
    background-color: #f7f7f7;

  }
  .sub_title_bar{
    margin-bottom: 20px;
    margin-top: 20px;
  }


  .container_left{
    width: 44%;
    float: left;
    border: 1px solid #e8e8e8;
  }
  .container_right{
    width: 44%;
    float: right;
    border: 1px solid #e8e8e8;
  }
  .container_li_top{
    background-color: #f4f5f9;
    text-align: center;
    height: 40px;
    line-height: 40px;
  }
  .container_li_box{
    border-top: 1px dashed #e8e8e8;
    cursor: pointer;
    position: relative;
  }
  .container_text{
    width: 64%;
    display: inline-block;
    text-align: center;
    height: 40px;
    line-height: 40px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    font-size: 14px;
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
    margin-right: 14px;
  }
  .change_delete{
    background-color: #e74c3c;
  }
  /*标签*/
  .tags_slide{
    height: 36px;
    line-height: 34px;
    margin-bottom: 20px;
    font-size: 14px;
    border: 1px solid #e8e8e8;
    width: 170px;
    text-align: center;
    display: inline-block;
    padding-right: 20px;
    position: relative;
    cursor: pointer;
  }
  .tags_slide ul{
    display: none;
    position: absolute;
    background-color: #fff;
    z-index: 1;
    border: 1px solid #e8e8e8;
    width: 101%;
    margin: -2px -1px;
  }
  .tags_slide_li:hover{
    background-color: #f7f7f7;
  }
  .tags_slide:hover>.down1{
    transform: rotate(180deg);
  }
  .sub_message{
    display: none;
  }
  .input_list{
    line-height: 40px;
  }

</style>
<script type="text/javascript">
  $(document).ready(function () {
    pageSet.setPageNumber();
    loadYes();
    loadNo();
    $('.menu_context_li').removeClass('active_li');
    $('.pc_tags').addClass('active_li');
    // 绑定键盘按下事件
    $(document).keypress(function (e) {
      // 回车键事件
      if (e.which == 13) {
        jQuery('.search_ico').click();
      }
    });
    //搜索重置page
    $('.search_ico').click(function () {
      findMessage();
    });
    $('.tags_slide').mouseleave(function () {
      $('.tags_slide ul').hide();
    });

  });

  var global_data;
//  var check_click_search = 0;
  var action_url="/api/db/tag";
  var click_type;
  var load_type;
  var user_id;
  //ajax获取用户
  //封装传输的信息并提交
  function loadYes(){
    $('.li_box_left').remove();
    load_type=0;
    var obj={};
    obj.action='show';
    obj.type=1;
    send(action_url,obj,load_type)
  }
  function loadNo(){
    $('.li_box_right').remove();
    load_type=1;
    var obj={};
    obj.action='show';
    obj.type=0;
    send(action_url,obj,load_type)
  }

  function send(url,array,load_type){
    $.ajax({
      type: "POST",
      url: url,
      data: array,
      async:false,
      dataType: "json",
      beforeSend: loading,//执行ajax前执行loading函数.直到success
      success: function (data) {
        closeLoading();
        if(data.status==true){
          global_data=data.result;
          if(load_type ==0){
            $('.li_box_left').remove();
            if(global_data.data ==0){
              $('.container_left_none').show();
            }else{
              $('.container_left_none').hide();
              sendMessage()
            }
          }else{
            $('.li_box_right').remove();
            if(global_data.data ==0){
              $('.container_right_none').show();
            }else{
              $('.container_right_none').hide();
              sendMessage()
            }
          }
        }else{
          showErrorTips(data.message);
        }
      },
      error: function () {
        displayErrorMsg(data.message);
      }
    })
  }

  function deleteSend(url,array,load_type){
    $.ajax({
      type: "POST",
      url: url,
      data: array,
      async:false,
      dataType: "json",
      beforeSend: loading,//执行ajax前执行loading函数.直到success
      success: function (data) {
        closeLoading();
        if(data.status==true){
          global_data=data.result;
          loadYes();
          loadNo();
        }else{
          showErrorTips(data.message);
        }
      },
      error: function () {
        displayErrorMsg(data.message);
      }
    })
  }
  //删除信息
  function deleteSingle(item){
    var obj={};
    var id = $(item).parent().parent().attr('index');
    obj.action='delete';
    obj.id=id;
    deleteSend(action_url,obj,load_type);
  }
  function sendMessage(){
    loadPage.checkUserPrivilege(count,insertUserMessage);
  }
  //添加标签
  function addManage(){
    var obj={};
    var content = $('.tags_start').val();
    var type = $('.tags_slide_text').attr('index');
    obj.action='add';
    obj.content=content;
    obj.type=type;
    if(type==1){
      operation.operation_ajax(action_url,obj,loadYes);
    }else{
      operation.operation_ajax(action_url,obj,loadNo);
    }
    removeManagerStyle();
  }
  //修改审核员
  function updateManage() {
    var obj={};
    var content = $('.tags_start').val();
    var type = $('.tags_slide_text').attr('index');
    obj.action='update';
    obj.content=content;
    obj.type=type;
    obj.id=user_id;
    if(type==1){
      operation.operation_ajax(action_url,obj,loadYes);
    }else{
      operation.operation_ajax(action_url,obj,loadNo);
    }
    removeManagerStyle();
  }
  function checkInputMessage(){
    if($('.tags_slide_text').attr('index')==""){
      showErrorTips("请选择标签类型")
    }else if($('.tags_start').val()==""){
      showErrorTips("请输入标签内容")
    }else{
      if (click_type == 1) {
        addManage()
      } else {
        updateManage()
      }
    }
  }
  //添加用户数据
  function insertUserMessage(){
    if(global_data.data.length == 0){
      if(load_type==0){
        $('.container_left_none').show();
      }else{
        $('.container_right_none').show();
      }
    }else{
      $('.container_left_none').hide();
      $('.container_right_none').hide();
      for (var i = 0; i < global_data.data.length; i++){
        var id=global_data.data[i].id;
        var tags_status=global_data.data[i].type;
        var content=global_data.data[i].content;
        addTagsDisplay(id,tags_status,content);
      }
    }

  }
  //添加标签列表
  function addTagsDisplay(id,tags_status,content) {
    if(tags_status ==1){
      $(".container_left").append(' <li class="container_li_box li_box_left" index='+id+' type='+tags_status+' onmouseleave="hideDeleteTip(this)">'+
              '<span class="container_text">'+content+'</span>'+
              '<span class="change_box change_delete" onclick="showDeleteTip(this)">删除</span>'+
              '<span class="change_box change_edit" onclick="showEditTip(this)">编辑</span>'+
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
    }else{
      $(".container_right").append(' <li class="container_li_box li_box_right" index='+id+' type='+tags_status+' onmouseleave="hideDeleteTip(this)">'+
              '<span class="container_text">'+content+'</span>'+
              '<span class="change_box change_delete" onclick="showDeleteTip(this)">删除</span>'+
              '<span class="change_box change_edit" onclick="showEditTip(this)">编辑</span>'+
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
  }
//  //显示下拉
//  function showAddToUserDrop(obj) {
//    $(obj).children('.user_list_drop_box_ul').toggle();
//  }
//  //点击下拉列表
//  function selectedCatDropList(obj) {
//    $('.select_error_message').hide();
//    $(obj).parent().parent().children('.user_list_drop_box_span').text($(obj).text()).attr('cat_id', $(obj).attr('cat_id'));
//    $('.user_list_drop_box_ul').hide();
//    $('.user_list_container_message li').remove();
//    global_page=0;
//    findMessage()
//  }
  //添加标签
  function addManagerStyle(){
//    event.preventDefault();
    click_type=1;
    $('.tags_slide_text').text('YES/NO标签').attr('index','');
    $('.tags_type').hide();
    $('.tags_start').val('');
    $('.tags_slide').show();
    $('.slide_container').animate({"top":"22%","opacity":"1"},300);
    $('.slide_container_top').children('.slide_container_top_title').text('添加标签');
    $('.submit_select_sure').text('添加');
  }
  //编辑
  function showEditTip(obj){
    click_type=2;
    if($(obj).parent().attr('type')==1){
      $('.tags_slide').hide();
      $('.tags_type').show().text('YES标签');
      $('.tags_slide_text').text('YES标签').attr('index','1')
    }else{
      $('.tags_slide_text').text('YES标签').attr('index','0');
      $('.tags_type').show().text('NO标签');
      $('.tags_slide').hide();
    }
    user_id = $(obj).parent().attr('index');
    $('.tags_start').val($(obj).parent().children('.container_text').text());
    $('.slide_container').animate({"top":"22%","opacity":"1"},300);
    $('.slide_container_top').children('.slide_container_top_title').text('编辑标签');
    $('.submit_select_sure').text('保存');
  }
  function removeManagerStyle(){
    $('.slide_container').animate({"top":"-220%","opacity":"0"},300);
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
  function showTagsUl(){
    $('.tags_slide_ul').toggle();
  }
  function selectTagsLi(obj){
    $(obj).parent().parent().children('.tags_slide_text').text($(obj).text()).attr('index',$(obj).attr('index'));
  }
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>标签库</span>
      </div>
    </div>
    <div class="userManage_container">
      <div class="clear"></div>
      <div class="sub_title_bar">
        <span class="sub_message"></span>
        <span class="add_span" onclick="addManagerStyle()"><span class="add_classify">+</span>添加标签</span>
        <div class="clear"></div>
      </div>
      <ul class="container_left">
        <li class="container_li_top">
          <span style="color:#00b38a;">YES标签</span>
        </li>
         <li class="container_left_none">
          <span class="container_text">暂无标签内容</span>
        </li>
      </ul>
      <ul class="container_right">
        <li class="container_li_top">
          <span style="color:#e74c3c;">NO标签</span>
        </li>
        <li class="container_right_none">
          <span class="container_text">暂无标签内容</span>
        </li>
      </ul>
      <div class="clear">

      </div>
    </div>
    <%--线路员添加版面--%>
    <div class="slide_container">
      <div class="slide_container_top">
        <span class="slide_container_top_title">添加标签</span>
        <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
      </div>
      <div class="input_list">
        <span>类型：</span>
        <div class="tags_slide" onclick="showTagsUl()">
          <span class="tags_slide_text" index="">选择YES/NO标签</span>
          <ul class="tags_slide_ul">
            <li class="tags_slide_li" index="1" onclick="selectTagsLi(this)">
              YES标签
            </li>
            <li class="tags_slide_li" index="0" onclick="selectTagsLi(this)">
              NO标签
            </li>
          </ul>
          <div class="down1"></div>
        </div>
        <span class="tags_type">YES</span>
      </div>

      <div class="slide_container_mid">
        <div class="input_list">
          <img src="/resource/images/pc_icon_menu_tags.png" />
          <input type="text" placeholder="标签内容" class="input_style tags_start" />
        </div>
        <div class="submit_select">
          <span class="submit_select_span main_color submit_select_sure" onclick="checkInputMessage()">添加</span>
          <%--<span class="submit_select_span main_color submit_select_not" onclick="removeManagerStyle()">取消</span>--%>
          <div class="clear"></div>
        </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
