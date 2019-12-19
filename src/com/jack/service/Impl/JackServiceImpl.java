package com.jack.service.Impl;

import com.jack.service.Jack_Service;
import com.publics.dao.BaseDao;
import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.assess.AduitModelVo;
import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.empModel.AttendanceVo;
import com.publics.vo.empModel.evaluationVo;
import com.publics.vo.empModel.teacherTotalVo;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class JackServiceImpl extends BaseDao implements Jack_Service {

    /**  考勤管理 */

    @Override
    public List selAtt(int Aname,int currPage,int pageSize) {
        return pageBySQL("select att.attId,e.empName,att.punckClockTime,att.cause,att.auditor,att.examineTime,att.examineExplain,att.`status`\n" +
                "from attendance att inner join emp e on att.empid = e.empid where att.empid = "+Aname+"",currPage,pageSize);
    }
    @Override
    public int selAttCount(int Aname) {
        return selTotalRow("select count(*) from attendance where empId = "+Aname+"");
    }
    @Override
    public String selDepChairman(int AName) {
        List list =  super.listBySQL("SELECT chairman FROM emp join dep on emp.depId = dep.depid where dep.depid =(select depId from emp where empId = "+AName+")");
        Map m = (Map) list.get(0);
        return (String) m.get("chairman");
    }
    @Override
    public void insertAtt(AttendanceVo attVo) {
        addObject(attVo);
    }
    @Override
    public void updataAtt(AttendanceVo att) {
         executeSQL("UPDATE attendance set examineTime = sysdate() , examineExplain = '"+att.getExamineExplain()+"',status= "+att.getStatus()+" where attId= "+att.getAttId()+"");
    }
    @Override
    public List selApprover(String Aname,int state) {
       return listBySQL("select att.attId,e.empName,att.punckClockTime,att.cause,att.auditor,att.examineTime,att.examineExplain,att.`status`\n" +
               "from attendance att inner join emp e on att.empid = e.empid where att.auditor = '"+Aname+"' and att.status = "+state+"");
    }
    @Override
    public void delAtt(int id) {
        executeSQL("delete from attendance where attId = "+id+"");
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
        return listBySQL("select ad.aduitName,e.empName,ag.Scores,ag.auditDate,ag.auditPerson,ag.Remark,ag.Image from \n" +
                "(aduitLog ag inner join aduitModel ad on ag.aduitModelid = ad.aduitModelid) \n" +
                "inner join emp e on e.Empid = ag.empid where ag.aduitLogid = "+id+"");
    }
    @Override
    public void delAduitLog(int id) {
        executeSQL("DELETE FROM aduitLog where aduitLogid = "+id+"");
    }
    @Override
    public List selDep() {
        return listBySQL("select depid,depName from dep");
    }

    @Override
    public List Conditional_query(String empName, String depId, String startDate, String EndDate,int currPage,int pageSize) {
        String sql = "select ag.aduitLogid,am.aduitName,e.empName,ag.Scores,ag.auditDate,ag.auditPerson,ag.Remark,ag.Image from \n" +
                "((aduitLog ag inner join emp e on ag.Empid = e.empid)\n" +
                "INNER JOIN aduitModel am on ag.aduitModelid = am.aduitModelid) INNER JOIN dep d on e.depId = d.depid\n" +
                "where ag.aduitLogid";
        if(!(empName == null || "".equals(empName))){  //根据员工查询
             sql += " and e.empName like \"%"+empName+"%\" ";
        }else if(!(depId == null || "".equals(depId))){ //根据部门查询
            sql += " and  d.depid = "+depId+"";
        }else if(!(startDate == null || "".equals(startDate))){ //根据开始时间查询
            sql += " and auditDate >='"+startDate+"' ";
        }else if(!(EndDate == null || "".equals(EndDate))){ //根据结束时间查询
            sql += " and auditDate <'"+EndDate+"'";
        }
        return listBySQL(sql);
    }
    @Override
    public int Conditional_queryCount(String empName, String depId, String startDate, String EndDate) {
        String sql = "select count(*) from \n" +
                "((aduitLog ag inner join emp e on ag.Empid = e.empid)\n" +
                "INNER JOIN aduitModel am on ag.aduitModelid = am.aduitModelid) INNER JOIN dep d on e.depId = d.depid\n" +
                "where ag.aduitLogid";
        if(!(empName == null || "".equals(empName))){  //根据员工查询
            sql += " and e.empName like '%"+empName+"%' ";
        }else if(!(depId == null || "".equals(depId))){ //根据部门查询
            sql += " and  d.depid = "+depId+"";
        }else if(!(startDate == null || "".equals(startDate))){ //根据开始时间查询
            sql += " and auditDate >='"+startDate+"' ";
        }else if(!(EndDate == null || "".equals(EndDate))){ //根据结束时间查询
            sql += " and auditDate <'"+EndDate+"'";
        }
        return selTotalRow(sql);
    }
    /** 考评内容 */
    @Override
    public List selHeadmasterList() {
        return listBySQL("select * from evaluation where evaluationType = '2'");
    }
    @Override
    public List selTeacherList() {
        return listBySQL("select * from evaluation where evaluationType = '1'");
    }
    @Override
    public int addAevaluation(evaluationVo evaluatio) {
        return addObjectInt(evaluatio);
    }
    @Override
    public void delAevaluation(int id) {
        executeSQL("delete from evaluation where evaluationid = "+id+"");
    }

    /** 教师考评 */
    @Override
    public List selTeacherListE(String name,String evaluationType,int currPage,int pageSize) {
        String s = "select te.teacherTotalid,te.evaluationType,e.empName,sc.className,te.classTeacher,te.classId,SUM(te.teacherScore) as sum from \n" +
                "((teacherTotal te inner join evaluation ev on te.evaluationid  = ev.evaluationid) INNER JOIN emp e on e.empId = te.classTeacher)\n" +
                " INNER JOIN studentClass sc on te.classId = sc.classId GROUP BY te.classTeacher,te.classId \n" +
                " having  te.teacherTotalid ";
        if(!("".equals(name) || name == null)){
            s += "and e.empName like \"%"+name+"%\" ";
        }else if(!("".equals(evaluationType) || evaluationType == null)){
            s += " and  te.evaluationType = "+evaluationType+" ";
        }
        s = s + "ORDER BY te.teacherTotalid desc ";
        return pageBySQL(s,currPage,pageSize);
    }

    @Override
    public List selScoreDetails(String teacher, String classid) {
        return listBySQL("select te.TeachertotalId,ev.evaluationName,te.evaluationType,e.empName,sc.className,te.teacherScore,te.Optime from \n" +
                "((teacherTotal te inner join evaluation ev on te.evaluationid  = ev.evaluationid) \n" +
                "INNER JOIN emp e on e.empId = te.classTeacher) INNER JOIN studentClass sc \n" +
                "on te.classid = sc.classId where e.empId="+teacher+" and sc.classId = "+classid+"");
    }

    @Override
    public List selReportForm() {
        return listBySQL("select te.teacherTotalid,(case when te.evaluationType = 1 then '授课老师' when te.evaluationType = 2 then '班主任' end )evaluation,te.sugges,e.empName,AVG(te.teacherScore) as avg from \n" +
                "((teacherTotal te inner join evaluation ev \n" +
                "on te.evaluationid  = ev.evaluationid) INNER JOIN emp e \n" +
                "on e.empId = te.classTeacher) INNER JOIN studentClass sc \n" +
                "on te.classId = sc.classId GROUP BY te.classTeacher ORDER BY avg desc\n");
    }

    /** 学生端——教师考评 */
    @Override
    public List selHeadmasterTest(int stu) {
        return listBySQL("select stc.classId,stc.className,e.empId,e.empName from (student stu inner join studentClass stc \n" +
                "on stu.clazz = stc.classId) inner join emp e on stc.classTeacher = e.empId\n" +
                "where Studid = "+stu+"");
    }
    @Override
    public List selHeadmasterType() {
        return listBySQL("select * from evaluation  where evaluationType = 2");
    }
    @Override
    public List selTeacherTest(int stu) {
        return listBySQL("select stc.classId,stc.className,e.empId,e.empName from (student stu inner join studentClass stc \n" +
                "on stu.clazz = stc.classId) inner join emp e on stc.teacher = e.empId\n" +
                "where Studid = "+stu+"");
    }
    @Override
    public List selTeacherType() {
        return listBySQL("select * from evaluation  where evaluationType = 1");
    }

    @Override
    public void addHeadmaster(teacherTotalVo teacherTotal) {
        addObject(teacherTotal);
    }

    @Override
    public void addTeacher(teacherTotalVo totalVo) {
        addObject(totalVo);
    }

    @Override
    public List selMonthly_assessment(int stuid, int etype) {
        return listBySQL("select * from teacherTotal where Optime>(select DATE_ADD(now(),interval -day(now())+1 day)) and Optime<=(select last_day(now())) and studentId = "+stuid+" and evaluationType = "+etype+"");
    }

    @Override
    public int selChatRecordCount(int empid) {
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        month++;
        String sql = "select count(*) from chatRecord where teacher = "+empid+" and chatDate >= '"+year+"-"+month+"-01 00:00:00'";

        cal.add(Calendar.MONTH,1);
        year = cal.get(Calendar.YEAR);
        month = cal.get(Calendar.MONTH);
        month++;
        sql +=" and chatDate < '"+year+"-"+month+"-01 00:00:00'";
        System.out.println(sql);
        return selTotalRow(sql);
    }

    @Override
    public int selClockCount(int empid) {
        return selTotalRow("select count(*) from attendance att inner join emp e on att.empid = e.empid where att.auditor = "+empid+" and att.status = 2");
    }


}
