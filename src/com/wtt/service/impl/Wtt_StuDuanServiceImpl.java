package com.wtt.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.publics.vo.sys.DepVo;
import com.wtt.service.Wtt_StuDuanService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Service
public class Wtt_StuDuanServiceImpl extends BaseDao implements Wtt_StuDuanService {

    @Override
    public List<FeedbackVo> feedback(int studentid,int currpage, int pagesize) {
        return pageBySQL("select f.feedbackId,s.stuname,d.depName,f.empName,f.feedBackType,f.feedbackTime,f.Image,f.opinion,f.remark,f.status from feedback f left join dep d on f.depId = d.depid\n" +
                "left join student s on s.Studid = f.empId where s.Studid = '"+studentid+"'"+" order by f.feedbackTime desc",currpage,pagesize);
    }

    @Override
    public int pagecount(int stuid) {
        return selTotalRow("select count(*) from feedback where empId= '"+stuid+"'");
    }

    @Override
    public List<DepVo> dep() {
        return listByHql("from DepVo");
    }

    @Override
    public void add(FeedbackVo feedbackVo) {
        addObject(feedbackVo);
    }
    @Override
    public Map student(int id) {
        String sql = "select c.className from student s \n" +
                "left join studentClass c on s.clazz = c.classId\n" +
                "where s.Studid= '"+id+"'";
        System.out.println(sql);
        List<Map> list = listBySQL(sql);
        for (Map map:list) {
            return map;
        }
        return null;
    }


    @Override
    public List<StudentLeaveVo> studentleave(int currpage, int pagesize) {
       String sql="select * from holidayStudent h left join student s on h.StudentId = s.Studid";
      return pageBySQL(sql,currpage,pagesize);
    }

    @Override
    public int leavepagecount() {
       return selTotalRow("select count(*) from holidayStudent");
    }

    @Override
    public void leaveadd(StudentLeaveVo studentLeaveVo) {
        addObject(studentLeaveVo);
    }

    @Override
    public Map selectteacher(int id) {
        String sql = "select e.empName teacher,e2.empName classTeacher from student s\n" +
                "left join studentClass cla on s.clazz = cla.classId\n" +
                "left join emp e on cla.teacher = e.empId\n" +
                "left join emp e2 on cla.classTeacher = e2.empId\n" +
                "where s.Studid= '"+id+"'";
        System.out.println(sql);
        List<Map> list = listBySQL(sql);
        for (Map map:list) {
            return map;
        }
        return null;
    }
}