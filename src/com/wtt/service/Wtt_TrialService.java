package com.wtt.service;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.educ.TrialVo;
import com.publics.vo.empModel.emp.EmpVo;

import java.util.List;

public interface Wtt_TrialService {
    //查询试讲培训
    List<TrialVo> trialvo(int currpage, int pagesize);
    //查询总页数
    int pagecount();
    //查询课程管理表
    List<CourseVo> coursevo();
    //查询员工列表
    List<EmpVo> emp();
    //新增
    void add(TrialVo trialVo);
    //根据id查找课程和员工
    CourseVo courseid(int id);
    EmpVo emp(int id);
    //删除
    void delete(int id);
}