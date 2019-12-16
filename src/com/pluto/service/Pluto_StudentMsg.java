package com.pluto.service;

import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentDormitoryVo;
import com.publics.vo.studentModel.StudentHappeningVo;
import com.publics.vo.studentModel.StudentVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

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
    //查询员工，暂时
    EmpVo getemp(int id);
}
