<%--
  Created by IntelliJ IDEA.
  User: zhu
  Date: 2016/11/5
  Time: 14:37
  des:后台管理--弹窗设置
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="adminHeader.jsp" flush="true"></jsp:include>
<script src="/resource/js/swiper-3.3.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resource/css/swiper-3.3.1.min.css" >
<%--右侧菜单--%>
<style type="text/css">

  .question_list_container {
    width: 926px;
    margin: 30px auto 0;
  }

  .search_question_list_input {
    padding: 8px 60px 8px 5px;
    width: 100%;
    background-color: transparent;
    border: 1px solid #e8e8e8;
    outline: 0;
  }

  .search_question_list {
    margin-bottom: 40px;
    position: relative;
    height: 22px;
    width: 350px;
    float: left;
    margin-left: 30px;
  }

  .search_question_list_a {
    border-left: 1px solid #e7e7eb;
    right: 0;
    width: 30px;
    text-align: center;
    position: absolute;
    top: 0;
    height: 31px;
  }

  .search_ico {
    background: url("/resource/images/icon_style.png") 0 -4412px no-repeat;
    height: 31px;
    margin-left: 6px;
  }

  .right_menu_li {
    line-height: 40px;
    height: 40px;
    border-bottom-color: #e7e7eb;
    float: left;
    padding: 0 30px;
    cursor: pointer;
  }

  .sub_message {
    line-height: 30px;
    font-size: 16px;
  }

  .question_list_message_box {
    border: 1px solid #e8e8e8;
    width: 44%;
    height: 120px;
    position: relative;
    margin-bottom: 20px;
    cursor: pointer;
    float: left;
  }

  .question_list_message_ico_box {
    float: left;
    margin-right: 20px;
  }

  .question_list_message_box:hover {
    box-shadow: 2px 2px 10px 2px #e8e8e8;
  }

  .question_list_message_box_right {
    border: 1px solid #e8e8e8;
    width: 100%;
    position: relative;
    cursor: pointer;
    margin-bottom: 20px;
    border-left: 2px solid #f5ad4e;
    height: 124px;
  }

  .question_list_message_box_right:hover {
    box-shadow: 2px 2px 10px 2px #e8e8e8;
  }

  .question_list_message_ico_box img {
    width: 160px;
    height: 110px;
    margin: 10px 0 0 10px;
  }

  .question_list_message_right {
    float: left;
    width: 840px;
    line-height: 40px;
    height: 100%;
  }

  .question_list_message_tittle {
    font-size: 14px;
    width: 500px;
    float: left;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    margin-left: 30px;
  }

  .question_list_upload_box {
    color: #555;
    margin: 15px 0 0 0;
    float: left;
  }

  .question_list_message_upload_source {
    margin-right: 20px;
    display: inline-block;
    margin-left: 20px;
    position: relative;
  }

  .question_list_message_upload_time {
    margin-top: 6px;
    color: #999;
    font-size: 12px;
  }

  .question_list_message_category {
    text-align: center;
    margin-top: 20px;
    overflow: hidden;
    color: #666;
    max-width: 90px;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .question_list_message_context {
    overflow: hidden;
    color: #666;
    margin-top: 8px;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
  }

  .question_list_container_message {
    width: 99%;
    padding: 10px 20px;
  }

  .change_color {
    color: #000;
  }

  /*APP全选操作*/
  .question_list_left_li_top {
    height: 30px;
    line-height: 30px;
    position: relative;
    margin-left: 40px;
    float: right;

  }

  .question_list_select_all {
    margin-left: 8px;
  }

  .question_list_check {
    background: url("/resource/images/manage_icon_style.png") 0 -3684px no-repeat;
    width: 30px;
    height: 16px;
    vertical-align: middle;
    display: inline-block;
  }

  .question_list_check_active {
    background: url("/resource/images/manage_icon_style.png") 0 -312px no-repeat;
  }

  .question_list_checklist_active {
    background: url("/resource/images/manage_icon_style.png") 0 -312px no-repeat;
  }

  .question_list_checklist_del_active {
    background: url("/resource/images/manage_icon_style.png") 0 -3732px no-repeat;
    width: 16px;
    height: 16px;
    vertical-align: middle;
    margin: 40px 0 0 16px;
  }

  .question_list_select_detailAll {
    padding: 3px 8px;
    cursor: pointer;
    margin-left: 14px;
  }

  .question_list_select_all {
    margin-left: 8px;
  }

  .question_list_check_active {
    background: url("/resource/images/manage_icon_style.png") 0 -312px no-repeat;
  }

  .question_list_select_detailAll_tip {
    position: absolute;
    display: none;
    top: 40px;
    left: -76px;
    width: 250px;
    height: 110px;
    border: 1px solid #e8e8e8;
    z-index: 10;
    background-color: #fff;
    padding-top: 17px;
    text-align: center;
  }

  .detailAll_tip_yes, .detailAll_tip_no {
    padding: 5px 10px;
    background-color: #f5ad4e;
    color: #fff;
    cursor: pointer;

  }

  .detailAll_tip_no {
    margin-left: 20px;
  }

  .popover_arrow {
    position: absolute;
    left: 70%;
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

  .popover_arrow_in {
    border-bottom-color: #fff;
    top: 1px;
  }

  .popover_arrow_out {
    top: 0;
  }

  /*question_list_select_delete_tip*/
  .question_list_select_delete_tip {
    position: absolute;
    top: 40px;
    display: none;
    right: -77px;
    width: 250px;
    height: 110px;
    border: 1px solid #e8e8e8;
    z-index: 1;
    background-color: #fff;
    padding-top: 17px;
    text-align: center;
  }

  .question_list_select_delete_tip .popover_arrow {
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

  .question_list_select_delete_tip .popover_arrow_in {
    border-bottom-color: #fff;
    top: 1px;
  }

  .question_list_select_delete_tip .popover_arrow_out {
    top: 0;
  }

  .detailAll_tip_no, .delete_tip_no {
    margin-right: 0;
  }

  .detailAll_tip_txt, .delete_tip_txt {
    font-size: 16px;
    margin-bottom: 14px;
  }

  .delete_tip_yes, .delete_tip_no {
    padding: 5px 10px;
    background-color: #f5ad4e;
    color: #fff;
    margin-right: 20px;
    cursor: pointer;
  }

  .question_list_all {
    position: relative;
    top: 0;
    right: 0;
  }

  .question_list_right {
    float: left;
    position: relative;
  }

  .question_list_left {
    float: right;
    position: relative;
    height: 100%;
    width: 60px;
  }

  .question_list_select_list {
    margin-left: 14px;
    margin-top: 24px;
  }

  .author_category_box {
    font-size: 14px;
    float: right;
    color: #777;
  }

  .author_category_os {
    display: inline-block;
  }

  .author_category_pic_number {
    display: inline-block;
    margin-left: 10px;
    margin-right: 10px;
  }

  .question_list_message_tittle_span{
    font-size: 16px;
    margin-top: 10px;
  }

  .question_list_drop_box {
    position: relative;
    float: left;

  }

  .question_list_drop_box:hover > .down1 {
    transform: rotate(180deg);
  }

  .question_list_drop_box_ul {
    display: none;
    position: absolute;
    top: 31px;
    border: 1px solid #e8e8e8;
    text-align: center;
    z-index: 1;
    background-color: #fff;
  }

  .question_list_drop_box_span {
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

  .down1 {
    position: absolute;
    top: 14px;
    right: 8px;
    width: 0;
    height: 0;
    font-size: 0;
    border-width: 7px 7px 0;
    border-style: solid dashed;
    border-color: #f5ad4e transparent transparent;
    -webkit-transition-duration: 0.5s;
    cursor: pointer;
  }

  .down1:hover {
    transform: rotate(180deg);
  }

  .goods_add_span {
    padding: 5px 10px 5px 24px;
    background-color: #f5ad4e;
    margin-bottom: 0px;
    color: #fff !important;
    position: relative;
    cursor: pointer;
    float: right;
    margin-left: 26px;
  }

  .organization_add_span {
    padding: 5px 10px 5px 24px;
    background-color: #f5ad4e;
    margin-bottom: 0px;
    color: #fff !important;
    position: relative;
    cursor: pointer;
    float: right;
    margin-left: 26px;
    display: none;
  }

  .goods_add_span:hover {
    color: #fff !important;
    background-color: #e25610;
  }

  .author_add_classify {
    font-size: 26px;
    position: absolute;
    line-height: 18px;
    left: 4px;
  }

  .question_list_organization {
    height: 102px !important;
  }

  .question_list_message_upload_organization {
    margin-bottom: 4px;
    float: left;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    color: #f5ad4e;
    line-height: 24px;
  }

  .question_list_message_upload_source .goods_source {
    color: #999;
  }

  .question_list_message_upload_source .goods_source:hover {
    color: #f5ad4e;
  }

  .question_list_message_abstract {
    color: #777;
    text-indent: 2em;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    height: 40px;
  }

  .question_list_message_right_box {
    display: inline-block;
    float: right;

    /*margin-right: 20px;*/
  }

  .question_list_message_vote {
    display: inline-block;

  }

  .question_list_message_comment {
    display: inline-block;
    margin-left: 10px;
  }

  .comment_style {
    padding-left: 13px;
    margin-right: 2px;
    height: 14px;
    display: inline-block;
    background: url("/resource/images/icon_collection.png") -248px -43px;
  }

  .vote_style {
    padding-left: 12px;
    margin-right: 2px;
    height: 13px;
    display: inline-block;
    background: url("/resource/images/icon_collection.png") -222px -90px;
  }

  .view_style {
    padding-left: 12px;
    margin-right: 2px;
    height: 13px;
    display: inline-block;
    background: url("/resource/images/icon_collection.png") -152px -44px;
  }

  .question_list_message_view {
    display: inline-block;
    margin-left: 10px;
  }

  .pass_author_avatar {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    margin-right: 4px;
    margin-top: -4px;
  }

  .question_list_select_passAll {
    padding: 3px 8px;
    cursor: pointer;
    margin-left: 14px;
  }

  .pass_organization {
    margin-left: 10px;
    color: #888;
  }

  .question_list_message_upload_source span {
    max-width: 240px;
    overflow: hidden;
    line-height: 11px;
    text-overflow: ellipsis;
    white-space: nowrap;
    display: inline-block;
  }

  .goods_category {
    display: inline-block;
    margin-left: 20px;
  }

  /*切换*/
  .set_focus_box {
    position: absolute;
    z-index: 1;
    margin-left: 70px;
    top: 0;
    left: -166px;
  }

  #switch {
    width: 64px;
    height: 26px;
    margin-top: 7px;
    margin-left: 7px;
  }

  .toggle {
    position: absolute;
    border: 2px solid #d6d6d6;
    border-radius: 20px;
    -webkit-transition: border-color .6s ease-out;
    transition: border-color .6s ease-out;
    box-sizing: border-box;
  }

  .toggle.toggle_on {
    border-color: #f5ad4e;
    -webkit-transition: all .5s .15s ease-out;
    transition: all .5s .15s ease-out;
  }

  .toggle_button {
    position: absolute;
    top: 4px;
    width: 14px;
    bottom: 4px;
    right: 39px;
    background-color: #d6d6d6;
    border-radius: 19px;
    cursor: pointer;
    -webkit-transition: all .3s .1s, width .1s, top .1s, bottom .1s;
    transition: all .3s .1s, width .1s, top .1s, bottom .1s;
  }

  .toggle_on .toggle_button {
    top: 3px;
    width: 54px;
    bottom: 3px;
    right: 3px;
    border-radius: 23px;
    background-color: #f5ad4e;
    box-shadow: 0 0 8px #f5ad4e;
    -webkit-transition: all .2s .1s, right .1s;
    transition: all .2s .1s, right .1s;
  }

  .toggle_text_on {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    line-height: 20px;
    text-align: center;

    font-size: 14px;
    font-weight: normal;
    cursor: pointer;
    -webkit-user-select: none; /* Chrome/Safari */
    -moz-user-select: none; /* Firefox */
    -ms-user-select: none; /* IE10+ */
    color: rgba(0, 0, 0, 0);
  }

  .toggle_on .toggle_text_on {
    color: #EBFFEB;
    -webkit-transition: color .3s .15s;
    transition: color .3s .15s;
  }

  .toggle_text_off {
    position: absolute;
    top: 0;
    bottom: 0;
    right: 6px;
    line-height: 20px;
    text-align: center;
    font-size: 14px;
    -webkit-user-select: none; /* Chrome/Safari */
    -moz-user-select: none; /* Firefox */
    -ms-user-select: none; /* IE10+ */
    cursor: pointer;
    color: #d6d6d6;
  }

  .toggle_on .toggle_text_off {
    color: rgba(0, 0, 0, 0);
  }

  /* used for streak effect */
  .glow_comp {
    position: absolute;
    opacity: 0;
    top: 10px;
    bottom: 10px;
    left: 10px;
    right: 10px;
    border-radius: 6px;
    background-color: rgba(75, 122, 141, .1);
    box-shadow: 0 0 12px rgba(75, 122, 141, .2);
    -webkit-transition: opacity 4.5s 1s;
    transition: opacity 4.5s 1s;
  }

  .toggle_on .glow_comp {
    opacity: 1;
    -webkit-transition: opacity 1s;
    transition: opacity 1s;
  }

  .category_sort_box {
    position: relative;
    width: 60px;
    text-align: center;
    padding-right: 15px;
    border: 1px solid #e8e8e8;
    height: 24px;
    line-height: 24px;
    margin-left: 32px;
    margin-top: 8px;
    cursor: pointer;
    display: none;
  }

  .category_sort_box .down1 {
    top: 8px;
  }

  .category_sort_box:hover > .down1 {
    transform: rotate(180deg);
  }

  .category_sort_box_ul {
    position: absolute;
    display: none;
    border: 1px solid #e8e8e8;
    width: 60px;
    left: -1px;
    margin-top: -2px;
    background-color: #fff;
    z-index: 1;
  }

  .category_sort_box_li {
    padding-right: 14px;
    line-height: 20px;
  }

  .category_sort_box_li:hover {
    background-color: #f5ad4e;
    color: #fff;
  }

  .goods_tag_list {
    float: right;
    margin-right: 10px;
    color: #888;
    font-size: 13px;
  }

  .goods_tag_list_span {
    border: 1px solid #e8e8e8;
    padding: 2px 6px;
    margin-right: 10px;
  }

  .article_add_span {
    padding: 5px 10px 5px 24px;
    background-color: #f5ad4e;
    margin-bottom: 0px;
    color: #fff !important;
    position: relative;
    cursor: pointer;
    float: right;
    margin-left: 26px;
  }

  .article_add_span:hover {
    color: #fff !important;
    background-color: #FF8F0c;
  }


  .article_tittle_box_span {
    padding: 8px 10px;
    border-radius: 2px;
    line-height: 38px;
  }
  /*条件样式*/
  .company_cat_box {
    float: left;
    position: relative;
    cursor: pointer;
    z-index: 1000;
  }

  .company_province_place:hover > .down1 {
    transform: rotate(180deg);
  }

  .company_city_place:hover > .down1 {
    transform: rotate(180deg);
  }
  .company_tittle_box_span {
    padding: 8px 10px;
    border-radius: 2px;
    width: 76px;
    display: inline-block;
  }
  .company_city_place{
    display: none;
    position: relative;
    margin-left: 20px;
  }
  .company_province_place{
    display: inline-block;
    position: relative;
  }
  .article{
    text-align: left;
    margin-left: 10px;
  }
  .company_cat_box_span {
    background-color: #fff;
    padding: 8px 8px;
    width: 80px;
    border-radius: 2px;
    display: inline-block;
    border: 1px solid #e8e8e8;
    padding-right: 30px;
    text-align: center;
    -moz-user-select: none;
    -khtml-user-select: none;
    user-select: none;
  }
  .company_cat_ul {
    display: none;
    position: absolute;
    top: 31px;
    border: 1px solid #e8e8e8;
    text-align: center;
    z-index: 1000;
    background-color: #fff;
    width: 100%;
    max-height: 350px;
    overflow: auto;

  }
  .company_city_cat_ul {
    display: none;
    position: absolute;
    top: 37px;
    border: 1px solid #e8e8e8;
    text-align: center;
    z-index: 1000;
    background-color: #fff;
    width: 100%;
    padding: 10px;
  }
  .i_up {
    width: 16px;
    position: absolute;
    top: -8px;
    left: 44%;
  }
  .company_cat_title {
    text-align: center;
    color: #f5ad4e;
    line-height: 40px;
    margin-top: -1px;
    overflow: hidden;
    max-height: 250px;
    overflow-y: auto;
  }

  .company_cat_li {
    border-top: 1px dotted #e8e8e8;
    color: #888;
    line-height: 32px;
    cursor: pointer;
    position: relative;
  }
  .company_cat_li span{
    display: inline-block;
    margin-right: 20px;
  }
  .company_cat_li:hover {
    background-color: #f4f5f9;
  }
  /* 滚动条的滑轨背景颜色 */
  .company_cat_ul::-webkit-scrollbar {
    width: 3px;
  }

  .company_cat_ul::-webkit-scrollbar-track {
    background-color: #fafafa;
  }


  .company_cat_ul::-webkit-scrollbar-thumb {
    background-color: #f5ad4e;
  }

  .company_cat_ul::-webkit-scrollbar-thumb:hover {
    background-color: #FF8F0c;
  }

  .company_cat_ul::-webkit-scrollbar-button {
    display: none;
  }

  .company_cat_ul::-webkit-scrollbar-corner {
    background-color: #999;
  }
  .allSearch{
    display: inline-block;
    width: 100%;
  }
  .article_right{
    position: absolute;
    right: 90px;
    top: 40px;
    line-height: 14px;
    color: #777;
    -moz-user-select: none;
    -khtml-user-select: none;
    user-select: none;
  }
  .question_list_message_context_span{
    color: #999;
    line-height: 16px;
    margin-top: 7px;
  }
  .question_list_message_subtitle_span{
    color: #999;
    line-height: 16px;
    margin-top: 16px;
  }
  .question_list_img{
    float: left;
    padding: 10px;
    width: 200px;
    height: 100%;
  }
  .question_list_img img{
    width: 100%;
    height: 100%;
  }

  .editor_mid_box {
    height: 200px;
    width: 92%;
    margin: 5px auto;
    border: 2px dashed #d2d4d5;
    background-color: #f7f9fa;
    position: relative;
    overflow: hidden;
    cursor: pointer;
    text-align: center;
    margin-bottom: 20px;
    display: inline-block;
    max-width: 92%;
  }

  .editor_mid_box_img {
    margin: 66px auto 10px;
    display: block;
    background: transparent url("/resource/images/icon_photo.png") -50px 0 no-repeat;
    width: 50px;
    height: 48px;
    color: rgba(0, 0, 0, 0.58);
    text-shadow: 0 1px 0 #fff;
  }

  .editor_mid_box_txt {
    text-align: center;
    color: #b7bfc5;
  }

  .editor_mid_box .file_prew {
    width: 100%;
    height: 100%;
    position: absolute;
    opacity: 0;
    filter: alpha(opacity=0);
    cursor: pointer;
  }

  form {
    height: 100%;
  }

  .editor_cancel {
    width: 20px;
    height: 20px;
    position: absolute;
    top: 4px;
    right: 0;
    display: none;
    background: transparent url("/resource/images/icon_photo.png") -148px 0 no-repeat;
  }
  .slide_container{
    width: 400px;
    z-index: 9;
  }
  .slide_container_mid{
    text-align: center;
  }
  /*结束*/
  .carousel{
    width: 758px;
    overflow: hidden;
    margin: 10px auto;
    margin-bottom: 30px;
    text-align: center;
    border: 1px solid #e8e8e8;
    box-shadow: 2px 2px 10px 2px #e8e8e8;
    transition-duration: .4s;
    -moz-transition-duration: .4s;
    -webkit-transition-duration: .4s;
    -o-transition-duration: .4s;
  }
  .swiper-pagination-bullet-active{
    background: #f5ad4e;
  }
  .to_href{
    width: 16px;
    position: relative;
    top: -2px;
    margin-left: 4px;
  }
  .style_change_input{
    width: 60px;
    color: #F5AD4E;
    font-weight: bold;
    text-indent: 4px;

  }
  .style_disabled{
    border: none;
    background: #fff!important;
  }
  .undisabled{
    border: 1px solid #f5ad4e;
    color: #555;
  }
  .ad_img{
    width: 100%;
  }
</style>
<script type="text/javascript">
  $(document).ready(function () {
    // 菜单切换
      $('.menu_body').removeClass('open_menu_body');
      $('.menu_head').removeClass('current');
      $('.menu_body a').removeClass('change_menu');
      $('#newsActivities_head').addClass('current');
      $('#newsActivities_body').addClass('open_menu_body');
      $('#newsPopUpAd_menu').addClass('change_menu');
    load();
    swiper();
  });
  var i = 0;
  var global_data;
  var global_selectNumber;
  var global_id;
  var action_url = '/api/pop_up_ad/manage';
  var click_type=1;
  //请求列表数据
  function load(){
    $('.question_list_message_box_right').remove();
    $('.swiper-slide').remove();
    var obj={};
    global_page = 0;
    obj.action='show';
    operation.operation_ajax(action_url,obj,sendMessage);
  }
  function sendMessage(){
    count = global_data.total;
    loadPage.checkUserPrivilege(count,insertMessage);
  }

  //添加数据
  function insertMessage(){
    for (var i = 0; i < global_data.slides.length; i++){
      var id=global_data.slides[i].id;//广告数量
      var content=global_data.slides[i].create_time.substring(0,16);//创建时间
      var title=global_data.slides[i].image_title;//目的地
      var seq = global_data.slides[i].image_seq;
      var image_url = global_data.slides[i].image_url;
      var image_link = global_data.slides[i].image_link;
      var subtitle=global_data.slides[i].image_subtitle;
      ShopsListStyle(image_link,image_url,id, content, title, seq,subtitle);
        $('.swiper-wrapper').append('<div class="swiper-slide">' +
            '<a href="'+image_link+'" class="img_link" target="_blank">'+
            '<img src='+image_url+' class="ad_img" alt="'+title+'">' +
            '</a>'+
            '</div>')
    }
//    }
//    $('.swiper-wrapper').append('<div class="swiper-slide">' +
//            '<a href="'+global_data.slides[0].image_link+'" class="img_link" target="_blank">'+
//            '<img src='+global_data.slides[0].image_url+' class="ad_img" alt="'+global_data.slides[0].image_title+'">' +
//            '</a>'+
//            '</div>');
    swiper();
  }

  function ShopsListStyle(image_link,image_url,id, content, title, seq ,subtitle) {
    $('.not_find_message').before('<li class="question_list question_list_message_box_right" data_val='+seq+' id='+id+' onmouseenter="changeAD(this)" onmouseleave="changeDis(this)">'+
            '<div class="question_list_left">'+
            '<div class="question_list_check question_list_select_list" onclick="showEditTip(this)"></div>'+
            '<div class="question_list_checklist_del_active" onclick="deleteSingleShops(this)"></div>'+
            '</div>'+
            '<div class="question_list_message_right">'+
            '<div class="question_list_img">'+
            '<img src="'+image_url+'" class="question_list_img_img">'+
            '</div>'+
            '<div class="question_list_message_tittle">' +
            '<a href="'+image_link+'" class="img_link" target="_blank">'+
            '<div class="question_list_message_tittle_span">'+title+'<img src="/resource/images/pc_icon_url.png" class="to_href"></div>' +

            '</a>'+
            '<div class="question_list_message_context_span">'+content+'</div>'+
            '<div class="clear"></div>'+
            '<div class="question_list_message_subtitle_span">'+subtitle+'</div>'+
            '<div class="clear"></div>'+
            '</div>'+
            '</div>'+
            '<div class="article_right"  ondblclick="changeDisable(this)">'+
            '<span class="article_tittle_box_span">权重</span>' +
            '<input placeholder="权重数" value='+seq+' disabled="disabled" class="style_change_input style_disabled">'+
            '</div>'+
            '<div class="clear"></div>'+
            '</li>')
  }
//  双击实现可编辑
  function changeDisable(obj){
    $(obj).children('input').removeAttr('disabled').addClass('undisabled');
  }
  //  移开实现不可编辑并提交
  function changeDis(obj){
    var item_val = $(obj).find('.style_change_input').val();
    var item_id = $(obj).attr('id');

    $(obj).find('.style_change_input').attr('disabled','disabled').removeClass('undisabled');
    if($(obj).attr('data_val')!=item_val){
      selectCateListApi(item_id,item_val)
    }
  }
  //鼠标覆盖改变弹窗展示
  function changeAD(obj){
    $('.swiper-slide').remove();
    var image_link =$(obj).find('.img_link').attr('href');
    var image_url =$(obj).find('.question_list_img_img').attr('src');
    $('.swiper-wrapper').append('<div class="swiper-slide">' +
            '<a href="'+image_link+'" class="img_link" target="_blank">'+
            '<img src='+image_url+' class="ad_img">' +
            '</a>'+
            '</div>');
    swiper();
  }
  function hideCate(obj){
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
      $(obj).animate({"margin-top": "20px"},500);
      $(obj).parent().children('.question_list_checklist_del_active').fadeIn(800);
    } else {
      $(obj).removeClass("question_list_checklist_active");
      $(obj).animate({"margin-top": "50px"},500);
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
    var obj={};
    var id = $(obje).parent().parent().attr('id');
    obj.action='delete';
    obj.id=id;
    operation.operation_ajax(action_url,obj,deleteTipMessage);
  }

  function deleteTipMessage(){
    showErrorTips('删除成功');
    load()
  }

  //选择修改

  function selectCateListApi(id,seq) {

    var obj={};
    global_page = 0;
    obj.action='update';
    obj.id=id;
    obj.seq=seq;
    operation.operation_ajax(action_url,obj,addTipMessage);
  }
  function addTipMessage(){
    load();
    showErrorTips('调整成功');
    removeManagerStyle();

  }
  function addManagerStyle(){
    $('.input_style').val("");
    $('.editor_cancel').click();
    click_type=0;
    $('.slide_container').animate({"top":"12%","opacity":"1"},300);
    $('.slide_container_top').find('.slide_container_top_title').text('添加弹窗图');
    $('.submit_select_sure').text('添加');
  }
  //编辑路线
  function showEditTip(obj){
    click_type=2;
    var parent = $(obj).closest('.question_list');
    global_id = parent.attr('id');
    var img_src =parent.find('.question_list_img_img').attr('src');
    var img_title = parent.find('.question_list_message_tittle_span').text();
    var img_subtitle = parent.find('.question_list_message_subtitle_span').text();
    var img_seq = parent.find('.style_change_input').val();
    var img_link = parent.find('.img_link').attr('href');
    $('.img0').show().attr('src',img_src).css({'width':'100%'});
    $('.editor_change').hide();
    $('.route_start').val(img_title);
    $('.route_sub').val(img_subtitle);
    $('.route_end').val(img_link);
    $('.route_weight').val(img_seq);
    $('.slide_container').animate({"top":"12%","opacity":"1"},300);
    $('.slide_container_top').find('.slide_container_top_title').text('编辑弹窗图');
    $('.submit_select_sure').text('保存');
  }
  function removeManagerStyle(){
    click_type=1;
    $('.slide_container').animate({"top":"-220%","opacity":"0"},300);
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
  function checkInputMessage(){
    if(click_type==0){
      if($('.route_start').val()==""){
        showErrorTips('请输入图片标题')
      }else if($('.file0').val()==""){
        showErrorTips('请添加弹窗图片')
      }else if($('.route_sub').val()==""){
          showErrorTips('请输入图片副标题')
      }else if($('.route_weight').val()==""){
        showErrorTips('请添权重')
      }else{
        addAD();
      }
    }else{
      if($('.route_start').val()==""){
        showErrorTips('请输入图片标题')
      }else if($('.route_sub').val()==""){
          showErrorTips('请输入图片副标题')
      }else if($('.route_weight').val()==""){
        showErrorTips('请添权重')
      }else{
        addAD();
      }
    }
  }

  function addAD() {
    var data = new FormData($('#upload_form')[0]);
    var ad_seq = $('.ad_seq').text();
    data.append("action", "add");
    if(click_type == 2){
      data.append("id", global_id);
    }
    $.ajax({
      type: "post",
      url: "/api/pop_up_ad/manage",
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

  function swiper(){
    var mySwiper = new Swiper('.swiper-container',{
      pagination : '.swiper-pagination',
      paginationClickable :true,
      autoplay : false
    })
  }
</script>
<%--右侧菜单--%>
<div class="ui_body">
  <jsp:include page="adminLeft.jsp" flush="true"></jsp:include>
  <div id="ui_right">
    <div class="right_top">
      <div class="right_top_style">
        <span>弹窗图管理界面</span>
      </div>
    </div>
    <div class="hover_all"></div>
    <div class="question_list_container">
      <div class="sub_title_bar">
        <span class="sub_message"></span>
        <span class="add_span" onclick="addManagerStyle()"><span class="add_classify">+</span>新建弹窗</span>
        <div class="clear"></div>
      </div>

    </div>
    <%--列表信息--%>
    <div class="question_list_container_message">

      <div class="not_find_message">
        <img src="/resource/images/eat.gif">
        <span>您所查询的信息被我吃光光了~~</span>
      </div>
      <div class="clear"></div>
    </div>
    <div class="carousel">
      <div class="swiper-container">
        <div class="swiper-wrapper">
        </div>
<%--        <div class="swiper-pagination">
          &nbsp;</div>--%>
      </div>
    </div>
  </div>
  <%--添加版面--%>
  <div class="slide_container">
    <form method="post" id="upload_form" accept-charset="utf-8" onsubmit="return false" enctype="multipart/form-data" action="/api/goods?action=create">
      <div class="slide_container_top">
        <span class="slide_container_top_title">添加弹窗图片</span>
        <span class="slide_container_top_remove" onclick="removeManagerStyle()">x</span>
      </div>
      <div class="slide_container_mid">
        <div class="editor_mid_box">
          <input type="file" title="支持jpg、jpeg、gif、png格式，文件小于2M" size="1"
                 onchange="loadImageChange(this)" class="file_prew file0" name="img"
                 accept=".jpg,.png,.gif,.jpeg">
          <img src="" class="img0" alt="">
          <div class="editor_cancel" onclick="removePicture(this)"></div>
          <div class="editor_change">
            <div class="editor_mid_box_img">
            </div>
            <div class="editor_mid_box_txt">
              <span>上传弹窗图片</span>
            </div>
          </div>
        </div>
        <div class="input_list">
          <img src="/resource/images/pc_icon_beihzu.png" />
          <input type="text" name="title" placeholder="弹窗标题" class="input_style route_start" />
        </div>
        <div class="input_list">
          <img src="/resource/images/pc_icon_beihzu.png" />
          <input type="text" name="subtitle" placeholder="弹窗副标题" class="input_style route_sub" />
        </div>
        <div class="input_list">
          <img src="/resource/images/pc_icon_url.png" />
          <input type="text" name="link" placeholder="弹窗链接" class="input_style route_end" />
        </div>

        <div class="input_list">
          <img src="/resource/images/pc_icon_weight.png" />
          <input type="text" name="weight" placeholder="权重（只能为数字）" class="input_style route_weight" onchange="onlyNum(this)" />
        </div>

        <div class="submit_select">
          <span class="submit_select_span main_color submit_select_sure" onclick="checkInputMessage()">添加</span>
          <div class="clear"></div>
        </div>
      </div>
    </form>
  </div>
  <div class="clear"></div>
</div>
</body>
</html>
