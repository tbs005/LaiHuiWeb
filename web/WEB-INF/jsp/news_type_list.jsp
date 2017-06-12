<%--
  Created by IntelliJ IDEA.
  User: YangGuang
  Date: 2016/8/10
  Time: 11:09
  describtion:后台管理--【拼车信息会】新闻类型列表
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>

<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <script type="text/javascript">
      $(function(){
          displayData(0);
      });
      //分页
      function displayData(pageNo){
          var pageSize = 7;
          $.ajax({
              url:"${pageContext.request.contextPath}/type/list",
              type:"POST",
              cache:false,
              data:{
                  "page":pageNo,
                  "size":pageSize
              },
              success:function(jsonObject){
                  //清空tbody
                  $("#userInfoTBody").empty();
                  if(jsonObject.total==0){
                      $("#message").text("没有符合条件的记录");
                  }else{
                      $("#message").text("");
                      var htmlString = "";
                      $.each(jsonObject.result,function(i,n){
                          htmlString +="<tr  bgcolor='white'>";
                          htmlString +="<td><img src='"+n.logo+"' style='width: 50px;height: 50px'></td>";
                          htmlString +="<td>"+n.typeName+"</td>";
                          htmlString +="<td id='dict"+i+"'>"+n.dictionaryName+"</td>";
                          htmlString +="<td>"+n.createTime+"<input type='hidden' name='isEnable' id='isEnable"+i+"' value='"+n.isEnable+"'/></td>";
                          htmlString +="<td><a onclick='updateNews("+n.typeId+")' style='color: #3455fa'>编辑</a> / <a onclick='deleteNews("+n.typeId+")' style='color: #3455fa'>删除</a> / <a onclick='isEnable("+n.typeId+","+i+")' style='color: #3455fa'>启用禁用</a></td>";
                          htmlString +="</tr>";
                      });
                      $("#userInfoTBody").append(htmlString);
                  }
                  //集成jquery的翻页插件
                  $("#pagination").pagination(jsonObject.totalCount, {//总记录条数
                      callback: displayData,//每次翻页的时候执行的回调函数  会自动传递当前页码索引   比正常页码小1
                      items_per_page:pageSize, // 每页显示多少条数据
                      current_page:pageNo,//当前页码索引
                      link_to:"javascript:void(0)",//保留超链接的样式，执行js代码   不跳转到任何资源
                      num_display_entries:8,//默认显示页码入口的个数
                      next_text:"下一页",
                      prev_text:"上一页",
                      next_show_always:true,//如果没有下一页是否显示连接
                      prev_show_always:true,//如果没有上一页是否显示连接
                      num_edge_entries:2,//页码较多的时候 可以用...省略
                      ellipse_text:"..."
                  });
              }
          });
      }

      //添加
      function addNews() {
          window.location.href="${pageContext.request.contextPath}/type/toAdd";
      }
      //修改
      function updateNews(obj) {
          window.location.href="${pageContext.request.contextPath}/type/toUpdate?typeId=" + obj;
      }
      //删除
      function deleteNews(obj) {
           if(!confirm('确定删除?')){
              return;
           }
          window.location.href="${pageContext.request.contextPath}/type/delete?typeId=" + obj;
      }

      //启用禁用
      function isEnable(obj,i) {
          var ie = "#isEnable" + i;
          var di = "#dict" + i;
          var isEnable = $(ie).val();
          var flag;
          if(isEnable == 1){
              flag = 0;
          }else {
              flag = 1;
          }
          $.ajax({
              url:'${pageContext.request.contextPath}/type/enable',
              type:'post',
              data:{
                  'isEnable':flag,
                  'typeId':obj
              },
              success:function (data) {
                  if(data.result.flag){
                      if(data.result.code == 1){
                          $(di).text('启用');
                          $(ie).val('1');
                      }else {
                          $(di).text('禁用');
                          $(ie).val('0');
                      }
                  }else {

                  }
              }
          });
      }
  </script>
  <div  id="ui_right">
      <div class="right_top">
        <div class="right_top_style">
          <span>新闻类型</span>
        </div>
      </div>
      <div class="userManage_container">
  <form>
    <div class="news_title"><input type="button" value="添加类型" onclick="addNews()" class="button"> <div>类型列表</div></div>
    <table width="100%" border="0" >
      <tr>
        <td align="center">
          <table border="1" id="box_num_table2" style="width: 100%;text-align: center">
            <thead>
            <tr  bgcolor="white">
              <td>logo</td>
              <td>类型名称</td>
              <td>启用禁用</td>
              <td>创建时间</td>
              <td>操作</td>
            </tr>
            </thead>
            <tbody id="userInfoTBody">
            </tbody>
          </table>
        </td>
      </tr>
      <tr>
        <td align="center">
          <div id="pagination"></div>
        </td>
      </tr>
    </table>
  </form>
</div>


  </div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
