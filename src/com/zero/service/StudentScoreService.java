package com.zero.service;

import com.publics.vo.educ.CourseVo;
import com.publics.vo.studentModel.*;

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
    List<Map> score(String where,int page,int limit);//查询学生考试成绩
    int scorecount();//学生成绩总条数
    int scorepagecount(String where);//学生成绩总条数
    List<TermVo> term();//在读学期
    List<CourseVo> course();//所有课程
    int haveScore(int classid, int courseid, int scoreType, int termid);//查询该班级是否有成绩
    int haveReplyScore(int classid,int projectId);//查询该班是否有答辩成绩
    List<Map> stu(int classid);//查询该班的学生
    TermVo nowterm(int termid);//在读学期
    CourseVo nowcourse(int courseid);//课程名称
    StudentClassVo nowclass(int classId);//班级名称
    ProjectNameVo nowproject(int projectId);//项目答辩名称
    void addscore(String sql);//新增学生成绩
    void addReplyscore(ReplyScoreVo scoreVo);//新增学生成绩
    List<Map> toeditScore(int classid, int courseid, int scoreType, int termid);//查询该班成绩
    void editscore(String rescore,StudentScoreVo studentScoreVo);//修改学生成绩
    List<Map> toeditReplyscore(int classid,int projectId);//修改学生答辩成绩
    void editReply(ReplyScoreVo replyScoreVo);//修改学生答辩成绩
    int judgeproject(String projectName);//答辩是否重复
    void addproject(ProjectNameVo p);//答辩是否重复
}
