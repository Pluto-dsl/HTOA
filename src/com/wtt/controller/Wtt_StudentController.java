package com.wtt.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.publics.utills.StringUtill;
import com.publics.vo.feedback.Collect_OpinionsVo;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.sun.deploy.net.HttpResponse;
import com.wtt.service.Wtt_StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/student")
public class Wtt_StudentController {
    @Resource
    Wtt_StudentService studentService;
    //去到学生请假页面
    @RequestMapping(value = "leave")
    public String leave(){
        return "student_wtt/studentleave";
    }

    //学生请假查询
    @RequestMapping(value = "selectleave")
    public void toEmpPaper(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<StudentLeaveVo> list = studentService.studentleave(page,limit);
        JSONArray jsonArray = new JSONArray();
        for(StudentLeaveVo studentLeaveVo:list){
            StudentVo studentVo = studentService.student(studentLeaveVo.getHolidayid());
            System.out.println("学生姓名:"+studentVo.getStuname());
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("holidayid",studentLeaveVo.getHolidayid());
            jsonObject1.put("StudentId",studentVo.getStuname());
            jsonObject1.put("holidayDay",studentLeaveVo.getHolidayDay());
            jsonObject1.put("startTime",studentLeaveVo.getStartTime());
            jsonObject1.put("endTime",studentLeaveVo.getEndTime());
            jsonObject1.put("Title",studentLeaveVo.getTitle());
            jsonObject1.put("Remark",studentLeaveVo.getRemark());
            jsonObject1.put("Status",studentLeaveVo.getStatus());
            jsonArray.add(jsonObject1);
        }
        //获取总行数
        int rows =studentService.pagecounts();
        JSONObject jsonObjects = new JSONObject();
        jsonObjects.put("msg","提示");
        jsonObjects.put("code",0);
        jsonObjects.put("data",jsonArray);
        jsonObjects.put("count",rows);
        try {
            PrintWriter pw = response.getWriter();
            pw.print(jsonObjects.toJSONString());
            pw.flush();
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //去到问题反馈查询页面
    @RequestMapping(value = "/questionPage")
    public String question(){
        return "emp_wtt/question";
    }
    //问题反馈查询
    @RequestMapping(value = "/selectquestion")
    public void selectquestion(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<FeedbackVo> list = studentService.feedback(page,limit);
        //获取总行数
        int rows =studentService.wentipagecounts();
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
        }catch (IOException e) {
            e.printStackTrace();
        }
    }

    //查询意见
    @RequestMapping(value ="/selectcollect")
    @ResponseBody
    public List<Collect_OpinionsVo> selectcollect(HttpServletRequest request){
        int id = Integer.parseInt(request.getParameter("wid"));
        System.out.println(id);
        List<Collect_OpinionsVo> list = studentService.selectyijian(id);
       return list;
    }
    //新增意见
    @RequestMapping(value = "/addcollect")
    public String addcollect(Collect_OpinionsVo collect_opinionsVo,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException {
        int id = Integer.parseInt(request.getParameter("feedbackId"));
        collect_opinionsVo.setWid(id);
        collect_opinionsVo.setPuttime(new Date());

        //获取当前登录用户
        session.setAttribute("username","张三");
        String name = (String) session.getAttribute("username");
        collect_opinionsVo.setEmpname(name);
        collect_opinionsVo.setContent(StringUtill.tostring(collect_opinionsVo.getContent()));
        //根据问题反馈Id去查找数据
        FeedbackVo feedbackVo = studentService.feedbackvo(id);
        //重新设置状态
        feedbackVo.setStatus(2);
        //在新增意见的时候改变问题反馈的状态（已处理）
        studentService.update(feedbackVo);
        //新增意见
        studentService.add(collect_opinionsVo);
        return "redirect:/student/questionPage";
    }
}