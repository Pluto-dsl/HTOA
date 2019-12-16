package com.jerry_zhq.service.impl;

import com.jerry_zhq.service.Zhq_DepService;
import com.publics.dao.BaseDao;
import com.publics.vo.sys.DepVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Zhq_DepServiceImpl extends BaseDao implements Zhq_DepService {
    //查询部门
    @Override
    public List selDep() {
        return listByHql("from DepVo");
    }
    //根据部门名查询所有部门
    @Override
    public List selDepAll(String d) {
        return listByHql("from DepVo where depName='"+d+"'");
    }


    //查询员工
    @Override
    public List selEmp() {
        return listByHql("from EmpVo");
    }

    //添加部门
    @Override
    public void addDep(DepVo depVo) {
        addObject(depVo);
    }

    //根据ID查询
    @Override
    public DepVo selById(Integer deptId) {
        return selId(deptId);
    }


    //修改部门
    @Override
    public void updateDep(DepVo depName) {
        updObject(depName);
    }

    //删除部门
    @Override
    public void deleteDep(DepVo  depId) {
        delObject(depId);
    }



}
