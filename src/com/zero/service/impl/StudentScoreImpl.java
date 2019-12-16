package com.zero.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.studentModel.ProjectNameVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.TermVo;
import com.zero.service.StudentScoreService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StudentScoreImpl extends BaseDao implements StudentScoreService {

    @Override
    public List<Map> ReplyScore(int page,int limit) {
        return super.pageBySQL("select sr.*,s.stuname,sc.className,p.projectName from studentReplyScore sr" +
                " left join student s on s.Studid = sr.StudentId" +
                " left join studentClass sc on sc.classId = s.clazz" +
                " left join project p on p.projectId = sr.projectId order by sr.replyId desc",page,limit);
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
        return super.pageBySQL("select sc.*,c.courseName,s.stuname,t.termName,e.empName from studentScore sc" +
                " left join student s on s.Studid = sc.stuid" +
                " left join course c on c.courseId = sc.courseId" +
                " left join term t on t.termid = sc.termid" +
                " left join emp e on e.empId = sc.EmpId order by sc.scoreId desc",page,limit);
    }

    @Override
    public List<Map> score(String where, int page, int limit) {
        String sql = "select sc.*,c.courseName,s.stuname,t.termName,e.empName from studentScore sc" +
                " left join student s on s.Studid = sc.stuid" +
                " left join course c on c.courseId = sc.courseId" +
                " left join term t on t.termid = sc.termid" +
                " left join emp e on e.empId = sc.EmpId " +
                " where 1=1 ";
        System.out.println("语句:"+sql);
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
        System.out.println("count"+sql);
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
    public List<Map> stu(int classid, int courseid, int scoreType, int termid) {
        return super.listBySQL("select s.stuno,s.stuname,t.termName,ss.testType,c.courseName from studentClass sc " +
                " left join student s on s.clazz = sc.classId" +
                " left join studentScore ss on ss.stuid = s.clazz" +
                " left join term t on t.termid = ss.termid" +
                " left join course c on c.courseId = ss.courseId" +
                " where s.clazz = "+classid+" and t.termid = "+termid+" and c.courseId = 24 and ss.testType = "+scoreType);
    }
}
