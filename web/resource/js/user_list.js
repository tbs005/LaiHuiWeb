$(document).ready(function () {
    loadUser();
    loadAppUser();
    loadiOSUser();
    loadAndroidUser();
    $('.menu_body').removeClass('open_menu_body');
    $('.menu_head').removeClass('current');
    $('.menu_body a').removeClass('change_menu');
    $('#userList_head').addClass('current');
    $('#userList_body').addClass('open_menu_body');
    $('#userList_menu').addClass('change_menu');
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
var action_url = "/user/info";
var start_time = "";
var end_time = "";

var count_array = [];
var count_status = 0;
//ajax获取用户
function updateLine() {
    count_array = [];
    loadUser();
    loadAppUser();
    loadiOSUser();
    loadAndroidUser();
    madeLine();
}
//加载统计数据
function loadAppUser() {
    count_status = "";
    var obj = {};
    obj.action = 'show';
    operation.operation_ajax2("/user/count", obj, madeCountObj);

}
function loadiOSUser() {
    count_status = 1;
    var obj = {};
    obj.action = 'show';
    obj.status = '1';
    operation.operation_ajax2("/user/count", obj, madeCountObj);
}
function loadAndroidUser() {
    count_status = 2;
    var obj = {};
    obj.action = 'show';
    obj.status = '2';
    operation.operation_ajax2("/user/count", obj, madeCountObj);
}

function madeCountObj() {
    var count_obj = {};
    var count = [];
    for (var i = 0; i < global_data.data.length; i++) {
        count.push(global_data.data[i].count)
    }

    if (count_status == "") {
        count_obj.name = 'APP用户新增数';                          //数据列名
        count_obj.data = count;                      //数据
        count_obj.color = '#f5ad4e';
        count_array.push(count_obj)
    } else if (count_status == 1) {
        count_obj.name = 'iOS用户新增数';                          //数据列名
        count_obj.data = count;                      //数据
        count_obj.color = '#3498db';
        count_array.push(count_obj)
    } else {
        count_obj.name = 'Android用户新增数';                          //数据列名
        count_obj.data = count;                      //数据
        count_obj.color = '#2ecc71';
        count_array.push(count_obj)
    }

}

//生成统计折线图
function madeLine() {
    var time_array = [];
    for (var i = 0; i < global_data.data.length; i++) {
        time_array.push(global_data.data[i].date);
    }
    //添加数据折线
    $('#container').highcharts({                   //图表展示容器，与div的id保持一致
        chart: {
            type: 'line'                         //指定图表的类型，默认是折线图（line）
        },
        title: {
            text: 'APP用户新增数据'      //指定图表标题
        },
        xAxis: {
            categories: time_array   //指定x轴分组
        },
        yAxis: {
            title: {
                text: '单位/人'                  //指定y轴的标题
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
                    click: function (event) {
                        start_time = event.point.category;
                        $('.select_start_time ').val(start_time);
                        var end_date = new Date(start_time.replace(/-/g, "/"));
                        var t = end_date.getTime() + 1000 * 60 * 60 * 24;
                        var time = new Date(t);
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
function changeDataStyle(time) {
    var year = time.getFullYear();
    var month = time.getMonth() + 1;
    var date = time.getDate();
    if (month.toString().length == 1) {
        month = "0" + month;
    } else {
        month = parseInt(month);
    }
    if (date.toString().length == 1) {
        date = "0" + date;
    } else {
        date = parseInt(date);
    }
    end_time = year + "-" + month + "-" + date;
    $('.select_end_time ').val(end_time);
}
//封装传输的信息并提交
function loadUser() {
    var obj = {};
    obj.action = 'show';
    obj.size = size;
    obj.page = global_page;
    operation.operation_ajax(action_url, obj, sendMessage);
}
function sendMessage() {
    $('.user_manage_container_li').remove();
    count = global_data.count;
    loadPage.checkUserPrivilege(count, insertUserMessage);
}
function findMessage() {
    var obj = {};
    var passenger_id = $('.passenger_span').attr('cat_id');
    var driver_id = $('.driver_span').attr('cat_id');
    var search = $('.search_user_input').val();
    start_time = $('.select_start_time ').val();
    end_time = $('.select_end_time ').val();
    obj.action = 'show';
    obj.keyword = search;
    obj.start_time = start_time;
    obj.end_time = end_time;
    obj.is_passenger = passenger_id;
    obj.is_car = driver_id;
    obj.size = size;
    obj.page = global_page;
    operation.operation_ajax(action_url, obj, sendMessage);
}

//删除信息
function deleteSingle(item) {
    var obj = {};
    var id = $(item).parent().parent().attr('user_id');
    obj.action = 'delete';
    obj.id = id;
    operation.operation_ajax(action_url, obj, loadUser);
}
//添加用户数据
function insertUserMessage() {
    $('.user_manage_container_li').remove();
    for (var i = 0; i < global_data.data.length; i++) {
        var is_validated_passenger = global_data.data[i].is_validated_passenger;//是否认认证乘客信息
        var create_time = global_data.data[i].create_time;//加入时间
        var idsn = global_data.data[i].idsn;//身份证号
        var is_validated_car = global_data.data[i].is_validated_car;//是否通过车主认证
        var mobile = global_data.data[i].mobile;//手机号
        // phone.substr(0, 3) + '****' + phone.substr(7);
        var name = global_data.data[i].name;//名字
        var id = global_data.data[i].id;//id
        var last_logined_time = global_data.data[i].last_logined_time;//最后登录时间
        var last_login_ip = global_data.data[i].last_login_ip;//最后登录时间
        addUserDisplay(is_validated_passenger, create_time, idsn, is_validated_car, mobile, name, id, last_logined_time, last_login_ip);
    }
}
//添加用户列表
function addUserDisplay(is_validated_passenger, create_time, idsn, is_validated_car, mobile, name, id, last_logined_time, last_login_ip) {
    $(".userManage_container_ul").append('<li class="user_manage_container_li" user_id=' + id + ' is_validated_car=' + is_validated_car + ' is_validated_passenger=' + is_validated_passenger + ' onmouseleave="hideDeleteTip(this)">' +
        '<span class="userManage_span" style="width:10%;">' + name + '</span>' +
        '<span class="userManage_span" style="width:15%;">' + idsn + '</span>' +
        '<span class="userManage_span" style="width:15%;">' + mobile.substr(0, 3) + '****' + mobile.substr(7) + '</span>' +
        '<span class="userManage_span" style="width:17%;">' + create_time + '</span>' +
        '<span class="userManage_span" style="width:17%;">' + last_logined_time + '</span>' +
        '<span class="userManage_span" style="width:15%;">' + last_login_ip.substr(0, last_login_ip.indexOf(".") + 1) + '****' + last_login_ip.substr(last_login_ip.lastIndexOf(".")) + '</span>' +
        '<span class="userManage_span" style="width:10%;">' +
        '<span class="detailAll_tip_yes" onclick="showUserInfo(\'' + id + '\')">查看</span>' +
        '</span>' +
        '<div class="user_list_checklist_del_active" onclick="showDeleteTip(this)"></div>' +
        '<div class="user_list_select_delete_tip all_tip">' +
        '<div class="detailAll_tip_txt">' +
        '<span>确认删除</span>' +
        '</div>' +
        '<span class="detailAll_tip_yes" onclick="deleteSingle(this)">确认</span>' +
        '<span class="detailAll_tip_no" onclick="hideDeleteTips(this)">取消</span>' +
        '<i class="popover_arrow popover_arrow_out"></i>' +
        '<i class="popover_arrow popover_arrow_in"></i>' +
        '</div>' +
        '</li>')
}
//显示下拉
function showAddToUserDrop(obj) {
    $(obj).children('.user_list_drop_box_ul').toggle();
}
//点击下拉列表
function selectedCatDropList(obj) {
    $('.select_error_message').hide();
    $(obj).parent().parent().children('.user_list_drop_box_span').text($(obj).text()).attr('cat_id', $(obj).attr('cat_id'));
    $(obj).parent().hide();
    global_page = 0;
    findMessage();
}

//单元删除提示
function showDeleteTip(obj) {
    $(obj).parent().children('.user_list_select_delete_tip').fadeIn();
}
//隐藏删除信息
function hideDeleteTips(obj) {
    $(obj).parent().hide();
}
function hideDeleteTip(obj) {
    $(obj).children('.user_list_select_delete_tip').hide()
}
function showUserInfo(id) {
    $.ajax({
        type: 'POST',
        url: '/user/getInfoById',
        data: {"userId": id},
        dataType: 'json',
        success: function (data) {
            $('.slide_container').animate({"top": "20%", "opacity": "1"}, 300);
            fillerUserInfo(data.result);
        },
        error: function (data) {
            alert("操作失败！");
        }
    });
}
function fillerUserInfo(result) {
    $('#userName').val(result.name);
    var mobile = result.mobile;
    $('#userMobile').val(mobile.substr(0, 3) + '****' + mobile.substr(7));
    $('#userSex').val(result.sex);
    var birthday = result.birthday;
    if (birthday) {
        birthday = birthday.substr(0, 4) + "年" + birthday.substr(4, 2) + "月" + birthday.substr(6) + "日"
    }
    $('#birthday').val(birthday);
    $('#userIdsn').val(result.idsn);
    var is_validated;
    if (result.is_validated == 1) {
        is_validated = "通过";
    } else {
        is_validated = "没通过";
    }
    $('#isValidated').val(is_validated);
    var is_validated_car;
    if (result.is_validated_car == 1) {
        is_validated_car = "是";
    } else {
        is_validated_car = "否";
    }
    $('#isValidatedCar').val(is_validated_car);
    var source;
    if (result.source == 1) {
        source = "IOS手机";
    } else if (result.source == 0) {
        source = "Android手机";
    }
    $('#userSource').val(source);
    $('#signature').val(result.signature);
    $('#userCompany').val(result.company);
    $('#liveCity').val(result.live_city);
    $('#userHome').val(result.home);
    $('#deliveryAddress').val(result.delivery_address);
    $('#lastLoginedTime').val(result.last_logined_time);
    var last_login_ip = result.last_login_ip;
    $('#lastLoginIP').val(last_login_ip.substr(0, last_login_ip.indexOf(".") + 1) + '****' + last_login_ip.substr(last_login_ip.lastIndexOf(".")));
    $('#createTime').val(result.create_time);
}
function removeManagerStyle() {
    $('.slide_container').animate({"top": "-220%", "opacity": "0"}, 300);
}