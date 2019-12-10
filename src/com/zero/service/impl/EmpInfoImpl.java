package com.zero.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.empModel.emp.EducationVo;
import com.publics.vo.empModel.emp.FamilyInfoVo;
import com.publics.vo.empModel.emp.JobVo;
import com.publics.vo.file.AnnexVo;
import com.zero.service.EmpInfo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class EmpInfoImpl extends BaseDao implements EmpInfo {
    @Override
    public List<JobVo> jobs(int EmpId) {
        return super.listByHql("from JobVo where Empid = "+EmpId);
    }

    @Override
    public void addjob(JobVo jobVo) {
        if(jobVo.getJobid()==0){//新增
            super.addObject(jobVo);
        }else{//修改
            super.updObject(jobVo);
        }
    }

    @Override
    public void deljob(String jobid) {
        super.executeSQL("delete from job where Jobid in ("+jobid+")");
    }

    @Override
    public List<EducationVo> education(int EmpId) {
        return super.listByHql("from EducationVo where Empid = "+EmpId);
    }

    @Override
    public void addeducation(EducationVo educationVo) {
        if(educationVo.getCollegeid()==0){//新增
            super.addObject(educationVo);
        }else{
            super.updObject(educationVo);
        }
    }

    @Override
    public void deleducation(String collegeid) {
        super.executeSQL("delete from education where collegeid in ("+collegeid+")");
    }

    @Override
    public List<FamilyInfoVo> familyInfo(int EmpId) {
        return super.listByHql("from FamilyInfoVo where Empid = "+EmpId);
    }

    @Override
    public void addfamilyInfo(FamilyInfoVo vo) {
        if(vo.getFamilyid()==0){//新增
            super.addObject(vo);
        }else{//修改
            super.updObject(vo);
        }
    }

    @Override
    public void delfamilyInfo(String allid) {
        super.executeSQL("delete from familyInfo where familyid in ("+allid+")");
    }

    @Override
    public List<Map> aduit(int empId) {
        return super.listBySQL("select al.*,am.aduitName from `aduitLog` al left join aduitModel am on al.aduitModelid = am.aduitModelid where Empid = "+empId);
    }

    @Override
    public void deladuit(String allid) {
        super.executeSQL("delete from aduitLog where aduitLogid in ("+allid+")");
    }

    @Override
    public List<Map> annex(int empId) {
        return super.listBySQL("select a.*,e.empName from annex a left join emp e on a.seId = e.empId " +
                "where e.empId = "+empId);
    }

    @Override
    public void addAnnex(AnnexVo annexVo) {
        super.addObject(annexVo);
    }

    @Override
    public void delAnnex(String allid) {
        super.executeSQL("delete from annex where annexId in ("+allid+")");
    }
}
