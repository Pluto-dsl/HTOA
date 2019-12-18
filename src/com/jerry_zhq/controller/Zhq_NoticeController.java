package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jerry_zhq.service.Zhq_NoticeService;
import com.publics.vo.notice.NoticeVo;
import com.publics.vo.studentModel.StudntBuildingVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class Zhq_NoticeController {

    @Resource
    Zhq_NoticeService zhq_noticeService;

    @RequestMapping("/toPage/Notice")
    public String toNotice(){
        return "/notice_zhq/selNotice";
    }

    @RequestMapping("/selNotice")
    @ResponseBody//查询
    public JSONObject selNotice(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        JSONObject jsonObject = new JSONObject();
        String hql = "from NoticeVo";
        List<NoticeVo> noticeVoList = zhq_noticeService.selNotice(hql,page,limit);
        int count = zhq_noticeService.selCount();

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("count",count);
        jsonObject.put("data",noticeVoList);
        return jsonObject;
    }

    //点击了添加按钮
    @RequestMapping("/toAddNotice")
    public String addStuDormit(){
        return "notice_zhq/addNotice";
    }



}
