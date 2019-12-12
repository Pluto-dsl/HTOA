package com.jack.controller;

import com.alibaba.fastjson.JSONObject;
import com.jack.service.Jack_Service;
import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.assess.AduitModelVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/jack")
public class Jack_Assessment {

    @Resource
    private Jack_Service service;

    /** 考核指标 */
    @RequestMapping(value = "/toAssessmentPage")
    public String toAssessmentPage(){
        return "emp_xzq/AssessmentPage";
    }
    @RequestMapping(value = "addAss")
    @ResponseBody
    public String addAss(AduitModelVo aduitModelVo){
        service.addAssessment(aduitModelVo);
        return "成功";
    }
    @RequestMapping(value = "/select")
    @ResponseBody
    public Map select(){
        List list = service.selDepList();
        System.out.println(list);
        Map map = new HashMap<>();
        map.put("names",list);
        return map;
    }
    @RequestMapping(value = "/editAss")
    @ResponseBody
    public String editAss(AduitModelVo aduitModelVo){
        System.out.println(aduitModelVo+"-----------------");
        service.editAssessment(aduitModelVo);
        return "成功";
    }
    @RequestMapping(value = "/delAss")
    @ResponseBody
    public String delAss(HttpServletRequest request){
        String type = request.getParameter("type");

        if("duo".equals(type)){
            System.out.println(request.getParameter("cid"));
            service.delAssessment(Integer.parseInt(request.getParameter("cid")));
        }else {
            service.delAssessment(Integer.parseInt(request.getParameter("Aid")));
            return "成功";
        }
        return "";
    }
    @RequestMapping(value = "/AssessmentPage")
    public void AssessmentPage(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        int currPage = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("limit"));
        response.setContentType("text/html;charset=utf-8");
        System.out.println(currPage+"----"+pageSize);
        List list = service.selAssessment(currPage,pageSize);
        int pageCount = service.selAssCount();
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

    /** 员工考核录入 */
    @RequestMapping(value = "/toCheckEntry")
    public String toCheckEntry(HttpSession session){
        session.setAttribute("user","dddd");
        return "emp_xzq/CheckEntry";
    }

    @RequestMapping(value = "/Ass")
    @ResponseBody
    public Map Ass(){
        Map Amap = new HashMap();
        List list = service.selAss();
        Amap.put("names",list);
        return Amap;
    }
    @RequestMapping(value = "/emp")
    @ResponseBody
    public Map emp(){
        Map emap = new HashMap();
        List list = service.selEmp();
        emap.put("names",list);
        return emap;
    }

    @RequestMapping(value = "/uploadImg")
    @ResponseBody
    public Map<String, Object> updatePersonal(@RequestParam(required=false)MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException{
        //如果文件内容不为空，则写入上传路径
        System.out.println(file+"=========");
        if (!file.isEmpty()) {
            //上传文件路径
            String path = request.getSession().getServletContext().getRealPath("\\WEB-INF\\static\\imgs");

            //上传文件名
            String filename = file.getOriginalFilename();
            File filepath = new File(path, filename);
            String url = "..\\imgs\\"+file.getOriginalFilename();

            //判断路径是否存在，没有就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }

            //将上传文件保存到一个目标文档中
            File file1 = new File(path + File.separator + filename);
            file.transferTo(file1);
            Map<String, Object> res = new HashMap<>();
            //返回的是一个url对象
            res.put("url", url);
            return res;

        } else {
            Map map = new HashMap();
            map.put("code","\"code\": 1");
            return map;
        }
    }

    @RequestMapping(value = "/addAduitLog",method = RequestMethod.POST)
    @ResponseBody
    public int addaduitLog(@RequestParam("aduitModelid") String aduitModelid ,
                              @RequestParam("Empid") String Empid,
                              @RequestParam("Scores") String Scores,
                              @RequestParam("auditDate") String auditDate,
                              @RequestParam("Remark") String Remark,
                              @RequestParam("auditPerson") String auditPerson,
                              @RequestParam("Image") String Image) throws ParseException {
        AduitLogVo aduitLogVo = new AduitLogVo();
        aduitLogVo.setAduitModelid(Integer.parseInt(aduitModelid));
        aduitLogVo.setEmpid(Integer.parseInt(Empid));
        aduitLogVo.setScores(Integer.parseInt(Scores));
        System.out.println(auditDate);
        DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
        Date date = format1.parse(auditDate);
        aduitLogVo.setAuditDate(date);
        aduitLogVo.setRemark(Remark);
        aduitLogVo.setAuditPerson(auditPerson);
        aduitLogVo.setImage(Image);
        System.out.println(aduitLogVo);
        service.addAduit(aduitLogVo);

        return 0;
    }

    @RequestMapping("/toAduitLogList")
    public String toAduitLogList(){
        return "emp_xzq/empAssessment";
    }

    /** 员工考核列表 */
    @RequestMapping("/AduitLogList")
    @ResponseBody
    public void AduitLogList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        int currPage = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("limit"));
        response.setContentType("text/html;charset=utf-8");
        System.out.println(currPage+"----"+pageSize);
        List list = service.selAduitLog(currPage,pageSize);
        int pageCount = service.selAdCount();
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

