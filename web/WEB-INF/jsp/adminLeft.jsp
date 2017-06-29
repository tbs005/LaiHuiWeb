<%@ page import="com.cyparty.laihui.utilities.ConfigUtils" %><%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/3/23
  Time: 15:00
  describtion:网页左侧菜单栏
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--  update lunwf 20170628--%>
<style type="text/css">
    .ui_left{width:210px;margin:0 auto;display: table-cell;padding-top: 10px;min-height: 800px;text-align: left;}
    .menu_head{
        height: 60px;
        line-height: 60px;
        padding-left: 38px;
        font-size: 14px;
        color: #525252;
        cursor: pointer;
        position: relative;
        margin: 0px;
        background:  url(/resource/images/pro_left.png) center right 10px  no-repeat;
    }
    .menu_head img {
        margin-right: 8px;
        margin-top: -2px;
        width: 24px;
    }
    .ui_left .current{ color: #FF8F0C; background: url(/resource/images/pro_down.png) center right 10px  no-repeat;}
    .menu_body{
        line-height: 60px;
        display:none
        /*padding: 0 0 0 32px;*/
    }
    .menu_body a{display:block;height:38px;line-height:38px;padding-left:70px;color:#777777;text-decoration:none;}
    .menu_body a:hover{text-decoration:none;}
    .open_menu_body{display:block}
    .change_menu{background-color: #F3F3F3 ;border-left: 2px solid #FF8F0C;}
    .change_menu hover{ background-color: #FF8F0C;}
</style>
<%--<script src="js/jquery.js"></script>--%>
<script>
    $(document).ready(function(){
        $("#firstpane h3.menu_head").click(function(){
            $(this).addClass("current").next("div.menu_body").slideToggle(300).siblings("div.menu_body").slideUp("slow");
            $(this).siblings().removeClass("current");


        });
    });
</script>
<div id="firstpane" class="ui_left">
    <div class="hover_all"></div>
    <div class="loading_box">
        <img class="loading" src="/resource/images/loading.gif" alt="请等待">
    </div>
    <c:if test="${manager !=null && manager.privilege>=3}">
        <h3 id="userList_head" class="menu_head"><img src="/resource/images/pc_icon_menu_user.png" alt=""><span>用户管理</span></h3>
        <div id="userList_body" class="menu_body" >
            <a id="userList_menu" href="/db/user_list">APP用户</a>
        </div>
    </c:if>

    <h3 id="manageAgent_head" class="menu_head "><img src="/resource/images/pc_icon_menu_agent.png" alt=""><span>区域代理商管理</span></h3>
    <div id="manageAgent_body" class="menu_body">
        <a id="manageAgent_menu" href="/db/manage/agent">代理商管理</a>
    </div>

    <c:if test="${manager !=null && manager.privilege>=3}">
        <h3 id="validate_head" class="menu_head "><img src="/resource/images/pc_icon_menu_id.png" alt=""><span>实名认证</span></h3>
        <div id="validate_body" class="menu_body">
            <a id="validateDriver_menu" href="/db/validate/driver_list">车主认证</a>
            <a id="validatePassenger_menu" href="/db/validate/passenger_list">乘客认证</a>
            <a id="driverCheck_menu" href="/db/driver/check">认证审核</a>
        </div>
    </c:if>

    <h3 id="mustArrive_head" class="menu_head "><img src="/resource/images/pc_icon_menu_arrive.png" alt=""><span>必达单管理</span></h3>
    <div id="mustArrive_body" class="menu_body">
        <a id="mustArrive_menu" href="/db/must_arrive">必达单管理</a>
    </div>

    <h3 id="departureList_head" class="menu_head "><img src="/resource/images/pc_icon_menu_info.png" alt=""><span>拼车信息汇</span></h3>
    <div id="departureList_body" class="menu_body">
        <a id="departureList_menu" href="/db/departure_list">发车信息</a>
    </div>

    <c:if test="${manager.mobile != ConfigUtils.SUB_ADMIN}">
        <h3 id="pcxxhCumulate_head" class="menu_head "><img src="/resource/images/pc_icon_menu_WX.png" alt=""><span>公众号管理</span></h3>
        <div id="pcxxhCumulate_body" class="menu_body">
            <a id="pcxxhCumulate_menu" href="/db/pcxxh/cumulate">公众号数据统计</a>
        </div>
    </c:if>

    <h3 id="carList_head" class="menu_head "><img src="/resource/images/pc_icon_menu_count.png" alt=""><span>订单管理</span></h3>
    <div id="carList_body" class="menu_body">
        <a id="carList_menu" href="/laihui/car/list">乘客订单信息</a>
    </div>

    <h3 id="newsActivities_head" class="menu_head "><img src="/resource/images/pc_icon_menu_ad.png" alt=""><span>广告与活动</span></h3>
    <div id="newsActivities_body" class="menu_body">
        <a id="newsCarousel_menu" href="/db/carousel">轮播图设置</a>
        <a id="newsPopUpAd_menu" href="/db/pop_up_ad">弹窗广告设置</a>
        <a id="newsNavigation_menu" href="/db/navigation_page">导航设置</a>
        <a id="newsSplashScreen_menu" href="/db/splash_screen">闪屏设置</a>
        <a id="newsPartner_menu" href="/db/partner">合作商户图标设置</a>
        <a id="newsManager_menu" href="/db/news/manage">新闻管理</a>
        <a id="newsTypes_menu" href="/db/news/type">新闻标题管理</a>
    </div>

    <c:if test="${manager.mobile != ConfigUtils.SUB_ADMIN}">
        <h3 id="fundManage_head" class="menu_head "><img src="/resource/images/pc_icon_menu_cash.png" alt=""><span>资金管理</span></h3>
        <div id="fundManage_body" class="menu_body">
            <a id="fundPickUp_menu" href="/pay/application">用户提现</a>
            <a id="fundCarPool_menu" href="/pay/list">拼车资金</a>
            <a id="fundDrawBack_menu" href="/pay/back">用户退款</a>
            <a id="fund76_menu" href="/db/campaign/76">76人</a>
        </div>
    </c:if>

    <c:if test="${manager !=null && manager.privilege<=4}">
        <h3 id="personalConf_head" class="menu_head "><img src="/resource/images/pch_menu_super.png" alt=""><span>个人配置</span></h3>
        <div id="personalConf_head" class="menu_body">
            <a id="personalInfo_head" href="/db/reset_password">个人信息</a>
        </div>
    </c:if>

    <c:if test="${manager !=null && manager.privilege>=4}">
        <h3 id="extensionManage_head" class="menu_head "><img src="/resource/images/pch_menu_super.png" alt=""><span>推广管理</span></h3>
        <div id="extensionManage_body" class="menu_body">
            <a id="addExtensioner_menu" href="/db/popularize">新增专业推广员</a>
            <a id="investmentExtension_menu" href="/db/merchant/join">招商加盟</a>
        </div>
    </c:if>

    <c:if test="${manager.mobile != ConfigUtils.SUB_ADMIN}">
        <h3 id="carEditor_head" class="menu_head "><img src="/resource/images/pch_menu_order.png" alt=""><span>录入车单</span></h3>
        <div id="carEditor_body"  class="menu_body">
            <a id="carEditor_menu" href="/db/car/editor">车单编辑</a>
                <%--<a href="/db/single/count">车单统计</a>--%>
        </div>
    </c:if>

    <c:if test="${manager !=null && manager.privilege>=4}">
        <h3 id="pushManage_head" class="menu_head "><img src="/resource/images/pc_icon_menu_content.png" alt=""><span>推送管理</span></h3>
        <div id="pushManage_body" class="menu_body">
            <a id="smsPush_menu" href="/db/sms/push">短信推送</a>
            <a id="activityPush_menu" href="/db/activity/push">活动推送</a>
        </div>
    </c:if>

    <h3 id="serviceManage_head" class="menu_head "><img src="/resource/images/pc_icon_menu_role.png" alt=""><span>维护管理</span></h3>
    <div id="serviceManage_body" class="menu_body">
        <a id="userFeedBack_menu" href="/db/user_suggestion">用户反馈</a>
    </div>

</div>
<script>

</script>