package com.wtt.service;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EducationVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.empModel.emp.JobVo;
import com.publics.vo.sys.DepVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Wtt_EmpService {
    List<WeeklogVo> weekpaper(int id,HttpServletRequest request,int currpage, int pagesize);
    //新增周报
    void add(WeeklogVo weeklogVo);
    //根据id所对应的对象
    JSONObject wekk(int id);
    EmpVo emp(int id);
    //修改
    void update(WeeklogVo weeklogVo);
    //根据周报id查找数据
    WeeklogVo weeklogvo(int id);
    //删除
    void delete(int id);
    //查询总行数
    int pagecount(int id,HttpServletRequest request);
    //根据员工id查出部门名称
    String name (int id);
    //根据员工Id查出教育经历
    List edmap(int id);
    //根据员工Id查出工作经历
    List jobmap(int id);
    //根据员工Id查出家庭信息
    List familymap(int id);
}