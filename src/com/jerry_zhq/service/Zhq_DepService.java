package com.jerry_zhq.service;

import com.publics.vo.sys.DepVo;

import java.util.List;

public interface Zhq_DepService {
    //查询部门
    List selDep();
    //根据部门名查询所有部门
    List selDepAll(String d);

    //查询员工
    List selEmp();

    //添加部门
    void addDep(DepVo depVo);

    //根据Id查询语句
     DepVo selById(Integer deptId);


    //修改部门
    void updateDep(DepVo depName);

    //删除部门
    void deleteDep(DepVo depId);





}
