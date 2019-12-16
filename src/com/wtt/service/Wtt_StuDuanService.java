package com.wtt.service;

import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.publics.vo.sys.DepVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Wtt_StuDuanService {
    //查询学生问题反馈
    List<FeedbackVo> feedback( int currpage, int pagesize);
    //查询总行数
    int pagecount();
    //查询部门
    List<DepVo> dep();
    //新增学生问题反馈
    void add(FeedbackVo feedbackVo);
    //查询学生
    Map student(String name);
    //查询学生请假
    List<StudentLeaveVo> studentleave(int currpage, int pagesize);
    //学生请假的总行数
    int leavepagecount();
    //新增学生请假

}