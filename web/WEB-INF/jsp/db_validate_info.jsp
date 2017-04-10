<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/2
  Time: 15:00
  describtion:后台管理--【实名认证】车主审核详情
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<style type="text/css">

  .userManage_container {
    width: 800px;
    margin: 30px auto 0;
    min-height: 550px;
  }
  .share_shop_container{
    width: 100%;
    position: relative;
    padding: 20px;
    line-height: 30px;
    border: 3px dashed #e8e8e8;
  }

  .share_goods_container{
    border: 1px solid #e8e8e8;
    padding: 10px;
    margin-bottom: 20px;
    transform: translateZ(0);
    -webkit-transform: translateZ(0);
  }
  .goods_title{
    padding-bottom: 10px;
    border-bottom: 1px dotted #e8e8e8;
    margin-bottom: 10px;
  }
  .goods_title span{
    border-left: 4px solid #ea6523;
    padding-left: 6px;
  }
  .line_title{
    margin: 20px auto;
  }
  .check_mid_pic{
   margin-bottom:0;
  }

</style>
<script type="text/javascript">
  $(document).ready(function () {
    loadMessage();
  });
  var url = window.location.href;
  var token = url.substr(url.indexOf("=") + 1);
  var array={};
  var status =-1;
  function loadMessage() {
    array.action = 'driver';
    array.token = token;
    operation.operation_ajax('/auth/info', array, checkStatus);
  }
  function checkStatus(){
    status=global_data.status
    if(status == 2){
      //未审核
      $('.goods_box iframe').attr('src','/auth/check_car?token='+token);
    }else if(status == 1){
      //审核通过
      $('.goods_box iframe').attr('src','/auth/validate/info?token='+token);
    }else{
      //审核拒绝
      $('.goods_box iframe').attr('src','/auth/validate/info?token='+token);

    }
  }
  function iFrameHeight() {
    var ifm= document.getElementById("iframe_page");
    var subWeb = document.frames ? document.frames["iframe_page"].document : ifm.contentDocument;
    if(ifm != null && subWeb != null) {
      ifm.height = 1200+"px";
      ifm.width = "100%";
    }
  }
</script>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>车主认证详情</span>
      </div>
    </div>
    <div class="userManage_container">
      <div class="share_goods_container">
        <div class="goods_title">
          <span>车主基本信息</span>
        </div>
        <div class="goods_box">
          <iframe src="" id="iframe_page" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" onLoad="iFrameHeight()"></iframe>
          <div class="clear"></div>
        </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>