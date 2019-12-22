package com.jack.controller;

import com.alibaba.fastjson.JSONObject;
import com.jack.service.Jack_Service;
import com.publics.vo.empModel.AttendanceVo;
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**  考勤管理  */

@Controller
@RequestMapping("/jack")
public class Jack_AttController {

    @Resource
    private Jack_Service service;



    @RequestMapping("/xxx")
    public String xxx(){
        return "emp_xzq/xxx";
    }

    @RequestMapping("/toAtt")
    public String toTest1(){
        return "emp_xzq/AttendancePage";
    }

    /**
     * 修改审批
     * */
    @RequestMapping("/AttUpdata")
    public String AttUpdata(String eid,String state,String specification){
        System.out.println(state);
        System.out.println(eid);
        System.out.println(specification);
        AttendanceVo avo = new AttendanceVo();
        avo.setExamineTime(new Date());
        avo.setAttId(Integer.parseInt(eid));
        avo.setStatus(Integer.parseInt(state));
        avo.setExamineExplain(specification);
        service.updataAtt(avo);

        return "emp_xzq/xxx";
    }

    //查询要审批的数据
    @RequestMapping("/Approver")
    public void Approver(HttpSession session,HttpServletResponse response) throws IOException {
        //获取当前登入的用户 查询是否有审核申请
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        List list = service.selApprover(empVo.getEmpName(),2);
        response.setContentType("text/json;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        System.out.println(json.toJSONString());
        out.print(json);
        out.close();

    }

    /**
     *
     * 添加未打卡申请
     * 获取当前登入的用户获取填写的申请信息添加到数据库
     * **/
    @RequestMapping("/Attadd")
    public String Attadd(HttpSession session,String punckClockTime,String cause,String timeing) throws ParseException {
        System.out.println("进来了");
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        String ptime = punckClockTime +" "+ timeing;

        System.out.println(ptime);
        //日期转换
        DateFormat format  = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date date = null;
        date = format.parse(ptime);

        System.out.println(date+"--------");
        AttendanceVo attVo = new AttendanceVo();
        attVo.setEmpId(empVo.getEmpId());
        String Auditor = service.selDepChairman(empVo.getEmpId()); //查询审核人
        attVo.setAuditor(Auditor);
        attVo.setCause(cause);
        attVo.setPunckClockTime(date);
        attVo.setStatus(2); //待审核
        attVo.setExamineTime(null);
        attVo.setApplyTime(new Date());

        service.insertAtt(attVo); //添加未打卡说明

        System.out.println(attVo.toString());

        return "emp_xzq/AttendancePage";
    }

    @RequestMapping(value = "delAtt")
    @ResponseBody
    public int delAtt(HttpServletRequest request){
        int w = Integer.parseInt(request.getParameter("cid"));
        service.delAtt(w);
        return 0;
    }


    /**
     * 查询未打卡说明列表
     * */
    @RequestMapping("/Att")
    public void Att(HttpSession session,HttpServletResponse response, HttpServletRequest request) throws IOException {
        int currPage = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("limit"));
        EmpVo empVo = (EmpVo) session.getAttribute("admin");//获取当前登入的名称
        response.setContentType("text/html;charset=utf-8");
        System.out.println(currPage+"----"+pageSize);
        List list = service.selAtt(empVo.getEmpId(),currPage,pageSize);
        System.out.println(empVo.getEmpId()+"当前用户id");
        int pageCount = service.selAttCount(empVo.getEmpId());
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        json.put("count",pageCount);
        System.out.println(json.toJSONString());
        out.print(json);
        out.close();

    }

}
