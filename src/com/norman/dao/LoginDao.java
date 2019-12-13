package com.norman.dao;

import com.norman.dao.impl.LoginDaoImpl;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;

import javax.annotation.Resource;

public interface LoginDao {
    EmpVo empByAcc(String hql);
    StudentVo stuByAcc(String hql);
}
