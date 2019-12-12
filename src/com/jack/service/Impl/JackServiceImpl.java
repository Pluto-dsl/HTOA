package com.jack.service.Impl;

import com.jack.service.Jack_Service;
import com.publics.dao.BaseDao;
import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.assess.AduitModelVo;
import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.empModel.AttendanceVo;
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


    /**  考核管理 */
    @Override
    public List selAssessment(int currPage, int pageSize) {
        return pageBySQL("select ad.aduitModelid,ad.Scores,d.depName,ad.Remark,ad.aduitName from aduitModel ad left join dep d on ad.Depid = d.depid ",currPage,pageSize);
    }  //考核指标查询
    @Override
    public int selAssCount() {
        return selTotalRow("select count(*) from aduitModel");
    } //获取数据总数
    @Override
    public List selDepList() {
        return listBySQL("select depid,depName from dep");
    } //查询部门列表
    @Override
    public void addAssessment(AduitModelVo aduitModelVo) {
        addObject(aduitModelVo);
    }
    @Override
    public void editAssessment(AduitModelVo aduitModelVo) {
        updObject(aduitModelVo);
    }
    @Override
    public void delAssessment(int Aid) {
        executeSQL("DELETE FROM aduitModel where aduitModelid = "+Aid+"");
    }

    /** 考核巡查管理 */
    @Override
    public List selAss() {
        return listBySQL("select aduitModelid,aduitName from aduitModel");
    }
    @Override
    public List selEmp() {
        return listBySQL("select empId,empName from emp");
    }
    @Override
    public void addAduit(AduitLogVo aduitLogVo) {
        addObject(aduitLogVo);
    }
    @Override
    public List selAduitLog(int currPage,int pageSize) {
        return listBySQL("select ag.aduitLogid,am.aduitName,e.empName,ag.Scores,ag.auditDate,ag.Image,ag.auditPerson,ag.Remark from (aduitLog ag inner join emp e on ag.Empid = e.empid) INNER JOIN aduitModel am on ag.aduitModelid = am.aduitModelid ORDER BY aduitLogid desc");
    }
    @Override
    public int selAdCount() {
       return selTotalRow("select count(*) from aduitLog");
    }
    @Override
    public List selAdDetails(int id) {
        return listBySQL("select ad.aduitName,e.empName,ag.Scores,ag.auditDate,ag.auditPerson,ag.Remark from \n" +
                "(aduitLog ag inner join aduitModel ad on ag.aduitModelid = ad.aduitModelid) \n" +
                "inner join emp e on e.Empid = ag.empid where ag.aduitLogid = "+id+"");
    }

    @Override
    public void delAduitLog(int id) {
        executeSQL("DELETE FROM aduitLog where aduitLogid = "+id+"");
    }


}
