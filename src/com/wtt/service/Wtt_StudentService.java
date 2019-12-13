package com.wtt.service;

import com.publics.vo.feedback.Collect_OpinionsVo;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;

import java.util.List;

public interface Wtt_StudentService {
    List<StudentLeaveVo> studentleave(int currpage, int pagesize);

    StudentVo student(int id);
    //查询总页数
    int pagecounts();
    //查询总页数
    int wentipagecounts();
    //查询问题反馈
    List<FeedbackVo> feedback(int currpage, int pagesize);
    //新增意见
    void add(Collect_OpinionsVo collect_opinionsVo);
    //查询意见
    List<Collect_OpinionsVo> selectyijian(int id);
    //查询学生
    String student(String name);
    //新增意见之后问题反馈的状态改为已处理（2）
    void update(FeedbackVo feedbackVo);
    //根据id去查找问题反馈
    FeedbackVo feedbackvo(int id);
}