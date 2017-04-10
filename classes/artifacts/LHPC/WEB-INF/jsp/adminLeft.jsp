<%--
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
                    <a href="/db/user_list">账户管理</a>
                </li>
            </ul>
        </div>
    </c:if>
    <c:if test="${manager !=null && manager.privilege>=3}">

        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_menu_id.png" alt="">
                <span>实名认证</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li db_validate_manager">
                    <a href="/db/validate/manager">认证审核员</a>
                </li>
                <li class="menu_context_li db_validate_list">
                    <a href="/db/validate/list">车主审核</a>
                </li>
            </ul>
        </div>
    </c:if>
    <c:if test="${manager !=null && manager.privilege==4}">
        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_,menu_route.png" alt="">
                <span>线路管理</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li route_list">
                    <a href="/db/route_list">线路信息</a>
                </li>
                    <%--<li class="menu_context_li driver_departure_list">--%>
                    <%--<a href="/db/departure_list">发车信息</a>--%>
                    <%--</li>--%>
            </ul>
        </div>
    </c:if>
    <div class="menu_context">
        <div class="menu_context_tittle">
            <img src="/resource/images/pc_icon_menu_content.png" alt="">
            <span>拼车信息汇</span>
        </div>
        <ul class="menu_context_ul">
            <c:if test="${manager !=null && manager.privilege>=3}">

                <li class="menu_context_li pch_route">
                    <a href="/db/pch/route_list">线路管理</a>
                </li>
                <li class="menu_context_li pc_tags">
                    <a href="/db/tags">标签管理</a>
                </li>
            </c:if>
            <li class="menu_context_li driver_departure_list">
                <a href="/db/departure_list">发车信息</a>
            </li>
            <li class="menu_context_li car_owner_departure_list">
                <a href="/db/car_owner/departure_list">微信车主发车信息</a>
            </li>
            <li class="menu_context_li app_driver_departure_count">
                <a href="/db/app_driver/departure_count">APP车主发车信息</a>
            </li>
            <li class="menu_context_li car_owner_base_list">
                <a href="/db/car_owner/base_list">车主信息统计</a>
            </li>
            <c:if test="${manager !=null && manager.privilege>=3}">
                <li class="menu_context_li wx_passenger_departure_list">
                    <a href="/db/wx_passenger/departure/cumulate">乘客发布信息</a>
                </li>
                <li class="menu_context_li wx_passenger_list">
                    <a href="/db/wx_passenger/cumulate">乘客信息统计</a>
                </li>
                <li class="menu_context_li passenger_booking_orders">
                    <a href="/wx/db/passenger_orders">乘客预约信息</a>
                </li>
                <li class="menu_context_li db_wx_binding_users">
                    <a href="/db/wx_user/cumulate/users">微信用户统计</a>
                </li>
                <li class="menu_context_li db_cumulate">
                    <a href="/db/pcxxh/cumulate">公众号数据统计</a>
                </li>
                <li class="menu_context_li db_editor_cumulate">
                    <a href="/db/editor/cumulate">编辑人员信息统计</a>
                </li>
            </c:if>
        </ul>
    </div>
    <c:if test="${manager !=null && manager.privilege==4}">
        <div class="menu_context">
            <div class="menu_context_tittle">
                <img src="/resource/images/pc_icon_menu_app.png" alt="">
                <span>APP信息管理</span>
            </div>
            <ul class="menu_context_ul">
                <li class="menu_context_li db_passenger_departure_list">
                    <a href="/db/passenger/departure_list">出行信息</a>
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
    <div class="menu_context">
        <div class="menu_context_tittle">
            <img src="/resource/images/pc_icon_menu_ad.png" alt="">
            <span>广告与活动</span>
        </div>
        <ul class="menu_context_ul">
            <li class="menu_context_li ad_manage_list">
                <a href="/db/ad_manage_list">目的地广告</a>
            </li>
        </ul>
    </div>
    <div class="menu_context">
        <div class="menu_context_tittle">
            <img src="/resource/images/pc_icon_menu_ad.png" alt="">
            <span>账单管理</span>
        </div>
        <ul class="menu_context_ul">
            <li class="menu_context_li pay_driver_orders">
                <a href="/db/pay/d_orders">车主流水信息</a>
            </li>
            <li class="menu_context_li pay_passenger_orders">
                <a href="/db/pay/p_orders">乘客流水信息</a>
            </li>
        </ul>
    </div>
</div>
