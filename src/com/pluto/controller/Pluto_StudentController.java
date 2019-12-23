package com.pluto.controller;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_StudentMsg;
import com.publics.utills.StringUtill;
import com.publics.vo.studentModel.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/student")
public class Pluto_StudentController {

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @Resource
    private Pluto_StudentMsg service;

    @RequestMapping("/stuList")
    public String getStudentList(HttpServletRequest request){
        List hList = service.getHourList("from StudentDormitoryVo");
        List cList = service.getListByHql("from StudentClassVo");
        List sList = service.getListByHql("from StuStartSetVo");
        request.setAttribute("cList",cList);
        request.setAttribute("sList",sList);
        request.setAttribute("ssList",hList);
        return "student_pluto/student_list";
    }

    @RequestMapping("/toUpdateStu")
    public String toUpdateStuPage(int id,Model model){
        StudentVo s = service.getStudentById(id);
        List clist = service.getClassList("from StudentClassVo");
        List mList = service.getMajor("from MajorVo");
        List hList = service.getHourList("from StudentDormitoryVo");
        List xList = service.getDeptList("from DeptVo");
        model.addAttribute("zyList",mList);
        model.addAttribute("classList",clist);
        model.addAttribute("xList",xList);
        model.addAttribute("ssList",hList);
        model.addAttribute("s",s);
        return "student_pluto/updateStudent";
    }

    @RequestMapping("/seekStuList")
    @ResponseBody
    public void seekStuList(HttpServletRequest request,HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String json = service.seekStuList(request);
        PrintWriter pw = response.getWriter();
        pw.print(json);
        pw.flush();
        pw.close();
    }


    @RequestMapping("/updateStu")
    @ResponseBody
    public String updateStudent(StudentVo studentVo,HttpServletRequest request,int oldss){
        String bir = request.getParameter("bir");
        String ent = request.getParameter("ent");
        Date bd=null;
        Date ed=null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            bd = sdf.parse(bir);
            ed = sdf.parse(ent);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        studentVo.setBirthday(bd);
        studentVo.setEntertime(ed);

        int newss = studentVo.getHuor();
        if(newss!=oldss){
            StudentDormitoryVo s1 = service.getHourById(newss);
            StudentDormitoryVo s2 = service.getHourById(oldss);
            s1.setCount(s1.getCount()+1);
            s2.setCount(s2.getCount()-1);
            service.updateHour(s1);
            service.updateHour(s2);
        }
        service.updateStudent(studentVo);
        return "1";
    }

    @RequestMapping("/delStu")
    @ResponseBody
    public String deleteStudent(int id){
        StudentVo s = service.getStudentById(id);
        int ssid = s.getHuor();
        service.deleteStudent(s);
        StudentDormitoryVo studentDormitoryVo = service.getHourById(ssid);
        studentDormitoryVo.setCount(studentDormitoryVo.getCount()-1);
        service.updateHour(studentDormitoryVo);
        return "1";
    }

    @RequestMapping("/tuixue")
    @ResponseBody
    public String tuixue(int id){
        StudentVo studentVo = service.getStudentById(id);
        studentVo.setTuixue("是");
        studentVo.setStat(6);
        int ssid = studentVo.getHuor();
        service.updateStudent(studentVo);
        StudentDormitoryVo studentDormitoryVo = service.getHourById(ssid);
        studentDormitoryVo.setCount(studentDormitoryVo.getCount()-1);
        service.updateHour(studentDormitoryVo);
        return "1";
    }

    @RequestMapping("/chongzhi")
    @ResponseBody
    public String chongzhi(int id){
        StudentVo studentVo = service.getStudentById(id);
        studentVo.setPassword("123456");
        service.updateStudent(studentVo);
        return "1";
    }

    @RequestMapping("/updateHour")
    @ResponseBody
    public String updateHour(int Studid,int hour){
        StudentVo studentVo = service.getStudentById(Studid);
        studentVo.setHuor(hour);
        service.updateStudent(studentVo);
        StudentDormitoryVo s = service.getHourById(hour);
        StudentDormitoryVo olds = service.getHourById(studentVo.getHuor());

        olds.setCount(olds.getCount()-1);
        s.setCount(s.getCount()+1);

        studentVo.setHuor(s.getHourid());

        service.updateHour(olds);
        service.updateHour(s);

        return "1";
    }

    @RequestMapping("/updateClass")
    @ResponseBody
    public String updateClass(int Studid,int classId){
        StudentVo studentVo = service.getStudentById(Studid);
        studentVo.setClazz(classId);
        service.updateStudent(studentVo);
        return "1";
    }

    @RequestMapping("/biye")
    @ResponseBody
    public String setBiye(int Studid){
         //System.out.println("shezhibiye");
        StudentVo studentVo = service.getStudentById(Studid);
        studentVo.setStat(5);
        service.updateStudent(studentVo);
        StudentDormitoryVo huor = service.getHourById(studentVo.getHuor());
        huor.setCount(huor.getCount()-1);
        service.updateHour(huor);
        return "1";
    }

    @RequestMapping("/toUpdateClass")
    public String toUpdateClass(int id,Model model){

        StudentVo studentVo = service.getStudentById(id);
        StudentClassVo sc = service.getClassById(studentVo.getClazz());
        String classname = sc.getClassName();
        List cList = service.getHourList("from StudentClassVo");

        model.addAttribute("classname",classname);
        model.addAttribute("classList",cList);
        model.addAttribute("s",studentVo);
        return "student_pluto/updateClass";
    }

    @RequestMapping("/toUpdateHour")
    public String updateHour(int id,Model model){

        StudentVo studentVo = service.getStudentById(id);
        StudentDormitoryVo s = service.getHourById(studentVo.getHuor());
        String sushe = s.getHuorName();
        List hList = service.getHourList("from StudentDormitoryVo");

        model.addAttribute("hourname",sushe);
        model.addAttribute("ssList",hList);
        model.addAttribute("s",studentVo);
        return "student_pluto/updateHour";
    }

    @RequestMapping("/addStu")
    @ResponseBody
    public String addStudent(StudentVo studentVo,String birt,String ents, HttpServletRequest request){
        System.out.println(studentVo.toString());


        System.out.println(birt+"+++++++++"+ents);

        Date bd=null;
        Date ed=null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            bd = sdf.parse(birt);
            ed = sdf.parse(ents);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        studentVo.setBirthday(bd);
        studentVo.setEntertime(ed);
         //System.out.println(studentVo.toString());
        service.addStudent(studentVo);
        return "1";
    }

    @RequestMapping("/toAddStu")
    public String toAddStudentPage(Model model){
        List clist = service.getClassList("from StudentClassVo");
        List mList = service.getMajor("from MajorVo");
        List hList = service.getHourList("from StudentDormitoryVo");
        model.addAttribute("hList",hList);
        model.addAttribute("zyList",mList);
        model.addAttribute("classList",clist);
        return "student_pluto/addStudent";
    }

    @RequestMapping("/returnData")
    @ResponseBody
    public void getList(HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        String json = service.getStudentList("select  s.Studid,s.stuno,s.stuname,s.sex,s.entertime,s.phone,s.addr,c.className,s.cardid,h.huorName,s.stat,s.computer,s.collar,s.`grants`,s.parents,s.parentsphone,s.qkMoney\n" +
                "\tfrom student s\n" +
                "\tinner join studentClass c on s.clazz = c.classId\n" +
                "\tinner join studentHuor h on s.huor = h.Hourid\n",page,limit);
        PrintWriter pw = response.getWriter();
        pw.print(json);
        pw.close();
    }

    @RequestMapping("/getZxData")
    public void getZxData(int stuid,HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter pw = response.getWriter();
        pw.print(service.getZxListJson(stuid));
        pw.flush();
        pw.close();
    }

    @RequestMapping("/toAddzxPage")
    public String toAddZx(int stuid,Model model){
        StudentVo s = service.getStudentById(stuid);
        model.addAttribute("s",s);

        return "student_pluto/addzx";
    }

    @RequestMapping("/addZx")
    @ResponseBody
    public void addZx(int stuid,String content,HttpServletRequest request){
        service.addZx(stuid,content,request);
    }

    @RequestMapping("/updatezx")
    @ResponseBody
    public void updatezx(int happenid,String content,HttpServletRequest request){
        service.updatezx(happenid,content,request);
    }

    @RequestMapping("/delzx")
    @ResponseBody
    public String updatezx(int happenid){
        service.deletezx(happenid);
        return "1";
    }

    @RequestMapping("/toUpdateZx")
    public String toUpdateZx(int zid,Model model){
        StudentHappeningVo sh = service.getHappeningById(zid);
         //System.out.println(sh.toString());
        StudentVo s = service.getStudentById(sh.getStuid());
        model.addAttribute("zx",sh);
        model.addAttribute("s",s);

        return "student_pluto/updatezx";
    }


//    -家庭信息-----------------------
    @RequestMapping("/familyData")
    @ResponseBody
    public void toFamilyDate(int stuid,HttpServletResponse response) throws IOException {
        String json = service.getFamilyListJsonbyId(stuid);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter pw = response.getWriter();
        pw.print(json);
        pw.flush();
        pw.close();
    }

    @RequestMapping("/deljt")
    @ResponseBody
    public String deljt(int familyid) throws IOException {
        StudentFamilyVo s = service.getFamilyById(familyid);
        service.delFamily(s);

        return "1";
    }

    @RequestMapping("/toAddJtPage")
    public String toAddJtPage(int stuid,Model model){
        StudentVo s = service.getStudentById(stuid);
        model.addAttribute("s",s);
        return "student_pluto/addFamily";
    }

    @RequestMapping("/addJt")
    @ResponseBody
    public String AddJt(StudentFamilyVo familyVo){

        service.addStudentFamily(familyVo);
        return "1";
    }

    @RequestMapping("/toUpdateJt")
    public String toUpdateJt(int familyid,Model model){
        StudentFamilyVo studentFamilyVo = service.getFamilyById(familyid);
        StudentVo s = service.getStudentById(studentFamilyVo.getStuid());
        model.addAttribute("s",s);
        model.addAttribute("f",studentFamilyVo);
        return "student_pluto/updFamily";
    }

    @RequestMapping("/updJt")
    @ResponseBody
    public String updJt(String familyname,int familyid,int stuid,String relation,String familyhone){
        StudentFamilyVo familyVo = new StudentFamilyVo();
        familyVo.setFamilyid(familyid);
        familyVo.setFamilyhone(familyhone);
        familyVo.setRelation(relation);
        familyVo.setStuid(stuid);
        familyVo.setFamilyname(familyname);

        service.updFamily(familyVo);
        return "1";
    }

//    ---------考试成绩-------------
    @RequestMapping("/examData")
    @ResponseBody
    public void toExamDate(int stuid,HttpServletResponse response) throws IOException {
        String json = service.getExamData(stuid);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter pw = response.getWriter();
        pw.print(json);
        pw.flush();
        pw.close();
    }

    @RequestMapping("/toUpdateExam")
    public String toUpdateExam(int scoreId, Model model){
        List kList = service.getKemuList();
        List xList = service.getxueqiList();
        Map sc = service.getStudentScoreVoById(scoreId);


        StudentVo s = service.getStudentById((Integer) sc.get("stuid"));
        model.addAttribute("s",s);
        model.addAttribute("sc",sc);
        model.addAttribute("kList",kList);
        model.addAttribute("xList",xList);

        return "student_pluto/updateExam";
    }

    @RequestMapping("/dbData")
    @ResponseBody
    public void dbData(int stuid,HttpServletResponse response) throws IOException {
        String json = service.getDbData(stuid);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter pw = response.getWriter();
        pw.print(json);
        pw.flush();
        pw.close();
    }

    @RequestMapping("/toUpdDb")
    public String toUpdDb(int replyId, Model model){
        List elist = service.getListByHql("from EmpVo");
        ReplyScoreVo r = (ReplyScoreVo) service.getObjById(new ReplyScoreVo().getClass(),replyId);
        StudentVo s = (StudentVo) service.getObjById(new StudentVo().getClass(),r.getStudentId());
        ProjectNameVo p = (ProjectNameVo) service.getObjById(new ProjectNameVo().getClass(),r.getProjectId());
        model.addAttribute("pro",p);
        model.addAttribute("p",r);
        model.addAttribute("s",s);
        model.addAttribute("eList",elist);


        return "student_pluto/updateDb";
    }

}

