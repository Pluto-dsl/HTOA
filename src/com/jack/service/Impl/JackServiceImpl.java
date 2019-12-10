package com.jack.service.Impl;

import com.jack.service.Jack_Service;
import com.publics.dao.BaseDao;
import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.empModel.AttendanceVo;
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service

public class JackServiceImpl extends BaseDao implements Jack_Service {

    /**  考勤管理 */
    @Override
    public List selAtt(String Aname,int currPage,int pageSize) {
        return pageByHql("from AttendanceVo where empName = '"+Aname+"'",currPage,pageSize);
    }
    @Override
    public int selAttCount(String Aname) {
        return selTotalRow("select count(*) from attendance where empName = '"+Aname+"'");
    }
    @Override
    public String selDepChairman(String AName) {
        List list =  super.listBySQL("SELECT chairman FROM emp join dep on emp.depId = dep.depid where dep.depid =(select depId from emp where empName = '"+AName+"')");
        Map m = (Map) list.get(0);
        return (String) m.get("chairman");
    }
    @Override
    public void insertAtt(AttendanceVo attVo) {
        addObject(attVo);
    }
    @Override
    public void updataAtt(AttendanceVo att) {
         executeSQL("UPDATE attendance set examineTime = sysdate() , examineExplain = '"+att.getExamineExplain()+"',state= "+att.getState()+" where attId= "+att.getAttId()+"");
    }
    @Override
    public List selApprover(String Aname,int state) {
       return listByHql("from AttendanceVo where auditor = '"+Aname+"' and state = "+state+"");
    }

    /**  课程类型 */
    @Override
    public List selCourse(int currPage, int pageSize) {
        return pageByHql("from CourseTypeVo ",currPage,pageSize);
    }
    @Override
    public int selCouCount() {
        return selTotalRow("select count(*) from courseType");
    }
    @Override
    public int UpdateCourse(CourseTypeVo course) {
        updObject(course);
        return 1;
    }
    @Override
    public int delCourse(int id) {
        executeSQL("DELETE FROM courseType where courseTypeId = "+id+"");
        return 1;
    }
    @Override
    public int AddCurse(CourseTypeVo courseTypeVo) {
        addObject(courseTypeVo);
        return 1;
    }

    /** 课程管理 */
    @Override
    public List selCourseMgt(int currPage, int pageSize) {
        return pageBySQL("select co.courseId,co.courseName,ct.courseTypeName,co.isobligatory,co.remark from course co join courseType ct on co.courseTypeId = ct.courseTypeId",currPage,pageSize);
    }
    @Override
    public int selCouCountM() {
        return selTotalRow("select count(*) from course");
    }
    @Override
    public List selCourseName() {
        List list = listBySQL("SELECT courseTypeId,courseTypeName FROM courseType");
        return list;
    }
    @Override
    public void addCourseMgt(CourseVo courseVo) {
        addObject(courseVo);
    }
    @Override
    public void updateCourseMgt(CourseVo courseVo) {
        updObject(courseVo);
    }
    @Override
    public int delCourseMgt(int cid) {
        executeSQL("DELETE FROM course where courseId = "+cid+"");
        return 1;
    }

    /** 登录 */
    @Override
    public Map TLoginUser(String user) {
        List<Map> list = super.listBySQL("SELECT Phone,password,empName FROM emp where Phone = '"+user+"'");
        for (Map map:list) {
            return map;
        }
        return null;
    }

    @Override
    public Map SLoginUser(String user) {
        String hql = "SELECT phone,password,stuname FROM student where phone = '"+user+"'";
        System.out.println(hql);
        List<Map> list = super.listBySQL(hql);
        for (Map map:list) {
            System.out.println(map.get("phone"));
            return map;
        }
        return null;
    }
}
