package com.zero.service;

import com.publics.vo.studentModel.ProjectNameVo;
import com.publics.vo.studentModel.StudentClassVo;

import java.util.List;
import java.util.Map;

public interface StudentScoreService {
    List<Map> ReplyScore(int page,int limit);//查询所有学生答辩成绩
    List<Map> ReplyScore(String where,int page,int limit);//带条件查询
    int pagecount();//查询行数
    int pagecount(String where);//查询行数
    List<StudentClassVo> allclass();//所有班级
    List<ProjectNameVo> allProject();//所有项目
    List<Map> score(int page,int limit);//查询学生考试成绩
    int scorecount();//学生成绩总条数
}
