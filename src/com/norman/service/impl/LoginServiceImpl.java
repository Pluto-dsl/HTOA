package com.norman.service.impl;

import com.norman.dao.LoginDao;
import com.norman.service.LoginService;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;

@Transactional
@Service
public class LoginServiceImpl extends BaseDao implements LoginService {
    @Resource
    private LoginDao loginDao;

    @Override
    public EmpVo empByAcc(String phone) {
        return loginDao.empByAcc("from EmpVo where Phone = '"+phone+"'");
    }

    @Override
    public StudentVo stuByAcc(String phone) {
        return loginDao.stuByAcc("from StudentVo where phone = '"+phone+"'");
    }
}
