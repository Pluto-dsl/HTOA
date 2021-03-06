package com.wtt.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.feedback.Collect_OpinionsVo;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.ClassCategoryVo;
import com.publics.vo.studentModel.StudentClassVo;
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

   /* @Override
    public int pagecounts() {
        return selTotalRow("select count(*) from holidayStudent");
    }*/

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
        String sql = "select empName,puttime,content from collect_opinions where wid = '"+id+"'";
        return listBySQL(sql);
    }

   /* @Override
    public String student(String name) {
        String sql = "select s.stuname from student s where s.intrphone = '"+name+"'";
         //System.out.println(sql);
        List<Map> list = listBySQL(sql);
        for (Map map:list) {
            return map.get("stuname").toString();
        }
        return null;
    }*/

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
        String sql = "select d.personnel from emp e\n" +
                "left join dep d on e.depId = d.depid\n" +
                "where e.empId = '"+empid+"'";
        List<Map> list1 = listBySQL(sql);
        for (Map map:list1) {
            return map.get("personnel").toString();
        }
        return null;
    }

    /*@Override
    public String chairman(int empid) {
        String sql = "select d.chairman from emp e\n" +
                "left join dep d on e.depId = d.depid\n" +
                "where e.empId = '"+empid+"'";
        List<Map> list1 = listBySQL(sql);
        for (Map map:list1) {
            return map.get("chairman").toString();
        }
        return null;
    }*/

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

    @Override
    public List<ClassCategoryVo> selectclasscate(int currpage, int pagesize) {
        return pageBySQL("select * from classType",currpage,pagesize);
    }

    /*@Override
    public String classtypename() {
        String sql="select classTypeName from classType";
        List<Map> list = listBySQL(sql);
        for (Map map:list) {
            return map.get("classTypeName").toString();
        }
        return null;
    }*/

    @Override
    public void addcategory(ClassCategoryVo classCategoryVo) {
        addObject(classCategoryVo);
    }

    @Override
    public void updatecate(ClassCategoryVo classCategoryVo) {
        updObject(classCategoryVo);
    }

    @Override
    public int pagecount(String sql) {
        return selTotalRow(sql);
    }

    @Override
    public List<StudentClassVo> list(int classtypeid) {
        String sql = "select s.classId,s.className,s.classNo,s.classTeacher,s.classType,s.count,s.deptId from studentClass s\n" +
                "left join classType c on s.classType = c.classTypeId\n" +
                "where s.classType = '"+classtypeid+"'";
        return listBySQL(sql);
    }

    @Override
    public void del(ClassCategoryVo classCategoryVo) {
        delObject(classCategoryVo);
    }

    @Override
    public int JudgeName(String name) {
        String sql = "select * from classType where classTypeName = '"+name+"'";
        List list= super.listBySQL(sql);
        int i = list.size();
        //当该方法返回1说明有该数据
        if(i>0){
            return 1;
        }
        return 0;
    }
}