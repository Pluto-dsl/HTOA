package com.zero.service;


import com.publics.vo.empModel.emp.EmpVo;

import java.util.List;
import java.util.Map;

public interface EmpsService {
    List<Map> selectEmp();//查找所有员工
    void addEmp(EmpVo empVo);//新增员工
    void deleteEmp(EmpVo empVo);//删除员工
}
