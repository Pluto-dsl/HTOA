package com.pluto.controller;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_StudentMsg;
import com.publics.service.LoggingService;
import com.publics.utills.StringUtill;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.*;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Controller
@RequestMapping("/student")
public class Pluto_StudentController {

    @Resource
    private LoggingService log;

    @Resource
    private Pluto_StudentMsg service;

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

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
        System.out.println("去之前的信息="+s.toString());
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
        System.out.println("aaaaa");
        System.out.println(studentVo.toString());

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

        StudentVo sss = service.getStudentById(studentVo.getStudid());
        oldss = sss.getHuor();
        System.out.println("原来的宿舍id="+oldss);
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
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了学生"+studentVo.getStuname()+"资料。");
        return "1";
    }

    @RequestMapping("/delStu")
    @ResponseBody
    public String deleteStudent(int id,HttpServletRequest request){
        StudentVo s = service.getStudentById(id);
        int ssid = s.getHuor();
        service.deleteStudent(s);


        service.deleteScore(id);//student_score删除学生成绩
        service.deleteReplyScore(id);//studentReplyScore删除答辩学生成绩
        StudentDormitoryVo studentDormitoryVo = service.getHourById(ssid);
        studentDormitoryVo.setCount(studentDormitoryVo.getCount()-1);
        service.updateHour(studentDormitoryVo);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"删除了学生"+s.getStuname()+"资料。");
        return "1";
    }

    /**
     *判断学生是否离校或者毕业
     * @p
     * aram id
     * @return
     */
    @RequestMapping("/judgeStart")
    @ResponseBody
    public int judgeStart(int id){
        int i = service.judgeStuStart(id);//i等于一说明学生已离校或者毕业
        return i;
    }

    @RequestMapping("/tuixue")
    @ResponseBody
    public String tuixue(int id,HttpServletRequest request){
        StudentVo studentVo = service.getStudentById(id);
        studentVo.setTuixue("是");
        studentVo.setStat(6);
        int ssid = studentVo.getHuor();
        service.updateStudent(studentVo);
        StudentDormitoryVo studentDormitoryVo = service.getHourById(ssid);
        studentDormitoryVo.setCount(studentDormitoryVo.getCount()-1);
        service.updateHour(studentDormitoryVo);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了学生："+studentVo.getStuname()+"的状态为退学");
        return "1";
    }

    @RequestMapping("/chongzhi")
    @ResponseBody
    public String chongzhi(int id,HttpServletRequest request){
        StudentVo studentVo = service.getStudentById(id);
        studentVo.setPassword("123456");
        service.updateStudent(studentVo);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"重置了学生"+studentVo.getStuname()+"的密码。");
        return "1";
    }

    @RequestMapping("/updateHour")
    @ResponseBody
    public String updateHour(int Studid,int hour,HttpServletRequest request){

        StudentVo studentVo = service.getStudentById(Studid);

        StudentDormitoryVo olds = service.getHourById(studentVo.getHuor());

        studentVo.setHuor(hour);
        service.updateStudent(studentVo);
        StudentDormitoryVo s = service.getHourById(hour);
//        StudentDormitoryVo olds = service.getHourById(studentVo.getHuor());

        olds.setCount(olds.getCount()-1);
        s.setCount(s.getCount()+1);

        studentVo.setHuor(s.getHourid());

        service.updateHour(olds);
        service.updateHour(s);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了学生"+studentVo.getStuname()+"的宿舍");
        return "1";
    }

    @RequestMapping("/updateClass")
    @ResponseBody
    public String updateClass(int Studid, int classId, HttpSession session){
        StudentVo studentVo = service.getStudentById(Studid);
        studentVo.setClazz(classId);
        service.updateStudent(studentVo);
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了学生："+studentVo.getStuname()+"的班级。");
        return "1";
    }

    @RequestMapping("/biye")
    @ResponseBody
    public String setBiye(int Studid,HttpServletRequest request){
         //System.out.println("shezhibiye");
        StudentVo studentVo = service.getStudentById(Studid);
        studentVo.setStat(5);
        service.updateStudent(studentVo);
        StudentDormitoryVo huor = service.getHourById(studentVo.getHuor());
        huor.setCount(huor.getCount()-1);
        service.updateHour(huor);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了学生"+studentVo.getStuname()+"的状态为毕业。");
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
//        List hList = service.ListBySql("select * from studentHuor");
        model.addAttribute("hourname",sushe);
        model.addAttribute("ssList",hList);
        model.addAttribute("s",studentVo);
        return "student_pluto/updateHour";
    }

    /*@RequestMapping("/addStu")
    @ResponseBody
    public String addStudent(StudentVo studentVo,String birt,String ents, HttpServletRequest request){
        System.out.println(studentVo.toString());
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

        StudentDormitoryVo huor = service.getHourById(studentVo.getHuor());
        huor.setCount(huor.getCount()+1);
        service.updateHour(huor);

        service.addStudent(studentVo);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"新增了一个学生，学生名："+studentVo.getStuname());
        return "1";
    }*/
    @RequestMapping("/addStu")
    public String addStudent(StudentVo studentVo,String birt,String ents, HttpServletRequest request){
        System.out.println(studentVo.toString());
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

//        studentVo.setStuno(""+getRandom());

        service.addStudent(studentVo);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"新增了一个学生，学生名："+studentVo.getStuname());
        return "student_pluto/winAdd";
    }


    public int getRandom(){
        int id = 0;
        do{
            Random random = new Random();
            int i = (int) (random.nextFloat()*1000000);
            boolean flag = service.judgeStuId(i);
            if(flag){
                id=i;
                break;
            }
        }while(true);
        return id;
    }

   /* @RequestMapping("/toAddStu")
    public String toAddStudentPage(Model model){
        List clist = service.getClassList("from StudentClassVo");
        List mList = service.getMajor("from MajorVo");
//        List hList = service.getHourList("from StudentDormitoryVo where count<numberBeds");
        List hList = service.ListBySql("select * from studentHuor where `count` < numberBeds");
        model.addAttribute("hList",hList);
        model.addAttribute("zyList",mList);
        model.addAttribute("classList",clist);
        return "student_pluto/addStudent";
    }*/

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
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"新增了学生的在校情况");
    }

    @RequestMapping("/updatezx")
    @ResponseBody
    public void updatezx(int happenid,String content,HttpServletRequest request){
        service.updatezx(happenid,content,request);
    }

    @RequestMapping("/delzx")
    @ResponseBody
    public String updatezx(int happenid,HttpServletRequest request){
        service.deletezx(happenid);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"删除了学生的在校情况");
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
    public String deljt(int familyid,HttpServletRequest request) throws IOException {
        StudentFamilyVo s = service.getFamilyById(familyid);
        service.delFamily(s);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"删除了学生的家庭情况");
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
    public String AddJt(StudentFamilyVo familyVo,HttpServletRequest request){

        service.addStudentFamily(familyVo);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"新增了学生的家庭情况");
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
    public String updJt(String familyname,int familyid,int stuid,String relation,String familyhone,HttpServletRequest request){
        StudentFamilyVo familyVo = new StudentFamilyVo();
        familyVo.setFamilyid(familyid);
        familyVo.setFamilyhone(familyhone);
        familyVo.setRelation(relation);
        familyVo.setStuid(stuid);
        familyVo.setFamilyname(familyname);

        service.updFamily(familyVo);
        EmpVo emp = (EmpVo) request.getSession().getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了学生的家庭情况");
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

    @RequestMapping("/judgePhone")
    @ResponseBody
    public String judgePhone(String iphone){
        int flag = service.judgePhone(iphone);
        if(flag==1){//当flag==1 ，说明已有用户
            return "1";
        }else {
            return "0";
        }
    }

    @RequestMapping("/judgeCardid")
    @ResponseBody
    public String judgeCardid(String cardid){
        boolean flag = service.judgeCardid(cardid);
        if(flag){
            return "1";
        }
        return "0";
    }

}

