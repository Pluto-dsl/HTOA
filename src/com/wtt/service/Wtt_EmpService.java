package com.wtt.service;

import com.publics.vo.empModel.WeeklogVo;

import java.util.List;
import java.util.Map;

public interface Wtt_EmpService {
    List<Map> weekpaper(int currpage,int pagesize);
    //新增周报
    void add(WeeklogVo weeklogVo);
    //根据id所对应的对象
    WeeklogVo wekk(int id);
    //修改
    void update(WeeklogVo weeklogVo);
    //删除
    void delete(int id);
    //查询总页数
    int pagecount();
}