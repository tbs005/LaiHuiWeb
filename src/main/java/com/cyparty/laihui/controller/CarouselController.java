package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.Carousel;
import com.cyparty.laihui.utilities.OssUtil;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import com.cyparty.laihui.utilities.Utils;
import com.cyparty.laihui.utilities.WXUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by zhu on 2016/5/11.
 */
@Controller
public class CarouselController {
    private boolean is_logined;
    @Autowired
    LaiHuiDB laiHuiDB;
    @Autowired
    OssUtil ossUtil;
    @RequestMapping("/db/carousel")
    public String index(Model model,HttpServletRequest request){
        is_logined= Utils.isLogined(request);
        if(is_logined){
            return "carousel_list";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @RequestMapping("/db/pop_up_ad")
    public String pop_up_ad(Model model,HttpServletRequest request){
        is_logined= Utils.isLogined(request);
        if(is_logined){
            return "pop_up_ad";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @RequestMapping("/db/withdraw_cash")
    public String withdraw_cash(Model model,HttpServletRequest request){
        is_logined= Utils.isLogined(request);
        if(is_logined){
            return "withdraw_cash";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }
    @RequestMapping("/db/navigation_page")
    public String navigation_page(Model model,HttpServletRequest request){
        is_logined= Utils.isLogined(request);
        if(is_logined){
            return "navigation_page";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }
    }


    @ResponseBody
    @RequestMapping(value = "/api/carousel/manage", method = RequestMethod.POST)
    public ResponseEntity<String> wx_cumulate(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        try {
            String action=request.getParameter("action");
            boolean is_success=false;
            int page=0;
            int size=10;
            if(request.getParameter("page")!=null&&!request.getParameter("page").trim().equals("")){
                try {
                    page=Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page=0;
                    e.printStackTrace();
                }
            }
            if(request.getParameter("size")!=null&&!request.getParameter("size").trim().equals("")){
                try {
                    size=Integer.parseInt(request.getParameter("size"));
                } catch (NumberFormatException e) {
                    size=10;
                    e.printStackTrace();
                }
            }
            switch (action) {
                case "add":
                    String title=request.getParameter("title");
                    String link=request.getParameter("link");
                    String seq=request.getParameter("seq");

                    Carousel carousel=new Carousel();

                    carousel.setImage_link(link);
                    carousel.setImage_title(title);
                    int now_seq=0;
                    if(seq!=null&&!seq.isEmpty()){
                        now_seq=Integer.parseInt(seq);
                    }
                    carousel.setSeq(now_seq);
                    //判断是更新还是创建
                    String ad_id=request.getParameter("id");
                    int id=0;
                    if(ad_id!=null&&!ad_id.trim().equals("")){
                        id=Integer.parseInt(ad_id);
                    }
                    if(id>0){
                            //更新
                            String filePath = Utils.fileImgUpload("img", request);
                            if (filePath != null && !filePath.trim().equals("")) {
                                String image_local = filePath.substring(filePath.indexOf("upload"));
                                String arr[] = image_local.split("\\\\");
                                String image_oss = arr[arr.length - 1];
                                try {
                                    if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                                        image_oss = "https://laihuipincheoss.oss-cn-qingdao.aliyuncs.com/" + image_oss;
                                        carousel.setImage_url(image_oss);
                                    }
                                } catch (Exception e) {
                                    image_oss = null;
                                    carousel.setImage_url(image_oss);
                                }
                            }else {
                                carousel.setImage_url(null);
                            }

                            String update_where="";
                            if(carousel.getImage_url()!=null){
                                //update
                                update_where=" set pc_image_url='"+carousel.getImage_url()+"',pc_image_link='"+carousel.getImage_link()+"',pc_image_title='"+title+"',pc_image_seq="+carousel.getSeq()+",pc_image_update_time='"+Utils.getCurrentTime()+"' where _id="+id;
                            }else {
                                update_where=" set pc_image_link='"+carousel.getImage_link()+"',pc_image_title='"+title+"',pc_image_seq="+carousel.getSeq()+",pc_image_update_time='"+Utils.getCurrentTime()+"' where _id="+id;
                            }

                            laiHuiDB.update("pc_carousel",update_where);
                            json = ReturnJsonUtil.returnSuccessJsonString(result, "创建成功！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                            //新建
                            String filePath = Utils.fileImgUpload("img", request);
                            if (filePath != null && !filePath.trim().equals("")) {
                                String image_local = filePath.substring(filePath.indexOf("upload"));
                                String arr[] = image_local.split("\\\\");
                                String image_oss = arr[arr.length - 1];
                                try {
                                    if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                                        image_oss = "https://laihuipincheoss.oss-cn-qingdao.aliyuncs.com/" + image_oss;
                                        carousel.setImage_url(image_oss);
                                    }
                                } catch (Exception e) {
                                    image_oss = null;
                                    carousel.setImage_url(image_oss);
                                }
                            }else {
                                carousel.setImage_url(null);
                            }
                            if(carousel.getImage_url()!=null&&carousel.getSeq()!=0){

                                carousel.setType(1);
                                is_success=laiHuiDB.createCarousel(carousel);
                            }
                            if(is_success){
                                json = ReturnJsonUtil.returnSuccessJsonString(result, "创建成功！");
                                return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                            }
                        }
                    json = ReturnJsonUtil.returnFailJsonString(result, "创建失败！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "show":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getCarouselJson(laiHuiDB, page, size, id,1), "轮播图信息获取成功");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "update":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    now_seq=1;
                    if(request.getParameter("seq")!=null&&!request.getParameter("seq").isEmpty()){
                        now_seq=Integer.parseInt(request.getParameter("seq"));
                    }
                    if(id>0){
                        String update_sql=" set pc_image_seq="+now_seq+" where _id="+id;
                        laiHuiDB.update("pc_carousel",update_sql);
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "轮播图顺序更改成功");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "轮播图顺序更改失败");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "delete":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    String delete_sql=" where _id="+id;
                    is_success=laiHuiDB.delete("pc_carousel",delete_sql);
                    if(is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "轮播图信息删除成功！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "轮播图信息删除失败！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.BAD_REQUEST);
        }
    }
    @ResponseBody
    @RequestMapping(value = "/api/pop_up_ad/manage", method = RequestMethod.POST)
    public ResponseEntity<String> pop_up_ad(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        try {
            String action=request.getParameter("action");
            boolean is_success=false;
            int page=0;
            int size=10;
            if(request.getParameter("page")!=null&&!request.getParameter("page").trim().equals("")){
                try {
                    page=Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page=0;
                    e.printStackTrace();
                }
            }
            if(request.getParameter("size")!=null&&!request.getParameter("size").trim().equals("")){
                try {
                    size=Integer.parseInt(request.getParameter("size"));
                } catch (NumberFormatException e) {
                    size=10;
                    e.printStackTrace();
                }
            }
            switch (action) {
                case "add":
                    String title=request.getParameter("title");
                    String link=request.getParameter("link");
                    String seq=request.getParameter("weight");

                    Carousel carousel=new Carousel();

                    carousel.setImage_link(link);
                    carousel.setImage_title(title);
                    int now_seq=0;
                    if(seq!=null&&!seq.isEmpty()){
                        now_seq=Integer.parseInt(seq);
                    }
                    carousel.setSeq(now_seq);
                    //判断是更新还是创建
                    String ad_id=request.getParameter("id");
                    int id=0;
                    if(ad_id!=null&&!ad_id.trim().equals("")){
                        id=Integer.parseInt(ad_id);
                    }
                    if(id>0){
                        //更新
                        String filePath = Utils.fileImgUpload("img", request);
                        if (filePath != null && !filePath.trim().equals("")) {
                            String image_local = filePath.substring(filePath.indexOf("upload"));
                            String arr[] = image_local.split("\\\\");
                            String image_oss = arr[arr.length - 1];
                            try {
                                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                                    image_oss = "https://laihuipincheoss.oss-cn-qingdao.aliyuncs.com/" + image_oss;
                                    carousel.setImage_url(image_oss);
                                }
                            } catch (Exception e) {
                                image_oss = null;
                                carousel.setImage_url(image_oss);
                            }
                        }else {
                            carousel.setImage_url(null);
                        }
                        String update_where="";
                        if(carousel.getImage_url()!=null){
                            //update
                            update_where=" set pc_image_url='"+carousel.getImage_url()+"',pc_image_link='"+carousel.getImage_link()+"',pc_image_title='"+title+"',pc_image_seq="+carousel.getSeq()+",pc_image_update_time='"+Utils.getCurrentTime()+"' where _id="+id;
                        }else {
                            update_where=" set pc_image_link='"+carousel.getImage_link()+"',pc_image_title='"+title+"',pc_image_seq="+carousel.getSeq()+",pc_image_update_time='"+Utils.getCurrentTime()+"' where _id="+id;
                        }

                        laiHuiDB.update("pc_carousel",update_where);
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "创建成功！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        //新建
                        String filePath = Utils.fileImgUpload("img", request);
                        if (filePath != null && !filePath.trim().equals("")) {
                            String image_local = filePath.substring(filePath.indexOf("upload"));
                            String arr[] = image_local.split("\\\\");
                            String image_oss = arr[arr.length - 1];
                            try {
                                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                                    image_oss = "https://laihuipincheoss.oss-cn-qingdao.aliyuncs.com/" + image_oss;
                                    carousel.setImage_url(image_oss);
                                }
                            } catch (Exception e) {
                                image_oss = null;
                                carousel.setImage_url(image_oss);
                            }
                        }else {
                            carousel.setImage_url(null);
                        }
                        if(carousel.getImage_url()!=null&&carousel.getSeq()!=0){
                            carousel.setType(2);
                            is_success=laiHuiDB.createCarousel(carousel);
                        }
                        if(is_success){
                            json = ReturnJsonUtil.returnSuccessJsonString(result, "创建成功！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "创建失败！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "show":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getCarouselJson(laiHuiDB, page, size, id,2), "轮播图信息获取成功");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "update":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    now_seq=1;
                    if(request.getParameter("seq")!=null&&!request.getParameter("seq").isEmpty()){
                        now_seq=Integer.parseInt(request.getParameter("seq"));
                    }
                    if(id>0){
                        String update_sql=" set pc_image_seq="+now_seq+" where _id="+id;
                        laiHuiDB.update("pc_carousel",update_sql);
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "弹出广告权重更改成功");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "弹出广告权重更改失败");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "delete":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    String delete_sql=" where _id="+id;
                    is_success=laiHuiDB.delete("pc_carousel",delete_sql);
                    if(is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "弹出广告删除成功！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "弹出广告删除失败！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        }
    }
    @ResponseBody
    @RequestMapping(value = "/api/navigation_page/manage", method = RequestMethod.POST)
    public ResponseEntity<String> navigation_page(HttpServletRequest request) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        JSONObject result = new JSONObject();
        String json = "";
        try {
            String action=request.getParameter("action");
            boolean is_success=false;
            int page=0;
            int size=10;
            if(request.getParameter("page")!=null&&!request.getParameter("page").trim().equals("")){
                try {
                    page=Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page=0;
                    e.printStackTrace();
                }
            }
            if(request.getParameter("size")!=null&&!request.getParameter("size").trim().equals("")){
                try {
                    size=Integer.parseInt(request.getParameter("size"));
                } catch (NumberFormatException e) {
                    size=10;
                    e.printStackTrace();
                }
            }
            switch (action) {
                case "add":
                    String title=request.getParameter("title");
                    String link=request.getParameter("link");
                    String seq=request.getParameter("weight");

                    Carousel carousel=new Carousel();

                    carousel.setImage_link(link);
                    carousel.setImage_title(title);
                    int now_seq=0;
                    if(seq!=null&&!seq.isEmpty()){
                        now_seq=Integer.parseInt(seq);
                    }
                    carousel.setSeq(now_seq);
                    //判断是更新还是创建
                    String ad_id=request.getParameter("id");
                    int id=0;
                    if(ad_id!=null&&!ad_id.trim().equals("")){
                        id=Integer.parseInt(ad_id);
                    }
                    if(id>0){
                        //更新
                        String filePath = Utils.fileImgUpload("img", request);
                        if (filePath != null && !filePath.trim().equals("")) {
                            String image_local = filePath.substring(filePath.indexOf("upload"));
                            String arr[] = image_local.split("\\\\");
                            String image_oss = arr[arr.length - 1];
                            try {
                                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                                    image_oss = "https://laihuipincheoss.oss-cn-qingdao.aliyuncs.com/" + image_oss;
                                    carousel.setImage_url(image_oss);
                                }
                            } catch (Exception e) {
                                image_oss = null;
                                carousel.setImage_url(image_oss);
                            }
                        }else {
                            carousel.setImage_url(null);
                        }
                        String update_where="";
                        if(carousel.getImage_url()!=null){
                            //update
                            update_where=" set pc_image_url='"+carousel.getImage_url()+"',pc_image_link='"+carousel.getImage_link()+"',pc_image_title='"+title+"',pc_image_seq="+carousel.getSeq()+",pc_image_update_time='"+Utils.getCurrentTime()+"' where _id="+id;
                        }else {
                            update_where=" set pc_image_link='"+carousel.getImage_link()+"',pc_image_title='"+title+"',pc_image_seq="+carousel.getSeq()+",pc_image_update_time='"+Utils.getCurrentTime()+"' where _id="+id;
                        }

                        laiHuiDB.update("pc_carousel",update_where);
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "创建成功！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        //新建
                        String filePath = Utils.fileImgUpload("img", request);
                        if (filePath != null && !filePath.trim().equals("")) {
                            String image_local = filePath.substring(filePath.indexOf("upload"));
                            String arr[] = image_local.split("\\\\");
                            String image_oss = arr[arr.length - 1];
                            try {
                                if (ossUtil.uploadFileWithResult(request, image_oss, image_local)) {
                                    image_oss = "https://laihuipincheoss.oss-cn-qingdao.aliyuncs.com/" + image_oss;
                                    carousel.setImage_url(image_oss);
                                }
                            } catch (Exception e) {
                                image_oss = null;
                                carousel.setImage_url(image_oss);
                            }
                        }else {
                            carousel.setImage_url(null);
                        }
                        if(carousel.getImage_url()!=null&&carousel.getSeq()!=0){
                            carousel.setType(3);
                            is_success=laiHuiDB.createCarousel(carousel);
                        }
                        if(is_success){
                            json = ReturnJsonUtil.returnSuccessJsonString(result, "创建成功！");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "创建失败！");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "show":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getCarouselJson(laiHuiDB, page, size, id,3), "导航页获取成功");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "update":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    now_seq=1;
                    if(request.getParameter("seq")!=null&&!request.getParameter("seq").isEmpty()){
                        now_seq=Integer.parseInt(request.getParameter("seq"));
                    }
                    if(id>0){
                        String update_sql=" set pc_image_seq="+now_seq+" where _id="+id;
                        laiHuiDB.update("pc_carousel",update_sql);
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "导航页权重更改成功");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "导航页权重更改失败");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "delete":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    String delete_sql=" where _id="+id;
                    is_success=laiHuiDB.delete("pc_carousel",delete_sql);
                    if(is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "导航页删除成功！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "导航页删除失败！");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "获取参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        }
    }
}
