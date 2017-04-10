<%--
  Created by IntelliJ IDEA.
  User: zhu
  Date: 2016/8/15
  Time: 13:12
  describtion:移动端--微信管理
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${pageTitle}</title>
  <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
  <script>
    wx.config({
      debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
      appId: 'wx5e8c9d82526a59db', // 必填，公众号的唯一标识

      timestamp: '${wx_timestamp}', // 必填，生成签名的时间戳
      nonceStr: '${wx_nonceStr}', // 必填，生成签名的随机串
      signature: '${wx_encryption}',// 必填，签名
      jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareQZone'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    });
    wx.ready(function () {
      wx.onMenuShareTimeline({
        title: '${pageTitle}', // 分享标题
        link: '${wx_url}', // 分享链接
        imgUrl: '${imageUrl}', // 分享图标
        success: function () {
          // 用户确认分享后执行的回调函数
        },
        cancel: function () {
          // 用户取消分享后执行的回调函数
        }
      });
      wx.onMenuShareAppMessage({
        title: '${pageTitle}', // 分享标题
        <c:if test="${intro eq null}">
        desc: '${wx_desc}',
        </c:if>                          // 分享描述
        <c:if test="${intro ne null}">
        desc: '${intro}',
        </c:if>

        link: '${wx_url}', // 分享链接
        imgUrl: '${imageUrl}', // 分享图标
        type: '', // 分享类型,music、video或link，不填默认为link
        dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
        success: function () {
          // 用户确认分享后执行的回调函数
        },
        cancel: function () {
          // 用户取消分享后执行的回调函数
        }
      });
      wx.onMenuShareQQ({
        title: '${pageTitle}', // 分享标题
        <c:if test="${intro eq null}">
        desc: '${wx_desc}',
        </c:if>                          // 分享描述
        <c:if test="${intro ne null}">
        desc: '${intro}',
        </c:if>
        link: '${wx_url}', // 分享链接
        imgUrl: '${imageUrl}', // 分享图标
        success: function () {
          // 用户确认分享后执行的回调函数
        },
        cancel: function () {
          // 用户取消分享后执行的回调函数
        }
      });
      wx.onMenuShareQZone({
        title: '${pageTitle}', // 分享标题
        <c:if test="${intro eq null}">
        desc: '${wx_desc}',
        </c:if>                          // 分享描述
        <c:if test="${intro ne null}">
        desc: '${intro}',
        </c:if>
        link: '${wx_url}', // 分享链接
        imgUrl: '${imageUrl}', // 分享图标
        success: function () {
          // 用户确认分享后执行的回调函数
        },
        cancel: function () {
          // 用户取消分享后执行的回调函数
        }
      });
      // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
    });
    wx.error(function (res) {

      // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。

    });

  </script>
</head>
<body>

</body>
</html>
