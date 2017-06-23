<%--
  Created by IntelliJ IDEA.
  User: zhu
  Date: 2016/11/5
  Time: 14:37
  des:后台管理--轮播图设置
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/swiper-3.3.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/swiper-3.3.1.min.css" >
<link rel="stylesheet" href="/resource/css/carousel_list.css" >
<%--右侧菜单--%>
<script src="/resource/js/carousel_list.js" type="text/javascript"></script>
  <%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>轮播图管理界面</span>
      </div>
    </div>
    <div class="hover_all"></div>
    <div class="carousel">
      <div class="swiper-container" style="height:300px;">
        <div class="swiper-wrapper">
        </div>
        <div class="swiper-pagination">
          &nbsp;</div>
      </div>
    </div>
    <div class="question_list_container">
      <div class="sub_title_bar">
        <span class="sub_message"></span>
        <span class="add_span" onclick="addManagerStyle()"><span class="add_classify">+</span>新建轮播图</span>
        <div class="clear"></div>
      </div>

    </div>
    <%--列表信息--%>
    <div class="question_list_container_message">

      <div class="not_find_message">
        <img src="/resource/images/eat.gif">
        <span>您所查询的信息被我吃光光了~~</span>
      </div>
      <div class="clear"></div>
    </div>
  </div>
  <%--添加版面--%>
  <div class="slide_container">
    <form method="post" id="upload_form" accept-charset="utf-8" onsubmit="return false" enctype="multipart/form-data" action="/api/goods?action=create">
    <div class="slide_container_top">
      <span class="slide_container_top_title">添加轮播</span>
      <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
    </div>
    <div class="slide_container_mid">
      <div class="editor_mid_box">
        <input type="file" title="支持jpg、jpeg、gif、png格式，文件小于2M" size="1"
               onchange="loadImageChange(this);" class="file_prew file0" name="img"
               accept=".jpg,.png,.gif,.jpeg">
        <img src="" class="img0" alt="">
        <div class="editor_cancel" onclick="removePicture(this)"></div>
        <div class="editor_change">
          <div class="editor_mid_box_img">
          </div>
          <div class="editor_mid_box_txt">
            <span>上传轮播图片</span>
          </div>
        </div>
      </div>
      <div><span class="adverMsg">请上传750*250像素的图片</span></div>
      <div class="input_list">
        <img src="/resource/images/pc_icon_beihzu.png" />
        <input type="text" name="title" placeholder="图片标题" class="input_style route_start" />
      </div>
      <div class="input_list">
        <img src="/resource/images/pc_icon_beihzu.png" />
        <input type="text" name="subtitle" placeholder="图片副标题" class="input_style route_sub" />
      </div >
      <div class="input_list">
        <img src="/resource/images/pc_icon_url.png" />
        <input type="text" name="link" placeholder="图片链接" class="input_style route_end" />
      </div>

      <div class="article">
        <span class="article_tittle_box_span">轮播排序</span>
        <div class="company_province_place" onmouseleave="hideCate(this)">
          <span class="company_cat_box_span ad_seq" onclick="showAddToCatDrop(this)" cat_id="">1</span>
          <div class="down1"></div>
          <ul class="company_cat_ul company_province_cat_ul">
            <div class="company_cat_title company_province_place_title">
            </div>
          </ul>
        </div>
      </div>
      <div class="submit_select">
        <span class="submit_select_span main_color submit_select_sure" onclick="checkInputMessage()">添加</span>
        <div class="clear"></div>
      </div>
    </div>
      </form>
  </div>
  <div class="clear"></div>
</div>
</body>
</html>
