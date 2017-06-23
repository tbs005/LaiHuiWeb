$(document).ready(function () {
    // 菜单切换
    $('.menu_context_li').removeClass('active_li');
    $('.carousel_list').addClass('active_li');
    load();
    swiper();
});
var i = 0;
var global_data;
var global_selectNumber;
var global_id;
var action_url = '/api/carousel/manage';
var click_type = 1;
//请求列表数据
function load() {
    $('.question_list_message_box_right').remove();
    $('.swiper-slide').remove();
    var obj = {};
    global_page = 0;
    obj.action = 'show';
    operation.operation_ajax(action_url, obj, sendMessage);
}
function sendMessage() {
    count = global_data.total;
    loadPage.checkUserPrivilege(count, insertMessage);
}

//添加数据
function insertMessage() {
    for (var i = 0; i < global_data.slides.length; i++) {
        var id = global_data.slides[i].id;//广告数量
        var content = global_data.slides[i].create_time.substring(0, 16);//创建时间
        var title = global_data.slides[i].image_title;//目的地
        var seq = global_data.slides[i].image_seq;
        var image_url = global_data.slides[i].image_url;
        var image_link = global_data.slides[i].image_link;
        var subtitle = global_data.slides[i].image_subtitle;
        ShopsListStyle(image_link, image_url, id, content, title, seq, subtitle);
        $('.swiper-wrapper').append('<div class="swiper-slide">' +
            '<a href="' + image_link + '" class="img_link" target="_blank">' +
            '<img src=' + image_url + ' class="ad_img" alt="' + title + '">' +
            '</a>' +
            '</div>')
    }
    swiper();
}

//显示版面下拉
function showAddToCatDrop(obj) {
    $(obj).parent().children('.company_cat_ul').toggle();
    $('.company_cat_li').remove();
    for (var i = 1; i <= count + 1; i++) {
        $('.company_province_place_title').append('<li class="company_cat_li " onclick="selectCateList(this)">' +
            '<span>' + i + '</span>' +
            '</li>')
    }
}
function ShopsListStyle(image_link, image_url, id, content, title, seq, subtitle) {
    $('.not_find_message').before('<li class="question_list question_list_message_box_right" id=' + id + '>' +
        '<div class="question_list_left">' +
        '<div class="question_list_check question_list_select_list" onclick="showEditTip(this)"></div>' +
        '<div class="question_list_checklist_del_active" onclick="deleteSingleShops(this)"></div>' +
        '</div>' +
        '<div class="question_list_message_right">' +
        '<div class="question_list_img">' +
        '<img src="' + image_url + '" class="question_list_img_img">' +
        '</div>' +
        '<div class="question_list_message_tittle">' +
        '<a href="' + image_link + '" class="img_link" target="_blank">' +
        '<div class="question_list_message_tittle_span">' + title + '<img src="/resource/images/pc_icon_url.png" class="to_href"></div>' +

        '</a>' +
        '<div class="question_list_message_context_span">' + content + '</div>' +
        '<div class="clear"></div>' +
        '<div class="question_list_message_subtitle_span">' + subtitle + '</div>' +
        '<div class="clear"></div>' +
        '</div>' +
        '</div>' +
        '<div class="article_right">' +
        '<span class="article_tittle_box_span">轮播排序</span>' +
        '<div class="company_province_place" onmouseleave="hideCate(this)">' +
        '<span class="company_cat_box_span company_province_cat" onclick="showAddToCatDrop(this)" cat_id="">' + seq + '</span>' +
        '<div class="down1"></div>' +
        '<ul class="company_cat_ul company_province_cat_ul">' +
        '<div class="company_cat_title company_province_place_title">' +
        '</div>' +
        '</ul>' +
        '</div>' +
        '</div>' +
        '<div class="clear"></div>' +
        '</li>')
}
function hideCate(obj) {
    $(obj).children('ul').hide();
}
//判断是否删除
function judgeDelMessage(obj) {
    $(".all_tip").hide();
    $(obj).parent().children(".author_selected_tip").show();
}

//单选操作
function question_list_select_list(obj) {
    if ($(obj).parent().children('.question_list_checklist_active').length == 0) {
        $(obj).addClass("question_list_checklist_active");
        $(obj).animate({"margin-top": "20px"}, 500);
        $(obj).parent().children('.question_list_checklist_del_active').fadeIn(800);
    } else {
        $(obj).removeClass("question_list_checklist_active");
        $(obj).animate({"margin-top": "50px"}, 500);
        $(obj).parent().children('.question_list_checklist_del_active').fadeOut(300);
    }

}
//单选删除数据
function question_list_list_delect(obj) {
    $('.all_tip').fadeOut();
    $(obj).parent().parent().children('.question_list_select_delete_tip').fadeIn().children(".delete_tip_txt span").text("确认删除");
}
//单元删除提示
function delete_tip_no() {
    $('.question_list_select_delete_tip').fadeOut();
}

//ajax传送删除单个数据
function deleteSingleShops(obje) {
    var obj = {};
    var id = $(obje).parent().parent().attr('id');
    obj.action = 'delete';
    obj.id = id;
    operation.operation_ajax(action_url, obj, deleteTipMessage);
}

function deleteTipMessage() {
    showErrorTips('删除成功');
    load()
}

//选择修改
function selectCateList(obj) {

    var item_name = $(obj).children('span').text();
    if (item_name == "") {
        item_name = 0;
    }
    $(obj).closest('.company_province_place').children('span').text(item_name);
    $('.company_province_cat_ul').hide();
    if (click_type == 1) {
        var id = $(obj).closest('.question_list ').attr('id');
        selectCateListApi(id, item_name);
    }

}

function selectCateListApi(id, seq) {

    var obj = {};
    global_page = 0;
    obj.action = 'update';
    obj.id = id;
    obj.seq = seq;
    operation.operation_ajax(action_url, obj, addTipMessage);
}
function addTipMessage() {
    load();
    showErrorTips('调序成功');
    removeManagerStyle();

}
function addManagerStyle() {
    $('.input_style').val("");
    $('.editor_cancel').click();
    click_type = 0;
    $('.slide_container').animate({"top": "12%", "opacity": "1"}, 300);
    $('.slide_container_top').find('.slide_container_top_title').text('添加轮播图');
    $('.submit_select_sure').text('添加');
}
//编辑路线
function showEditTip(obj) {
    click_type = 2;
    var parent = $(obj).closest('.question_list');
    global_id = parent.attr('id');
    var img_src = parent.find('.question_list_img_img').attr('src');
    var img_title = parent.find('.question_list_message_tittle_span').text();
    var img_subtitle = parent.find('.question_list_message_subtitle_span').text();
    var img_seq = parent.find('.company_cat_box_span').text();
    var img_link = parent.find('.img_link').attr('href');
    $('.img0').show().attr('src', img_src).css({'width': '100%'});
    $('.editor_change').hide();
    $('.route_start').val(img_title);
    $('.route_sub').val(img_subtitle);
    $('.route_end').val(img_link);
    $('.ad_seq').text(img_seq);
    $('.slide_container').animate({"top": "12%", "opacity": "1"}, 300);
    $('.slide_container_top').find('.slide_container_top_title').text('编辑轮播图');
    $('.submit_select_sure').text('保存');
}
function removeManagerStyle() {
    click_type = 1;
    $('.slide_container').animate({"top": "-220%", "opacity": "0"}, 300);
}

//初始加载图片设置
function loadImageChange(obj) {
    console.log("开始替换图片");
    var objUrl = getObjectURL(obj.files[0]);
    console.log('objUrl' + objUrl);
    if (objUrl != null) {
        var j = $(obj).parent().children('.img0');
        j.addClass("add_image");
        var k = $(obj).parent();
        if (objUrl) {
            $(obj).parent().children('.img0').attr("src", objUrl).attr('id', -1);
        }
        var i = $(obj).parent().children('.img0').attr("src");
        imageStyle(i, j, k);
    }
}
function imageStyle(i, j, k) {
    console.log("改变img的框的大小和添加提示图片的显示");
    if (i == undefined || i == "") {
        console.log("回复默认设置");
        k.css({"width": "92%"});
        k.children('.editor_change').css('display', 'block');
        k.children('.editor_cancel').css('display', 'none');
        j.css({"display": "none"});
    } else {
        console.log("改变图片设置");
        k.css({"width": "auto"});
        k.children('.editor_change').css('display', 'none');
        k.children('.editor_cancel').css('display', 'block');
        j.css({"height": "100%", "display": "block"});
    }
}
//建立一個可存取到該file的url
function getObjectURL(file) {
    var url = null;
    if (window.createObjectURL != undefined) { // basic
        url = window.createObjectURL(file);
    } else if (window.URL != undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file);
    } else if (window.webkitURL != undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file);
    }
    console.log("获取到的url是" + url);
    return url;
}
//点击删除添加图片设置
function removePicture(obj) {
    var j = $(obj).parent().children('.img0');
    var k = $(obj).parent();
    k.css({"width": "92%"});
    k.children('.editor_change').css('display', 'block');
    k.children('.editor_cancel').css('display', 'none');
    j.css({"display": "none"});
    $(obj).parent().children('.file0').val("");
}
function getFileName(file_name) {
    var pos = file_name.lastIndexOf("\\");
    return file_name.substring(pos + 1);

}

//检查输入的必选
function checkInputMessage() {
    if (click_type == 0) {
        if ($('.route_start').val() == "") {
            showErrorTips('请输入图片标题')
        } else if ($('.route_sub').val() == "") {
            showErrorTips('请输入图片副标题')
        } else if ($('.file0').val() == "") {
            showErrorTips('请添加轮播图片')
        } else {
            addAD();
        }
    } else {
        if ($('.route_start').val() == "") {
            showErrorTips('请输入图片标题')
        } else if ($('.route_sub').val() == "") {
            showErrorTips('请输入图片副标题')
        } else {
            addAD();
        }
    }


}

function addAD() {
    var data = new FormData($('#upload_form')[0]);
    var ad_seq = $('.ad_seq').text();
    data.append("action", "add");
    data.append("seq", ad_seq);
    if (click_type == 2) {
        data.append("id", global_id);
    }
    $.ajax({
        type: "post",
        url: "/api/carousel/manage",
        data: data,
        processData: false,
        contentType: false,
        beforeSend: loading,//执行ajax前执行loading函数.直到success
        success: function (data) {
            showErrorTips(data.message);
            if (data.status == true) {
                closeLoading();
                removeManagerStyle();
                load();
            }
        }
    })
}

function swiper() {
    var mySwiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        autoplay: 2000
    })
}
