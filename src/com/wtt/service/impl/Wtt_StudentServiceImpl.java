package com.wtt.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.feedback.Collect_OpinionsVo;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.wtt.service.Wtt_StudentService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class Wtt_StudentServiceImpl extends BaseDao implements Wtt_StudentService {

    @Override
    public List<StudentLeaveVo> studentleave(int id) {
        String sql="select h.holidayid,s.stuname,h.holidayDay,h.startTime,h.endTime,h.status,h.remark from holidayStudent h\n" +
                "left join student s on h.StudentId = s.Studid\n" +
                "where h.holidayid= '"+id+"'";
        return listBySQL(sql);
    }

    @Override
    public int pagecounts() {
        return selTotalRow("select count(*) from holidayStudent");
    }

    @Override
    public int wentipagecounts() {
        return selTotalRow("select count(*) from feedback");
    }

    @Override
    public List<FeedbackVo> feedback(int currpage, int pagesize) {
        return pageBySQL("select f.feedbackId,s.stuname,d.depName,f.empName,f.feedBackType,f.feedbackTime,f.Image,f.opinion,f.remark,f.status from feedback f left join dep d on f.depId = d.depid\n"+
                "left join student s on s.Studid = f.empId",currpage,pagesize);
    }

    @Override
    public void add(Collect_OpinionsVo collect_opinionsVo) {
        addObject(collect_opinionsVo);
    }

    @Override
    public List<Collect_OpinionsVo> selectyijian(int id) {
        String sql = "select empName,content from collect_opinions where wid = '"+id+"'";
        return listBySQL(sql);
    }

    @Override
    public String student(String name) {
        String sql = "select s.stuname from student s where s.intrphone = '"+name+"'";
        System.out.println(sql);
        List<Map> list = listBySQL(sql);
        for (Map map:list) {
            return map.get("stuname").toString();
        }
        return null;
    }

    @Override
    public void update(FeedbackVo feedbackVo) {
        updObject(feedbackVo);
    }

    @Override
    public FeedbackVo feedbackvo(int id) {
       return (FeedbackVo) getObject(new FeedbackVo().getClass(),id);
    }

    @Override
    public StudentLeaveVo leavelist(int jobid) {
        return (StudentLeaveVo) getObject(new StudentLeaveVo().getClass(),jobid);
    }

    @Override
    public String name(int jobid) {
        String sql="select s.stuname from student s\n" +
                "left join holidayStudent h on s.Studid = h.StudentId\n" +
                "where h.holidayid = '"+jobid+"'";
        List<Map> list1 = listBySQL(sql);
        for (Map map:list1) {
            return map.get("stuname").toString();
        }
        return null;
    }

    @Override
    public void updateleave(StudentLeaveVo studentLeaveVo) {
        updObject(studentLeaveVo);
    }

    @Override
    public String chairman(int empid) {
        String sql = "select d.chairman from emp e\n" +
                "left join dep d on e.depId = d.depid\n" +
                "where e.empId = '"+empid+"'";
        List<Map> list1 = listBySQL(sql);
        for (Map map:list1) {
            return map.get("chairman").toString();
        }
        return null;
    }

    @Override
    public Map studentid(int jobid) {
        String sql="select * from student s\n" +
                "left join holidayStudent h on s.Studid = h.StudentId\n" +
                "where h.holidayid = '"+jobid+"'";
        List<Map> list1 = listBySQL(sql);
        for (Map map:list1) {
            return map;
        }
        return null;
    }

    @Override
    public List selclassteacher(String sql) {
        return listBySQL(sql);
    }
}