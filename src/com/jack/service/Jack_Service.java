package com.jack.service;

import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.empModel.AttendanceVo;

import java.util.List;

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


}
