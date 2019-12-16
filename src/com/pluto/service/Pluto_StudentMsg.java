package com.pluto.service;

import com.publics.vo.studentModel.StudentVo;

import java.util.List;

public interface Pluto_StudentMsg {
    String getStudentList(String sql);
    List getClassList(String hql);
    List getMajor(String hql);
    void addStudent(StudentVo s);
}
