<%--
  Created by IntelliJ IDEA.
  User: super
  Date: 2016/8/3
  Time: 11:09
  describtion:后台管理--【个人配置】人员基本信息
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--头部信息--%>

<script type="text/javascript" src="/resource/js/jedate.js"></script>
<link rel="stylesheet" href="/resource/css/jedate.css"/>
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main.css?v=1.0"/>
<script type="text/javascript"src="http://webapi.amap.com/maps?v=1.3&key=7a7787dd18e73bf0e5a350f6be459b35"></script>
<script src="/resource/js/jquery-1.11.3.min.js" type="text/javascript"></script>

<link type="text/css" rel="stylesheet" href="/resource/css/common.css" />
<script src="/resource/js/index.js" type="text/javascript"></script>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<style>
    .userManage_container {
        width: 902px;
        margin: 30px auto 0;
        min-height: 550px;
    }

    .user_container {
        padding: 8px 20px;
        border-bottom: 1px solid #e8e8e8;
        position: relative;
    }

    .user_container_last_child {
        border-bottom: none;
    }

    .user_avatar {
        border-radius: 50%;
        width: 40px;
        position: relative;
        top: 6px;
    }

    .user_mobile {
        padding-left: 10px;
        font-size: 16px;
    }

    .user_name {
        color: #999;
        padding-left: 8px;
    }

    .user_time {
        display: block;
        float: right;
        color: #999;
    }

    .user_content {
        padding-left: 56px;
        text-indent: 28px;
        color: #777;
    }
    .user_content p{
        margin-bottom: 4px;
    }

    .user_message {
        line-height: 36px;
    }

    .delete_message {
        display: inline-block;
        float: right;
        color: #f5ad4e;
        cursor: pointer;
    }

    .delete_message:hover {
        color: #FF8F0c;
    }

    /*p::before{*/
    /*content: '“';*/
    /*color: #999;*/
    /*font-size: 20px;*/
    /*}*/
    /*p::after{*/
    /*content: '”';*/
    /*color: #999;*/
    /*font-size: 20px;*/
    /*}*/
    .user_container:hover {
        background-color: #fafafa;
    }

    /*user_list_select_delete_tip*/
    .user_list_select_delete_tip {
        position: absolute;
        /* top: 110px; */
        display: none;
        right: -44px;
        width: 170px;
        height: 110px;
        border: 1px solid #e8e8e8;
        z-index: 1;
        background-color: #fff;
        padding-top: 18px;
        text-align: center;
        bottom: -109px;
    }

    .user_list_select_delete_tip .popover_arrow {
        position: absolute;
        left: 55%;
        margin-left: -8px;
        margin-top: -8px;
        display: inline-block;
        width: 0;
        height: 0;
        border-width: 8px;
        border-style: dashed;
        border-color: transparent;
        border-top-width: 0;
        border-bottom-color: #d9dadc;
        border-bottom-style: solid;
    }

    .user_list_select_delete_tip .popover_arrow_in {
        border-bottom-color: #fff;
        top: 1px;
    }

    .user_list_select_delete_tip .popover_arrow_out {
        top: 0;
    }

    .detailAll_tip_no {
        margin-right: 0;
    }

    .detailAll_tip_txt {
        font-size: 16px;
        margin-bottom: 20px;
    }

    .detailAll_tip_yes, .detailAll_tip_no {
        padding: 5px 10px;
        background-color: #f5ad4e;
        color: #fff;
        margin-right: 0px;
        cursor: pointer;
    }

    .detailAll_tip_no {
        margin-left: 14px;
    }

    /*tab标签css样式*/
    .select_checkbox {
        color: #777;
        cursor: pointer;
        position: relative;
        text-align: center
    }

    .select_checkbox_active .select_popover_arrow {
        position: absolute;
        right: 0px;
        display: inline-block;
        width: 0px;
        height: 0;
        border-style: dashed;
        border-color: transparent;
        border-bottom-color: #f5ad4e;
        border-bottom-style: solid;
        top: 19px;
        border-left-width: 10px;
        border-right-width: 0px;
        border-top-width: 0px;
        border-bottom-width: 10px;
    }

    .select_checkbox_container {
        position: relative;
        display: inline-block;
        padding: 2px 6px;
        border: 1px solid #e8e8e8;
        margin-right: 20px;
        margin-bottom: 10px;
    }

    .select_checkbox_active {
        border: 1px solid #f5ad4e;
    }
    .publish_time_select {
        float: left;
        line-height: 25px;
        margin-top: 5px;
        margin-left: 30px;
    }
    /*以下是凡哥代码*/
         body{font-family: "Microsoft Yahei";}
        .pc_content{margin-top: 5%;line-height: 4;width: 100%;text-align: center}
        .pc_content_passenger{display:inline;float:left;margin-left:10%;width: 50%;margin: 0 auto;padding: 2%;border: 1px solid #e4e4e4;box-shadow: 2px 2px 2px #cccbca;border-radius: 1vh;text-align: center}
        .pc_content h2{color:#FF8F0c;font-size: 25px}
        input{font-size: 16px;padding-left:2%;border: none;outline: #e4e4e4;width: 50%;color:#9a9a9a;height: 5vh;border:2px solid #FF8F0c;box-sizing: border-box; border-radius: 1vh;}
        .pc_content_passenger span{width:20%;display: inline-block}
        .pc_content_driver span{width:20%;display: inline-block}
        .pc_content_driver{display:inline;float:left;margin-left:10%;width: 50%;margin: 0 auto;padding: 2%;border: 1px solid #e4e4e4;box-shadow: 2px 2px 2px #cccbca;border-radius: 1vh;text-align: center}
        #btn_passenger{background:#FF8F0c;color: white;margin-top: 10%;line-height:5vh;height:5vh;font-size: 20px}
        #btn_driver{background:#FF8F0c;color: white;margin-top: 10%;line-height:5vh;height:5vh;font-size: 20px}
    /*以上是凡哥代码*/
</style>

<%--右侧菜单--%>
<div class="ui_body">
    <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
    <div id="ui_right">
        <div class="right_top">
            <div class="right_top_style">
                <span>车单编辑</span>
            </div>
        </div>
        <div class="pc_content">
    <div class="pc_content_passenger">
        <form action="">
        <h2>添加乘客车单</h2>
        <div><span>手机号：</span><input type="text" placeholder="请输入手机号" class="mobile"></div>
            <div>
                <div class="mianR">
                    <div class="carDealer">
                        <div class="employee" style="display:block">
                            <form    id="formalForm01">
                                <ul class="clearfix">
                                    <li class="departure">
                                        <script>
                                            var add = new AddressCom03();
                                            /*add.set_init(["2", "110000", "110102"]);//初始值*/
                                        </script>
                                    </li>
                                    <li class="destination">
                                        <script>
                                            var add = new AddressCom04();
                                            /*add.set_init(["2", "110000", "110102"]);//初始值*/
                                        </script>
                                    </li>
                                </ul>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        <%--<div><span>起点：</span><input type="text" placeholder="请输入起点" class="boarding_point"></div>
        <div><span>终点：</span><input type="text" placeholder="请输入终点" class="breakout_point"></div>--%>
        <div><span>出发时间：</span><input class="datainp departure_time" id="datebut01" type="text" placeholder="例如：2017-04-14 15:00:00"  readonly onClick="jeDate({dateCell:'#datebut01',isTime:true,format:'YYYY-MM-DD hh:mm:ss'})"></div>
        <div><span>几人乘车：</span><input type="text" placeholder="请说明有几人乘车" class="booking_seats"></div>
        <div><span>备注：</span><input type="text" placeholder="*注：是否有行李" class="remark"></div>
        <input type="button" value="添加" id="btn_passenger">
        </form>
    </div>
    <div class="pc_content_driver">
        <form action="">
        <h2>添加车主车单</h2>
        <div><span>手机号：</span><input onblur="blur()" type="text" placeholder="请输入手机号" class="mobile1"></div>
            <div>
                <div class="mianR">
                    <div class="carDealer">
                        <div class="employee" style="display:block">
                            <form    id="formalForm">
                                <ul class="clearfix">
                                    <li class="departure">
                                        <script>
                                            var add = new AddressCom();
                                            /*add.set_init(["2", "110000", "110102"]);//初始值*/
                                        </script>
                                    </li>
                                    <li class="destination">
                                        <script>
                                            var add = new AddressCom01();
                                            /*add.set_init(["2", "110000", "110102"]);//初始值*/
                                        </script>
                                    </li>
                                </ul>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        <%--<div><span>起点：</span><input type="text" placeholder="请输入起点" class="boarding_point1"></div>
        <div><span>终点：</span><input type="text" placeholder="请输入终点" class="breakout_point1"></div>--%>
        <div><span>出发时间：</span><input class="datainp departure_time1" id="datebut02" type="text" placeholder="例如：2017-04-14 15:00:00"  readonly onClick="jeDate({dateCell:'#datebut02',isTime:true,format:'YYYY-MM-DD hh:mm:ss'})"></div>
        <div><span>几个座位：</span><input type="text" placeholder="请说明邀请几人乘车" class="init_seats"></div>
        <div><span>备注：</span><input type="text" placeholder="*注：乘客是否可以携带行李或宠物。" class="remark1"></div>
        <input type="button" value="添加" id="btn_driver">
        </form>
    </div>
</div>
<div id="mapContainer" style="display:none;"></div>
<div id="ww"></div>
    </div>

    <div class="clear"></div>
</div>

<script>
var map = new AMap.Map("mapContainer", {
        resizeEnable: true
    });
    AMap.service('AMap.PlaceSearch',function(){//回调函数
        //实例化PlaceSearch
//        placeSearch= new AMap.PlaceSearch();
//        //TODO: 使用placeSearch对象调用关键字搜索的功能
    });

    $('#btn_passenger').click(function(){

        var boarding_point = $(".boarding_point").val();
        var breakout_point = $(".breakout_point").val();

    var placeSearch = new AMap.PlaceSearch({ //构造地点查询类
        pageSize: 5,
        pageIndex: 1,
        city: "", //城市
        map: map
    });
    //关键字查询
    var aa;
    placeSearch.search(boarding_point, function(status, result) {
        var data=result.poiList.pois[0];
        var obj={};
        obj.adCode=data.adcode;
        obj.cityCode=data.citycode;
        obj.city=data.cityname;
        obj.id="lhpc";
        obj.address=data.address;
        obj.name=data.name;
        obj.province=data.pname;
        obj.longitude=data.location.lng;
        obj.latitude=data.location.lat;
        objstr = JSON.stringify(obj);
        aa = objstr;
        console.log(aa);
    });

    var placeSearch1 = new AMap.PlaceSearch({ //构造地点查询类
        pageSize: 5,
        pageIndex: 1,
        city: "", //城市
        map: map
    });
    //关键字查询
    var bb;
    placeSearch1.search(breakout_point, function(status, result) {
        var data=result.poiList.pois[0];
        var obj={};
        obj.adCode=data.adcode;
        obj.cityCode=data.citycode;
        obj.city=data.cityname;
        obj.id="lhpc";
        obj.address=data.address;
        obj.name=data.name;
        obj.province=data.pname;
        obj.longitude=data.location.lng;
        obj.latitude=data.location.lat;
        objstr1 = JSON.stringify(obj);
        bb = objstr1;
        console.log(bb);
    });

    setTimeout(function () {
        var mobile = $(".mobile").val();
        var departure_time = $(".departure_time").val();
        var booking_seats = $(".booking_seats").val();
        var remark = $(".remark").val();

        var re = /^1[3456789]\d{9}$/;
        if(!re.test(mobile)){
            alert("手机号输入有误！");
        }else{
            setTimeout(function () {
                $.ajax({
                    type: 'POST',
                    url: '/pc/pessenger/date',
                    data:  {'mobile':mobile ,'boarding_point':aa,'breakout_point':bb,'departure_time':departure_time,'booking_seats':booking_seats,'remark':remark},
                    dataType:'json',
                    success:function(data){
                        alert(data.message);
                        console.log(data);
                        window.location.reload()
                    },
                    error: function(){
                        $('.content_record_p').html("查询失败");
                    }
                })
            }, 500);
        }

    }, 1000);

  });

//  ********车主***************


    $('#btn_driver').click(function(){

        var boarding_point = $(".boarding_point1").val();
        var breakout_point = $(".breakout_point1").val();

        var placeSearch = new AMap.PlaceSearch({ //构造地点查询类
            pageSize: 5,
            pageIndex: 1,
            city: "", //城市
            map: map
        });
        //关键字查询
        var aa;
        placeSearch.search(boarding_point, function(status, result) {
            var data=result.poiList.pois[0];
            var obj={};
            obj.adCode=data.adcode;
            obj.cityCode=data.citycode;
            obj.city=data.cityname;
            obj.id="lhpc";
            obj.address=data.address;
            obj.name=data.name;
            obj.province=data.pname;
            obj.longitude=data.location.lng;
            obj.latitude=data.location.lat;
            objstr = JSON.stringify(obj);
            aa = objstr;
            console.log(aa);
        });

        var placeSearch1 = new AMap.PlaceSearch({ //构造地点查询类
            pageSize: 5,
            pageIndex: 1,
            city: "", //城市
            map: map
        });
        //关键字查询
        var bb;
        placeSearch1.search(breakout_point, function(status, result) {
            var data=result.poiList.pois[0];
            var obj={};
            obj.adCode=data.adcode;
            obj.cityCode=data.citycode;
            obj.city=data.cityname;
            obj.id="lhpc";
            obj.address=data.address;
            obj.name=data.name;
            obj.province=data.pname;
            obj.longitude=data.location.lng;
            obj.latitude=data.location.lat;
            objstr1 = JSON.stringify(obj);
            bb = objstr1;
            console.log(bb);
        });

        setTimeout(function () {
            var mobile = $(".mobile1").val()
            var departure_time = $(".departure_time1").val()
            var init_seats = $(".init_seats").val()
            var remark = $(".remark1").val();
            var re = /^1[3456789]\d{9}$/;
            if(!re.test(mobile)){
                alert("手机号输入有误！");
                console.log("dsfasf");
            }else{
                setTimeout(function () {
                    $.ajax({
                        type: 'POST',
                        url: '/pc/deriver/date',
                        data:  {'mobile':mobile ,'boarding_point':aa,'breakout_point':bb,'departure_time':departure_time,'init_seats':init_seats,'remark':remark},
                        dataType:'json',
                        success:function(data){
                            alert(data.message);
                            console.log(data);
                            window.location.reload()
                        },
                        error: function(){
                            $('.content_record_p').html("查询失败");
                        }
                    })
                }, 500);
            }

        }, 1000);

    });
</script>
<script type="text/javascript" src="http://webapi.amap.com/demos/js/liteToolbar.js"></script>
<%--底部--%>
<jsp:include page="footer.jsp" flush="true"></jsp:include>