package com.zero.service;

import com.publics.vo.empModel.emp.EducationVo;
import com.publics.vo.empModel.emp.FamilyInfoVo;
import com.publics.vo.empModel.emp.JobVo;

import java.util.List;

public interface EmpInfo {
    List<JobVo> jobs(int EmpId);//查找当前员工的所有工作经历
    void addjob(JobVo jobVo);//新增或者编辑工作经历
    void deljob(String jobid);//删除工作经历
    List<EducationVo> education(int EmpId);//教育背景
    void addeducation(EducationVo educationVo);//新增或者编辑教育背景
    void deleducation(String allid);//删除教育背景
    List<FamilyInfoVo> familyInfo(int EmpId);//家庭联系信息
    void addfamilyInfo(FamilyInfoVo vo);//新增或者编辑教育背景
    void delfamilyInfo(String allid);//删除教育背景
}
