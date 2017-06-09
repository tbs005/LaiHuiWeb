<%--
  Created by IntelliJ IDEA.
  User: YangGuang
  Date: 2016/8/10
  Time: 11:09
  describtion:后台管理--【拼车信息会】添加新闻
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
  li{
    margin:1rem 0 ;
  }
#submitBtn,#cancelBtn{
  background: none;
  border: 1px solid #666;
  padding: 0rem 2rem;
  font-size: 1.5rem;
  margin-right: 2rem;
}
</style>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>

<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <script src="${pageContext.request.contextPath}/resource/js/preview.js" type="text/javascript"></script>
  <script type="text/javascript">
      $(function(){
          var editor = new wangEditor('textarea1');
          //配置获取图片名称
          editor.config.uploadImgFileName = 'myFileName'
          // 上传图片
          editor.config.uploadImgUrl = '${pageContext.request.contextPath}/news/upload';
          // 设置 headers
          editor.config.uploadHeaders = {
              'Accept' : 'text/x-json'
          };
          // 隐藏掉插入网络图片功能。该配置，只有在你正确配置了图片上传功能之后才可用。
          /*editor.config.hideLinkImg = true;*/
          editor.create();
          // 初始化编辑器的内容
          editor.$txt.html('');
      });
  </script>
  <div  id="ui_right">
      <div class="right_top">
        <div class="right_top_style">
          <span>新闻发布</span>
        </div>
      </div>
      <div class="userManage_container">
  <form:form modelAttribute="news" id="newsForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/news/add" method="post">
    <input type="hidden" id="content" name="content" value="">
    <div class="news_title"> <div>新增新闻</div></div>
      <ul>
        <li>图片:<input type="file" name="img" onchange="previewImage(this)"></li>
        <div id="preview" >
          <img id="imghead" width=100 height=100 border=0>
        </div>
        <li>新闻标题:<input type="text" name="title" id="title" value=""></li>
        <li>新闻描述:<input type="text" name="description" id="description" value=""></li>
        <li>发布单位:<input type="text" name="publisher" id="publisher" value=""></li>
        <li>新闻类型:
        <form:select path="type" id="type">
          <c:forEach items="${typeList}" var="l">
            <form:option  value="${l.type_id}">${l.type_name}</form:option>
          </c:forEach>
        </form:select></li>
        <li>新闻内容:
        <textarea id="textarea1" style="height:400px;max-height:500px;">
        </textarea>
        </li>
        <li>
          <input type="button" id="submitBtn" onclick="submitInfo()" value="保存"><input type="button" id="cancelBtn" onclick="cancel()" value="返回">
        </li>
      </ul>
  </form:form>
</div>


  </div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
