package com.pluto.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_StudentMsg;
import com.publics.dao.BaseDao;
import com.publics.utills.StringUtill;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.*;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class Pluto_StudentMsgImpl extends BaseDao implements Pluto_StudentMsg {

    @Override
    public String getStudentList(String sql,int page,int limit) {
        List list = super.pageBySQL(sql,page,limit);
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","学生列表");
        json.put("count",super.selTotalRow("select count(*) from student"));
        json.put("data",list);
        return json.toJSONString();
    }

    @Override
    public List getClassList(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public List getMajor(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public void addStudent(StudentVo s) {
        super.addObject(s);
    }

    @Override
    public StudentClassVo getClassById(int id) {
        return (StudentClassVo) super.getObject(new StudentClassVo().getClass(),id);
    }

    @Override
    public void updateHour(StudentDormitoryVo s) {
        super.updObject(s);
    }

    @Override
    public StudentHappeningVo getHappeningById(int hid) {
        return (StudentHappeningVo) super.getObject(new StudentHappeningVo().getClass(),hid);
    }

    @Override
    public void updatezx(int happenid, String content, HttpServletRequest request) {

        StudentHappeningVo sh = this.getHappeningById(happenid);
        String savetime = request.getParameter("savetime");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date time = null;
        try {
            time = sdf.parse(savetime);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        sh.setHappening(content);
        sh.setOptime(time);
         //System.out.println("---------"+sh.toString());
        super.updObject(sh);
    }

    @Override
    public void deleteStudent(StudentVo studentVo) {
        super.delObject(studentVo);
    }

    @Override
    public void deletezx(int happeningId) {
        super.delObject(this.getHappeningById(happeningId));
    }

    @Override
    public void addZx(int sid, String content, HttpServletRequest request) {

        EmpVo empVo = (EmpVo) request.getSession().getAttribute("admin");
        String savetime = request.getParameter("savetime");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date time = null;
        try {
            time = sdf.parse(savetime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        StudentHappeningVo sh = new StudentHappeningVo();
        sh.setEmpid(empVo.getEmpId());
        sh.setHappening(content);
        sh.setStuid(sid);
        sh.setOptime(time);
        super.addObject(sh);

    }

    @Override
    public void updFamily(StudentFamilyVo studentFamilyVo) {
        super.updObject(studentFamilyVo);
    }

    @Override
    public StudentFamilyVo getFamilyById(int familyid) {
        return (StudentFamilyVo) super.getObject(new StudentFamilyVo().getClass(),familyid);
    }

    @Override
    public void addStudentFamily(StudentFamilyVo studentFamilyVo) {
        super.addObject(studentFamilyVo);
    }

    @Override
    public String getZxListJson(int stuid) {
        List list = super.listBySQL("select s.stuname,h.happenid,h.happening,h.optime,e.empName from student s \n" +
                "\tinner join studentHappening h on s.Studid = h.stuid\n" +
                "\tinner join emp e on e.empId = h.Empid \n" +
                "\twhere s.Studid="+stuid);
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","学生列表");
        json.put("count",10);
        json.put("data",list);
        return json.toJSONString();
    }

    @Override
    public StudentDormitoryVo getHourById(int id) {
        return (StudentDormitoryVo) super.getObject(new StudentDormitoryVo().getClass(),id);
    }

    @Override
    public List getDeptList(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public List getHourList(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public StudentVo getStudentById(int id) {
        return (StudentVo) super.getObject(new StudentVo().getClass(),id);
    }

    @Override
    public void updateStudent(StudentVo studentVo) {
        super.updObject(studentVo);
    }

    @Override
    public EmpVo getemp(int id) {
        return (EmpVo) super.getObject(new EmpVo().getClass(),id);
    }

    @Override
    public String getFamilyListJsonbyId(int stuid) {
        List list = super.listBySQL("select f.*,s.stuname from student s INNER JOIN studentFamily f on s.Studid = f.stuid where stuid="+stuid);
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","学生列表");
        json.put("count",10);
        json.put("data",list);
        return json.toJSONString();
    }

    @Override
    public void delFamily(StudentFamilyVo studentFamilyVo) {
        super.delObject(studentFamilyVo);
    }

    @Override
    public String getExamData(int stuid) {
        List list = super.listBySQL("select sc.scoreId,s.stuname,t.termName,c.courseName,sc.testType,sc.score,sc.Rescore,sc.scoreTime,sc.remark from studentScore sc \n" +
                "\t\tINNER JOIN student s on s.Studid = sc.stuid\n" +
                "\t\tINNER JOIN course c on c.courseid = sc.courseId\n" +
                "\t\tINNER JOIN term t on t.termid = sc.termid\n" +
                "\t\twhere sc.stuid="+stuid);
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","学生列表");
        json.put("count",10);
        json.put("data",list);
        return json.toJSONString();
    }

   /* @Override
    public ModelAndView toUpdateExam(int scoreId) {
        ModelAndView modelAndView = new ModelAndView();
        List xlist = super.listByHql("from TermVo");
        List klist = super.listByHql("from CourseVo");
        StudentScoreVo sc = (StudentScoreVo) super.getObject(new StudentScoreVo().getClass(),scoreId);
        modelAndView.addObject("sc",sc);
        modelAndView.addObject("xList",xlist);
        modelAndView.addObject("kList",klist);
        return modelAndView;
    }
*/

    @Override
    public String getDbData(int stuid) {
        List list = super.listBySQL("select stu.stuname,p.projectName,s.*,e.empName from studentReplyScore s \n" +
                "\t\tINNER JOIN project p on s.projectId = p.projectId\n" +
                "\t\tINNER JOIN emp e on s.empId = e.empId \n" +
                "\t\tINNER JOIN student stu on stu.Studid = s.StudentId\n" +
                "\t\twhere s.StudentId="+stuid);
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","学生列表");
        json.put("count",10);
        json.put("data",list);
        return json.toJSONString();
    }

    @Override
    public String seekStuList(HttpServletRequest request) {
        String stuname  = request.getParameter("name");
        String stuphone = request.getParameter("phone");
        String stuclass = request.getParameter("stuclass");
        String stuhour  = request.getParameter("hour");
        String stustart = request.getParameter("start");
        try {
            stuname  = StringUtill.tostring(stuname);
            stuphone = StringUtill.tostring(stuphone);
            stuclass = StringUtill.tostring(stuclass);
            stuhour  = StringUtill.tostring(stuhour );
            stustart = StringUtill.tostring(stustart);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        String sql = "select  s.Studid,s.stuno,s.stuname,s.sex,s.entertime,s.phone,s.addr,c.className,s.cardid,h.huorName,s.stat,s.computer,s.collar,s.`grants`,s.parents,s.parentsphone,s.qkMoney \n" +
                " from student s " +
                " inner join studentClass c on s.clazz = c.classId" +
                " inner join studentHuor h on s.huor = h.Hourid" +
                " where 1=1";
        String countsql = "select  count(*) sl\n" +
                "\tfrom student s\n" +
                "\tinner join studentClass c on s.clazz = c.classId\n" +
                "\tinner join studentHuor h on s.huor = h.Hourid where 1=1";

        if(!"".equals(stuname)){
            sql+=" and s.stuname like '%"+stuname+"%'";
            countsql+=" and s.stuname like '%"+stuname+"%'";
        }
        if(!"".equals(stuphone)){
            sql+=" and s.phone like '%"+stuphone+"%'";
            countsql+=" and s.phone like '%"+stuphone+"%'";
        }
        if(!"0".equals(stuclass)){
            sql+=" and s.clazz = "+stuclass;
            countsql+=" and s.clazz = "+stuclass;
        }
        if(!"0".equals(stuhour)){
            sql+=" and s.huor = "+stuhour;
            countsql+=" and s.huor = "+stuhour;
        }
        if(!"0".equals(stustart)){
            sql+=" and s.stat = "+stustart;
            countsql+=" and s.stat = "+stustart;
        }


        List list = super.listBySQL(sql);

        List temp = super.listBySQL(countsql);
        Map m = (Map) temp.get(0);
        int count =  Integer.valueOf(m.get("sl").toString());

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","学生列表");
        json.put("count",count);
        json.put("data",list);

        return json.toJSONString();
    }

    @Override
    public Map getStudentScoreVoById(int id) {
        //return (StudentScoreVo) super.getObject(new StudentScoreVo().getClass(),id);
        return (Map) super.listBySQL("select * from studentScore where scoreId="+id).get(0);
    }

    @Override
    public List getxueqiList() {
        return super.listByHql("from TermVo");
//        return null;
    }

    @Override
    public List getListByHql(String hql) {
        return super.listByHql(hql);
    }

    @Override
    public Object getObjById(Class cla,int id) {
        return super.getObject(cla,id);
    }

    @Override
    public List getKemuList() {
        return super.listByHql("from CourseVo");
    }
}
