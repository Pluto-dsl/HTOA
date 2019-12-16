package com.pluto.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_StudentMsg;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentDormitoryVo;
import com.publics.vo.studentModel.StudentHappeningVo;
import com.publics.vo.studentModel.StudentVo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
        System.out.println("---------"+sh.toString());
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
}
