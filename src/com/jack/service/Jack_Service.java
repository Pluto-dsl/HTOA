package com.jack.service;

import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.assess.AduitModelVo;
import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.empModel.AttendanceVo;
import com.publics.vo.empModel.EnrollmentVo;
import com.publics.vo.empModel.evaluationVo;
import com.publics.vo.empModel.teacherTotalVo;
import com.publics.vo.notice.RecipientVo;
import com.publics.vo.studentModel.StudentClassVo;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface Jack_Service {
    /**
    *  这里是考勤管理部分
    * */
    List selAtt(int Aid, int currPage, int pageSize); //查询考勤表
    int selAttCount(int Aname); //查询总页数
    String selDepChairman(int AName); //查询部门负责人
    void insertAtt(AttendanceVo attVo); //插入未打卡说明
    void updataAtt(AttendanceVo attendanceVo); //审批修改
    List selApprover(String Aname, int state);
    void delAtt(int id);

    /**
    * 课程类型业务部分
    * */
    List selCourse(int currPage, int pageSize); //查询课程类型表
    int selCouCount(); //查询课程类型总数
    int UpdateCourse(CourseTypeVo course);
    int delCourse(int id);
    int AddCurse(CourseTypeVo courseTypeVo);

    /**
    *  课程管理业务
    * */
    List selCourseMgt(int currPage, int pageSize); //查询课程管理表
    int selCouCountM(); //获取课程总数
    List selCourseName();//获取课程类型种类
    void addCourseMgt(CourseVo courseVo); //添加课程
    void updateCourseMgt(CourseVo courseVo); //修改课程
    int delCourseMgt(int cid); //删除课程
    List selRepeatCourse(String Name);
    List selRepeatCourseType(String Name);

    /** 考核管理业务 */
    List selAssessment(int currPage, int pageSize); //考核指标查询
    int selAssCount(); //获取数据总数
    List selDepList(); //查询部门列表
    void addAssessment(AduitModelVo aduitModelVo); //添加考核
    void editAssessment(AduitModelVo aduitModelVo);//编辑考核
    void delAssessment(int Aid); //删除

    /** 考核管理 */
    List selAss(int value); //查询所有的考核指标
    List selEmp(int value);  //查询所有的员工
    List selDepAll(); //查询所有的部门
    void addAduit(AduitLogVo aduitLogVo); //员工考核录入
    List selAduitLog(int currPage, int pageSize); //员工考核列表
    int selScores(int id); //查询考核分数
    int selAdCount();
    List selAdDetails(int id); //考核详情
    void delAduitLog(int id);//删除考核
    List selDep(); //获取部门名称列表
    List Conditional_query(String empName, String depId, String startDate, String EndDate, int currPage, int pageSize); //条件查询
    int Conditional_queryCount(String empName, String depId, String startDate, String EndDate); //条件查询
    /** 考评内容，教师考评 */
    List selHeadmasterList();
    List selTeacherList();
    int addAevaluation(evaluationVo evaluatio);
    void delAevaluation(int id);
    List selTeacherListE(String name, String evaluationType, int currPage, int pageSize); // 教师考评
    List selScoreDetails(String teacher, String classid);
    List selReportForm();
    /** 学生端——教师考评 */
    List selHeadmasterTest(int stu);
    List selHeadmasterType();
    List selTeacherTest(int stu);
    List selTeacherType();
    void addHeadmaster(teacherTotalVo totalVo); //插入考评分数
    void addTeacher(teacherTotalVo totalVo);    //插入考评分数
    List selMonthly_assessment(int stuid, int etype);

    /** 公告 */
    int selChatRecordCount(int empid); //谈心查询
    int selClockCount(String empid); //未打卡查询
    //根据员工id查找部门
    /*Map deplist(int empid);
    int selectleave(int teacherid,int classteacherid,int depid);

    StudentClassVo studentclass();*/
    /** 学生公告 */
    List selNoticeList(int id);
    int selNoticeCount(int id);
    int selUnreadCountStu(int id);
    void UpdateRead(int stuid, int notid);

    /** 员工公告 */
    List selNoticeListemp(int id);
    int selNoticeCountemp(int id);
    int selUnreadCountemp(int id);
    void UpdateReademp(int stuid, int notid);

    /** 招生管理 */
    List selEnrollmentList(int currPage,int pageSize);
    int selEnrollmentCount();
    List selClassTypeList();
    List selMajorList();
    void addEnrollment(EnrollmentVo enroll);
    void delEnrollment(int id);
    void editEnrollment(EnrollmentVo enroll);

    /** 消息提醒 */
    List selMessage(int empid,String date);

    //根据公告id查询已读的人数
    int trueCount(int noticeId);
    //根据公告id查询未读的人数
    int falseCount(int noticeId);
    //根据查询出来的已读未读人数修改Notice表中的已读未读人数
    void updateCountNotice(int trueCount,int falseCount,int noticeId);

    //根据公告id查询已读的人数
    int trueCountStu(int noticeId);
    //根据公告id查询未读的人数
    int falseCountStu(int noticeId);
    //根据查询出来的已读未读人数修改Notice表中的已读未读人数
    void updateCountNoticeStu(int trueCount,int falseCount,int noticeId);

}
