package com.wtt.controller;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.wtt.service.Wtt_StuDuanService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/studentduan")
public class Wtt_StuDuanController {
    @Resource
    Wtt_StuDuanService wtt_stuDuanService;

    //
    /*@RequestMapping(value = "stuframeset")
    public String stuframeset(){
        return "main";
    }
    //去到学生端主页
    @RequestMapping(value = "studentonmain")
    public String studentonmain(){
        return "studentOamain";
    }*/

    @RequestMapping(value = "/problem_feedback")
    public String problem_feedback(ModelMap modelMap,HttpSession session){
        List deplist = wtt_stuDuanService.dep();
        modelMap.addAttribute("list",deplist);
        return "student_wtt/problem_feedback";
    }
    //学生端查询问题反馈
    @RequestMapping(value = "/selectproblem")
    public void selectproblem(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<FeedbackVo> list = wtt_stuDuanService.feedback(page,limit);
        //获取总行数
        int rows =wtt_stuDuanService.pagecount();
        /*System.out.println("总行数:"+rows);*/
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

    //新增学生问题反馈
    @RequestMapping(value = "/addproblems",method = RequestMethod.POST)
    public String addproblem(FeedbackVo feedbackVo, /*@RequestParam(value = "file")*/ MultipartFile images, HttpServletRequest request,HttpSession session){
        /*System.out.println("部门id:"+request.getParameter("depId"));*/
        //获取旧文件名
        String oldname = images.getOriginalFilename();
       /* System.out.println("获取旧文件名:"+oldname);*/
        //获取旧文件名的后缀名
        String substr = oldname.substring(oldname.indexOf("."));
       /* System.out.println("后缀名:"+substr);*/
        //给上传文件加上年月日
        Date date = new Date(new java.util.Date().getTime());
        //设计新文件名
        String newname = UUID.randomUUID().toString();
        //拼接全文件名
        String allpath = newname+substr;
        //获取文件的绝对路径
        String path =request.getSession().getServletContext().getRealPath("\\");
        path+="WEB-INF\\static\\imgs\\problem\\"+date;
        File file = new File(path);
        if(!file.exists()){
            file.mkdirs();
        }
        File file1 = new File(path,allpath);
        try {
            images.transferTo(file1);
            feedbackVo.setImage("..\\imgs\\problem\\"+date+"\\"+allpath);
        } catch (IOException e) {
            e.printStackTrace();
        }
        feedbackVo.setFeedBackType(1);
        feedbackVo.setFeedbackTime(new java.util.Date());
        //获取存在session中的用户(电话号码)
        StudentVo studentVo = (StudentVo) session.getAttribute("admin");
        String name = studentVo.getStuname();
        Map map = wtt_stuDuanService.student(name);
        int id = (int) map.get("Studid");
        System.out.println("学生id:"+id);
        feedbackVo.setEmpId(id);
        feedbackVo.setStatus(1);
        String classname = (String) map.get("className");
        System.out.println("班级名称:"+classname);
        feedbackVo.setEmpName(classname);
        wtt_stuDuanService.add(feedbackVo);
        return "redirect:/studentduan/problem_feedback";
    }

    //去到学生申请请假页面
    @RequestMapping(value = "/studentleaves")
    public String studentleave(){
        return "student_wtt/apply_leave";
    }

    //查询学生请假
    @RequestMapping(value = "studentselectleave")
    public void studentselectleave(int page,int limit,HttpServletResponse response){
        response.setContentType("text/html;charset=utf-8");
        List<StudentLeaveVo> list = wtt_stuDuanService.studentleave(page,limit);
        //获取总行数
        int rows =wtt_stuDuanService.leavepagecount();
        JSONObject jsonObjects = new JSONObject();
        jsonObjects.put("msg","提示");
        jsonObjects.put("code",0);
        jsonObjects.put("data",list);
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
}