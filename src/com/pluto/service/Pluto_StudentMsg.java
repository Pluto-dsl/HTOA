package com.pluto.service;

import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.*;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Pluto_StudentMsg {
    String getStudentList(String sql,int page,int limit);//
    List getClassList(String hql);//查询班级列表
    List getMajor(String hql);//查询专业列表
    void addStudent(StudentVo s);//添加学生
    StudentVo getStudentById(int id);//根据id查询学生
    void updateStudent(StudentVo studentVo);//修改学生
    List getHourList(String hql);//查询宿舍列表
    List getDeptList(String hql);//查询系列表
    StudentDormitoryVo getHourById(int id);//根据id查询宿舍对象
    StudentClassVo getClassById(int id);//根据id查询班级
    void updateHour(StudentDormitoryVo s);//修改宿舍信息
    void deleteStudent(StudentVo studentVo);//删除学生
    String getZxListJson(int stuid);//获取在校情况列表json
    void addZx(int sid, String content, HttpServletRequest request);//新增在校情况
    StudentHappeningVo getHappeningById(int hid);//根据id查询在校情况
    void updatezx(int sid, String content, HttpServletRequest request);//修改在校情况
    void deletezx(int happeningId);//根据id删除在校情况记录
    String getFamilyListJsonbyId(int stuid);//根据id查询学生家庭信息的json
    void addStudentFamily(StudentFamilyVo studentFamilyVo);//添加学生家庭信息
    StudentFamilyVo getFamilyById(int familyid);//根据学生id查询学生家庭信息
    void updFamily(StudentFamilyVo studentFamilyVo);//修改学生家庭信息
    void delFamily(StudentFamilyVo studentFamilyVo);//删除学生家庭信息
    String getExamData(int stuid);//获取学生成绩列表
    int judgeStuStart(int id);//查看学生状态是否是退学或者毕业

//    ModelAndView toUpdateExam(int scoreId);//修改学生成绩
    List getKemuList();//查询科目列表
    List getxueqiList();//查询学期列表
    Map getStudentScoreVoById(int id);//根据id查询学生成绩
    String getDbData(int stuid);//获取学生的答辩成绩表数据
    List getListByHql(String hql);//根据hql查询列表
    Object getObjById(Class cla,int id);//根据id获取对象
    String seekStuList(HttpServletRequest request);//根据查询学生列表
    List ListBySql(String sql);//根据SQL查询List

    void deleteScore(int stuid); //根据id删除学生成绩
    void deleteReplyScore(int stuid); //根据id删除学生答辩成绩

    int judgePhone(String phone);//判断学生电话是否重复，或者跟老师的相同
    boolean judgeStuId(int stuid);//判断学生学号是否重复
    boolean judgeCardid(String cardid);//判断身份证号是否重复

    boolean judgeHuor(int id);//判断宿舍是否满员

}
