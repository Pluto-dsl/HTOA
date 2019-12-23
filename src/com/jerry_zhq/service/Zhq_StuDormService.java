package com.jerry_zhq.service;

import com.publics.vo.studentModel.StudentDormitoryVo;
import com.publics.vo.studentModel.StudentVo;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.Map;

public interface Zhq_StuDormService  {
    //查询
    List selDorm(String hql, int page, int pageSize);

    //查询总条数
    int selCount();

    //根据宿舍中的楼栋id查询楼栋名
    List<Map> selDormFloor(int id);

    //删除
    void delStuDorm(StudentDormitoryVo studentDormitoryVo);

    //查询楼栋名称
    List selFloorName();

    //查询所有宿舍房号
    List selDormName();

    //添加
    void addDorm(StudentDormitoryVo studentDormitoryVo);

    //修改
    void update(StudentDormitoryVo studentDormitoryVo);

    //查询学生表
    List selStudent();
    //查询班级表
    List sleStudentClass();

    //根据Id查询房号
    Object selIdHourName(Class vo,int id);

    //根据宿舍id查找学生
    int size(int hourid);
}
