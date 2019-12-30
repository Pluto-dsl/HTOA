package com.norman.service.impl;

import com.norman.service.Ljw_sysSetService;
import com.publics.dao.BaseDao;
import com.publics.vo.studentModel.MajorVo;
import com.publics.vo.studentModel.TermVo;
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
    public String delDept(int id) {
         //System.out.println(id);
        if (super.listBySQL("SELECT * FROM studentClass WHERE deptId = "+id).size() >= 1){
            return "isUsed";
        }else if (super.listBySQL("SELECT * FROM major WHERE deptid = "+id).size() >= 1){
            return "isUsed";
        }
        DeptVo dept = new DeptVo();
        dept.setDeptid(id);
        super.delObject(dept);
        return "success";
    }

    @Override
    public List<MajorVo> selMajorList(int page, int limit) {
        return super.pageBySQL("SELECT m.majorid,m.majorName,d.deptid,d.deptName,m.remark FROM major m \n" +
                "LEFT JOIN dept d on m.deptid=d.deptid",page,limit);
    }

    @Override
    public List<DeptVo> selDeptList() {
        return listByHql("FROM DeptVo");
    }

    @Override
    public int selMajorSize() {
        return super.listBySQL("SELECT m.majorid,m.majorName,d.deptid,d.deptName,m.remark FROM major m \n" +
                "LEFT JOIN dept d on m.deptid=d.deptid").size();
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
    public String delMajor(int id) {
        if (super.listBySQL("SELECT * FROM studentClass WHERE majorId = "+id).size() >= 1){
            return "isUsed";
        }
        MajorVo major = new MajorVo();
        major.setMajorid(id);
        super.delObject(major);
        return "success";
    }

    @Override
    public List<TermVo> selTermList(int page, int limit) {
        return super.pageByHql("FROM TermVo",page,limit);
    }

    @Override
    public int selTermSize() {
        return super.listByHql("FROM TermVo").size();
    }

    @Override
    public void insTerm(TermVo vo) {
        super.addObject(vo);
    }


    @Override
    public void updTerm(TermVo vo) {
        super.updObject(vo);
    }

    @Override
    public String delTerm(int id) {
        if (super.listBySQL("SELECT * FROM studentScore WHERE termid = "+id).size() >= 1){
            return "isUsed";
        }
        TermVo termVo = new TermVo();
        termVo.setTermid(id);
        super.delObject(termVo);
        return "success";
    }

    @Override
    public int selTermName(String termName) {
        return super.listByHql("from TermVo where termName = '"+termName+"'").size();
    }
}
