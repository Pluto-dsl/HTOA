package com.zero.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.empModel.emp.EducationVo;
import com.publics.vo.empModel.emp.FamilyInfoVo;
import com.publics.vo.empModel.emp.JobVo;
import com.zero.service.EmpInfo;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmpInfoImpl extends BaseDao implements EmpInfo {
    @Override
    public List<JobVo> jobs(int EmpId) {
        return super.listByHql("from JobVo where Empid = "+EmpId);
    }

    @Override
    public List<EducationVo> education(int EmpId) {
        return super.listByHql("from EducationVo where Empid = "+EmpId);
    }

    @Override
    public List<FamilyInfoVo> familyInfo(int EmpId) {
        return super.listByHql("from FamilyInfoVo where Empid = "+EmpId);
    }
}
