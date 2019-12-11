package com.zero.service;

import com.publics.vo.studentModel.StudentFallVo;

import java.util.List;
import java.util.Map;

public interface StudentService {
    List<Map> allClas();//查询所有班级
    List<StudentFallVo> allLevel();//查询所有届别
    void deleteClass(int classid);//删除班级
}
