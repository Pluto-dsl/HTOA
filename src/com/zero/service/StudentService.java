package com.zero.service;

import com.publics.vo.empModel.EnrollmentVo;
import com.publics.vo.studentModel.ClassCategoryVo;
import com.publics.vo.studentModel.MajorVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentFallVo;
import com.publics.vo.sys.DeptVo;

import java.util.List;
import java.util.Map;

public interface StudentService {
    List<Map> allClas();//查询所有班级
    List<Map> seek(int level,String grade,int ctype);//查询所有班级
    List<StudentFallVo> allLevel();//查询所有届别
    List<Map> teacher();//授课老师
    List<ClassCategoryVo> classtype();//班级类别
    List<DeptVo> dept();//系名称
    List<MajorVo> major();//专业名称
    void deleteClass(int classid);//删除班级
    void addClass(StudentClassVo classVo);//新增or修改班级
    void addFall(StudentFallVo fallVo);//新增or修改届别
    List<Map> classStudent(int classId);//查询选中班级所有学生
    List<Map> enroStu();//所有招生的学生
    List<Map> seekStu(String stuname,String Phone,int ctype);//搜索所有招生的学生
    EnrollmentVo enStu(int sid);//查询学生
    MajorVo marjov(int marjorid);//专业
    List judgeLevel(String level);//是否有届别
}
