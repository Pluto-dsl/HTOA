package com.norman.service.impl;

import com.norman.service.Ljw_sysSetService;
import com.publics.dao.BaseDao;
import com.publics.vo.studentModel.MajorVo;
import com.publics.vo.sys.DeptVo;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class Ljw_sysSetServiceImpl extends BaseDao implements Ljw_sysSetService {

    @Override
    public List<DeptVo> selDeptList(int page, int limit) {
        return super.pageByHql("FROM DeptVo",page,limit);
    }

    @Override
    public int selDeptSize() {
        return super.listByHql("FROM DeptVo").size();
    }

    @Override
    public void insDept(DeptVo vo) {
        super.addObject(vo);
    }

    @Override
    public void updDept(DeptVo vo) {
        super.updObject(vo);
    }

    @Override
    public void delDept(int id) {
        DeptVo dept = new DeptVo();
        dept.setDeptid(id);
        super.delObject(dept);
    }

    @Override
    public List<MajorVo> selMajorList(int page, int limit) {
        return super.pageByHql("FROM MajorVo",page,limit);
    }

    @Override
    public int selMajorSize() {
        return super.listByHql("FROM MajorVo").size();
    }

    @Override
    public void insMajor(MajorVo vo) {
        super.addObject(vo);
    }

    @Override
    public void updMajor(MajorVo vo) {
        super.updObject(vo);
    }

    @Override
    public void delMajor(int id) {
        MajorVo major = new MajorVo();
        major.setMajorid(id);
        super.delObject(major);
    }
}
