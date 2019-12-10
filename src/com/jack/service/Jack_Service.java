package com.jack.service;

import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.empModel.AttendanceVo;

import java.util.List;
import java.util.Map;

public interface Jack_Service {
    /**
     *  这里是考勤管理部分
     * */
    List selAtt(String Aname, int currPage, int pageSize); //查询考勤表
    int selAttCount(String Aname); //查询总页数
    String selDepChairman(String AName); //查询部门负责人
    void insertAtt(AttendanceVo attVo); //插入未打卡说明
    void updataAtt(AttendanceVo attendanceVo); //审批修改
    List selApprover(String Aname,int state);

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

    /** 登录 */
    Map TLoginUser(String user);
    Map SLoginUser(String user);
}
