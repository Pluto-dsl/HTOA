package com.wtt.service;

import com.publics.vo.feedback.Collect_OpinionsVo;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.ClassCategoryVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;

import java.util.List;
import java.util.Map;

public interface Wtt_StudentService {
    List<StudentLeaveVo> studentleave(int id);
    //查询总页数
    /*int pagecounts();*/
    //查询总页数
    int wentipagecounts();
    //查询问题反馈
    List<FeedbackVo> feedback(int currpage, int pagesize);
    //新增意见
    void add(Collect_OpinionsVo collect_opinionsVo);
    //查询意见
    List<Collect_OpinionsVo> selectyijian(int id);
    //查询学生
    /*String student(String name);*/
    //新增意见之后问题反馈的状态改为已处理（2）
    void update(FeedbackVo feedbackVo);
    //根据id去查找问题反馈
    FeedbackVo feedbackvo(int id);
    //根据单据ID查找单据内容
    StudentLeaveVo leavelist(int jobid);
    //根据单据id查找学生名字
    String name(int jobid);
    //修改单据的状态
    void updateleave(StudentLeaveVo studentLeaveVo);
    //根据员工id去找部门负责人
    String chairman(int empid);
    //根据单据id查找学生
    Map studentid(int jobid);
    //查找所有班主任
    List selclassteacher(String sql);
    //查询班级类别
    List<ClassCategoryVo> selectclasscate(int currpage, int pagesize);
   /* ClassCategoryVo classcategoryvo();*/
    //新增班级类别
    void addcategory(ClassCategoryVo classCategoryVo);
    //修改班级类别
    void updatecate(ClassCategoryVo classCategoryVo);
    //总页数
    int pagecount(String sql);
}