package com.pluto.service;

import com.publics.vo.empModel.HolidayVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public interface Pluto_LeaveService {
    String getLeaveList(String sql);//查询请假列表
    void addLeave(HttpServletRequest request);//添加请假
}
