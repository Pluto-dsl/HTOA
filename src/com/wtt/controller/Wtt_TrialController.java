package com.wtt.controller;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.educ.TrialVo;
import com.wtt.service.Wtt_TrialService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/training")
public class Wtt_TrialController {
    @Resource
    Wtt_TrialService wtt_trialService;
    //去到试讲培训页面
    @RequestMapping(value = "/rehearsal_trainingPage")
    public String rehearsal_trainingPage(){
        return "emp_wtt/shijiang_training";
    }

    //查询试讲培训
    @RequestMapping(value = "/selectshijiang")
    public void selectshijiang(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<TrialVo> list = wtt_trialService.trialvo(page,limit);
        System.out.println(list);
        //获取总行数
        int rows =wtt_trialService.pagecount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg","提示");
        jsonObject.put("code",0);
        jsonObject.put("data",list);
        jsonObject.put("count",rows);
        try {
            PrintWriter pw = response.getWriter();
            pw.print(jsonObject.toJSONString());
            pw.flush();
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}