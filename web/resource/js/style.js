/**
 * Created by super on 2016/7/26.
 */
var data_obj = {};
//检测信息
//检测信息
var validate = (function () {

    var validate_submit = function (url, array, callback) {
        $.ajax({
            type: "POST",
            url: url,
            data: array,
            dataType: "json",
            beforeSend: loading,//执行ajax前执行loading函数.直到success
            success: function (data) {
                global_data = data;
                if (global_data.status == true) {
                    console.log("交互成功");
                    callback();
                    closeLoading();
                } else {
                    validate.showTips(global_data.message);
                }
            },
            error: function () {
                console.log("交互失败");
                callback();
            }
        })
    };
    var validate_submit_app = function (url, array, callback) {
        $.ajax({
            type: "POST",
            url: url,
            data: array,
            dataType: "json",
            beforeSend: loading,//执行ajax前执行loading函数.直到success
            success: function (data) {
                global_data = data;
                if (global_data.status == true) {
                    console.log("交互成功");
                    callback();
                    closeLoading();
                } else {
                    showFloatStyle(global_data.message);
                }
            },
            error: function () {
                console.log("交互失败");
                callback();
            }
        })
    };
    //同步传输
    var validate_submit2 = function (url, array, callback) {
        $.ajax({
            type: "POST",
            url: url,
            data: array,
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.status == true) {
                    global_data = data.result;
                    console.log("交互成功");
                    callback();
                } else {
                    showFloatStyle(data.message);
                }
            },
            error: function () {
                displayErrorMsg(data.message);
            }
        })
    };
    //同步传输,数据格式同1
    var validate_submit3 = function (url, array, callback) {
        $.ajax({
            type: "POST",
            url: url,
            data: array,
            async: false,
            dataType: "json",
            beforeSend: loading,//执行ajax前执行loading函数.直到success
            success: function (data) {
                global_data = data;
                if (global_data.status == true) {
                    console.log("交互成功");
                    callback();
                    closeLoading();
                } else {
                    validate.showTips(global_data.message);
                }
            },
            error: function () {
                console.log("交互失败");
                callback();
            }
        })
    };
    //提交设置，不结束loading
    var validate_submit4 = function (url, array, callback) {
        $.ajax({
            type: "POST",
            url: url,
            data: array,
            dataType: "json",
            beforeSend: loading,//执行ajax前执行loading函数.直到success
            success: function (data) {
                global_data = data;
                if (global_data.status == true) {
                    console.log("交互成功");
                    callback();
                } else {
                    validate.showTips("交互失败");
                }
            },
            error: function () {
                console.log("交互失败");
                callback();
            }
        })
    };



    function showTips(message) {
        $('.validate_error_tips').show().text(message);
    };

    function hideTips() {
        $('.validate_error_tips').hide().text("");
    }

    //控制输入的只能是数字
    function onlyNum(obj) {
        if (isNaN($(obj).val())) {
            $(obj).val("");
            validate.showTips("请输入合法的身份证号");
        } else {
            validate.hideTips();
        }
    }

    return {
        validate_submit: validate_submit,
        showTips: showTips,
        hideTips: hideTips,
        onlyNum: onlyNum,
        validate_submit2: validate_submit2,
        validate_submit3: validate_submit3,
        validate_submit4: validate_submit4,
        validate_submit_app:validate_submit_app

    }

})();
//改变字体适应效果
function changeFontSize(){
    var w = $(document.body).width();
    if(w>1080) {
        w = 1080;
        $('html').css('font-size',w/78+'px');
    }else{
        $('html').css('font-size',w/36+'px');
    }

};

//ajax加载画面
function loading(){
    $('.hover').show();
    $('.loading_box').show();
}
function closeLoading(){
    $('.hover').hide();
    $('.loading_box').hide();
}


//查看大图
var changeImg = (function(){
    //查看大图
    function showBigImg(obj) {
        $('.hover').show();
        $('.image_tips').show().css({'top': '10rem'}).children('img').attr('src', $(obj).attr('src'));
        $('.reload_img').show();
        $('.cancel').show();
    }
    function cancelBigImg(){
        $('.hover').hide();
        $('.image_tips').hide();
        $('.cancel').hide();
    }

    return {
        showBigImg : showBigImg,
        cancelBigImg:cancelBigImg
    }

})();

//返回顶部
function movetop() {
    $(".backtop").hide();
    $(window).scroll(function () {
        $(window).scrollTop() > 100 ? $(".backtop").fadeIn(700) : $(".backtop").fadeOut(700)
    });
    $(".backtop").click(function () {
        return $("body,html").animate({scrollTop: 0}, 300).stop();
    })
}
//清空搜索条件
function emptySearchInput(){
    $('.search_user_input').val('');
}
//展示浮动层，自动消失
function showFloatStyle(errorTips) {
    $('.hover').fadeIn(200);
    $('.float_container').empty().append('<div class="float_box">'+
        '<span class="float_box_span"></span>'+
        '</div>').fadeIn(200);
    $('.float_box_span').text(errorTips);
    setTimeout(function () {
        $('.hover').fadeOut(200);
        $('.float_container').fadeOut(200);
        $('.loading_box').fadeOut(200);
    }, 1500);
}
//展示浮动层可编辑
function showFloatStyle2() {
    $('.hover').fadeIn(200);
    $('.float_container2').fadeIn(200);
}

function removeFloatMessage() {
    $('.hover').fadeOut(200);
    $('.float_container2').fadeOut(200);
}