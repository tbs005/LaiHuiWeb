package com.cyparty.laihui.controller;

import com.alibaba.fastjson.JSONObject;
import com.cyparty.laihui.db.LaiHuiDB;
import com.cyparty.laihui.domain.Advisory;
import com.cyparty.laihui.utilities.ReturnJsonUtil;
import com.cyparty.laihui.utilities.Utils;
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
 * Created by lh2 on 2017/5/12.
 */
@Controller
public class AdvisoryController {

    private boolean is_logined;

    @Autowired
    private LaiHuiDB laiHuiDB;

    @RequestMapping("/db/advisory/manage")
    public String db_validate(Model model, HttpServletRequest request){
        is_logined=Utils.isLogined(request);
        if(is_logined){
            return "advisory_manage_list";
        }else {
            model.asMap().clear();
            return "redirect:/db/login";
        }

    }

    @ResponseBody
    @RequestMapping(value = "/advisory/manage",method = RequestMethod.POST)
    public ResponseEntity<String> advisoryManage(HttpServletRequest request){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type", "application/json;charset=UTF-8");
        responseHeaders.set("Access-Control-Allow-Origin", "*");
        JSONObject result = new JSONObject();
        String json = "";
        int id = 0;
        try {
            String action = request.getParameter("action");
            boolean is_success=false;
            int page=0;
            int size=1;
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
                    size=1;
                    e.printStackTrace();
                }
            }
            switch (action) {
                case "add":
                    String title1=request.getParameter("title");
                    String sub_title1=request.getParameter("sub_title");
                    String content1=request.getParameter("content");
                    Advisory advisory=new Advisory();
                    advisory.setTitile(Utils.checkNull(title1));
                    advisory.setSub_title(Utils.checkNull(sub_title1));
                    advisory.setContent(Utils.checkNull(content1));
                    is_success = laiHuiDB.createAdvisory(advisory);
                    if (is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "添加资讯信息成功");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                    json = ReturnJsonUtil.returnFailJsonString(result, "添加资讯信息失败");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "show":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    json = ReturnJsonUtil.returnSuccessJsonString(ReturnJsonUtil.getAdvisoryJson(laiHuiDB, page, size, id), "��ѯ��Ϣ��ȡ�ɹ�");
                    return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                case "delete":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    String delete_sql=" where advisory_id="+id;
                    is_success=laiHuiDB.delete("pc_advisory",delete_sql);
                    if(is_success){
                        json = ReturnJsonUtil.returnSuccessJsonString(result, "删除资讯信息成功");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "删除资讯信息失败");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
                case "update":
                    if(request.getParameter("id")!=null&&!request.getParameter("id").isEmpty()){
                        id=Integer.parseInt(request.getParameter("id"));
                    }else {
                        id=0;
                    }
                    if (id>0){
                        String title = request.getParameter("title");
                        String sub_title = request.getParameter("sub_title");
                        String content = request.getParameter("content");
                        String update_sql=" set title='"+Utils.checkNull(title)+"',sub_title='"+Utils.checkNull(sub_title)+"',content='"+Utils.checkNull(content)+"',update_time='"+ Utils.getCurrentTime()+"' where advisory_id="+id;
                        is_success=laiHuiDB.update("pc_advisory",update_sql);
                        if(is_success){
                            json = ReturnJsonUtil.returnSuccessJsonString(result, "修改资讯细信息成功");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }else {
                            json = ReturnJsonUtil.returnFailJsonString(result, "修改资讯信息失败");
                            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                        }
                    }else {
                        json = ReturnJsonUtil.returnFailJsonString(result, "参数错误");
                        return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
                    }
            }
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            json = ReturnJsonUtil.returnFailJsonString(result, "参数错误");
            return new ResponseEntity<String>(json, responseHeaders, HttpStatus.OK);
        }
    }
}
