<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/14
  Time: 18:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    var ue = UE.getEditor('editor');
    UE.Editor.prototype._bkGetActionUrl=UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl=function(action){
        if (action == 'uploadimage' ||action== 'uploadscrawl'
            || action == 'uploadfile' || action == 'uploadvideo'
            || action == 'catchimage' )
        {
            return '<%=request.getContextPath() %>/ueditor/upload.do';
        } else{
            return this._bkGetActionUrl.call(this, action);
        }
    }
    // 复写UEDITOR的getContentLength方法 解决富文本编辑器中一张图片或者一个文件只能算一个字符的问题,可跟数据库字符的长度配合使用
    UE.Editor.prototype._bkGetContentLength = UE.Editor.prototype.getContentLength;
    UE.Editor.prototype.getContentLength = function(){
        return this.getContent().length;
    }
</script>

