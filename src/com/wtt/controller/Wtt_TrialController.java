package com.wtt.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.educ.TrialVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.wtt.service.Wtt_TrialService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
    public String rehearsal_trainingPage(ModelMap modelMap){
        List list1 = wtt_trialService.coursevo();
        List list2 = wtt_trialService.emp();
        modelMap.addAttribute("course",list1);
        modelMap.addAttribute("emp",list2);
        return "emp_wtt/shijiang_training";
    }

    //查询试讲培训
    @RequestMapping(value = "/selectshijiang")
    public void selectshijiang(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<TrialVo> list = wtt_trialService.trialvo(page,limit);
        JSONArray jsonArray = new JSONArray();
        for (TrialVo trialVo:list){
            EmpVo empVo = wtt_trialService.emp(trialVo.getEmpId());
             //System.out.println(empVo);
            CourseVo courseVo =wtt_trialService.courseid(trialVo.getCourseId());
            /* //System.out.println(courseVo);
             //System.out.println("课程名称:"+courseVo.getCourseName());
             //System.out.println("员工名称:"+empVo.getEmpName());*/
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("trialId",trialVo.getTrialId());
            jsonObject.put("date",trialVo.getDate());
            jsonObject.put("time",trialVo.getTime());
            jsonObject.put("courseId",courseVo.getCourseName());
            jsonObject.put("type",trialVo.getType());
            jsonObject.put("empId",empVo.getEmpName());
            jsonObject.put("remark",trialVo.getRemark());

            jsonArray.add(jsonObject);
        }
        //获取总行数
        int rows =wtt_trialService.pagecount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg","提示");
        jsonObject.put("code",0);
        jsonObject.put("data",jsonArray);
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

    //新增学生
    @RequestMapping(value = "/addtrial")
    public String addtrial(TrialVo trialVo){

        wtt_trialService.add(trialVo);
        return "redirect:/training/rehearsal_trainingPage";
    }

    //删除试讲培训
    @RequestMapping(value = "/deletetrial")
    public String deleteEmpPaperPage(HttpServletResponse response,int id){
        wtt_trialService.delete(id);
        /*try {
            PrintWriter printWriter = response.getWriter();
            printWriter.println("");
            printWriter.flush();
            printWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }*/
        return "redirect:/emp/selectEmpPaper";
    }
}