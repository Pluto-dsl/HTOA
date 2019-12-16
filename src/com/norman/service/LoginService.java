package com.norman.service;

import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;

public interface LoginService {
    EmpVo empByAcc(String phone);
    StudentVo stuByAcc(String phone);
}