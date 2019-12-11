package com.zero.service;

import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.empModel.emp.EducationVo;
import com.publics.vo.empModel.emp.FamilyInfoVo;
import com.publics.vo.empModel.emp.JobVo;
import com.publics.vo.file.AnnexVo;

import java.util.List;
import java.util.Map;

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
    List<Map> aduit(int empId);//查询当前员工考核
    void addaduit(AduitLogVo aduitLogVo);//新增员工考核
    void deladuit(String allId);//删除当前选中的考核
    int aduitSocre(int id);//查询选中考核指标
    List<Map> annex(int empId);//查询所有证件
    void addAnnex(AnnexVo annexVo);//新增证件
    void delAnnex(String allid);//删除选中证件照
    List<Map> empaduit(int empId);// 查询当前用户所有考核
}
