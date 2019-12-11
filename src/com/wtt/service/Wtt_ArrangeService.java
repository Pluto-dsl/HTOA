package com.wtt.service;

import com.publics.vo.educ.WeekArrangeVo;
import com.publics.vo.empModel.emp.EmpVo;

import java.util.List;

public interface Wtt_ArrangeService {
    List<WeekArrangeVo> weekArrangevo(int currpage, int pagesize);
    //查询总页数
    int pagecount();
    //查询员工列表
    List<EmpVo> emp();
    //新增
    void add(WeekArrangeVo weekArrangeVo);
    //根据id查找员工
    EmpVo emps(int id);
    //删除
    void delete(int id);
}