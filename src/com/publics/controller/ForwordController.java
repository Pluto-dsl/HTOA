package com.publics.controller;

import com.jerry_zhq.service.Zhq_NoticeService;
import com.pluto.service.Pluto_StudentMsg;
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ForwordController {

    @Resource
    Zhq_NoticeService zhq_noticeService;


    @RequestMapping("/toPage/{path}")
    public String tomain(@PathVariable("path") String path, HttpSession session){
        return path;
    }
}