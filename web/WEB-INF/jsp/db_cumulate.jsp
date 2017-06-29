<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/1
  Time: 11:09
  describtion:后台管理--【拼车信息汇】数据统计
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--头部信息--%>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/resource/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
<script src="/resource/js/highcharts.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/jquery-ui.css" type="text/css">
<style>
    .count_container {
        width: 902px;
        margin: 30px auto 0;
        min-height: 550px;
    }

    .count_container_ul {
        border: 1px solid #e8e8e8;
        margin-bottom: 30px;
    }

    .count_container_li_top {
        background-color: #f4f5f9;
    }

    .count_span {
        width: 24%;
        display: inline-block;
        text-align: center;
        height: 40px;
        line-height: 40px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        font-size: 14px;
    }

    .count_title {
        position: relative;
        height: 40px;
    }

    .count_title_span {
        display: inline-block;
        background-color: #fff;
        position: relative;
        z-index: 10;
        padding-right: 20px;
        font-size: 16px;
        border-left: 4px #F5AD4E solid;
        top: 10px;
        padding-left: 10px;
    }

    .count_line {
        border-top: 1px solid #e8e8e8;
        position: absolute;
        top: 20px;
        width: 100%;
    }

    .count_sum {
        line-height: 40px;
    }

    .count_sum_total {
        color: #2ecc71;
    }

    .count_detail {
        color: #F5AD4E;
        cursor: pointer;
        position: relative;
        z-index: 101;
    }

    .count_detail:hover {
        color: #FF8F0C;
    }

    .slide_container {
        width: 600px;
        top:0;
        bottom:0;
        margin: 20px auto;
        overflow: auto;
    }

    #message_container {
        padding: 0 30px;
    }

    .count_slide_span {
        width: 49%;
    }

    .user_manage_container_li {
        border-top: 1px dashed #e8e8e8;
        position: relative
    }

    .slide_count_add_box {
        line-height: 40px;
    }

    .slide_count_add_span {
        color: #2ecc71;
    }

    .count_message {
        margin-bottom: 60px;
    }
    .submit_select{
        margin-top:20px ;
    }

</style>
<script type="text/javascript">
    $(document).ready(function () {
        loadSummaryMessage();
        loadCumulateMessage();

        $('.menu_body').removeClass('open_menu_body');
        $('.menu_head').removeClass('current');
        $('.menu_body a').removeClass('change_menu');
        $('#pcxxhCumulate_head').addClass('current');
        $('#pcxxhCumulate_body').addClass('open_menu_body');
        $('#pcxxhCumulate_menu').addClass('change_menu');

    });

    var global_cat_id;
    var check_click_search = 0;
    var array_all = [];//存储详细数据
    var array_change = [];
    //ajax获取用户
    //封装传输的信息并提交
    //获取详细数据
    function loadSummaryMessage() {
        var obj = {};
        obj.action = 'summary';
        operation.operation_ajax2("/api/pcxxh/cumulate", obj, splitDetailMessage);
    }
    //将详细数据进行拆分
    function splitDetailMessage() {
        console.log(global_data.list.length);
        var date;
        var sum = 0;
        var count = 0;
        //遍历数据并封装
        for (var i = 0; i < global_data.list.length; i++) {
            if (i + 1 != global_data.list.length) {
                //判断一共存在几个日期（不包含日期数据）
                if (global_data.list[i].ref_date != global_data.list[i + 1].ref_date) {
                    var obj_all = {};
                    var array_detail = [];
                    obj_all.date = global_data.list[i].ref_date;
                    //计算每个日期包含数据总数
                    sum = [(i + 1) - count];
                    for (var j = 0; j < sum; j++) {
                        //对数据进行对象封装
                        var obj_detail = {};
                        var new_user = global_data.list[i - j].new_user;
                        var cancel_user = global_data.list[i - j].cancel_user;
                        var user_source = global_data.list[i - j].user_source;
                        var date = global_data.list[i - j].ref_date;
                        obj_detail.new_user = new_user;
                        obj_detail.cancel_user = cancel_user;
                        obj_detail.user_source = user_source;
                        obj_detail.ref_date = date;
                        array_detail.push(obj_detail);
                    }
                    count = (i + 1);
                    obj_all.data_message = array_detail;
                    array_all.push(obj_all);
                }
            } else {
                //添加最后一段日期数据
                var obj_all = {};
                var array_detail = [];
                obj_all.date = global_data.list[i].ref_date;
                sum = [(i + 1) - count];
                for (var j = 0; j < sum; j++) {
                    var obj_detail = {};
                    var new_user = global_data.list[i - j].new_user;
                    var cancel_user = global_data.list[i - j].cancel_user;
                    var user_source = global_data.list[i - j].user_source;
                    var date = global_data.list[i - j].ref_date;
                    obj_detail.new_user = new_user;
                    obj_detail.cancel_user = cancel_user;
                    obj_detail.user_source = user_source;
                    obj_detail.ref_date = date;
                    array_detail.push(obj_detail);
                }
                count = (i + 1);
                obj_all.data_message = array_detail;
                array_all.push(obj_all);
            }
        }
        addCountMessage();
    }
    //获取总数
    function loadCumulateMessage() {
        var obj = {};
        obj.action = 'cumulate';
        operation.operation_ajax2("/api/pcxxh/cumulate", obj, addAllChange);
    }
    //将数据进行循环
    function addCountMessage(){
        for(var i=0;i<array_all.length;i++){
            var date = array_all[i].date;
            var count_sum;
            var new_user_all=0;
            var cancel_user_all=0;
            var index=i;
            for(var j=0;j<array_all[i].data_message.length;j++){
                var new_user = array_all[i].data_message[j].new_user;
                var cancel_user = array_all[i].data_message[j].cancel_user;
                new_user_all+=new_user;
                cancel_user_all+=cancel_user;

            };
            count_sum=(new_user_all-cancel_user_all);
            insertUserMessage(index,date,count_sum,new_user_all,cancel_user_all)
        }
    }
    //添加展示数据
    function insertUserMessage(index,date,count_sum,new_user_all,cancel_user_all) {
        $('.count_container_box').prepend('<div class="count_message" index='+index+'>'+
        '<div class="count_title">' +
        '<span class="count_title_span">'+date+'日数据</span>' +
        '<div class="count_line"></div>' +
        '</div>' +
        '<div class="count_sum">' +
        '<span>累计关注总数：</span>' +
        '<span class="count_sum_total">'+count_sum+'</span>' +
        '</div>' +
        '<ul class="count_container_ul count_detail_box">' +
        '<li class="count_container_li_top">' +
        '<span class="count_span">净增量</span>' +
        '<span class="count_span">新增关注</span>' +
        '<span class="count_span">取消关注</span>' +
        '<span class="count_span">详情内容</span>' +
        '</li>' +
        '<li class="user_manage_container_li" >' +
        '<span class="count_span ">'+count_sum+'</span>' +
        '<span class="count_span new_user_all">'+new_user_all+'</span>' +
        '<span class="count_span">'+cancel_user_all+'</span>' +
        '<span class="count_span count_detail" onclick="addManagerStyle(this)">查看详情</span>' +
        '</li>' +
        '</ul>' +
        '</div>'
    )
    }
    //添加详情数据
    function addDetailMessage(ref_date,new_user_all){
        $('.submit_select').before('<div class="detail_box">' +
                '<div class="slide_container_top">'+
                '<span>'+ref_date+'日统计数据</span>'+
                '<span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>'+
                '</div>'+
                '<div class="slide_container_mid" id="message_container">'+
                '<div class="slide_time">'+
                '<div class="slide_count_add_box">'+
                '<span>新增关注</span>'+
                '<span class="slide_count_add_span">+'+new_user_all+'</span>'+
                '</div>'+
                '<ul class="count_container_ul count_slide_box">'+
                '<li class="count_container_li_top">'+
                '<span class="count_span count_slide_span">来源</span>'+
                '<span class="count_span count_slide_span">新增数量</span>'+
                '</li>'+
                '<div class="clear count_slide_box_clear"></div>'+
                '</ul>'+
                '<div id="container" style="min-width:400px;height:400px"></div>'+
                '</div>'+
                '</div>'+
                '</div>')
    }
    function addAllChange(){
        array_change = [];
        for(var i=(global_data.list.length-1);i>=0;i--){
            array_change.push(global_data.list[i].cumulate_user);
//            $($('.count_sum_total')[i]).text(array_change[i]);
        }
        for(var j = 0; j<array_change.length;j++){
            $($('.count_sum_total')[j]).text(array_change[j]);
        }

    }
    //移除下滑
    function removeManagerStyle() {
        $('.slide_container').css("z-index","100").animate({"top": "0", "opacity": "0"}, 300);
    }
    function addManagerStyle(obj) {
        $('.detail_box').remove();
        var index=$(obj).parent().parent().parent().attr('index');
        var ref_date= array_all[index].date;
        var new_user_all = $(obj).parent().parent().parent().find('.new_user_all').text();
        addDetailMessage(ref_date,new_user_all);
        var data_array=[];
        for(var j=0;j<array_all[index].data_message.length;j++){
            var data_array_list=[];
            // 0代表其他合计
            // 1代表公众号搜索
            // 17代表名片分享
            // 30代表扫描二维码
            // 43代表图文页右上角菜单
            // 51代表支付后关注（在支付完成页）
            // 57代表图文页内公众号名称
            // 75代表公众号文章广告
            // 78代表朋友圈广告
            var new_user = array_all[index].data_message[j].new_user;
            var user_source= array_all[index].data_message[j].user_source;
            if(user_source==0){
                user_source = "其他合计";
            }else if(user_source==1){
                user_source = "公众号搜索";
            }else if(user_source==17){
                user_source = "名片分享";
            }else if(user_source==30){
                user_source = "扫描二维码";

            }else if(user_source==43){
                user_source = "图文页右上角菜单";
            }else if(user_source==51){
                user_source = "支付后关注";
            }else if(user_source==57){
                user_source = "图文页内公众号名称";
            }else if(user_source==75){
                user_source = "公众号文章广告";
            }else {
                user_source = "朋友圈广告";
            }
            data_array_list.push(user_source);
            data_array_list.push(new_user);
            $('.count_slide_box_clear').before('<li class="user_manage_container_li" >'+
                    '<span class="count_span count_slide_span ">'+user_source+'</span>'+
                    '<span class="count_span count_slide_span ">'+new_user+'</span>'+
                    '</li>');
            data_array.push(data_array_list);
        };


        console.log(data_array);

        $('#container').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: '关注公众号来源分布图'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: '比例',
                data:data_array
            }]
        });
        $('.slide_container').css("z-index","102").animate({"top": "0", "opacity": "1"}, 300);
    }



</script>
<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>公众号统计信息</span>
            </div>
        </div>
        <div class="count_container">
            <div class="clear"></div>
            <div class="count_container_box">
            </div>
            <%--下拉面--%>
            <div class="slide_container">

                <div class="submit_select">
                    <span class="submit_select_span main_color submit_select_not" id="message_copy"
                          onclick="removeManagerStyle()">关闭</span>

                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
