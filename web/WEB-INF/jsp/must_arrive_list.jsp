<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2017/06/16
  Time: 16:00
  describtion:后台管理--【必达单管理】必达单管理
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
<style>
    .userManage_container{
        width: 902px;
        margin: 30px auto 0;
        min-height: 550px;
        position: relative;
    }
    .userManage_container_2 {
        width: 902px;
        margin: 10px auto 0;
        min-height: 550px;
        position: relative;
    }
    .userManage_container_ul {
        border: 1px solid #e8e8e8;
    }
    .userManage_container_ul_2 {
        border: 1px solid #e8e8e8;
    }
    .userManage_container_li_top {
        background-color: #f4f5f9;
    }
    .userManage_container_li_top span{
        width: 140px;
    }
    .userManage_container_li_top_2 {
        background-color: #f4f5f9;
    }
    .userManage_container_li_top_2 span{
        width: 140px;
    }
    .userManage_span {
        width: 9%;
        display: inline-block;
        text-align: center;
        height: 40px;
        line-height: 40px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        font-size: 14px;
    }

    .user_manage_container_li {
        border-top: 1px dashed #e8e8e8;
        cursor:pointer;
    }
    .user_manage_container_li:hover{
        background-color: #f7f7f7;

    }
    .sub_title_bar {
        margin-bottom: 10px;
        margin-top: 20px;
    }
    .page_container{
        padding: 15px 92px;
    }

    /*下拉列表*/
    .user_list_drop_box {
        position: relative;
        float: left;
        margin-right: 30px;
    }

    .user_list_drop_box:hover > .down1 {
        transform: rotate(180deg);
    }

    .user_list_drop_box_ul {
        display: none;
        position: absolute;
        top: 31px;
        border: 1px solid #e8e8e8;
        text-align: center;
        z-index: 1;
        background-color: #fff;
    }

    .user_list_drop_box_span {
        line-height: 30px;
        padding: 0 30px 0 10px;
        text-align: center;
        border: 1px solid #e8e8e8;
        display: inline-block;
        cursor: pointer;
        width: 182px;
    }

    .cat_list_drop_box_li {
        width: 180px;
        line-height: 32px;
        cursor: pointer;
        position: relative;
    }

    .cat_list_drop_box_li:hover {
        background-color: #f4f5f9;
    }
    .select_error_message {
        color: #f5ad4e;
        position: absolute;
        left: 30px;
        display: none;
    }

    .detailAll_tip_yes {
        padding: 5px 10px;
        background-color: #f5ad4e;
        color: #fff;
        margin-right: 0px;
        cursor: pointer;
    }
    .update_message{
        position: absolute;
        right: 10px;
        top: 0px;
        z-index: 10;
        color: #fff;
        background: #f5ad4e;
        padding: 2px 5px;
        cursor: pointer;
    }
    .update_message:hover{
        background-color: #FF8F0c;
    }
    .send_message{
        position: absolute;
        color: #fff;
        margin-top: -10px;
        right:100px;
        background: #f5ad4e;
        padding: 2px 5px;
        cursor: pointer;
    }
    .send_message:hover{
        background-color: #FF8F0c;
    }
    .slide_container{
        width: 1000px;
        height:900px;
        z-index: 999;
    }
    .slide_container_mid{
        width:950px;
        margin:0 auto;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        loadArrive();
        loadArriveLine();
        $('.menu_context_li').removeClass('active_li');
        $('.arrive_list').addClass('active_li');


        $('.menu_body').removeClass('open_menu_body');
        $('.menu_head').removeClass('current');
        $('.menu_body a').removeClass('change_menu');
        $('#mustArrive_head').addClass('current');
        $('#mustArrive_body').addClass('open_menu_body');
        $('#mustArrive_menu').addClass('change_menu');

        pageSet.setPageNumber()
        // 绑定键盘按下事件
        $(document).keypress(function (e) {
            // 回车键事件
            if (e.which == 13) {
                jQuery('.search_ico').click();
            }
        });
        //搜索重置page
        $('.search_ico').click(function () {
            global_page = 0;
            findMessage();
        });
        $('.user_list_drop_box').mouseleave(function () {
            $('.user_list_drop_box_ul').hide();
        });
        $("#datepicker").datetimepicker({
            changeMonth: true,
            changeYear: true
        });
        $("#datepicker2").datetimepicker({
            changeMonth: true,
            changeYear: true
        });
        $.datepicker.regional['zh-CN'] = {
            clearText: '清除', clearStatus: '清除已选日期',
            closeText: '关闭', closeStatus: '不改变当前选择',
            prevText: '上月', prevStatus: '显示上月',
            nextText: '下月', nextStatus: '显示下月',
            currentText: '今天', currentStatus: '显示本月',
            monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                '七月', '八月', '九月', '十月', '十一月', '十二月'],
            monthNamesShort: ['一', '二', '三', '四', '五', '六',
                '七', '八', '九', '十', '十一', '十二'],
            monthStatus: '选择月份', yearStatus: '选择年份',
            weekHeader: '周', weekStatus: '年内周次',
            dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
            dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
            dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],
            dayStatus: '设置 DD 为一周起始', dateStatus: '选择 m月 d日, DD',
            dateFormat: 'yy-mm-dd', firstDay: 1,
            initStatus: '请选择日期', isRTL: false
        };
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
        madeLine();
//    setInterval(updateLine,5000);
    });

    var global_cat_id;
    var check_click_search = 0;
    var action_url="/arrive/list";
    var start_time="";
    var end_time="";

    var count_array=[];
    var count_status=0;
    //ajax获取用户
    function updateLine(){
        count_array=[];
        loadArrive();
        loadArriveLine();
        madeLine();
    }
    //加载统计数据
    function loadArriveLine(){
        count_status="";
        var obj={};
        obj.action='show';
        operation.operation_ajax2("/arrive/line",obj,madeCountObj);

    }

    function madeCountObj(){
        var count_obj={};
        var count=[];
        for(var i=0;i<global_data.data.length;i++){
            count.push(global_data.data[i].count)
        }

        count_obj.name= '用户必达单新增数';        //数据列名
        count_obj.data= count;                      //数据
        count_obj.color='#f5ad4e';
        count_array.push(count_obj)

    }

    //生成统计折线图
    function madeLine(){
        var time_array = [];
        for(var i=0;i<global_data.data.length;i++){
            time_array.push(global_data.data[i].date);
        }
        //添加数据折线
        $('#container').highcharts({                   //图表展示容器，与div的id保持一致
            chart: {
                type: 'line'                         //指定图表的类型，默认是折线图（line）
            },
            title: {
                text: '用户必达单新增数据'      //指定图表标题
            },
            xAxis: {
                categories: time_array   //指定x轴分组
            },
            yAxis: {
                title: {
                    text: ''                  //指定y轴的标题
                }
            },
            tooltip: {
                shared: true,
                crosshairs: true
            },
            plotOptions: {
                series: {
                    cursor: 'pointer',
                    events: {
                        click: function(event) {
                            start_time =event.point.category;
                            $('.select_start_time ').val(start_time);
                            var end_date = new Date(start_time.replace(/-/g,"/"));
                            var t =end_date.getTime()+1000*60*60*24;
                            var time=new Date(t);
                            changeDataStyle(time);
                            findMessage()
                        },
                    }
                }
            },
            series: count_array
        });
    }
    //转换日期格式
    function changeDataStyle(time){
        var year  = time.getFullYear();
        var month = time.getMonth()+1;
        var date  = time.getDate();
        if(month.toString().length==1){
            month = "0"+month;
        }else{
            month = parseInt(month);
        }
        if(date.toString().length==1){
            date = "0"+date;
        }else{
            date = parseInt(date);
        }
        end_time =year+"-"+month+"-"+date;
        $('.select_end_time ').val(end_time);
    }
    //封装传输的信息并提交
    function loadArrive(){
        var obj={};
        obj.action='show';
        obj.size=size;
        obj.page=global_page;
        operation.operation_ajax(action_url,obj,sendMessage);
    }
    function sendMessage(){
        $('.user_manage_container_li').remove();
        count = global_data.count;
        loadPage.checkUserPrivilege(count,insertArriveMessage);
    }
    function findMessage(){
        var obj={};
        var order_status = $('.order_status_span').attr('value_id');
        var is_enable = $('.is_enable_span').attr('value_id');
        var search = $('.search_user_input').val();
        start_time = $('.select_start_time ').val();
        end_time = $('.select_end_time ').val();
        obj.action='show';
        obj.keyword=search;
        obj.start_time=start_time;
        obj.end_time=end_time;
        obj.order_status=order_status;
        obj.is_enable=is_enable;
        obj.size=size;
        obj.page=global_page;
        operation.operation_ajax(action_url,obj,sendMessage);
    }
    //添加用户数据
    function insertArriveMessage(){
        $('.user_manage_container_li').remove();
        for (var i = 0; i < global_data.data.length; i++){
            var orderId = global_data.data[i].orderId;
            var traderNo = global_data.data[i].traderNo;
            var sex = global_data.data[i].sex;
            var userId = global_data.data[i].userId;
            var userName = global_data.data[i].userName;
            var mobile=global_data.data[i].mobile;
            var boardAdd=global_data.data[i].boardAdd;
            var boardLatitude=global_data.data[i].boardLatitude;
            var boardLongitude=global_data.data[i].boardLongitude;
            var breakAdd=global_data.data[i].breakAdd;
            var breakLatitude=global_data.data[i].breakLatitude;
            var breakLongitude=global_data.data[i].breakLongitude;
            var price=global_data.data[i].price;
            var seats=global_data.data[i].seats;
            var orderStatus=global_data.data[i].orderStatus;
            var isEnable=global_data.data[i].isEnable;
            var refuse=global_data.data[i].refuse;
            var departureTime=global_data.data[i].departureTime;
            var createTime=global_data.data[i].createTime;
            addArriveDisplay(orderId,traderNo,userId,userName,mobile,sex,boardAdd,boardLatitude,boardLongitude,breakAdd,breakLatitude,breakLongitude,price,seats,orderStatus,isEnable,refuse,departureTime,createTime);
        }
    }
    //添加用户列表
    function addArriveDisplay(orderId,traderNo,userId,userName,mobile,sex,boardAdd,boardLatitude,boardLongitude,breakAdd,breakLatitude,breakLongitude,price,seats,orderStatus,isEnable,refuse,departureTime,createTime) {
        var boardAddShort = boardAdd.length>7 ? boardAdd.substr(0,6)+"... " : boardAdd;
        var breakAddShort = breakAdd.length>7 ? breakAdd.substr(0,6)+"... " : breakAdd;
        var str = '<li class="user_manage_container_li" orderId='+orderId+' >' +
            '<span class="userManage_span" style="width:5%;margin: 0px 1px 0px 1px;" title="'+orderId+'">'+orderId+'</span>' +
            '<span class="userManage_span" style="width:5%;margin: 0px 1px 0px 1px;" title="'+userName+'">'+userName+'</span>' +
            '<span class="userManage_span" style="width:14%;margin: 0px 1px 0px 1px;" title="'+mobile+'">'+mobile+'</span>' +
            '<span class="userManage_span" style="width:12%;margin: 0px 1px 0px 0px;" title="'+boardAdd+'">'+boardAddShort+'</span>' +
            '<span class="userManage_span" style="width:12%;margin: 0px 3px 0px 1px;" title="'+breakAdd+'">'+breakAddShort+'</span>' +
            '<span class="userManage_span" style="width:10%;margin: 0px 2px 0px 1px;" title="'+orderStatus+'">'+orderStatus+'</span>' +
            '<span class="userManage_span" style="width:7%;margin: 0px 1px 0px 1px;" title="'+isEnable+'">'+isEnable+'</span>' +
            '<span class="userManage_span" style="width:7%;margin: 0px 3px 0px 2px;" title="'+refuse+'">'+refuse+'</span>' +
            '<span class="userManage_span" style="width:12%;margin: 0px 3px 0px 1px;" title="'+departureTime+'">'+departureTime+'</span>' +
            '<span class="userManage_span" style="width:12%;margin: 0px 0px 0px 1px;">' +
                '<span class="detailAll_tip_yes" onclick="addManagerStyle(\''+orderId+'\',\''+traderNo+'\',\''+userId+'\',\''+userName+'\',\''+mobile+'\',\''+sex+'\',\''+boardAdd+'\',\''+breakAdd+'\',\''+price+'\',\''+seats+'\',\''+orderStatus+'\',\''+isEnable+'\',\''+refuse+'\',\''+departureTime+'\',\''+createTime+'\')">找车</span> ' ;
                if(orderStatus=='申请退款'&&isEnable=='不可用'){
                    str+='<span class="detailAll_tip_yes" onclick="confirmRefund(\''+orderId+'\')">退款</span>' ;
                }
            str+='</span>' ;
            str+='</li>';
            $(".userManage_container_ul").append(str);
    }
    function confirmRefund(orderId) {
        var r=confirm("确定已成功退款？");
        if (r==true){
            $.ajax({
                type: 'POST',
                url: '/arrive/confirmRefund',
                data:{"orderId":orderId},
                dataType:'json',
                success:function(data){
                    alert(data.message);
                    findMessage();
                },
                error: function(data){
                    alert("操作失败！");

                }
            });
        }
    }
    setInterval("findMessage()",30000);
    //显示下拉
    function showAddToUserDrop(obj) {
        $(obj).children('.user_list_drop_box_ul').toggle();
    }
    //点击下拉列表
    function selectedCatDropList(obj) {
        $('.select_error_message').hide();
        $(obj).parent().parent().children('.user_list_drop_box_span').text($(obj).text()).attr('value_id', $(obj).attr('value_id'));
        $(obj).parent().hide();
        global_page=0;
        findMessage();
    }
    var name2;//姓氏+先生/女士
    function addManagerStyle(orderId,traderNo,userId,userName,mobile,sex,boardAdd,breakAdd,price,seats,orderStatus,isEnable,refuse,departureTime,createTime){
        $('.slide_container').animate({"top":"0.5%","opacity":"1"},300);
        $('#orderId').val(orderId);
        $('#traderNo').val(traderNo);
        $('#userId').val(userId);
        $('#userName').val(userName);
        $('#mobile').val(mobile);
        $('#boardAdd').val(boardAdd);
        $('#breakAdd').val(breakAdd);
        $('#price').val(price);
        $('#seats').val(seats);
        $('#orderStatus').val(orderStatus);
        $('#isEnable').val(isEnable);
        $('#refuse').val(refuse);
        $('#departureTime').val(departureTime);
        $('#createTime').val(createTime);
        name2 = userName.substr(0,1)+sex;
        $('#messContext').text(name2+"正在寻找从"+boardAdd+"到"+breakAdd+"的顺风车，预定"+seats+"个车位，已预付车费"+price+"元，预计"+departureTime+"启程，详情请下载 http://dwz.cn/4A6CAt 进行抢单");
        if(isEnable=='可用'&&orderStatus=='车单已支付'){
            $(".send_message").show();
        }else{
            $(".send_message").hide();
        }
        if(orderStatus=='申请退款'&&isEnable=='不可用'&&refuse>=3){
            $("#refundMessageTr").show();
            $("#refundMessageTd").text("退款详情：由于用户拒绝车单3次，仅需退还拼车费"+price+"元");
        }else if(orderStatus=='申请退款'&&isEnable=='不可用'&&refuse<3){
            $("#refundMessageTr").show();
            $("#refundMessageTd").text("退款详情：在规定期限内没有为用户找到合适车辆，需退还双倍拼车费+服务费"+(price*2+5*1)+"元");
        }else if(orderStatus=='退款成功'&&isEnable=='不可用'&&refuse>=3){
            $("#refundMessageTr").show();
            $("#refundMessageTd").text("退款详情：已退还拼车费"+price+"元");
        }else if(orderStatus=='退款成功'&&isEnable=='不可用'&&refuse<3){
            $("#refundMessageTr").show();
            $("#refundMessageTd").text("退款详情：已退还双倍拼车费+服务费"+(price*2+5*1)+"元")
        }else{
            $("#refundMessageTr").hide();
        }
        clearMoblie();
        refreshMustArriveMobile();
    }
    function clearMoblie(){
        $("#driverMobile1").val("");
        $("#driverMobile2").val("");
        $("#driverMobile3").val("");
        $("#driverMobile4").val("");
        $("#driverMobile5").val("");
        $("#driverMobile6").val("");
        $("#driverMobile7").val("");
        $("#driverMobile8").val("");
        $("#driverMobile9").val("");
        $("#driverMobile10").val("");
    }
    function removeManagerStyle(){
        $('.slide_container').animate({"top":"-220%","opacity":"0"},300);
    }
    function sendMessDriver(){
        var traderNo = $("#traderNo").val();
        var userId = $("#userId").val();
        var begin = $('#boardAdd').val();
        var end = $('#breakAdd').val();
        var seats = $('#seats').val();
        var price = $('#price').val();
        var time = $('#departureTime').val();
        var driverMobile01=$("input[name='driverMobile']")[0].value;
        var driverMobile02=$("input[name='driverMobile']")[1].value;
        var driverMobile03=$("input[name='driverMobile']")[2].value;
        var driverMobile04=$("input[name='driverMobile']")[3].value;
        var driverMobile05=$("input[name='driverMobile']")[4].value;
        var driverMobile06=$("input[name='driverMobile']")[5].value;
        var driverMobile07=$("input[name='driverMobile']")[6].value;
        var driverMobile08=$("input[name='driverMobile']")[7].value;
        var driverMobile09=$("input[name='driverMobile']")[8].value;
        var driverMobile10=$("input[name='driverMobile']")[9].value;
        var driverMobiles = driverMobile01+","+driverMobile02+","+driverMobile03+","+driverMobile04+","+driverMobile05+","
            +driverMobile06+","+driverMobile07+","+driverMobile08+","+driverMobile09+","+driverMobile10;
        if(driverMobiles.length<11){
            alert('请填写正确的手机号码！');
            return false;
        }
        $.ajax({
            type: 'POST',
            url: '/arrive/pushMess',
            data:{"traderNo":traderNo,"userId":userId,"mobiles":driverMobiles,"name":name2,"begin":begin,"end":end,"seats":seats,"price":price,"time":time},
            dataType:'json',
            success:function(data){
                alert(data.message);
                clearMoblie();
                refreshMustArriveMobile();
            },
            error: function(data){
                alert("推送失败！");

            }
        });
    }

    function  refreshMustArriveMobile() {
        var obj={};
        obj.size=size_2;
        obj.page=global_page_2;
        obj.userId=$('#userId').val();
        obj.traderNo=$('#traderNo').val();
        operation_ajax_2("/arrive/arriveformobile",obj,sendMessage_2);
    }
    function sendMessage_2(){
        $('.user_manage_container_li_2').remove();
        count_2 = global_data_2.count;
        loadPage_2.checkUserPrivilege_2(count_2,insertArriveMessage_2);
    }
    //添加用户数据
    function insertArriveMessage_2(){
        $('.user_manage_container_li_2').remove();
        for (var i = 0; i < global_data_2.data.length; i++){
            var orderId = global_data_2.data[i].orderId;
            var traderNo = global_data_2.data[i].traderNo;
            var mobile = global_data_2.data[i].mobile;
            var pushTime = global_data_2.data[i].pushTime;    //
            var isExist = global_data_2.data[i].isExist;//
            var creatTime=global_data_2.data[i].creatTime;      //
            addArriveDisplay_2(orderId,traderNo,mobile,pushTime,isExist,creatTime);
        }
    }
    //添加用户列表
    function addArriveDisplay_2(orderId,traderNo,mobile,pushTime,isExist,creatTime) {
        $(".userManage_container_ul_2").append('<li class="user_manage_container_li_2" orderId='+orderId+' >' +
            '<span class="userManage_span" style="width:10%;margin: 0px 1px 0 1px;">'+orderId+'</span>' +
            '<span class="userManage_span" style="width:20%;margin: 0px 1px 0 1px;">'+mobile+'</span>' +
            '<span class="userManage_span" style="width:20%;margin: 0px 1px 0 1px;">'+pushTime+'</span>' +
            '<span class="userManage_span" style="width:20%;margin: 0px 1px 0 1px;">'+isExist+'</span>' +
            '<span class="userManage_span" style="width:20%;margin: 0px 1px 0 1px;">'+creatTime+'</span>' +
            '</li>')
    }
    function findMessage_2(){
        var obj={};
        obj.size=size_2;
        obj.page=global_page_2;
        obj.userId=$('#userId').val();
        obj.traderNo=$('#traderNo').val();
        operation_ajax_2("/arrive/arriveformobile",obj,sendMessage_2);
    }
</script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>必达单管理</span>
                <div class="search_user">
                    <input type="text" placeholder="姓名、手机号" class="search_user_input">
                    <a href="javascript:;" class="search_user_a">
                        <div class="search_ico"></div>
                    </a>
                </div>
            </div>
        </div>
        <div class="userManage_container">
            <span class="update_message" onclick="updateLine()">更新数据</span>
            <div id="container"></div>
            <div class="clear"></div>
            <div class="user_list_drop_box" onclick="showAddToUserDrop(this)" >
                <span class="user_list_drop_box_span order_status_span" value_id="">抢单状态条件</span>
                <span class="select_error_message">请选择抢单状态条件</span>
                <ul class="user_list_drop_box_ul">
                    <div class="cat_list_drop_box_li all_id" value_id="" onclick="selectedCatDropList(this)">全部</div>
                    <div class="clear cat_list_box"></div>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="100" onclick="selectedCatDropList(this)">司机已抢单</li>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="200" onclick="selectedCatDropList(this)">车单已支付</li>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="300" onclick="selectedCatDropList(this)">同意抢单</li>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="4" onclick="selectedCatDropList(this)">拼车交易完成</li>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="5" onclick="selectedCatDropList(this)">车单结束</li>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="6" onclick="selectedCatDropList(this)">退款成功</li>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="-1" onclick="selectedCatDropList(this)">申请退款</li>
                </ul>
                <div class="down1"></div>
                <div class="clear"></div>
            </div>
            <div class="user_list_drop_box" onclick="showAddToUserDrop(this)" >
                <span class="user_list_drop_box_span is_enable_span" value_id="">订单状态条件</span>
                <span class="select_error_message">请选择订单状态条件</span>
                <ul class="user_list_drop_box_ul">
                    <div class="cat_list_drop_box_li all_id" value_id="" onclick="selectedCatDropList(this)">全部</div>
                    <div class="clear cat_list_box"></div>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="1" onclick="selectedCatDropList(this)">可用</li>
                    <li class="cat_list_drop_box_li cat_list_style" value_id="0" onclick="selectedCatDropList(this)">不可用</li>

                </ul>
                <div class="down1"></div>
                <div class="clear"></div>
            </div>
            <div class="user_list_drop_box">
                <input id="datepicker" name="publish_time" placeholder="选择开始时间" class="select_time select_start_time" onchange="findMessage()">
            </div>
            <div class="user_list_drop_box">
                <input id="datepicker2" name="publish_time" placeholder="选择结束时间" class="select_time select_end_time" onchange="findMessage()">
            </div>
            <div class="clear"></div>
            <div class="sub_title_bar">
                <span class="sub_message"></span>
                <div class="page_box">
                    <div class="page_prev" onclick="loadPage.pagePrev()">
                        <div class="arrow prev_arrow"></div>
                    </div>
                    <div class="page_number">
                        <span class="page_current"></span>
                        <span>/</span>
                        <span class="page_content"></span>
                    </div>
                    <div class="page_next" onclick="loadPage.pageNext()">
                        <div class="arrow next_arrow"></div>
                    </div>
                    <input type="text" class="page_input_number">

                    <div class="page_go" onclick="loadPage.checkPageTo()">
                        <span>跳转</span>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="page_set" onclick="pageSet.showPageSetDrop(this)" onmouseleave="pageSet.hidePageSet(this)">
                    <span class="page_set_style">每页</span>
                    <span class="page_set_number show_page">20</span>
                    <span class="page_set_style">条</span>
                    <ul class="page_set_ul">

                    </ul>
                    <div class="down1"></div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </div>
            <ul class="userManage_container_ul">
                <li class="userManage_container_li_top">
                    <span class="userManage_span" style="width:5%">单号</span>
                    <span class="userManage_span" style="width:5%">姓名</span>
                    <span class="userManage_span" style="width:13%">手机号</span>
                    <span class="userManage_span" style="width:12%">出发地址</span>
                    <span class="userManage_span" style="width:12%">到达地址</span>
                    <span class="userManage_span" style="width:10%">订单现状</span>
                    <span class="userManage_span" style="width:7%">订单状态</span>
                    <span class="userManage_span" style="width:7%">拒绝次数</span>
                    <span class="userManage_span" style="width:12%">用车时间</span>
                    <span class="userManage_span" style="width:12%">操作</span>
                </li>
                <div class="not_find_message">
                    <img src="/resource/images/eat.gif" alt="">
                    <span>您所查询的信息被我吃光光了~~</span>
                </div>
                <div class="clear"></div>
            </ul>

        </div>
        <%--分页加载--%>
        <div class="page_container">
            <div class="page_box">
                <div class="page_prev" onclick="loadPage.pagePrev()">
                    <div class="arrow prev_arrow"></div>
                </div>
                <div class="page_number">
                    <span class="page_current"></span>
                    <span>/</span>
                    <span class="page_content"></span>
                </div>
                <div class="page_next" onclick="loadPage.pageNext()">
                    <div class="arrow next_arrow"></div>
                </div>
                <input type="text" class="page_input_number">
                <div class="page_go" onclick="loadPage.checkPageTo()">
                    <span>跳转</span>
                </div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <%--添加新页面--%>
    <div class="slide_container" style=" overflow:scroll;border: 1px solid #F5AD4E;">
        <form method="post" id="upload_form" accept-charset="utf-8" onsubmit="return false" enctype="multipart/form-data" action="/api/goods?action=create">
            <div class="slide_container_top">
                <span class="slide_container_top_title">寻找车主</span>
                <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
            </div>
            <div class="slide_container_mid" style="border: 1px dashed #F5AD4E">
                <input type="hidden" id="userId"/><input type="hidden" id="traderNo"/>
                <table style="width:900px;margin-left:auto;">
                    <tr style="height: 30px;"><td colspan="3" style="font-weight: bold;color:#F5AD4E;">订单详情</td></tr>
                    <tr style="height: 30px;">
                        <td>订单编号：<input type="text" id="orderId" readonly="true" ></td>
                        <td>用&nbsp;&nbsp;户&nbsp;&nbsp;名：<input type="text" id="userName" readonly="true" ></td>
                        <td>手&nbsp;&nbsp;机&nbsp;&nbsp;号：<input type="text" id="mobile" readonly="true" ></td>
                    </tr>
                    <tr style="height: 30px;">
                        <td colspan="2">出发地点：<input type="text" id="boardAdd" readonly="true" style="width:455px;" ></td>
                        <td></td>
                    </tr>
                    <tr style="height: 30px;">
                        <td colspan="2">到达地点：<input type="text" id="breakAdd" readonly="true" style="width:455px;"></td>
                        <td>预定座位：<input type="text" id="seats" readonly="true" ></td>
                    </tr>
                    <tr style="height: 30px;">
                        <td>订单价格：<input type="text" id="price" readonly="true" ></td>
                        <td>接单状态：<input type="text" id="orderStatus" readonly="true" ></td>
                        <td>订单状态：<input type="text" id="isEnable" readonly="true" ></td>
                    </tr>
                    <tr style="height: 30px;">
                        <td>拒绝次数：<input type="text" id="refuse" readonly="true" ></td>
                        <td>出发时间：<input type="text" id="departureTime" readonly="true" ></td>
                        <td>创建时间：<input type="text" id="createTime" readonly="true" ></td>
                    </tr>
                    <tr id="refundMessageTr" style="height: 30px;">
                        <td id="refundMessageTd" colspan="3" style="color: red"></td>
                    </tr>
                </table>
            </div><br/>
            <div class="slide_container_mid" style="border: 1px dashed #F5AD4E">
                <table style="width:900px;margin-left:auto;">
                    <tr style="height: 30px;"><td colspan="2" style="font-weight: bold;color:#F5AD4E;">推送短信</td></tr>
                    <tr style="height: 30px;">
                        <td rowspan="2">车主电话：</td>
                        <td>
                            <input type="text" id="driverMobile1" name="driverMobile" length="11" style="width:143px;">&nbsp;
                            <input type="text" id="driverMobile2" name="driverMobile" length="11" style="width:143px;">&nbsp;
                            <input type="text" id="driverMobile3" name="driverMobile" length="11" style="width:143px;">&nbsp;
                            <input type="text" id="driverMobile4" name="driverMobile" length="11" style="width:143px;">&nbsp;
                            <input type="text" id="driverMobile5" name="driverMobile" length="11" style="width:143px;">&nbsp;
                        </td>
                    </tr>
                    <tr style="height: 30px;">
                        <td>
                            <input type="text" id="driverMobile6" name="driverMobile" length="11" style="width:143px;">&nbsp;
                            <input type="text" id="driverMobile7" name="driverMobile" length="11" style="width:143px;">&nbsp;
                            <input type="text" id="driverMobile8" name="driverMobile" length="11" style="width:143px;">&nbsp;
                            <input type="text" id="driverMobile9" name="driverMobile" length="11" style="width:143px;">&nbsp;
                            <input type="text" id="driverMobile10" name="driverMobile" length="11" style="width:143px;">&nbsp;
                        </td>
                    </tr>
                    <tr style="height: 30px;">
                        <td>短信内容：<input type="radio" checked="checked" readonly="true" ></td>
                        <td><div id="messContext" style="width: 750px;"></div></td>
                    </tr>
                    <tr style="height: 40px;">
                        <td colspan="2" ><span class="send_message" onclick="sendMessDriver()">推送短信</span></td>
                    </tr>
                </table>
            </div><br/>
            <div class="slide_container_mid" style="border: 1px dashed #F5AD4E">
                <div class="userManage_container_2">
                    <div class="sub_title_bar_2">
                        <span class="sub_message_2"></span>
                        <div class="page_box_2">
                            <div class="page_prev_2" onclick="loadPage_2.pagePrev_2()">
                                <div class="arrow_2 prev_arrow_2"></div>
                            </div>
                            <div class="page_number_2">
                                <span class="page_current_2"></span>
                                <span>/</span>
                                <span class="page_content_2"></span>
                            </div>
                            <div class="page_next_2" onclick="loadPage_2.pageNext_2()">
                                <div class="arrow_2 next_arrow_2"></div>
                            </div>
                            <input type="text" class="page_input_number_2">

                            <div class="page_go_2" onclick="loadPage_2.checkPageTo_2()">
                                <span>跳转</span>
                            </div>
                            <div class="clear_2"></div>
                        </div>
                        <div class="page_set_2" onclick="pageSet_2.showPageSetDrop_2(this)" onmouseleave="pageSet_2.hidePageSet_2(this)">
                            <span class="page_set_style_2">每页</span>
                            <span class="page_set_number show_page_2">10</span>
                            <span class="page_set_style_2">条</span>
                            <ul class="page_set_ul_2">
                            </ul>
                            <div class="down1_2"></div>
                            <div class="clear_2"></div>
                        </div>
                        <div class="clear_2"></div>
                    </div>
                    <ul class="userManage_container_ul_2">
                        <li class="userManage_container_li_top_2">
                            <span class="userManage_span" style="width:10%">序号</span>
                            <span class="userManage_span" style="width:20%">手机号</span>
                            <span class="userManage_span" style="width:20%">短信发送时间</span>
                            <span class="userManage_span" style="width:20%">是否注册</span>
                            <span class="userManage_span" style="width:20%">注册时间</span>
                        </li>
                        <div class="not_find_message_2">
                            <img src="/resource/images/eat.gif" alt="">
                            <span>您所查询的信息被我吃光光了~~</span>
                        </div>
                        <div class="clear"></div>
                    </ul>
                </div>
            </div>
        </form>
    </div>
    <div class="clear"></div>
</div>

<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
<style>
    /*页码样式*/
    .page_prev_2 , .page_next_2{
        float: left;
        border: 1px solid #e8e8e8;
        border-radius: 5px;
        color: #222;
        height: 30px;
        line-height: 30px;
        width: 30px;
        position: relative;
        margin-top: 5px;
        cursor: pointer;
    }
    .page_prev_2:hover{
        background-color: #f4f5f9;
    }
    .page_next_2:hover{
        background-color: #f4f5f9;
    }
    .page_prev:hover > .prev_arrow_2{
        border-right-color: #f5ad4e ;
    }
    .page_next:hover > .next_arrow_2{
        border-left-color: #f5ad4e ;
    }
    .page_prev_2 .arrow_2, .page_next_2 .arrow_2 {
        position: absolute;
        top: 50%;
        left: 50%;
        margin-top: -6px;
        margin-left: -3px;
    }
    .page_next_2 .arrow_2 {
        display: inline-block;
        width: 0;
        height: 0;
        border-width: 6px;
        border-style: dashed;
        border-color: transparent;
        border-right-width: 0;
        border-left-color: #919191;
        border-left-style: solid;
    }
    .page_prev_2 .arrow_2 {
        display: inline-block;
        width: 0;
        height: 0;
        border-width: 6px;
        border-style: dashed;
        border-color: transparent;
        border-left-width: 0;
        border-right-color: #919191;
        border-right-style: solid;
    }
    .page_container_2{
        content: "";
        border-top: 1px #e8e8e8 solid;
        margin-top: 20px;
        padding: 15px 60px;
        line-height: 40px;
        position: relative;
    }
    .page_box_2{
        float: right;
    }
    .page_number_2{
        margin: 0px 10px;
        float: left;
    }
    .page_input_number_2{
        vertical-align: middle;
        float: left;
        width: 75px;
        height: 30px;
        line-height: 22px;
        padding: 4px 0;
        border: 1px solid #e8e8e8;
        box-shadow: none;
        -moz-box-shadow: none;
        -webkit-box-shadow: none;
        border-radius: 3px;
        -moz-border-radius: 3px;
        -webkit-border-radius: 3px;
        text-align: center;
        font-size: 14px;
        margin: 5px 10px;
    }
    .page_go_2{
        float: left;
        border: 1px solid #e8e8e8;
        color: #222;
        height: 30px;
        line-height: 30px;
        width: auto;
        padding-left: 20px;
        padding-right: 20px;
        margin-top: 5px;
        border-radius: 5px;
        cursor: pointer;
    }
    .sub_title_bar_2{
        line-height: 40px;
        height:40px;
        margin-bottom: 0px;
        margin-top: 0px;
    }

    .sub_message_2 {
        line-height: 40px;
        font-size: 16px;
        float: left;
    }
    .page_set_2{
        float: right;
        line-height: 30px;
        margin-top: 5px;
        margin-right: 30px;
        border: 1px solid #e8e8e8;
        height: 30px;
        cursor: pointer;
        color: #333;
        position: relative;
        width: 110px;
        text-indent: 10px;
    }
    .page_set_ul_2{
        display: none;
        width: 100%;
        background-color: #fff;
        z-index: 1;
        position: relative;
        border: 1px solid #e8e8e8;
        margin-top: -1px;
        border-top: none;
    }
    .page_set_ul_2 li{
        line-height: 34px;
        height: 34px;
    }
    .page_set_ul_2 li:hover{
        background-color: #e8e8e8;
    }
    .page_set_number_2{
        color: #f5ad4e;
    }
    .page_set_2:hover>.down1_2{
        transform: rotate(180deg);
    }
    /*页码样式结束*/
    .not_find_message_2{
        margin-top: 40px;
        /*display: none;*/
        margin-bottom: 20px;
    }
    .not_find_message_2 img{
        margin-left: 160px;
    }
    .not_find_message_2 span{
        font-size: 25px;
        color: #13A5EA
    }
</style>
<script type="application/javascript">
    /**
     * Created by super on 2016/8/1.
     */
    var global_data_2;
    var global_page_2 = 0;
    var global_sum_2;
    var page_sum_2=1;
    var size_2=10;
    var count_2;
    var page_array_2=[10,20,30,50,100];
    //加载页码
    var loadPage_2 = (function(){
        //加载下一页
        function pageNext_2(){
            global_page_2=$($('.page_current_2')[0]).text()-1;
            $('.user_manage_container_li_2').remove();
            global_page_2++;
            findMessage_2();
        }
        //加载上一页
        function pagePrev_2(){
            global_page_2=$($('.page_current_2')[0]).text()-1;
            $('.user_manage_container_li_2').remove();
            global_page_2--;
            findMessage_2();
        }
        //控制上一页下一页按钮
        function pageButton_2(){
            console.log("当前"+global_page_2);
            if(global_page_2==0){
                console.log("page_sum总页数"+page_sum_2);
                if(global_page_2==page_sum_2-1){
                    $('.page_prev_2').hide();
                    $('.page_next_2').hide();
                    $('.page_input_number_2').hide();
                    $('.page_go_2').hide();
                }else{
                    $('.page_input_number_2').show();
                    $('.page_go_2').show();
                    $('.page_prev_2').hide();
                    $('.page_next_2').show();
                }
            }else if(global_page_2==page_sum_2-1){
                console.log("page_sum总页数2"+page_sum_2);
                $('.page_input_number_2').show();
                $('.page_go_2').show();
                $('.page_prev_2').show();
                $('.page_next_2').hide();
            }else{
                $('.page_input_number_2').show();
                $('.page_go_2').show();
                $('.page_prev_2').show();
                $('.page_next_2').show();
            }
        }
        //页码检查
        function checkPageTo_2(){
            if($($('.page_input_number_2')[0]).val()==""){
                global_page_2=$($('.page_input_number_2')[1]).val()-1;
            }else{
                global_page_2=$($('.page_input_number_2')[0]).val()-1;
            }
            if(global_page_2>page_sum_2-1 || global_page_2<0){
                global_page_2 = $('.page_current_2').text()-1;
                $('.page_input_number_2').val("");
                displayErrorMsg_2("输入的页码有误");
            }else if($($('.page_input_number_2')[0]).val()=="" && $($('.page_input_number_2')[1]).val()==""){
                global_page_2 = $('.page_current_2').text()-1;
                $('.page_input_number_2').val("");
                displayErrorMsg_2("输入的页码为空");
            }else if(isNaN($('.page_input_number_2').val())){
                global_page_2 = $('.page_current_2').text()-1;
                $('.page_input_number_2').val("");
                displayErrorMsg_2("输入的页码格式不正确");
            }else if($('.page_input_number_2').val()==$($('.page_current_2')[0]).text() || $('.page_input_number_2').val()==$($('.page_current_2')[1]).text()) {
                return false;
            }else{
                $('.page_input_number_2').val("");
                findMessage_2();
            }

        }

        //判断用户权限
        function checkUserPrivilege_2(count,listStyleFunction_2){
            $('.right_menu_li_all_2').show();
            global_sum_2=count;
            if(global_sum_2==0){
                $('.page_box_2').hide();
                $('.not_find_message_2').show();
            }else{
                $('.page_box_2').show();
                $('.not_find_message_2').hide();
            }
            $('.sub_message_2').text("总数"+"("+global_sum_2+")");
            //统计分页总数配置
            page_sum_2=Math.ceil(global_sum_2/size_2);
            if((global_page_2+1)>page_sum_2){
                global_page_2=0;
            }
            $('.page_content_2').text(page_sum_2);
            listStyleFunction_2();
            pageButton_2();
            $('.page_current_2').text(global_page_2+1);
        }
        return {
            pageNext_2 : pageNext_2,
            pagePrev_2 : pagePrev_2,
            checkPageTo_2 : checkPageTo_2,
            checkUserPrivilege_2 : checkUserPrivilege_2
        }
    }());

    //查
    var operation_ajax_2 = function(url,array,callback_2){
        $.ajax({
            type: "POST",
            url: url,
            data: array,
            dataType: "json",
            beforeSend: loading,//执行ajax前执行loading函数.直到success
            success: function (data) {
                if(data.status==true){
                    global_data_2=data.result;
                    console.log("操作成功");
                    callback_2();
                    closeLoading();
                }else{
                    showErrorTips(data.message);
                }
            },
            error: function () {
                displayErrorMsg(data.message);
            }
        })

    };

    //展示错误信息
    function showErrorTips_2(errorMessageTip){
        $('.error_animate_tips_2').animate({
            top:'60px',
            opacity:1
        },200).text(errorMessageTip);
        setTimeout(function(){backTips_2()},2000)
    }
    function displayErrorMsg_2(errorMsg)
    {
        $('.error_message_tip_2').fadeIn();
        $('.error_message_2').text(errorMsg);
    }
    function backTips(){
        $('.error_animate_tips').animate({
            top:'-50px',
            opacity:0
        },500)
    };

    var pageSet_2 = (function(){

        //显示页码设置
        function showPageSetDrop_2(obj) {
            $(obj).children('.page_set_ul_2').toggle();
        }
        //隐藏页码
        function hidePageSet_2(obj){
            $(obj).children('.page_set_ul_2').hide();
        }
        //获取页码信息
        function getPageNumber_2(obj){
            global_page_2 = 0;
            size_2=$(obj).children('.page_set_number_2').text();
            $('.show_page_2').text(size_2);
            findMessage();
        }
        //添加页码选择数据
        function setPageNumber_2(){
            for(var i=0;i<page_array_2.length;i++){
                $('.page_set_ul_2').append('<li onclick="pageSet_2.getPageNumber_2(this)">'+
                    '<span class="page_set_style_2">每页</span>'+
                    '<span class="page_set_number_2">'+page_array_2[i]+'</span>'+
                    '<span>条</span>'+
                    '</li>')
            }
        }
        return{
            showPageSetDrop_2:showPageSetDrop_2,
            hidePageSet_2:hidePageSet_2,
            getPageNumber_2:getPageNumber_2,
            setPageNumber_2:setPageNumber_2
        }
    }());
    //控制输入的只能是数字
    function onlyNum_2(obj)
    {
        if(isNaN($(obj).val())){
            $(obj).val("");
            showErrorTips_2("只允许输入数字")
        }
    }


</script>