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

<div class="ui_left">
    <div class="hover_all"></div>
    <div class="loading_box">
        <img class="loading" src="/resource/images/loading.gif" alt="请等待">
    </div>
    <c:if test="${manager !=null && manager.privilege>=3}">

        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_menu_user.png" alt="">
                <span>用户管理</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li user_list">
                    <a href="/db/user_list">APP用户</a>
                </li>

            </ul>
        </div>
    </c:if>
    <div class="menu_context">
        <div class="menu_context_tittle">
            <img src="/resource/images/pc_icon_menu_agent.png" alt="">
            <span>区域代理商管理</span>
        </div>
        <ul class="menu_context_ul">
            <li class="menu_context_li db_manage_agent">
                <a href="/db/manage/agent">代理商管理</a>
            </li>
        </ul>
    </div>
    <c:if test="${manager !=null && manager.privilege>=3}">

        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_menu_id.png" alt="">
                <span>实名认证</span>
            </div>
            <ul class="menu_context_ul">
                    <%--<li class="menu_context_li db_validate_manager">--%>
                    <%--<a href="/db/validate/manager">认证审核员</a>--%>
                    <%--</li>--%>
                <li class="menu_context_li db_validate_driver_list">
                    <a href="/db/validate/driver_list">车主认证</a>
                </li>
                <li class="menu_context_li db_validate_passenger_list">
                    <a href="/db/validate/passenger_list">乘客认证</a>
                </li>
                <li class="menu_context_li db_driver_check">
                    <a href="/db/driver/check">认证审核</a>
                </li>
            </ul>
        </div>
    </c:if>
    <div class="menu_context">
        <div class="menu_context_tittle">
            <img src="/resource/images/pc_icon_menu_content.png" alt="">
            <span>拼车信息汇</span>
        </div>
        <ul class="menu_context_ul">

            <li class="menu_context_li driver_departure_list">
                <a href="/db/departure_list">发车信息</a>
            </li>
            <%--<li class="menu_context_li car_owner_departure_list">--%>
            <%--<a href="/db/car_owner/departure_list">微信车主发车信息</a>--%>
            <%--</li>--%>
            <%--<li class="menu_context_li app_driver_departure_count">--%>
            <%--<a href="/db/app_driver/departure_count">APP车主发车信息</a>--%>
            <%--</li>--%>
            <%--<li class="menu_context_li car_owner_base_list">--%>
            <%--<a href="/db/car_owner/base_list">车主信息统计</a>--%>
            <%--</li>--%>
            <c:if test="${manager !=null && manager.privilege>=3}">
                <%--<li class="menu_context_li wx_passenger_departure_list">--%>
                <%--<a href="/db/wx_passenger/departure/cumulate">乘客发布信息</a>--%>
                <%--</li>--%>
                <%--<li class="menu_context_li wx_passenger_list">--%>
                <%--<a href="/db/wx_passenger/cumulate">乘客信息统计</a>--%>
                <%--</li>--%>
                <%--<li class="menu_context_li passenger_booking_orders">--%>
                <%--<a href="/wx/db/passenger_orders">乘客预约信息</a>--%>
                <%--</li>--%>
                <%--<li class="menu_context_li db_wx_binding_users">--%>
                <%--<a href="/db/wx_user/cumulate/users">微信用户统计</a>--%>
                <%--</li>--%>

                <%--<li class="menu_context_li db_editor_cumulate">--%>
                <%--<a href="/db/editor/cumulate">编辑人员信息统计</a>--%>
                <%--</li>--%>
            </c:if>
        </ul>
    </div>
    <c:if test="${manager.mobile != ConfigUtils.SUB_ADMIN}">
        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_menu_WX.png" alt="">
                <span>公众号</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li db_cumulate">
                    <a href="/db/pcxxh/cumulate">公众号数据统计</a>
                </li>
            </ul>
        </div>
    </c:if>

    <%--<c:if test="${manager !=null && manager.privilege==4}">--%>
    <%--<div class="menu_context">--%>
    <%--<div class="menu_context_tittle">--%>
    <%--<img src="/resource/images/pc_icon_menu_app.png" alt="">--%>
    <%--<span>APP信息管理</span>--%>
    <%--</div>--%>
    <%--<ul class="menu_context_ul">--%>
    <%--<li class="menu_context_li db_passenger_departure_list">--%>
    <%--<a href="/db/passenger/departure_list">出行信息</a>--%>
    <%--</li>--%>
    <%--</ul>--%>
    <%--</div>--%>
    <%--</c:if>--%>


    <div class="menu_context">
        <div class="menu_context_tittle">
            <img src="/resource/images/pc_icon_menu_count.png" alt="">
            <span>订单管理</span>
        </div>
        <ul class="menu_context_ul">
            <li class="menu_context_li pay_driver_orders">
                <a href="/laihui/car/list">乘客订单信息</a>
            </li>
            <%--<li class="menu_context_li pay_passenger_orders">--%>
            <%--<a href="/db/pay/p_orders">乘客流水信息</a>--%>
            <%--</li>--%>
        </ul>
    </div>
    <div class="menu_context">
        <div class="menu_context_tittle">
            <img src="/resource/images/pc_icon_menu_ad.png" alt="">
            <span>广告与活动</span>
        </div>
        <ul class="menu_context_ul">

            <li class="menu_context_li carousel_list">
                <a href="/db/carousel">轮播图设置</a>
            </li>
            <li class="menu_context_li pop_up_ad">
                <a href="/db/pop_up_ad">弹窗广告设置</a>
            </li>
            <li class="menu_context_li navigation_page">
                <a href="/db/navigation_page">导航设置</a>
            </li>
            <li class="menu_context_li splash_screen">
                <a href="/db/splash_screen">闪屏设置</a>
            </li>
        </ul>
    </div>
    <c:if test="${manager.mobile != ConfigUtils.SUB_ADMIN}">
        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_menu_cash.png" alt="">
                <span>资金管理</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li pay_application">
                    <a href="/pay/application">用户提现</a>
                </li>
                <li class="menu_context_li pay_list">
                    <a href="/pay/list">拼车资金</a>
                </li>
                <li class="menu_context_li pay_back">
                    <a href="/pay/back">用户退款</a>
                </li>
                <li class="menu_context_li campaign_76">
                    <a href="/db/campaign/76">76人</a>
                </li>
            </ul>
        </div>
    </c:if>
    <c:if test="${manager !=null && manager.privilege<=4}">
        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pch_menu_super.png" alt="">
                <span>个人配置</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li reset_password">
                    <a href="/db/reset_password">个人信息</a>
                </li>
            </ul>
        </div>
    </c:if>
    <c:if test="${manager !=null && manager.privilege>=4}">
        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pch_menu_super.png" alt="">
                <span>推广管理</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li popularize">
                    <a href="/db/popularize">新增专业推广员</a>
                </li>
            </ul>
            <ul class="menu_context_ul">
                <li class="menu_context_li merchant_join">
                    <a href="/db/merchant/join">招商加盟</a>
                </li>
            </ul>
        </div>
    </c:if>
    <c:if test="${manager.mobile != ConfigUtils.SUB_ADMIN}">
        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_menu_content.png" alt="">
                <span>录入车单</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li order_editor">
                    <a href="/db/car/editor">车单编辑</a>
                </li>
            </ul>
        </div>
    </c:if>
    <c:if test="${manager !=null && manager.privilege>=4}">
        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_menu_content.png" alt="">
                <span>推送管理</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li sms_push">
                    <a href="/db/sms/push">短信推送</a>
                </li>
                <li class="menu_context_li activity_push">
                    <a href="/db/activity/push">活动推送</a>
                </li>
            </ul>
        </div>
    </c:if>
    <div class="menu_context">
        <div class="menu_context_tittle">
            <img src="/resource/images/pc_icon_menu_role.png" alt="">
            <span>维护</span>
        </div>
        <ul class="menu_context_ul">
            <li class="menu_context_li user_suggestion">
                <a href="/db/user_suggestion">用户反馈</a>
            </li>
        </ul>
    </div>
</div>
