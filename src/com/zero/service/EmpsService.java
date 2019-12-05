package com.zero.service;


import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.DepVo;

import java.util.List;
import java.util.Map;

public interface EmpsService {
    List<Map> selectEmp();//查找所有员工
    void addEmp(EmpVo empVo);//新增员工
    void update(EmpVo empVo);//修改员工
    List allDep();//查询所有部门
    void deleteEmp(EmpVo empVo);//删除员工
    Map toemp(int empId);//查找需要修改的员工
}
