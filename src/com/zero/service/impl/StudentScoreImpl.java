package com.zero.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.studentModel.*;
import com.zero.service.StudentScoreService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StudentScoreImpl extends BaseDao implements StudentScoreService {

    @Override
    public List<Map> ReplyScore(int page,int limit) {
        return super.pageBySQL("select sr.*,s.stuname,sc.className,p.projectName,e.empName from studentReplyScore sr" +
                " left join student s on s.Studid = sr.StudentId" +
                " left join studentClass sc on sc.classId = s.clazz" +
                " left join project p on p.projectId = sr.projectId" +
                " left join emp e on e.empId = sr.empId" +
                " order by sr.replyId desc",page,limit);
    }

    @Override
    public List<Map> ReplyScore(String where, int page, int limit) {
        String sql = "select sr.*,s.stuname,sc.className,p.projectName from studentReplyScore sr" +
                " left join student s on s.Studid = sr.StudentId" +
                " left join studentClass sc on sc.classId = s.clazz" +
                " left join project p on p.projectId = sr.projectId where 1=1 ";
        return super.pageBySQL(sql+where+" order by sr.replyId desc",page,limit);
    }

    @Override
    public int pagecount() {
        List<Map> list = super.listBySQL("select count(*) co from studentReplyScore");
        Map map = list.get(0);
        return Integer.parseInt(map.get("co").toString());
    }

    @Override
    public int pagecount(String where) {
        String sql = "select count(*) co from studentReplyScore sr" +
                    " left join student s on s.Studid = sr.StudentId" +
                    " left join studentClass sc on sc.classId = s.clazz" +
                    " left join project p on p.projectId = sr.projectId where 1=1 ";
        sql+=where;
        return Integer.parseInt(((Map)super.listBySQL(sql+where).get(0)).get("co").toString());
    }

    @Override
    public List<StudentClassVo> allclass() {
        return super.listByHql("from StudentClassVo");
    }

    @Override
    public List<ProjectNameVo> allProject() {
        return super.listByHql("from ProjectNameVo");
    }

    @Override
    public List<Map> score(int page, int limit) {
        return super.pageBySQL("select sc.*,c.courseName,s.stuname,ss.className,t.termName,e.empName from studentScore sc" +
                "  left join student s on s.Studid = sc.stuid" +
                "  left join studentClass ss on ss.classId = s.clazz" +
                "  left join course c on c.courseId = sc.courseId" +
                "  left join term t on t.termid = sc.termid" +
                "  left join emp e on e.empId = sc.EmpId order by sc.scoreId desc",page,limit);
    }

    @Override
    public List<Map> score(String where, int page, int limit) {
        String sql = "select sc.*,c.courseName,s.stuname,ss.className,t.termName,e.empName from studentScore sc" +
                " left join student s on s.Studid = sc.stuid" +
                " left join studentClass ss on ss.classId = s.clazz" +
                " left join course c on c.courseId = sc.courseId" +
                " left join term t on t.termid = sc.termid" +
                " left join emp e on e.empId = sc.EmpId " +
                " where 1=1 ";
         //System.out.println("语句:"+sql);
        sql = sql + where + " order by sc.scoreId desc";
        return super.pageBySQL(sql,page,limit);
    }

    @Override
    public int scorecount() {
        List<Map> list = super.listBySQL("select count(*) co from studentScore");
        Map map = list.get(0);
        return Integer.parseInt(map.get("co").toString());
    }

    @Override
    public int scorepagecount(String where) {
        String sql = "select count(*) co from studentScore sc" +
                " left join student s on s.Studid = sc.stuid" +
                " left join course c on c.courseId = sc.courseId" +
                " left join term t on t.termid = sc.termid" +
                " left join emp e on e.empId = sc.EmpId " +
                " where 1=1 ";
        sql+=where;
         //System.out.println("count"+sql);
        return Integer.parseInt(((Map)super.listBySQL(sql).get(0)).get("co").toString());
    }

    @Override
    public List<TermVo> term() {
        return super.listByHql("from TermVo");
    }

    @Override
    public List<CourseVo> course() {
        return super.listByHql("from CourseVo");
    }

    @Override
    public int haveScore(int classid, int courseid, int scoreType, int termid) {
        return  super.listBySQL("select sc.score from studentScore sc " +
                " left join student s on s.Studid = sc.stuid" +
                " where s.clazz = "+classid+" and sc.courseId = "+courseid+" and sc.testType = "+scoreType+" and sc.termid =  "+termid).size();


    }

    @Override
    public int haveReplyScore(int classid,int projectId) {
        return super.listBySQL("select sr.score1  from studentReplyScore sr " +
                " left join student s on s.Studid = sr.StudentId" +
                " where s.clazz = "+classid+" and sr.projectId = "+projectId).size();
    }

    @Override
    public List<Map> stu(int classid) {
        return super.listBySQL("select s.Studid,s.stuno,s.stuname,sc.className from student s" +
                " left join studentClass sc on sc.classId = s.clazz " +
                " where s.clazz = "+classid);
    }

    @Override
    public TermVo nowterm(int termid) {
        List<TermVo> list = super.listByHql("from TermVo where termid = "+termid);
        return list.get(0);
    }

    @Override
    public CourseVo nowcourse(int courseid) {
        List<CourseVo> list = super.listByHql("from CourseVo where courseId = "+courseid);
        return list.get(0);
    }

    @Override
    public StudentClassVo nowclass(int classId) {
        List<StudentClassVo> list = super.listByHql("from StudentClassVo where classId = "+classId);
        return list.get(0);
    }

    @Override
    public ProjectNameVo nowproject(int projectId) {
        List<ProjectNameVo> list = super.listByHql("from ProjectNameVo where projectId = "+projectId);
        return list.get(0);
    }


    @Override
    public void addscore(String sql) {
        sql = "insert into studentScore values"+sql;
        super.executeSQL(sql);
    }

    @Override
    public void addReplyscore(ReplyScoreVo scoreVo) {
        super.addObject(scoreVo);
    }

    @Override
    public List<Map> toeditScore(int classid, int courseid, int scoreType, int termid) {
        String  sql = "SELECT sc.scoreId,sc.score,sc.Rescore,t.termid,t.termName,sc.testType,sc.remark,sc.scoreTime,s.Studid,s.stuno,s.stuname,c.courseName,c.courseId,e.empName FROM student s  " +
                " left join studentScore sc on s.Studid = sc.stuid" +
                " left join term t on t.termid = sc.termid" +
                " left join course c on c.courseId = sc.courseId " +
                " left join emp  e on e.empId = sc.Empid" +
                " where  s.clazz = "+classid+" and c.courseId = "+courseid+" and sc.testType = "+scoreType+" and t.termid = "+termid;
        return super.listBySQL(sql);
    }

    @Override
    public void editscore(String rescore,StudentScoreVo s) {
        super.executeSQL("update studentScore set Empid = "+s.getEmpid()+",Rescore = "+rescore+",courseId = "+s.getCourseId()+",remark = '"+s.getRemark()+"',score = "+s.getScore()+",scoreTime='"+s.getScoreTime()+"',stuid = "+s.getStuid()+",termid = "+s.getTermid()+",testType = "+s.getTestType()+" where scoreId = "+s.getScoreId());
    }

    @Override
    public List<Map> toeditReplyscore(int classid, int projectId) {
        String sql = "select sr.*,s.stuno,s.stuname from studentReplyScore sr " +
                "left join student s on s.Studid = sr.StudentId where s.clazz = "+classid+" and sr.projectId = "+projectId;
        return super.listBySQL(sql);
    }

    @Override
    public void editReply(ReplyScoreVo replyScoreVo) {
        super.updObject(replyScoreVo);
    }


    @Override
    public int judgeproject(String projectName) {
        return super.listBySQL("select projectId from project  where  projectName ='"+projectName+"'").size();
    }

    @Override
    public void addproject(ProjectNameVo p) {
        if (p.getProjectId()==0){
            super.addObject(p);
        }else {
            super.updObject(p);
        }
    }
}
