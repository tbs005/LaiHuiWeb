<%--
  Created by IntelliJ IDEA.
  User: YangGuang
  Date: 2016/8/10
  Time: 11:09
  describtion:后台管理--【拼车信息会】添加类型
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
  <div  id="ui_right">
      <div class="right_top">
        <div class="right_top_style">
          <span>新闻类型</span>
        </div>
      </div>
      <div class="userManage_container">
  <form:form modelAttribute="news" id="newsForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/type/add" method="post">
    <div class="news_title"> <div>新增类型</div></div>
      <ul>
        <li>logo:<input type="file" name="img" onchange="previewImage(this)"></li>
        <div id="preview" >
          <img id="imghead" width=100 height=100 border=0>
        </div>
        <li>类型名称:<input type="text" name="typeName" id="title" value=""></li>
        <li>
          <input type="submit" id="submitBtn"  value="保存"><input type="button" id="cancelBtn" onclick="cancel()" value="返回">
        </li>
      </ul>
  </form:form>
</div>

  </div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
