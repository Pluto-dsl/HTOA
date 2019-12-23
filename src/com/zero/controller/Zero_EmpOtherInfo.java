package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.empModel.emp.EducationVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.empModel.emp.FamilyInfoVo;
import com.publics.vo.empModel.emp.JobVo;
import com.publics.vo.file.AnnexVo;
import com.zero.service.EmpInfo;
import org.springframework.core.io.InputStreamSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

@Controller
@RequestMapping("zeroEmpInfo")
@SessionAttributes("empId")
public class Zero_EmpOtherInfo {
    @Resource
    EmpInfo service;
    @RequestMapping(value = "/topage")//所有员工资料页
    public String toemp(Model model, int empId) {//去员工资料页
        model.addAttribute("empId",empId);
        List<Map> empaduit =service.empaduit(empId);// 查询当前用户所有考核
        int scores = (int)(empaduit.get(0)).get("Scores");//
        model.addAttribute("scores",scores);
        model.addAttribute("empaduit",empaduit);
        return "emp/empOtherInfo";
    }
    //工作经历
    @RequestMapping(value = "/job")//所有员工资料页
    @ResponseBody
    public void job(HttpServletResponse response,int empId) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.jobs(empId));
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "/addjob")//添加或修改工作经历
    @ResponseBody
    public void addjob(int Empid,int Jobid,String companyName,String degree,String startDate,String endDate,String reason,String Remark,HttpServletResponse response) throws IOException, ParseException {
        JobVo jobVo = new JobVo();//重新拼装job对象
        jobVo.setEmpid(Empid);
        jobVo.setJobid(Jobid);
        jobVo.setCompanyName(companyName);
        jobVo.setDegree(degree);
        DateFormat fmt =new SimpleDateFormat("yyyy-MM-dd");
        jobVo.setStartDate(fmt.parse(startDate));
        jobVo.setEndDate(fmt.parse(endDate));
        jobVo.setReason(reason);
        jobVo.setRemark(Remark);
        service.addjob(jobVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/delJob")//删除工作经历
    @ResponseBody
    public void deljob(String allid,HttpServletResponse response) throws IOException, ParseException {
        service.deljob(allid);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }

    //教育背景
    @RequestMapping(value = "/education")//所有员工资料页
    public void education(HttpServletResponse response,int empId) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.education(empId));
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/addeducation")//添加或修改教育背景
    @ResponseBody
    public void addeducation(int Empid,int collegeid,String collegeName,String degree,String startDate,String endDate,String Remark,HttpServletResponse response) throws IOException, ParseException {
        EducationVo educationVo = new EducationVo();//重新拼装job对象
        educationVo.setEmpid(Empid);
        educationVo.setCollegeid(collegeid);
        educationVo.setEmpid(Empid);
        educationVo.setCollegeName(collegeName);
        educationVo.setDegree(degree);
        DateFormat fmt =new SimpleDateFormat("yyyy-MM-dd");
        educationVo.setStartDate(fmt.parse(startDate));
        educationVo.setEndDate(fmt.parse(endDate));
        educationVo.setRemark(Remark);
        service.addeducation(educationVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/deleducation")//删除工作经历
    @ResponseBody
    public void deleducation(String allid,HttpServletResponse response) throws IOException, ParseException {
        service.deleducation(allid);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }

    //家庭联系人
    @RequestMapping(value = "/familyInfo")//所有家庭联系人
    public void familyInfo(HttpServletResponse response,int empId) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.familyInfo(empId));
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "/addfamilyInfo")//添加或修改家庭联系人
    @ResponseBody
    public void addfamilyInfo(FamilyInfoVo familyInfoVo,HttpServletResponse response) throws IOException, ParseException {
        service.addfamilyInfo(familyInfoVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/delfamilyInfo")//删除家庭联系人
    @ResponseBody
    public void delfamilyInfo(String allid,HttpServletResponse response) throws IOException, ParseException {
        service.delfamilyInfo(allid);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }

    //员工考核
    @RequestMapping(value = "/aduit")//当前用户所有考核
    @ResponseBody
    public Map aduit(int empId){
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.aduit(empId));
        return map;
    }

    @RequestMapping(value = "/addaduit")//新增或修改选中用户考核
    @ResponseBody
    public String  addaduit(AduitLogVo aduitLogVo, HttpSession session){
        aduitLogVo.setAuditPerson(((EmpVo) session.getAttribute("admin")).getEmpName());//从session中获取
        aduitLogVo.setAuditDate(new java.util.Date());
        service.addaduit(aduitLogVo);
        return "ok";
    }

    //根据所选考核id返回分数
    @RequestMapping(value = "/aduitScore")//当前用户所有考核
    @ResponseBody
    public int aduitScore(int id){
        return service.aduitSocre(id);
    }

    @RequestMapping(value = "/deladuit")//删除所选用户考核
    @ResponseBody
    public String deladuit(String allid) {
        service.deladuit(allid);
        return "yes";
    }

    //证件上传
    @RequestMapping(value = "/annex")//所有证件
    @ResponseBody
    public Map annex(int empId){
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.annex(empId));
        return map;
    }

    @RequestMapping(value = "/addannex")//添加证件
    public String addannex(int empId, MultipartFile annexPath,String annexName,String Remark, HttpServletRequest request,HttpSession session) throws IOException {
        String oldName = annexPath.getOriginalFilename();
         //System.out.println(annexPath.getOriginalFilename());
        //文件后缀名
        String hou = oldName.substring(oldName.indexOf("."));
        //构造文件写入路径
        String path = request.getRealPath("\\")+"WEB-INF\\static\\imgs\\annex\\";
        //判断文件夹是否存在
        File dir = new File(path);
        if(!dir.exists()){
            dir.mkdirs();//没有即创建
        }
        //创建新的文件名
        String newName = UUID.randomUUID().toString()+hou;
        //拼凑完整的文件路径
        String filepath = path+newName;
        // //System.out.println("保存路径"+filepath);
        File file = new File(filepath);
        //保存文件
        try {
            annexPath.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
        AnnexVo annexVo = new AnnexVo();
        annexVo.setAnnexPath("imgs/annex/"+newName);
        annexVo.setAnnexName(annexName);
        annexVo.setRemark(Remark);
        annexVo.setSeName(1);
        annexVo.setSeId(empId);
        annexVo.setAnnexDate(new Date(new java.util.Date().getTime()));
        annexVo.setSessionName(((EmpVo) session.getAttribute("admin")).getEmpName());//操作人 在有登录后在session中获取
        service.addAnnex(annexVo);
        return "redirect:topage?empId="+empId;
    }
    @RequestMapping(value = "/delannex")//删除证件
    @ResponseBody
    public String delannex(String allid) throws IOException, ParseException {
        service.delAnnex(allid);
        return "yes";
    }

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }
}
