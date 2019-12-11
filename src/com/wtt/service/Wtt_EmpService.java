package com.wtt.service;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface Wtt_EmpService {
    List<WeeklogVo> weekpaper(HttpServletRequest request,int currpage, int pagesize);
    //新增周报
    void add(WeeklogVo weeklogVo);
    //根据id所对应的对象
    JSONObject wekk(int id);
    EmpVo emp(int id);
    //修改
    void update(WeeklogVo weeklogVo);
    //删除
    void delete(int id);
    //查询总行数
    int pagecount(HttpServletRequest request);
}