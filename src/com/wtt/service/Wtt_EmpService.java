package com.wtt.service;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;

import java.util.List;

public interface Wtt_EmpService {
    List<WeeklogVo> weekpaper(int currpage,int pagesize);
    //新增周报
    void add(WeeklogVo weeklogVo);
    //根据id所对应的对象
    JSONObject wekk(int id);
    EmpVo emp(int id);
    //修改
    void update(WeeklogVo weeklogVo);
    //删除
    void delete(int id);
    //查询总页数
    int pagecount();
}