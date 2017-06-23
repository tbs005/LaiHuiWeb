loadUser();
function loadUser() {
    var obj = {};
    operation.operation_ajax('/push/last', obj, insertMessage);
}
function insertMessage() {
    console.log(global_data);
    var all_count = global_data.total;
    var last =global_data.last;
    $('.total').text(all_count + "条");
    $('.last').text(last );
}

function submitForm() {
    var data = new FormData($('#pushForm')[0]);
    $.ajax({
        type: "post",
        url:"/activities/push",
        data:data,
        processData: false,
        contentType: false,
        success:function (data) {
            showErrorTips(data.message);
            if (data.status == true) {
                closeLoading();
                removeManagerStyle();
                load();
            }
        }
    });
}

//初始加载图片设置
function loadImageChange(obj) {
    console.log("开始替换图片");
    var objUrl = getObjectURL(obj.files[0]);
    console.log('objUrl'+objUrl);
    if(objUrl!=null){
        var j = $(obj).parent().children('.img0');
        j.addClass("add_image");
        var k = $(obj).parent();
        if (objUrl) {
            $(obj).parent().children('.img0').attr("src", objUrl).attr('id',-1);
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
    k.css({"width": "45%"});
    k.children('.editor_change').css('display', 'block');
    k.children('.editor_cancel').css('display', 'none');
    j.css({"display": "none"});
    $(obj).parent().children('.file0').val("");
}
